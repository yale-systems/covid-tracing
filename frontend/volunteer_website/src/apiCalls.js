
import moment from 'moment';
export default {
  async checkLogin(credentials) {
    if (
      credentials.username == "username" &&
      credentials.password == "password"
    ) {
      return true;
    } else {
      return false;
    }
  },
  async getContacts() {
    let curr = this
    let contacts = await this.getContactsFromAPI().then((response) => {
      response = curr.convertContactDatesToMoments(response)
      return response
    })
    return contacts
  },
  async getInterviews() {
    var patients = await this.getPatientsFromAPI()
    patients = this.convertPatientDatesToMoments(patients)
    return patients
  },
  convertPatientDatesToMoments(response) {
    for (var item of response) {
      item.date = moment(item.date, "YYYY-MM-DD")
    }
    return response
  },
  convertContactDatesToMoments(response) {
    for (var item of response) {
      item.contactDate = moment(item.contactDate, "YYYY-MM-DD")
      item.updateDate = moment(item.updateDate, "YYYY-MM-DD")
    }
    return response
  },
  async getPatientsFromAPI() {
    return ([
      {
        patientID: 1,
	      firstName: "Richard",
        lastName: "Greenberd",
        language: 0,
        date: "2020-05-28",
        callStatus: 3,
        callTimeElapsed: 55,
        phone: 2406319313,
        email: "dick@dickhead.org",
        symptomatic: true,
        age: 24,
        interviewRequested: false
      },
      {
        patientID: 2,
	      firstName: "Bessie",
        lastName: "Greenberd",
        language: 0,
        date: "2020-06-01",
        callStatus: 2,
        callTimeElapsed: 2,
        phone: 4234448273,
        email: "boobs@barbie.com",
        symptomatic: false,
        age: 86,
        interviewRequested: true
      },
      {
        patientID: 3,
	      firstName: "Constance",
        lastName: "O'Klein",
        language: 1,
        date: "2020-06-13",
        callStatus: 0,
        callTimeElapsed: 0,
        phone: 8811238232,
        email: "constance-klein@gmail.com",
        symptomatic: true,
        age: 37,
        interviewRequested: true
      },
      {
        patientID: 13,
	      firstName: "Bambi",
        lastName: "Bambino",
        language: 2,
        date: "2020-06-10",
        callStatus: 6,
        callTimeElapsed: 100,
        phone: 3817237182,
        email: "bb@bambino.net",
        symptomatic: true,
        age: 67,
        interviewRequested: false
      },
      {
        patientID: 5,
	      firstName: "Sufus",
        lastName: "Slybeird",
        language: 3,
        date: "2020-06-01",
        callStatus: 4,
        callTimeElapsed: 5,
        phone: 3231243312,
        email: "slybeird1926@gmail.com",
        symptomatic: true,
        age: 42,
        interviewRequested: true
      },
    ])
  },
  async getContactsFromAPI () {
    return ([
      {
        contactID: 1,
        contactDate: "2020-06-01",
        updateDate: "2020-06-10",
        firstName: "Joe",
        lastName: "Shmo",
        phone: 2406211595,
        email: "joe.shmo@yale.edu",
        household: true,
        relationship: 0,
        language: 1,
        healthcare: false,
        symptomatic: true,
        contactType: 0,
        age: 1,
        callStatus: 0,
        symptoms: [],
        selfIsolate: null,
        notes: '',
        assistance: [],
      },
      {
        contactID: 2,
        contactDate: "2020-06-03",
        updateDate: "2020-06-12",
        firstName: "Emily",
        lastName: "Smith",
        phone: 2418881595,
        email: "esmith@gmail.com",
        household: false,
        relationship: 5,
        language: 0,
        healthcare: false,
        symptomatic: false,
        contactType: 1,
        age: 1,
        callStatus: 4,
        symptoms: [],
        selfIsolate: null,
        notes: '',
        assistance: [],
      },
      {
        contactID: 3,
        contactDate: "2020-05-28",
        updateDate: "2020-06-16",
        firstName: "Jack",
        lastName: "Doe",
        phone: 3312224723,
        email: "sarcasticfork@comcast.net",
        household: true,
        relationship: 2,
        language: 0,
        healthcare: false,
        symptomatic: false,
        age: 0,
        contactType: 0,
        callStatus: 6,
        symptoms: [],
        selfIsolate: 1,
        notes: '',
        assistance: [],
      },
      {
        contactID: 4,
        contactDate: "2020-06-15",
        updateDate: "2020-06-17",
        firstName: "Lassie",
        lastName: "Spaniel",
        phone: 2313129090,
        email: "bambamboom@me.com",
        household: false,
        relationship: 4,
        language: 3,
        healthcare: false,
        symptomatic: false,
        age: 2,
        contactType: 1,
        callStatus: 2,
        symptoms: [],
        selfIsolate: null,
        notes: '',
        assistance: [],
      },
      {
        contactID: 5,
        contactDate: "2020-06-10",
        updateDate: "2020-06-12",
        firstName: "Drajo",
        lastName: "Bredian",
        phone: 2313129090,
        email: "bambamboom@me.com",
        household: false,
        relationship: 4,
        language: 2,
        healthcare: false,
        symptomatic: false,
        age: 2,
        contactType: 0,
        callStatus: 3,
        symptoms: [],
        selfIsolate: null,
        notes: '',
        assistance: [],
      }
  ])
  }
};
