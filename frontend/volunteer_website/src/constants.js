const relationships = [
    /* 0 */ "parent",
    /* 1 */ "grandparent",
    /* 2 */ "child",
    /* 3 */ "friend",
    /* 4 */ "work colleague",
    /* 5 */ "other",
    /* 6 */ "don't want to say"
]; 
const languages = [
    {
        key: 0,
        status: "English"
    },
    {
        key: 1,
        status: "Spanish"
    },
    {
        key: 2,
        status: "Mandarin"
    },
    {
        key: 3,
        status: "Arabic"
    }
];

const ages = [
    /* 0 */ "Minor",
    /* 1 */ "Adult",
    /* 2 */ "Elderly",    
];

const callStatuses = [
    {
        key: 0,
        status: "Have not called"
    },
    {
        key: 1,
        status: "Called, didn't leave voicemail"
    },
    {
        key: 2,
        status: "Called, left voicemail"
    },
    {
        key: 3,
        status: "Call again"
    },
    {
        key: 4,
        status: "Declined interview"
    },
    {
        key: 5,
        status: "Partially completed interview"
    },
    {
        key: 6,
        status: "Family completed interview"
    },
    {
        key: 7,
        status: "Patient completed interview"
    },
    {
        key: 8,
        status: "Unable to reach"
    },
    {
        key: 9,
        status: "Unable to reach, bad number"
    },
];

const contactStatuses = [
    {
        key: 0,
        status: "Have not notified yet"
    },
    {
        key: 1,
        status: "No, left voicemail"
    },
    {
        key: 2,
        status: "No, did not leave voicemail"
    },
    {
        key: 3,
        status: "Unable to reach"
    },
    {
        key: 4,
        status: "Unable to reach, bad number"
    },
    {
        key: 5,
        status: "Yes, notified contact"
    },
    {
        key: 6,
        status: "Yes, notified family"
    },
    {
        key: 7,
        status: "Yes, notified proxy"
    },
];

const contactType = [
    /* 0 */ "minimal",
    /* 1 */ "close",
];

const selfIsos = [
    {
        key: 0,
        status: "yes"
    },
    {
        key: 1,
        status: "yes, but need assistance"
    },
    {
        key: 2,
        status: "no"
    },
];

const symptoms = [
    {
        key: 0,
        status: "mild fatigue"
    },
    {
        key: 1,
        status: "low-grade fever"
    },
    {
        key: 2,
        status: "cough"
    },
    {
        key: 3,
        status: "chills"
    },
    {
        key: 4,
        status: "runny nose"
    },
    {
        key: 5,
        status: "nasal congestion"
    },
    {
        key: 6,
        status: "loss of taste and/or smell"
    },
    {
        key: 7,
        status: "headache"
    },
    {
        key: 8,
        status: "muscle and joint pain"
    },
    {
        key: 9,
        status: "tight feeling in chest"
    },
];

const assistances = [
    {
        key: 0,
        status: "food"
    },
    {
        key: 1,
        status: "mental health"
    },
    {
        key: 2,
        status: "work-related"
    },
    {
        key: 3,
        status: "other"
    }
];


export default {
    relationships, ages, languages, callStatuses, contactStatuses, contactType, selfIsos, symptoms, assistances
};