import Vue from "vue";
import Vuex from "vuex";
import apiCalls from "@/apiCalls.js" 

Vue.use(Vuex);

function todayDate() {
    let today = new Date();
    let day = String(today.getDate()).padStart(2, '0');
    let month = String(today.getMonth() + 1).padStart(2, '0');
    let year = today.getFullYear();

    return (year + '-' + month + '-' + day)
}

export default new Vuex.Store({
    state: {
        loggedIn: false,
        patientInfo: null,
        addLocations: {},
        deleteContacts: [],
        deleteLocations: [],
        todayDate: todayDate(),
        startDate: undefined,
        resultDate: '',
        endDate: undefined,
        contacts: { },
        householdContactIDArray: [],
        contactID: 1,
        fuckThis: 0,
        userType: '',
        userInfo: {
            name: 'Saleem',
            department: 'Yale Health',
            languages: [0, 1],
            capacity: 3
        },
        patients: [],
        openPID: -1,
        dialogClosed: 0
    },
    getters: {
        readableStartDate: function(state) {
            return state.startDate.format("dddd, MMMM Do YYYY")
        },
        readableEndDate: function(state) {
            return state.endDate.format("dddd, MMMM Do YYYY")
        },
        fullName: function(state) {
            console.log("I was called!")
            return function(id) {
                let contact = state.contacts[id]
                var lastName = (contact.lastName === undefined) ? '' : contact.lastName
                return (contact.firstName + ' ' + lastName)
            }
        },
        getPatientById: (state) => (id) => {
            return state.patients.find(patient => patient.patientID === id)
        },
        outsideContacts: function(state) {
            state.fuckThis
            var outsideIDs = []
            for (var key of Object.keys(state.contacts)) {
                if (!state.contacts[key].household) {
                    outsideIDs.push(key)
                }
            }
            return outsideIDs
        }
    },
    mutations: {
        logIn(state) {
            state.loggedIn = true
        },
        logOut(state) {
            state.loggedIn = false
        },
        setUserType(state, type) {
            state.userType = type
        },
        setPatients(state, patients) {
            state.patients = patients
        },
        instantiatePatient(state, value) {
            state.patientInfo = value
        },
        qAddLocation(state, event) {
            // add the event by its current ID
            state.addLocations[event.eventID] = event
        },
        rmAddLocation(state, ID) {
            if (state.addLocations.hasOwnProperty(ID)) {
                delete state.addLocations[ID]
                return true
            }
            return false
        },
        dialogClose(state) {
            state.dialogClosed += 1
        },
        qDeleteContact(state, ID) {
            state.deleteContacts.push(ID)
        },
        qDeleteLocation(state, ID) {
            state.deleteLocations.push(ID)
        },
        rmDeleteLocation(state, ID) {
            const isSame = (element) => element == ID;
            let index = state.deleteLocations.findIndex(isSame)
            if (index >= 0) {
                state.deleteLocations.splice(index, 1)
            }
        },
        setDate(state, date) {
            var moment = require('moment')
            //compute start and end dates
            state.startDate = date.clone().subtract(2, 'day')
            let end = date.clone().add(10, 'day')
            state.endDate = end.isAfter(state.todayDate) ? moment(state.todayDate, 'YYYY-MM-DD') : end
        },
        addContact(state, contact) {
            // uses the newest ID in the state, probably will need to be changed when we start loading things in
            state.contacts[state.contactID] = {
                firstName: contact.firstName,
                lastName: contact.lastName,
                household: contact.household,
                relationshipType: contact.relationshipType,
                phone: contact.phone,
                email: contact.email,
                healthcareWorker: contact.healthcareWorker,
                age: contact.age,
                symptomatic: contact.symptomatic,
            }

            if (contact.household) {
                //add the date
                state.contacts[state.contactID].date = contact.date
                //add ID to array
                state.householdContactIDArray.push(state.contactID)
            }
            state.contactID = state.contactID + 1
            state.fuckThis += 1
        },
        deleteContact(state, contactID) {
            // uses the newest ID in the state, probably will need to be changed when we start loading things in
            let contact = state.contacts[contactID]

            if (contact.household) {
                state.householdContactIDArray = state.householdContactIDArray.filter(function(ele) {
                    return ele != contactID
                })
            }
            delete state.contacts[contactID]
            state.fuckThis += 1
        },
        modifyContact(state, contact) {
            // pulls the contact using contact ID
            state.contacts[contact.contactID] = Object.assign({}, state.contacts[contact.contactID], 
            {
                firstName: contact.firstName,
                lastName: contact.lastName,
                household: contact.household,
                relationshipType: contact.relationshipType,
                phone: contact.phone,
                email: contact.email,
                healthcareWorker: contact.healthcareWorker,
                age: contact.age,
                symptomatic: contact.symptomatic,
                date: contact.date
            })
            state.fuckThis += 1
        },
        setOpenPID(state, value) {
            state.openPID = value
        },
        clearOpenPID(state) {
            state.openPID = -1
        }
    },
    actions: {
        async loadPatients({commit}) {
            let patients = await apiCalls.getInterviews()
            commit('setPatients', patients)
        }
    }
});
