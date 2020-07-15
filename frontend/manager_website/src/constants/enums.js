const contact_type = makeEnum(["minimal", "close"]);

const age_group = makeEnum(["minor", "adult", "elderly"]);

const contact_call_status = makeEnum([
        "Have not notified yet",  
        "No, left voicemail", 
        "No, did not leave voicemail", 
        "Unable to reach", 
        "Unable to reach, bad number", 
        "Yes, notified contact", 
        "Yes, notified family", 
        "Yes, notified proxy"
])

const relationship = makeEnum([
        "parent",
        "grandparent",
        "child",
        "friend",
        "work colleague",
        "other",
        "don't want to say"
    ]);

const language = makeEnum([
        "English",
        "Spanish",
        "Chinese",
        "Arabic"
    ]);


const symptomatic = makeEnum([
        "tested positive for COVID-19",
        "symptomatic but hasn't been tested yet",
        "no symptoms",
        "don't know"
    ]);

const symptoms = makeEnum([
        "mild fatigue",
        "low-grade fever",
        "cough", 
        "chills", 
        "runny nose", 
        "nasal congestion", 
        "loss of taste and/or smell", 
        "headache", 
        "muscle and joint pain", 
        "tight feeling in chest", 
        "trouble breathing"
    ]);

const self_isolate = makeEnum([
        "Yes", 
        "Yes, but need assistance", 
        "No"
    ]);

const assistance = makeEnum([
        "Food support (grocery delivery, food access, etc.)",
        "Shelter (if homeless or experiencing housing instability)", 
        "Financial support (paying bills, finding work, etc.)", 
        "Finding primary care physician", 
        "Healthcare support", 
        "Health Insurance", 
        "Home care support (cleaning person, housekeeper)", 
        "Medications/Medical supplies", 
        "Personal care / hygiene items", 
        "Mental health support", 
        "Clothing", 
        "Other"
    ]);

const case_call_status = makeEnum([
        "Have not called yet", 
        "Called, didn’t leave voicemail", 
        "Called, left voicemail", 
        "Call again", 
        "Does not want interview", 
        "Family completed interview", 
        "Partial completed interview", 
        "Patient completed interview", 
        "Unable to reach", 
        "Unable to reach, bad number"
    ]);

const preexisting_conditions = makeEnum([
        "Chronic Respiratory Illness (Asthma, COPD, Emphysema, etc)", 
        "Cardiovascular Disease (High blood pressure, cardiac event, etc.)", 
        "Diabetes", 
        "Cancer", 
        "Immunocompromised (HIV/AIDS, etc.)", 
        "Immunosuppressed (medicinally)", 
        "None Indicated", 
        "Other"
    ]);

const gender = makeEnum([
        "female",
        "male", 
        "other", 
        "prefer not to disclose"
    ]);

const race = makeEnum([
        "American Indian or Alaska Native", 
        "Asian", 
        "Black or African American",  
        "Hispanic or Latino", 
        "Native Hawaiian or Other Pacific Islander", 
        "White", 
        "Prefer not to answer"
    ]);

const suspected_exposure = makeEnum([ 
        "Travel", 
        "Healthcare Work (Physician, Nurse, etc)", 
        "Work (Customer Service, Office Work, etc)", 
        "Close contact with confirmed COVID-19", 
        "Other", 
        "Don't Know/Unsure"
    ]);

const employment = makeEnum([
        "Employed", 
        "Student", 
        "Volunteer", 
        "Stay-at-Home Parent (Homemaker)", 
        "Unemployed", 
        "Retired", 
        "Disability" 
    ]);

const saw_doctor = makeEnum([
        "Yes", 
        "No", 
        "Do not have one"
    ]);

const insurance = makeEnum([
        "Private Insurance (Anthem Blue Cross/Blue Shield, Aetna, United Healthcare, Humana, etc.)", 
        "Medicaid/Husky", 
        "Medicare", 
        "Yale Health Plan", 
        "Combination of Health Insurances", 
        "Self-Pay/Cash", 
        "Uninsured", 
        "Don't Know/Refuse to Share"
    ]);

const reason_flagged = makeEnum([
        "Medical Emergency",
        "Risk of Self-Harm or Harm to Others",
        "Domestic Violence"
    ]);

function makeEnum(array) {
    let dict = []
    for (let i in array) {
        dict.push({'key': i, 'value': array[i]})
    }
    const obj = {
        asArray: array,
        asDict: dict
    }
    return obj
}

export default { contact_type, age_group, contact_call_status, 
relationship, language, symptomatic,
symptoms, self_isolate, assistance, case_call_status,
preexisting_conditions, gender, race, suspected_exposure, 
employment, saw_doctor, insurance, reason_flagged }
