export default {
    computed: {
        enums() {
            return this.$store.state.enums
        }
    },
    //takes a contact, returns the full name as a string
    methods: {
        gettersHelper(item, field) {
            const gettersMap = {
                // personal info
                'name': (item) => this.getFullName(item),
                'first_name': (item) => item.first_name,
                'last_name': (item) => item.last_name,
                'phone': (item) => this.getPhone(item),
                'phone_number': (item) => item.phone_number,
                'email': (item) => item.email,
                'age' : (item) => item.age,
                'age_group': (item) => this.getEnum(item, 'AgeGroup'),
                'gender': (item) => this.getEnum(item, 'Gender'),
                'race': (item) => this.getEnum(item, 'Race'),
                'language': (item) => this.getEnum(item, 'Language'),
                'home_address': (item) => item.home_address,
                'dob': (item) => item.date_of_birth,
            
                // case/contact info
                'household': (item) => item.household,
                'contact_type': (item) => this.getEnum(item, 'ContactType'),
                'times_called': (item) => item.times_called,
                'contact_call_status': (item) => this.getEnum(item, 'ContactCallStatus'),
                'contact_date': (item) => item.contact_date,
                'update_date': (item) => item.update_date,
                'relationship': (item) => this.getEnum(item, 'Relationship'),
            
            
                //patient-specific case info
                'diagnosis_date': (item) => item.diagnosis_date,
                'onset_date': (item) => item.onset_date,
                'last_worked_date': (item) => item.last_worked_date,
                'case_call_status': (item) => this.getEnum(item, 'CaseCallStatus'),
                'travelled': (item) => item.travelled,
                'saw_doctor': (item) => this.getEnum(item, 'SawDoctor'),
                'knows_status': (item) => item.knows_status,
            
                // patient specific meta info
                'insurance': (item) => this.getEnum(item, 'Insurance'),
                'employment': (item) => this.getEnum(item, 'Employment'),
                'suspected_exposure': (item) => this.getEnumArray(item, 'SuspectedExposure'),
                'housing_insecure': (item) => item.housing_insecure,
                'shelter_name': (item) => item.shelter_name,
                'referral': (item) => item.referral,
                'flagged': (item) => item.flagged,
                'reason_flagged': (item) => this.getEnum(item, 'ReasonFlagged'),
            
                // interview info (info gotten by talking to them)
                'symptomatic': (item) => {
                    if (typeof item.symptomatic == 'boolean') {
                        return item.symptomatic
                    }
                    this.getEnum(item, 'Symptomatic')
                },
                'symptoms': (item) => this.getEnumArray(item, 'Symptoms'),
                'self_isolate': (item) => this.getEnum(item, 'SelfIsolate'),
                'assistance': (item) => this.getEnumArray(item, 'Assistance'),
                'isolated_from_patient': (item) => item.isolated_from_patient,
                'healthcare_worker': (item) => item.healthcare_worker,
                'preexisting_conditions': (item) => this.getEnumArray(item, 'PreexistingConditions'),
            
                // admin info
                'notes': (item) => item.notes,
                'patient_id': (item) => item.patient_id,
                'volunteer_id': (item) => item.volunteer_id,
                'manager_id': (item) => item.manager_id,
                'org_name': (item) => item.org_name,
                'requested_interview': (item) => item.requested_interview,
                'progress': (item) => this.getProgress(item),
            
                // volunteer specific admin info
                'interviewer': (item) => item.interviewer,
                'total_capacity': (item) => item.total_capacity,
                'remaining_capacity': (item) => item.remaining_capacity,
                'current_cases': (item) => item.current_cases,
                'completed_cases': (item) => item.completed_cases,
                'languages': (item) => this.getLanguages(item),
            }

            let f = gettersMap[field]
            if (f === undefined) {
                console.error(`${field} is not a recognized data field`)
                return 'n/a'
            } else {
                return f(item)
            }
        },
        getFullName(item) {
            var fullName = ''
            if (item.first_name != undefined) {
                fullName += item.first_name 
            }
            if (item.last_name != undefined) {
                fullName = fullName + ' ' + item.last_name
            }
            return fullName
        },
        getPhone(item) {
            if(item.phone_number == undefined) {
                return ''
            }
            let phone = item.phone_number.toString()
            return '(' + phone.substring(0, 3) + ') ' + phone.substring(3, 6) + '-' + phone.substring(6, phone.length)
        },
        getProgress(item) {
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
        },
        camelToUnderscore(str) {
            return str.split(/(?=[A-Z])/).join('_').toLowerCase()
        },
        getEnum(item, field) {
            let underscore = this.camelToUnderscore(field)
            return this.enums[field].find((el) => el.key == item[underscore]).value
        },
        getEnumArray(item, field) {
            let underscore = this.camelToUnderscore(field)
            if(item[underscore] === undefined || item[underscore].length == 0) {
                return ''
            } else {
                let str = ''
                for(let i in item[underscore]) {
                    let thing = this.enums[field].find((el) => el.key == i)
                    if (thing != undefined) {
                        str += thing.value
                        str += ', '
                    }
                }
                str = str.substring(0, str.length - 2)
                console.log(str)
                return str
            }
        },
        getLanguages(item) {
            if(item.languages.length == 0) {
                return ''
            } else {
                let str = ''
                for(let i of item.languages) {
                    str += this.enums.Language.asArray[i]
                    str += ', '
                }
                str = str.substring(0, str.length - 2)
                return str
            }
        }
    }
}