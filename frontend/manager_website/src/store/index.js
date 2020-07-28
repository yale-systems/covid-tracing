import Vue from "vue";
import Vuex from "vuex";
import apiCalls from '@/apiCalls.js';
import moment from 'moment';
import createPersistedState from "vuex-persistedstate";
import CryptoJS from 'crypto-js';
import SecureStorage from 'secure-web-storage';

Vue.use(Vuex);


//PATIENTS MODULE
const getPatientDefaultState = () => {
    return {
		patients: [],
		addPatients: [],
        links: {},
        touched: true,
        activePatient: null
    }
}

const patients = {
    namespaced: true,
    state: getPatientDefaultState(),
    getters: {
        activePatient: (state, getters, rootState) =>  {
            return state.patients.find(patient => patient.patient_id === rootState.activePatientId)
        },
        id: (state) => (patientId) => {
            return state.patients.find(patient => patient.patient_id === patientId)
        },
        criticalDate(state, getters, rootState) {
            state.touched
            let patient = state.patients.find(patient => patient.patient_id === rootState.activePatientId)
            console.log(patient.symptomatic)
            if(patient && patient.symptomatic) {
                return patient.onset_date
            } else {
                return patient.diagnosis_date
            }
        },
        readableStartDate: (state, getters) => {
            let startDate = getters.criticalDate.clone()
            return startDate.subtract(2, 'days').format('MMMM Do, YYYY')
        },
        startDate: (state, getters) => {
            let startDate = getters.criticalDate.clone()
            return startDate.subtract(2, 'days').format('YYYY-MM-DD')
        },
        readableEndDate: (state, getters) => {
            let endDate = getters.criticalDate.clone()
            let today = moment()
            endDate.add(10,'days')
            return (endDate.isAfter(today) ? today.format('MMMM Do, YYYY') : endDate.format('MMMM Do, YYYY'))
        },
        endDate: (state, getters) => {
            let endDate = getters.criticalDate.clone()
            let today = moment()
            endDate.add(10,'days')
            return (endDate.isAfter(today) ? today.format('YYYY-MM-DD') : endDate.format('YYYY-MM-DD'))
        },
        getAllPatients: (state) => {
            return state.patients
		},
		addPatientsNames(state) {
			state.touched
			return state.addPatients.map((patient) => {
				if ((patient.first_name == undefined || patient.first_name == '')
					&& (patient.last_name == undefined || patient.last_name == '')) {
					return "New Case"
				}
				let first = patient.first_name == undefined ? '' : patient.first_name
				let last = patient.last_name == undefined ? '' : patient.last_name
				return first + ' ' + last
			})
        },
        addPatients(state) {
            state.touched
            return state.addPatients
        }
    },
    mutations: {
        setPatients(state, value) {
            state.patients.push(value)
        },
        setActivePatient(state, activeId) {
            let patient = state.patients.find(patient => patient.patient_id === activeId)
            if(patient != null) {
                state.activePatient = patient
            }
        },
        setLinks(state, links) {
            Object.keys(links).forEach(index => {
                // console.log(link)
                state.links[links[index]['rel']] = links[index]['href'].replace(/\d+$/, "")
            })
        }, 
        updatePatient(state, data) {
            let pid = state.patients.findIndex(patient => patient.patient_id === data.activePatientId)
            if (pid >= 0) {
                state.patients[pid] = data
            }
            state.touched = !state.touched
		},
		addPatientsToPatients(state, concatArray) {
			state.patients = state.patients.concat(concatArray)
			console.log(state.patients)
		},
		addPatient(state, value) {
			state.touched = !state.touched
			if(value.patient_id == state.addPatients.length) {
				state.addPatients.push(value)
			} else {
				const index = state.addPatients.findIndex((element) => element.patient_id == value.patient_id)
				if(index != -1) {
					state.addPatients[index] = value
				}
			}
		},
		deletePatient(state, id) {
			state.addPatients = state.addPatients.filter((element) => element.id != id)
		},
		clearAddPatients(state) {
			state.addPatients = []
		},
        resetState(state) { Object.assign(state, getPatientDefaultState())}
    },
    actions: {
        initializePatient({commit}, response) {
            commit('setPatients', response.patient)
            commit('setLinks', response.links)
        },
        async update({state, commit}, patient) {
            let link = state.links.update
            let res = await apiCalls.updatePatient(link, patient)
            if (res) {
                commit('updatePatient', patient)
            }
            return res
        },
        resetState({commit}) { commit('resetState') },
        load({commit, dispatch}, patients) {
            if(patients.length == 0) {
                return
            }
            let links = patients[0].links
            delete patients[0].links
            let firstPatient = {
                patient: patients[0],
                links: links
            }
            dispatch('initializePatient', firstPatient)
            patients.splice(0, 1)
            for(let patient of patients) {
                commit('setPatients', patient)
            }
		},
		async loadManager({commit}, links) {
			for (const link of links) {
				let pats = await apiCalls.getPatients(link)
				commit('addPatientsToPatients', pats.patients)
				commit('setLinks', pats.links)
			}
		},
		// if patient is already in array, then update, else make new
		addPatient({state, commit}, patient) {
			if (patient.patient_id == -1) {
				patient.patient_id = state.addPatients.length
			}
			commit('addPatient', patient)
			return patient.patient_id
		},
		//ACTIONS SHOULDN'T BE MUTATING STATE! 
		reassignPatient({state, rootState}, volunteer) {
			for (let patient of rootState.view.selected) {
				state.patients[patient].volunteer_id = volunteer
			}
			state.touched++;
			return true
		}
    }
}

