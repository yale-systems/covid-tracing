
export const patients = [
    {
      // personal information
      patient_id: 1,
      first_name: "Richard",
      last_name: "Greenberd",
      username: "patient1",
      password: "password",
      gender: 0,
      phone: 2406319313,
      language: 2,
      email: "fish@fishlake.org",
      dob: "1980-05-07",
      race: 0,

      // admin information
      requested_interview: false,
      manager_id: 1,
      volunteer_id: null,
      notes: '',
      case_call_status: 3,
      times_called: 1,

      // case information
      diagnosis_date: "2020-05-28",
      onset_date: "2020-05-30",
      last_worked_date: "2020-05-21",
      travelled: false,
      saw_doctor: true,
      knows_status: true,
      symptomatic: true,
      symptoms: [0, 1],
      self_isolate: 1,
      preexisting_conditions: [0],

      // meta information
      employment: 0,
      insurance: 0,
      suspected_exposure: [0],
      home_address: "265 Dwight St. New Haven, CT",
      housing_insecure: false,
      shelter_name: '',
      assistance: [],
      referral: false,
      flagged: false,
      reason_flagged: null,
    },
    {
      // personal information
      patient_id: 2,
      first_name: "Bessie",
      last_name: "Greenberd",
      username: "patient2",
      password: "password",
      gender: 1,
      phone: 2033334443,
      language: 0,
      email: "orange@orangelakecounty.org",
      dob: "1982-06-27",
      race: 1,

      // admin information
      requested_interview: false,
      manager_id: 1,
      volunteer_id: 3,
      notes: '',
      case_call_status: 4,
      times_called: 0,

      // case information
      diagnosis_date: "2020-06-28",
      onset_date: "2020-06-30",
      last_worked_date: "2020-06-21",
      travelled: false,
      saw_doctor: true,
      knows_status: true,
      symptomatic: true,
      symptoms: [0, 1, 2],
      self_isolate: 0,
      preexisting_conditions: [0],

      // meta information
      employment: 1,
      insurance: 0,
      suspected_exposure: [0],
      home_address: "Pleasant Rd. Yorkshire, Talahassee",
      housing_insecure: false,
      shelter_name: '',
      assistance: [],
      referral: false,
      flagged: false,
      reason_flagged: null,
    },
    {
      // personal information
      patient_id: 3,
      first_name: "Jennie",
      last_name: "Allen",
      username: "patient3",
      password: "password",
      gender: 1,
      phone: 6504078989,
      language: 0,
      email: "tweet@tweeter.com",
      dob: "1990-01-12",
      race: 2,

      // admin information
      requested_interview: true,
      manager_id: 1,
      volunteer_id: 4,
      notes: '',
      case_call_status: 5,
      times_called: 1,

      // case information
      diagnosis_date: "2020-06-20",
      onset_date: '',
      last_worked_date: "2020-06-22",
      travelled: true,
      saw_doctor: false,
      knows_status: false,
      symptomatic: false,
      symptoms: [],
      self_isolate: 2,
      preexisting_conditions: [],

      // meta information
      employment: 1,
      insurance: 3,
      suspected_exposure: [6],
      home_address: "423 Durnham St, FL",
      housing_insecure: false,
      shelter_name: '',
      assistance: [],
      referral: true,
      flagged: false,
      reason_flagged: null,
    },
    {
      // personal information
      patient_id: 4,
      first_name: "Raine",
      last_name: "Slybeird",
      username: "patient4",
      password: "password",
      gender: 2,
      phone: 1998889102,
      language: 2,
      email: "musiclover@alcraeft.net",
      dob: "1987-02-12",
      race: 0,

      // admin information
      requested_interview: false,
      manager_id: 1,
      volunteer_id: 4,
      notes: 'patient is undocumented',
      case_call_status: 6,
      times_called: 2,

      // case information
      diagnosis_date: "2020-07-01",
      onset_date: "2020-07-01",
      last_worked_date: "2020-07-01",
      travelled: false,
      saw_doctor: true,
      knows_status: true,
      symptomatic: true,
      symptoms: [0, 1, 2],
      self_isolate: 1,
      preexisting_conditions: [4, 2],

      // meta information
      employment: 0,
      insurance: 7,
      suspected_exposure: [2],
      home_address: "367 Elmhurst, Elm St New Haven",
      housing_insecure: false,
      shelter_name: '',
      assistance: [],
      referral: false,
      flagged: true,
      reason_flagged: 0,
    },
    {
      // personal information
      patient_id: 5,
      first_name: "Joanna",
      last_name: "Codiene",
      username: "patient5",
      password: "password",
      gender: 1,
      phone: 5835555442,
      language: 0,
      email: "elms@elmcity.net",
      dob: "1960-07-04",

      // admin information
      requested_interview: false,
      manager_id: 1,
      volunteer_id: 5,
      notes: '',
      case_call_status: 5,
      times_called: 1,

      // case information
      diagnosis_date: "2020-07-01",
      onset_date: "2020-07-01",
      last_worked_date: "2020-07-01",
      travelled: false,
      saw_doctor: true,
      knows_status: true,
      symptomatic: true,
      symptoms: [2, 3],
      self_isolate: 0,
      preexisting_conditions: [3],

      // meta information
      employment: 1,
      insurance: 0,
      suspected_exposure: [2],
      home_address: "22 Goshen Ct, Gaithersburg MD",
      housing_insecure: true,
      shelter_name: "Martha's Place",
      assistance: [0, 1],
      referral: false,
      flagged: true,
      reason_flagged: 2,
    },
]

