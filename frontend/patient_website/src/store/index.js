import Vue from "vue";
import Vuex from "vuex";

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
        showNavBar: false
    },
    getters: {
        readableStartDate: function(state) {
            var moment = require('moment');
            let d = moment(state.startDate, 'YYYY-MM-DD')
            return d.format("dddd, MMMM Do YYYY")
        },
        readableEndDate: function(state) {
            var moment = require('moment');
            let d = moment(state.endDate, 'YYYY-MM-DD')
            return d.format("dddd, MMMM Do YYYY")
        },
        fullName: function(state) {
            console.log("I was called!")
            return function(id) {
                let contact = state.contacts[id]
                var lastName = (contact.lastName === undefined) ? '' : contact.lastName
                return (contact.firstName + ' ' + lastName)
            }
        }
    },
    mutations: {
        logIn(state) {
            state.loggedIn = true
        },
        logOut(state) {
            state.loggedIn = false
        },
        toggleNavBarToTrue(state) {
            state.showNavBar = true
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
        setDate(state, value) {
            var moment = require('moment');
            //value is of form datepicker '03-02-2018'
            state.resultDate = value;

            //1. convert to date object
            let d = moment(value, 'YYYY-MM-DD');
            //2. compute begin date
            state.startDate = d.subtract(2, 'day').format('YYYY-MM-DD')

            state.endDate = d.add(12, 'day').isAfter(state.todayDate) ? state.todayDate : d.format('YYYY-MM-DD')
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
        }
    }
});