const getViewDefaultState = () => {
    return {
        allPatientFields : [
            { text: "Name", value: "name" },
			{ text: "Language", value: "language" },
			{ text: "Call Status", value: "case_call_status" },
			{ text: "Date of Birth", value: "dob" },
            { text: "Interview Requested", value: "requested_interview" },
            { text: "Phone", value: "phone"},
            { text: "Race", value: "race"},
            { text: "Home address", value: "home_address"}
        ],
        selectedPatientFields: [
            true, true, true, true, false, false, false, false
        ],
        contactFields: [

        ],
        volunteerFields: [

        ],
        selected: []
    }
}

const view = {
    namespaced: true,
    state: getViewDefaultState(),
	getters: {
		activePatientFields: function(state) {
			let headers = []
			for (let field in state.selectedPatientFields) {
				if (state.selectedPatientFields[field]) {
					headers.push(state.allPatientFields[field])
				}
			}
			return headers
		}
    },
	mutations: {
		setSelect(state, value) {
			state.selected.push(value)
		},
		removeSelect(state, value) {
			state.selected.splice( state.selected.indexOf(value), 1 );
		},
		clearSelect(state) {
			state.selected = []
		},
		updatePatientFields(state, value) {
			state.selectedPatientFields = value
		}
	}
}

//CONTACTS MODULE
const getContactDefaultState =  () => {
    return {
        contacts:[],
        links: {},
        touched: true
    }
}

const contacts = {
    namespaced: true,
    state: getContactDefaultState(),
    getters: {
        newContactId(state) {
            if (state.contacts.length == 0) { return undefined }
            return state.contacts[state.contacts.length-1].contact_id
        },
        id: (state) => (id) => {
            state.touched
            return state.contacts.find(contact => contact.contact_id === id)
        },
        householdContacts: (state) => {
            console.log()
            return state.contacts.filter(contact => contact.household === true)
        },
        outsideContacts: (state) => {
            return state.contacts.filter(contact => contact.household === false)
        },
        contacts: (state) => { 
            state.touched 
            return state.contacts 
        },
        fullName: (state) => (id) => {
            state.touched
            let contact = state.contacts.find(contact => contact.contact_id === id)
            let firstName = contact.first_name == undefined ? '' : contact.first_name
            let lastName = contact.last_name == undefined ? '' : contact.last_name
            return firstName + ' ' + lastName
        }
    },
    mutations: {
        setContact(state, value) {
            if(value.contact_date) {
                value.contact_date = moment(value.contact_date)
            }
            state.contacts.push(value)
            state.touched = !state.touched
        },
        setLinks(state, links) {
            Object.keys(links).forEach(index => {
                // console.log(link)
                state.links[links[index]['rel']] = links[index]['href'].replace(/\d+$/, "")
            })
        },
        updateContact(state, value) {
            let contactId = state.contacts.findIndex(contact => contact.contact_id === value.contact_id)
            if(contactId >= 0) {
                state.contacts[contactId] = value
            }
            state.touched = !state.touched
        },
        resetState(state) { Object.assign(state, getContactDefaultState()) }
    },
    actions: {
        //loads in all contacts associated with a given patient
        async load({commit, rootState}, patientId) {
            let link = `${rootState.patients.links.get_contacts}${patientId}`
            console.log(rootState)
            let response = await apiCalls.getContacts(link)
            if(response.contacts) {
                for(let contact of response.contacts) {
                    delete contact.enums
                    delete contact.links
                    commit('setContact', contact)
                }
                commit('setLinks', response.links)
            }
        },
        //loads in all contacts associated with a given volunteer
        async loadVol({commit, rootState}) {
            let link=rootState.volunteers.links.get_contacts
            let response = await apiCalls.getContacts(link)
            if(response.contacts) {
                for(let contact of response.contacts) {
                    delete contact.enums
                    delete contact.links
                    commit('setContact', contact)
                }
                commit('setLinks', response.links)
            }
		},
		
		async loadManager({commit, rootState}) {
            let link = rootState.manager.links.get_contacts
            let response = await apiCalls.getContacts(link)
            if(response.contacts) {
                for(let contact of response.contacts) {
                    delete contact.enums
                    delete contact.links
                    commit('setContact', contact)
                }
                commit('setLinks', response.links)
            }
        },

        // COMMON METHODS
        async update({commit, state}, contact) {
            let link = state.links.update
            let response = await apiCalls.updateContact(link, contact) 
            if(response) {
                commit('updateContact', contact)
                return true
            } else {
                return false
            }
        },
        async add({commit, rootState}, contact) {
            let link = rootState.patients.links.insert_contact
            let pid = rootState.activePatientId
            contact.patient_id = pid
            let response = await apiCalls.addContact(link, contact)
            if(response != {}) {
                commit('setContact', response)
                return response.contact_id
            } else {
                return -1
            }
        },
        resetState({commit}) { commit('resetState') }
    }
}

