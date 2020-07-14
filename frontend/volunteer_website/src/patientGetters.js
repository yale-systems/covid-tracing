import constants from '@/constants'

export default {
    getPatientID(item) {
        return item.patientID
    },
    //takes a contact, returns the full name as a string
    getFullName(item) {
        var fullName = ''
        if (item.firstName != undefined) {
            fullName += item.firstName 
        }
        if (item.lastName != undefined) {
            fullName = fullName + ' ' + item.lastName
        }
        return fullName
    },
    getReadableDate(item) {
        return item.date.format('MMMM Do YYYY')
    },
    getDate(item){
        return item.date
    },
    getPhone(item) {
        let phone = item.phone.toString()
        return '(' + phone.substring(0, 3) + ') ' + phone.substring(3, 6) + '-' + phone.substring(6, phone.length)
    },
    getEmail(item) {
        return item.email
    },
    getAge(item) {
        return item.age
    },
    getLanguage(item) {
        return constants.languages[item.language].status
    },
    getStatus(item) {
        return constants.callStatuses[item.callStatus].status
    },
    getHousehold(item) {
        return item.household
    },
    getFirstName(item) {
        return item.firstName
    },
    getLastName(item) {
        return item.lastName
    },
    getSymptomatic(item) {
        return item.symptomatic
    },
    getProgress(item) {
        if (item.callStatus == 0) {
            return 0
        } else if (item.callStatus == 5 || item.callStatus == 3 || 
            item.callStatus == 1 || item.callStatus == 2 || 
            item.callStatus == 8) {
            return 50
        } else if (item.callStatus == 4 || item.callStatus == 9) {
            return -10
        } else {
            return 100
        }
    },
    getProgressNum(item) {
        if (item.callStatus == 0) { //red
            return 5
        } else if (item.callStatus == 5 || item.callStatus == 3 || 
            item.callStatus == 1 || item.callStatus == 2 || 
            item.callStatus == 8) { //yellow
            return 10
        } else if (item.callStatus == 4 || item.callStatus == 9) { // black
            return 0
        } else {
            return 20 //green
        }
    },
    getPhoneNum(item) {
        return item.phone
    }
}