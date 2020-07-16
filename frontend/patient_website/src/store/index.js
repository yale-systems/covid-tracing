import Vue from "vue";
import Vuex from "vuex";
import apiCalls from '@/apiCalls.js'
import moment from 'moment'

Vue.use(Vuex);

const getEventDefaultState = () => {
    return {
        events: [],
        links: {},
        touched: true
    }
}

//EVENTS MODULE
const events = {
    namespaced: true,
    state: getEventDefaultState(),
    getters: {
        //  GET EVENT BY ID
        id: (state) => (eventId) => {
            return state.events.find(event => event.event_id === eventId)
        },
        // GETTERS TO FILTER EVENTS INTO CURRENT, DELETED, ADDED, AND UPDATED EVENTS
        current: (state) => {
            state.touched
            return state.events.filter(event => !event.delete)
        },
        deleted: (state) => {
            state.touched
            return state.events.filter(event => event.delete)
        },
        added: (state) => {
            state.touched
            return state.events.filter(event => (event.add && !event.delete))
        },
        updated: (state) => {
            state.touched
            return state.events.filter(event => (event.update && !event.delete && !event.add))
        },
    },
    mutations: {
        setEvent(state, event) {
            state.events.push(event)
        },
        setLinks(state, links) {
            state.links = links
        },
        // need to check if the event was just added // if it was, then just remove it directly
        deleteEvent(state, eventId) {
            let event = state.events.find(event => event.event_id === eventId)
            if(event != undefined) { 
                event.delete = true 
                state.touched = !state.touched
            }
        },
        // if it was added, then we don't set update to true
        updateEvent(state, value) {
            let eventId = state.events.findIndex(event => event.event_id === value.event_id)
            if(eventId >= 0) {
                state.events[eventId] = value
                if(!state.events[eventId].add) {
                    state.events[eventId].update = true
                }
                state.touched = !state.touched
            }
        },
        removeEvent(state, eventId) {
            let id = state.events.findIndex(event => event.event_id === eventId)
            if(id >= 0) {
                state.events.splice(id, 1)
            }
        },
        addedEvent(state, ids) {
            let index = state.events.findIndex(event => event.event_id === ids.old)
            if(index >= 0) {
                state.events[index].event_id = ids.new
                state.events[index].add = false
                state.events[index].update = false
            }
        },
        resetState(state) {
            Object.assign(state, getEventDefaultState())
        }
    },
    actions: {
        addBlankEvent({commit, state, rootState}) {
            let newID = state.events[state.events.length - 1].event_id + 1
            let newEvent = {
                event_id: newID,
                patient_id: rootState.activePatientId,
                confirmed: false,
                contact_ids: [],
                start_time: null,
                end_time: null,
                location: {
                    coordinates: {},
                    streetName: ''
                },
                add: true,
                delete: false,
                update: false,
                dateValid: false
            }
            commit('setEvent', newEvent)
        },
        //LOADS IN EVENTS
        async load({commit, rootState}, patientId) {
            // get the link from the patients namespace
            let link = `${rootState.patients.links.get_events}${patientId}`
            let response = await apiCalls.getEvents(link)
            for(let event of response.events) {
                commit('setEvent', event)
            }
            commit('setLinks', response.links)
        },

        //SUBMIT -- takes valid input
        async submit({commit, getters, state, rootState}) {
            let massageLocation = function(event) {
                if(event.location.coordinates) {
                    event.geom = {
                        coordinates: [event.location.coordinates.lng, event.location.coordinates.lat],
                        type: "Point"
                    }
                }
                return event
            }
            //DELETES THE DELETED EVENTS
            let toDelete = getters['deleted']
            let dLink = state.links.delete
            let deleteSuccess = await apiCalls.deleteEvents(dLink, toDelete)
            for(let s of deleteSuccess) {
                commit('removeEvent', s)
            }
            //ADDS THE ADDED EVENTS
            let toAdd = getters['added']
            let aLink = rootState.patients.links.insert_event
            for (let index in toAdd) {
                toAdd[index] = massageLocation(toAdd[index])
            }
            let addSuccess = await apiCalls.addEvents(aLink, toAdd)
            for(let oldId of Object.keys(addSuccess)) {
                commit('addedEvent', { old: oldId, new: addSuccess[oldId]})
            }

            //UPDATES THE UPDATED EVENTS
            let toUpdate = getters['updated']
            let uLink = state.links.update
            for (let index in toUpdate) {
                toUpdate[index] = massageLocation(toUpdate[index])
            }
            let updateSuccess = await apiCalls.updateEvents(uLink, toUpdate)
            for(let s of updateSuccess) {
                let id = state.events.findIndex(event => event.event_id === s)
                state.events[id].update = false
            }
            if((toDelete.length - deleteSuccess.length)
                + (toUpdate.length - updateSuccess.length)
                + (toAdd.length - addSuccess.length)
                > 0) 
            {
                return false
            } else {
                return true
            }
        },
        resetState({commit}) { commit('resetState') }
    }
}

