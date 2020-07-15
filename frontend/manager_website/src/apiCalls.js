import moment from 'moment'
import {patients, volunteers, contacts} from "@/constants/fakeBackend"
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
    async getDummyPatients() {
        let pat = patients
        return this.convertPatientDatesToMoments(pat)
    },
    async getDummyContacts() {
        let cont = contacts
        return this.convertContactDatesToMoments(cont)
    },
    async getDummyVolunteers() {
        return volunteers
    }
}