//VOLUNTEERS MODULE
const getVolunteerDefaultState = () => {
    return {
        volunteers: [],
        links: {}, 
        touched: true,
        active: null
    }
}

const volunteers = {
    namespaced: true,
    state: getVolunteerDefaultState(),
    getters: {
        id: (state) => (id) => {
            state.touched
            return state.volunteers.find(volunteer => volunteer.volunteer_id === id)
        },
        active: (state) => {
            if(state.active != null) {
                return state.volunteers.find(volunteer => volunteer.volunteer_id === state.active)
            } else {
                return null
            }   
        }
    },
    mutations: {
        setVolunteer(state, value) {
            state.volunteers.push(value)
		},
		setVolunteers(state, value) {
			state.volunteers = value
		},
        setLinks(state, links) {
            Object.keys(links).forEach(index => {
                // console.log(link)
                state.links[links[index]['rel']] = links[index]['href'].replace(/\d+$/, "")
            })
        },
        updateVolunteer(state, value) {
            let volId = state.volunteers.findIndex(volunteer => volunteer.volunteer_id === value.volunteer_id)
            if(volId >= 0) {
                state.volunteers[volId] = value
            }
            state.touched = !state.touched
        },
        setActive(state, value) {
            state.active = value
        },
        resetState(state) { Object.assign(state, getVolunteerDefaultState()) }
    },
    actions: {
        //loads in all information associated with a given volunteer
        async initializeVolunteer({commit}, data) {
            //sets the links associated with a volunteer
            commit('setVolunteer', data.volunteer)
            commit('setLinks', data.links)
            commit('setActive', data.volunteer.volunteer_id)
        },
        
        // we should def be calling this... but when ????  
        async update({commit, state}, volunteer) {
            let res = false
            let link = state.links.update
            await apiCalls.updateVolunteer(link, volunteer)
                .then(function(response) {
                    if(response != {}) {
                        commit('updateVolunteer', response)
                        res = true
                    }
                })
                .catch(function(error) { console.error(error) })
            return res
		},
		resetState({commit}) { commit('resetState') },
		async loadManager({commit}, link) {
            let res = true
			await apiCalls.getVolunteers(link)
				.then(function(response) {
					if(response != undefined && response != {}) {
                        commit('setLinks', response.links)
                        commit('setVolunteers', response.volunteers)
					}
                })
                .catch(error => {console.error(error); res = false})
            return res
		}
	}
}

const getManagerDefaultState = () => {
	return {
		manager: null,
		links: {}
	}
}

const manager = {
	namespaced: true,
	state: getManagerDefaultState(),
	mutations:{
		setLinks(state, value) {
			state.links = value
		},
		setManager(state, value) {
			state.manager = value
		}
	},
	actions: {
		initializeManager({commit}, data) {
			commit('setLinks', data.links)
			commit('setManager', data.manager)
		}
	}
}

// ROOT STORE
const getRootDefaultState = () => {
    return {
        loggedIn: false,
        showNavBar: false,
        activePatientId: undefined,
        activeVolunteerId: undefined,
        activeContactId: undefined,
        enums: {},
        openPID: undefined,
        dialogClosed: true
    }
}