const getPatientDefaultState = () => {
    return {
        patients: [],
        links: {},
        touched: true,
        activePatient: null
    }
}

//PATIENTS MODULE
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
        criticalDate: (state, getters, rootState) => {
            let patient = state.patients.find(patient => patient.patient_id === rootState.activePatientId)
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
        readableEndDate: (state, getters) => {
            let endDate = getters.criticalDate.clone()
            let today = moment()
            endDate.add(10,'days')
            return (endDate.isAfter(today) ? today.format('MMMM Do, YYYY') : endDate.format('MMMM Do, YYYY'))
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
            Object.keys(links).forEach(key => {
                state.links[key] = links[key]["href"].replace(/\d+$/, "")
            })
        }, 
        updatePatient(state, data) {
            let pid = state.patients.findIndex(patient => patient.patient_id === data.activePatientId)
            if (pid >= 0) {
                state.patients[pid] = data
            }
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
        resetState({commit}) { commit('resetState') }
    }
}

const getContactDefaultState =  () => {
    return {
        contacts:[],
        links: {},
        touched: true
    }
}

//CONTACTS MODULE
const contacts = {
    namespaced: true,
    state: getContactDefaultState(),
    getters: {
        id: (state) => (id) => {
            state.touched
            return state.contacts.find(contact => contact.contact_id === id)
        },
        householdContacts: (state) => {
            return state.contacts.filter(contact => contact.household == true)
        },
        contacts: (state) => { return state.contacts },
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
        },
        setLinks(state, value) {
            state.links = value
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

const getRootDefaultState = () => {
    return {
        loggedIn: false,
        showNavBar: false,
        activePatientId: undefined,
        enums: {}
    }
}

// ROOT STORE
export default new Vuex.Store({
    state: getRootDefaultState(),
    getters: {
        activePatientId: (state) => {return state.activePatientId}
    },
    mutations: {
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
        setEnums(state, enums) {
            state.enums = enums
        },
        resetState(state) { Object.assign(state, getRootDefaultState()) }
    },
    actions: {
        async logIn({state, dispatch, commit}, credentials) {
            let response = await apiCalls.checkLogin(credentials)
            if (response != null) {
                commit('logIn')
                commit('setActivePatient', response.patient.patient_id)
                await dispatch('patients/initializePatient', response)
                commit('patients/setActivePatient', response.patient.patient_id)
                let enums = await apiCalls.getEnums(state.patients.links.self + state.activePatientId)
                commit('setEnums', enums)
                return true
            } else {
                return false
            }  
        },
        logOut({commit, dispatch}) {
            dispatch('patients/resetState')
            dispatch('contacts/resetState')
            dispatch('events/resetState')
            commit('resetState')
            commit('logOut')
        }
    },
    modules: {
        patients: patients,
        events: events,
        contacts: contacts
    }
});
