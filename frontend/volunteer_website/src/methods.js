import enums from '@/constants/enums.js';

function getFullName(item) {
    var fullName = ''
    if (item.first_name != undefined) {
        fullName += item.first_name 
    }
    if (item.last_name != undefined) {
        fullName = fullName + ' ' + item.last_name
    }
    return fullName
}

function getPhone(item) {
    if(item.phone_number == undefined) {
        return ''
    }
    let phone = item.phone_number.toString()
    return '(' + phone.substring(0, 3) + ') ' + phone.substring(3, 6) + '-' + phone.substring(6, phone.length)
}

function getProgress(item) {
    if(item.contact_id) {
        if (item.contact_call_status == 0) {
            return 0
        } else if (item.contact_call_status < 3) {
            return 50
        } else {
            return 100
        }
    }
    else {
        if (item.case_call_status == 0) {
            return 0
        } else if (item.case_call_status < 4 || item.case_call_status == 6) {
            return 50
        } else {
            return 100
        }
    }
}

function getEnum(item, field) {
    return enums[field].asArray[item[field]]
}

function getEnumArray(item, field) {
    if(item[field] === undefined || item[field].length == 0) {
        return ''
    } else {
        let str = ''
        for(let i in item[field]) {
            str += enums[field].asArray[i]
            str += ', '
        }
        str = str.substring(0, str.length - 2)
        console.log(str)
        return str
    }
}

function getLanguages(item) {
    if(item.languages.length == 0) {
        return ''
    } else {
        let str = ''
        for(let i of item.languages) {
            str += enums.language.asArray[i]
            str += ', '
        }
        str = str.substring(0, str.length - 2)
        return str
    }
}

const gettersMap = {
    // personal info
    'name': (item) => getFullName(item),
    'first_name': (item) => item.first_name,
    'last_name': (item) => item.last_name,
    'phone': (item) => getPhone(item),
    'phone_number': (item) => item.phone_number,
    'email': (item) => item.email,
    'age' : (item) => item.age,
    'age_group': (item) => getEnum(item, 'age_group'),
    'gender': (item) => getEnum(item, 'gender'),
    'race': (item) => getEnum(item, 'race'),
    'language': (item) => getEnum(item, 'language'),
    'home_address': (item) => item.home_address,
    'dob': (item) => item.date_of_birth,

    // case/contact info
    'household': (item) => item.household,
    'contact_type': (item) => getEnum(item, 'contact_type'),
    'times_called': (item) => item.times_called,
    'contact_call_status': (item) => getEnum(item, 'contact_call_status'),
    'contact_date': (item) => item.contact_date,
    'update_date': (item) => item.update_date,
    'relationship': (item) => getEnum(item, 'relationship'),


    //patient-specific case info
    'diagnosis_date': (item) => item.diagnosis_date,
    'onset_date': (item) => item.onset_date,
    'last_worked_date': (item) => item.last_worked_date,
    'case_call_status': (item) => getEnum(item, 'case_call_status'),
    'travelled': (item) => item.travelled,
    'saw_doctor': (item) => getEnum(item, 'saw_doctor'),
    'knows_status': (item) => item.knows_status,

    // patient specific meta info
    'insurance': (item) => getEnum(item, 'insurance'),
    'employment': (item) => getEnum(item, 'employment'),
    'suspected_exposure': (item) => getEnumArray(item, 'suspected_exposure'),
    'housing_insecure': (item) => item.housing_insecure,
    'shelter_name': (item) => item.shelter_name,
    'referral': (item) => item.referral,
    'flagged': (item) => item.flagged,
    'reason_flagged': (item) => getEnum(item, 'reason_flagged'),

    // interview info (info gotten by talking to them)
    'symptomatic': (item) => {
        if (typeof item.symptomatic == 'boolean') {
            return item.symptomatic
        }
        getEnum(item, 'symptomatic')
    },
    'symptoms': (item) => getEnumArray(item, 'symptoms'),
    'self_isolate': (item) => getEnum(item, 'self_isolate'),
    'assistance': (item) => getEnumArray(item, 'assistance'),
    'isolated_from_patient': (item) => item.isolated_from_patient,
    'healthcare_worker': (item) => item.healthcare_worker,
    'preexisting_conditions': (item) => getEnumArray(item, 'preexisting_conditions'),

    // admin info
    'notes': (item) => item.notes,
    'patient_id': (item) => item.patient_id,
    'volunteer_id': (item) => item.volunteer_id,
    'manager_id': (item) => item.manager_id,
    'org_name': (item) => item.org_name,
    'requested_interview': (item) => item.requested_interview,
    'progress': (item) => getProgress(item),

    // volunteer specific admin info
    'interviewer': (item) => item.interviewer,
    'total_capacity': (item) => item.total_capacity,
    'remaining_capacity': (item) => item.remaining_capacity,
    'current_cases': (item) => item.current_cases,
    'completed_cases': (item) => item.completed_cases,
    'languages': (item) => getLanguages(item),
}

export default {
    //takes a contact, returns the full name as a string
    methods: {
        gettersHelper(item, field) {
            let f = gettersMap[field]
            if (f === undefined) {
                console.error(`${field} is not a recognized data field`)
                return 'n/a'
            } else {
                return f(item)
            }
        }
    }
}