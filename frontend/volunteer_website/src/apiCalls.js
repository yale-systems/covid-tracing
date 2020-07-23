import moment from 'moment';
import axios from 'axios'
import { baseurl } from '@/constants/baseurl.js'
import geocoder from '@/geocoder.js'

export default {
    // returns patient information if valid, null otherwise
    async patientCheckLogin(credentials) {
        // 1. CHECK CREDS (return null if failure)
        const userRegex = /^username[1-3]?[0-9]$/;
        const passwordRegex = /^password$/;
        if (credentials.username.match(userRegex) &&
            credentials.password.match(passwordRegex)) {
            const numberRegex = /[1-3]?[0-9]/
            const Id = credentials.username.match(numberRegex);
            // 2. CALL getPatient
            const url = baseurl + 'patient/getbypatientid/'
            return await this.getPatient(url, Id[0]) 
        } else {
            return null
        }
    },
    async volunteerCheckLogin(credentials) {
      // 1. CHECK CREDS (return null if failure)
      const userRegex = /^username[1-3]?[0-9]$/;
      const passwordRegex = /^password$/;
      if (credentials.username.match(userRegex) &&
          credentials.password.match(passwordRegex)) {
          const numberRegex = /[1-3]?[0-9]/
          const Id = credentials.username.match(numberRegex);
          // 2. CALL getPatient
          const url = baseurl + 'volunteer/getbyvolunteerid/'
          return await this.getVolunteer(url, Id[0]) 
      } else {
          return null
      }
  },

    //PATIENT API CALLS
    async getPatient(url, id) {
        try {
            //get response from backend
            let response = await axios.get(url + id);
            delete response.data.enums

            //make patient object 
            let patient = Object.assign({}, response.data);
            delete patient._links
            patient.diagnosis_date = moment(patient.diagnosis_date)
            patient.onset_date = moment(patient.onset_date)
            patient.last_worked_date = moment(patient.last_worked_date)
            if(patient.symptomatic == 0) {
                patient.symptomatic = 1
            } else if (patient.symptomatic == 2) {
                patient.symptomatic = 0
            }
            // return patient, links
            return {
                patient: patient,
                links: response.data._links,
            }
        } catch(error) {
            console.log(error);
            return null;
        }
    },
    async updatePatient(url, patient) {
        if(patient.symptomatic == 0) {
            patient.symptomatic = 2
        } else if (patient.symptomatic == 1) {
            patient.symptomatic = 0
        }
        try {
            await axios.put(url, patient) 
            return true
        } catch (e) {
            console.log(e)
            return false
        }
    },
    // get all patients associated with a volunteer
    async getPatientsForVol(url) {
      let res = []
      await axios.get(url)
        .then((response) => {
          if(response.data) {
            for(let patient of response.data) {
              if(patient.diagnosis_date) {
                patient.diagnosis_date = moment(patient.diagnosis_date)
              }
              if(patient.onset_date) {
                patient.onset_date = moment(patient.onset_date)
              }
              if(patient.last_worked_date) {
                patient.last_worked_date = moment(patient.last_worked_date)
              }
              if(patient.date_of_birth) {
                patient.date_of_birth = moment(patient.date_of_birth)
              }
              delete patient._links
              delete patient.enums
              res.push(patient)
            }
          }
        })
        .catch(error => {console.error(error)})
        console.log(res)
        return res
    },
    
    //EVENT API CALLS
    async getEvents(url) {
        console.log(URL)
        let res = {
            events: [],
            links: {}
        };
        try {
            let response = await axios.get(url)
            let events = response.data
            if(events.length > 5) {
                events = events.slice(0, Math.min(5, events.length))
            }
            let geocoderThing = await geocoder.getGeocoder()
            if(events.length > 0) {
                let links = {}
                for(let link of events[0].links) {
                    links[link.rel] = link.href.replace(/\d+$/, "")
                }
                res.links = links
            }
            for (let event of events) {
                event.start_time = moment(event.start_time)
                if(event.contact_ids == null) {
                    event.contact_ids = []
                }
                event.add = false
                event.dateValid = true
                event.delete = false
                event.update = false
                let position = {}
                let placeholder = ''
                if (event.geom) {
                    position = {
                        lng: event.geom.coordinates[0], 
                        lat: event.geom.coordinates[1]
                    }
                    placeholder = await geocoder.getStreetName(position, geocoderThing, function(response) {placeholder = response})
                }
                event.location = {
                    streetName: placeholder,
                    coordinates: position
                }
                delete event.links
                res.events.push(event)
            }
            console.log("yeah so i got here")
            console.log(res)
            return res
        } catch(error) {
            console.error(error)
        }
        
    },
    async addEvents(url, events) {
        // return a map of the successful event id with its new id
        let success = {}
        await Promise.all(events.map(async (event) => {
            await axios.post(url, event)
                .then((response) => {
                    success[event.event_id] = response.data.event_id
                })
                .catch((error) => {
                    console.error(error)
                })
        }))
        return success
    },
    async updateEvents(url, events) {
        let success = []
        await Promise.all(events.map(async (event) => {
            await axios.put(url, event)
                .then(() => {
                    success.push(event.event_id)
                })
                .catch((error) => {
                    console.error(error)
                })
        }))
        return success
    },
    async deleteEvents(url, events) {
        let success = []
        await Promise.all(events.map(async (event) => {
            let link = `${url}${event.event_id}`
            await axios.delete(link)
                .then(function() {
                    console.log(event.event_id)
                    success.push(event.event_id)
                })
                .catch(function(error) {
                    console.error(error)
                })
        }))
        return success
    },

    //CONTACT API CALLS
    async getContacts(url) {
        let res = {};
        await axios.get(url)
            .then(function (response) {
                let contacts = response.data
                contacts = contacts.map((contact) => {
                    contact.contact_date = moment(contact.contact_date)
                    contact.update_date = moment(contact.update_date)
                    return contact
                })
                let links = {}
                if(contacts.length > 0) {
                    for(let link of contacts[0].links) {
                        links[link.rel] = link.href.replace(/\d+$/, "")
                    }
                }
                res.contacts = contacts
                res.links = links
            })
            .catch(function(error) {
                console.error(error)
            })
        return res
    },
    async addContact(url, contact) {
        let res = {}
        if(contact.contact_date) {
            contact.contact_date.toISOString()
        }
        if(contact.update_date) {
            contact.update_date.toISOString()
        }
        await axios.post(url, contact)
            .then((response) => {
                delete response.data.enums
                delete response.data.links
                if(response.data.contact_date) {
                    response.data.contact_date = moment(response.data.contact_date)
                }
                if(response.data.update_date) {
                    response.data.update_date = moment(response.data.update_date)
                }
                res = response.data
            })
            .catch(error => {console.error(error)})
        return res
    },
    async updateContact(url, contact) {
        let res = null
        if(contact.contact_date) {
            contact.contact_date.toISOString()
        }
        if(contact.update_date) {
            contact.update_date.toISOString()
        }
        await axios.put(url, contact)
            .then(() => res = true)
            .catch(error => {console.error(error); res = false })
        return res
    },

    
    //ENUM API CALLS -- NOTE, UPDATE THIS
    async getEnums(patientURL) {
        let enums = {}
        
        //get enums
        await axios.get(patientURL).then(async (res) => {
            enums = Object.assign(enums, res.data.enums)
            if (res.data._links.get_contacts) {
                await axios.get(res.data._links.get_contacts.href).then(res => {
                    if (res.length == 0) {return} 
                    enums = Object.assign(enums, res.data[0].enums)
                }).catch(e => {
                    console.log(e)
                })
            }
        }).catch(e => {
            console.log(e)
        })

        //process the enums
        Object.keys(enums).map((singleEnum) => {
            let single = Object.keys(enums[singleEnum]).map((string) => {
                let str = string.replace(/_/g, ' ').toLowerCase();
                str = str[0].toUpperCase() + str.slice(1)
                return ({key: enums[singleEnum][string], value: str})
            })
            enums[singleEnum] = single
        })
        return enums
    },

    async getVolunteer(url, id) {
      let link = `${url}${id}`
      let res = {}
      await axios.get(link)
        .then(response => {
          res = response.data
        })
        .catch(error => console.error(error))
      return res
    }

};