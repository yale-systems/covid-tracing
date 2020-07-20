

import Vue from "vue";
import Vuex from "vuex";
import apiCalls from "@/apiCalls.js";

Vue.use(Vuex);

const data = {
	state: () => ({
		patients: {},
		addPatients: [],
		contacts: {},
		volunteers: {},
		touched: 0,
	}),
	mutations: {
		setPatients(state, value) {
			for (let patient of value) {
				state.patients[patient.patient_id] = patient
			}
			state.touched += 1
		},
		setContacts(state, value) {
			for (let contact of value) {
				let copy = contact
				state.contacts[contact.contact_id] = copy
			}
			state.touched += 1
		},
		setVolunteers(state, value) {
			for(let volunteer of value) {
				state.volunteers[volunteer.volunteer_id] = volunteer
			}
			state.touched += 1
		},
		addPatient(state, value) {
			state.touched = !state.touched
			if(value.patient_id == state.addPatients.length) {
				state.addPatients.push(value)
			} else {
				console.log("checking to see if things are modified")
				console.log(state.addPatients[0].patient_id, value.patient_id)
				const index = state.addPatients.findIndex((element) => element.patient_id == value.patient_id)
				if(index != -1) {
					console.log("found index!")
					state.addPatients[index] = value
				}
			}
		},
		deletePatient(state, id) {
			state.addPatients = state.addPatients.filter((element) => element.id != id)
		},
		clearAddPatients(state) {
			state.addPatients = []
		}
	},
	getters: {
		addPatientsNames(state) {
			state.touched
			return state.addPatients.map((patient) => {
				if ((patient.first_name == undefined || patient.first_name == '')
					 && (patient.last_name == undefined || patient.last_name == '')) {
					return "new case"
				}
				let first = patient.first_name == undefined ? '' : patient.first_name
				let last = patient.last_name == undefined ? '' : patient.last_name
				return first + ' ' + last
			})
		},
		patientsAsArray: function(state) {
			state.touched;
			let patDict = state.patients;
			let patArr = []
			for (let key of Object.keys(patDict)) {
				const pat_id = parseInt(key)
				let item = patDict[pat_id]
				patArr.push({patient_id: pat_id, ...item})
			}
			return patArr
		},
		volunteersAsArray: function(state) {
			state.touched;
			let volDict = state.volunteers;
			let volArr = []
			for (let key of Object.keys(volDict)) {
				const pat_id = parseInt(key)
				let item = volDict[pat_id]
				volArr.push({patient_id: pat_id, ...item})
			}
			return volArr
		},
		contactsAsArray: function(state) {
			state.touched;
			let conDict = state.contacts;
			let conArr = []
			for (let key of Object.keys(conDict)) {
				const pat_id = parseInt(key)
				let item = conDict[pat_id]
				conArr.push({patient_id: pat_id, ...item})
			}
			return conArr
		}
	},
	actions: {
		async loadPatients({commit}) {
			await apiCalls.getDummyPatients()
				.then(function(patients) {
					commit('setPatients', patients)
				})
				.catch(function(error) {
					console.log(error)
				})
		},
		async loadContacts({commit}) {
			await apiCalls.getDummyContacts()
				.then(function(contacts) {
					commit('setContacts', contacts)
				})
				.catch(function(error) {
					console.log(error)
				})
		},
		async loadVolunteers({commit}) {
			await apiCalls.getDummyVolunteers()
				.then(function(vol) {
					commit('setVolunteers', vol)
				})
				.catch(function(error) {
					console.log(error)
				})
		},
		// if patient is already in array, then update, else make new
		addPatient({state, commit}, patient) {
			console.log(patient.patient_id)
			if (patient.patient_id == -1) {
				patient.patient_id = state.addPatients.length
				console.log(patient.patient_id)
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

const view = {
	state: () => ({
		allPatientFields: [
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
	}),
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

export default new Vuex.Store({
	state: {
		loggedIn: false,
		userInfo: {},
	},
	mutations: {
		logIn(state) {
			state.loggedIn = true
		},
		logOut(state) {
			state.loggedIn = false
			state.userInfo = {}
		}
	},
	modules: {
		data: data,
		view: view
	}
});
