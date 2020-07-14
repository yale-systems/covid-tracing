import constants from '@/constants'

export default {
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
    getPhone(item) {
        let phone = item.phone.toString()
        return '(' + phone.substring(0, 3) + ') ' + phone.substring(3, 6) + '-' + phone.substring(6, phone.length)
    },
    getEmail(item) {
        return item.email
    },
    getAge(item) {
        return constants.ages[item.age]
    },
    getLanguage(item) {
        return constants.languages[item.language].status
    },
    getStatus(item) {
        return constants.contactStatuses[item.callStatus].status
    },
    getHousehold(item) {
        return item.household
    },
    getContactType(item) {
        return constants.contactType[item.contactType]
    },
    getFirstName(item) {
        return item.firstName
    },
    getRelationship(item) {
        return constants.relationships[item.relationship]
    },
    getSymptomatic(item) {
        return item.symptomatic
    },
    getHealthcare(item) {
        return item.healthcare
    },
    getProgress(item) {
        if (item.callStatus == 0) {
            return 0
        } else if (item.callStatus < 5) {
            return 50
        } else {
            return 100
        }
    }
}