const SECRET_KEY = 'cats'

let secureStorage = new SecureStorage(sessionStorage, {
    hash: function hash(key) {
        key = CryptoJS.SHA256(key, SECRET_KEY);

        return key.toString();
    },
    encrypt: function encrypt(data) {
        data = CryptoJS.AES.encrypt(data, SECRET_KEY);

        data = data.toString();

        return data;
    },
    decrypt: function decrypt(data) {
        data = CryptoJS.AES.decrypt(data, SECRET_KEY);

        data = data.toString(CryptoJS.enc.Utf8);

        return data;
    }
});

export default new Vuex.Store({
    state: getRootDefaultState(),
    plugins: [createPersistedState({
        storage: secureStorage,
        setState: function(key, state, storage) {
            return storage.setItem(key, state)
        },
        getState: function(key, storage) {
            let value;
            try {
              (value = storage.getItem(key))
              if(value == undefined) {
                  return undefined
              } else {
                
                if (value.contacts.contacts) {
                    value.contacts.contacts = value.contacts.contacts.map((contact) => {
                        contact.contact_date = moment(contact.contact_date)
                        contact.update_date = moment(contact.update_date)
                        return contact
                    })
                }
                if (value.patients.patients) {
                    value.patients.patients = value.patients.patients.map((patient) => {
                        patient.diagnosis_date = moment(patient.diagnosis_date)
                        patient.onset_date = moment(patient.onset_date)
                        patient.last_worked_date = moment(patient.last_worked_date)
                        patient.date_of_birth = moment(patient.date_of_birth)
                        return patient
                    })
                }
                // if (value.events.events) {
                //     value.events.events = value.events.events.map((event) => {
                //         event.start_time = moment(event.start_time)
                //         return event
                //     })
                // }
                console.log(value)
                return value
              }
            } catch (err) {
                console.log(err)
            }
            
            return undefined;
          }
    })],
    getters: {
        activePatientId: (state) => {return state.activePatientId}
    },
    mutations: {
        closeDialog(state) {
            state.dialogClosed = !state.dialogClosed
        },
        logOut(state) {
            state.loggedIn = false
        },
        logIn(state) {
            state.loggedIn = true
        },
        toggleNavBarToTrue(state) {
            state.showNavBar = true
        },
        setActivePatient(state, value) {
            state.activePatientId = value
        },
        setActiveVol(state, value) {
            state.activeVolunteerId = value
        },
        setEnums(state, enums) {
            state.enums = Object.assign({}, enums)
        },
        resetState(state) { Object.assign(state, getRootDefaultState()) },
        setOpenPID(state, value) {
            state.openPID = value
        }
    },
    actions: {
		//REWRITE THIS
        async managerLogin({state, dispatch, commit}, credentials) {
            await dispatch('logOut')
            let response = await apiCalls.managerCheckLogin(credentials)
            if (response == null) { return false }
			
			commit('logIn')
            let links = {}
            Object.keys(response._links).map((key) => {
                links[key] = response._links[key].href 
			})
			delete response.links
            // load in manager
			let managerData = { manager : response, links: links }
			await dispatch('manager/initializeManager', managerData)
			// load in patients, volunteers, and contacts

			// lol we cannot do this rn bcos the backend is broke
			// await dispatch('contacts/loadManager')
			await dispatch('patients/loadManager', [state.manager.links.get_patients, state.manager.links.get_orphaned_patients])
			await dispatch('volunteers/loadManager', state.manager.links.get_volunteers)

			if(state.patients.patients.length > 0) {
				console.log(state)
				let enums = await apiCalls.getEnums(state.patients.links.self + state.patients.patients[0].patient_id)
				commit('setEnums', enums)
			}
			return true
        },
        async logOut({commit, dispatch}) {
            secureStorage.clear()
            dispatch('patients/resetState')
            dispatch('contacts/resetState')
            // dispatch('events/resetState')
            dispatch('volunteers/resetState')
            commit('resetState')
            commit('logOut')
        },
        clearFormData({dispatch}) {
            dispatch('contacts/resetState')
            // dispatch('events/resetState')
        },
        loadFormData({commit, dispatch}, pid) {
            commit('setActivePatient', pid)
            commit('patients/setActivePatient', pid)
            dispatch('contacts/load', pid)
            dispatch('events/load', pid)
        }
    },
    modules: {
		view: view,
        patients: patients,
        contacts: contacts,
		volunteers: volunteers,
		manager: manager
    }
});