export const contacts = [
    {
      // personal information
      contact_id: 1,
      first_name: "Joe",
      last_name: "Shmo",
      phone: 2406211595,
      email: "joe.shmo@yale.edu",
      age_group: 1,
      language: 1,

      // contact information
      household: true,
      relationship: 0,
      contact_type: 0,
      healthcare: false,
      symptomatic: true,
      symptoms: [],
      self_isolate: null,
      isolated_from_patient: false,
      assistance: [],
      contact_date: "2020-06-01",
  
      // admin information
      contact_call_status: 0,
      times_called: 0,
      update_date: "2020-06-10",
      volunteer_id: 2,
      patient_id: 1,
    },
    {
      // personal information
      contact_id: 2,
      first_name: "Velma",
      last_name: "Whitney",
      phone: 2403339999,
      email: "jheres@mac.com",
      age_group: 1,
      language: 0,

      // contact information
      household: false,
      relationship: 3,
      contact_type: 1,
      healthcare: false,
      symptomatic: false,
      symptoms: [],
      self_isolate: null,
      isolated_from_patient: false,
      assistance: [],
      contact_date: "2020-06-20",
  
      // admin information
      contact_call_status: 0,
      times_called: 0,
      update_date: "2020-06-22",
      volunteer_id: 2,
      patient_id: 1,
    },
    {
      // personal information
      contact_id: 3,
      first_name: "Aoife",
      last_name: "Porter",
      phone: 2039031233,
      email: "rkobes@gmail.com",
      age_group: 1,
      language: 1,

      // contact information
      household: false,
      relationship: 4,
      contact_type: 1,
      healthcare: false,
      symptomatic: false,
      symptoms: [],
      self_isolate: true,
      isolated_from_patient: false,
      assistance: [],
      contact_date: "2020-6-29",
  
      // admin information
      contact_call_status: 5,
      times_called: 1,
      update_date: "2020-06-29",
      volunteer_id: 1,
      patient_id: 1,
    },
    {
      // personal information
      contact_id: 4,
      first_name: "Harris",
      last_name: "Harrison",
      phone: 9356701256,
      email: "hhdallara@verizon.net",
      age_group: 2,
      language: 0,

      // contact information
      household: false,
      relationship: 5,
      contact_type: 0,
      healthcare: false,
      symptomatic: true,
      symptoms: [0, 1],
      self_isolate: false,
      isolated_from_patient: false,
      assistance: [0, 1],
      contact_date: "2020-06-25",
  
      // admin information
      contact_call_status: 6,
      times_called: 2,
      update_date: "2020-06-26",
      volunteer_id: 1,
      patient_id: 1,
    },
    {
      // personal information
      contact_id: 5,
      first_name: "Newton",
      last_name: "Avila",
      phone: 8905671234,
      email: "amimojo@att.net",
      age_group: 0,
      language: 0,

      // contact information
      household: false,
      relationship: 3,
      contact_type: 1,
      healthcare: false,
      symptomatic: false,
      symptoms: [],
      self_isolate: null,
      isolated_from_patient: false,
      assistance: [],
      contact_date: "2020-06-20",
  
      // admin information
      contact_call_status: 0,
      times_called: 0,
      update_date: "2020-06-22",
      volunteer_id: 1,
      patient_id: 1,
    },
]

export const volunteers = [
    {
        volunteer_id: 1,
        first_name: "Sammy",
        last_name: "Delulio",
        phone: 9231234323,
        email: "sammy.delulio@yale.edu",
        languages: [0, 3],
        username: "volunteer1",
        password: "password",
        // admin data
        interviewer: true,
        total_capacity: 5,
        remaining_capacity: 3,
        current_cases: 2,
        completed_cases: 1,
        manager_id: 1
    },
    {
        volunteer_id: 2,
        first_name: "Jack",
        last_name: "Josenhart",
        phone: 2312332432,
        email: "jack.josenhart@yale.edu",
        languages: [0],
        username: "volunteer2",
        password: "password",
        // admin data
        interviewer: false,
        total_capacity: 2,
        remaining_capacity: 0,
        current_cases: 2,
        completed_cases: 1,
        manager_id: 1
    },
    {
        volunteer_id: 3,
        first_name: "Nancy",
        last_name: "Josenhart",
        phone: 4273625372,
        email: "nancy.josenhart@gmail.com",
        languages: [0, 1],
        username: "volunteer3",
        password: "password",
        // admin data
        interviewer: true,
        total_capacity: 3,
        remaining_capacity: 3,
        current_cases: 3,
        completed_cases: 3,
        manager_id: 1
    },
    {
        volunteer_id: 4,
        first_name: "Elio",
        last_name: "Mastnor",
        phone: 6237432743,
        email: "elio.mastnor@yale.edu",
        languages: [1],
        username: "volunteer4",
        password: "password",
        // admin data
        interviewer: true,
        total_capacity: 5,
        remaining_capacity: 3,
        current_cases: 2,
        completed_cases: 1,
        manager_id: 1
    },
    {
        volunteer_id: 5,
        first_name: "Jart",
        last_name: "Mringo",
        phone: 7263163253,
        email: "jmringo123@comcast.net",
        languages: [2],
        username: "volunteer5",
        password: "password",
        // admin data
        interviewer: true,
        total_capacity: 5,
        remaining_capacity: 3,
        current_cases: 2,
        completed_cases: 1,
        manager_id: 1
    },
]

export const manager = {
  manager_id: 1,
  username: "manager1",
  password: "password",
  name: "Manda",
  org_name: "Yale Health"
}