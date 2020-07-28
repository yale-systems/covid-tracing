<template>
    <div>
        <v-form ref="form">
            <v-container>
                <v-row class="mt-4">
                    <h3 class="ml-6"> Basic Information </h3>
                </v-row>
                <v-row class="d-flex flex-wrap justify-space-around">
                    <v-text-field class="min400" label="First Name*" v-model="patient.first_name"> </v-text-field>
                    <v-text-field class="min400" label="Last Name" v-model="patient.last_name"> </v-text-field>
                    <Selector 
                        class="min400"
                        field="gender"
                        v-model="patient.gender"
                    />
                    <Selector 
                        class="min400"
                        field="race"
                        v-model="patient.race"
                    />
                    <v-menu
                        v-model="menu1"
                        :close-on-content-click="false"
                        transition="slide-y-transition"
                        offset-y
                        min-width="290px"
                        mr-2
                        >
                        <template v-slot:activator="{ on }">
                            <v-text-field
                                class="min400"
                                v-model="patient.dob"
                                prepend-inner-icon="mdi-calendar"
                                readonly
                                label="Date of Birth"
                                v-on="on"
                            ></v-text-field>
                        </template>
                        <v-date-picker 
                            v-model="patient.dob" 
                            :max="todayDate"
                            no-title 
                            scrollable
                            @input="menu1=false">
                        </v-date-picker>
                    </v-menu>
                </v-row>
                <v-row class="mt-4">
                    <h3 class="ml-6"> Contact Information </h3>
                </v-row>
                <v-row class="d-flex flex-wrap justify-space-around"> 
                    <v-text-field
                        class="min400" label="Phone Number" v-model="patient.phone_number"
                    ></v-text-field>
                    <v-text-field
                        class="min400" label="Email Address" v-model="patient.phone_number"
                    ></v-text-field>
                    <Selector 
                        class="min400"
                        field="language"
                        v-model="patient.language"
                    />
                </v-row>
                <TFToggle 
                    label="Requested Interview"
                    v-model="patient.requested_interview"
                />
                <v-row class="mt-4">
                    <h3 class="ml-6"> Case Information </h3>
                </v-row>
                <v-row class="d-flex flex-wrap justify-space-around"> 
                    <v-menu
                        v-model="menu2"
                        :close-on-content-click="false"
                        transition="slide-y-transition"
                        offset-y
                        min-width="290px"
                        mr-2
                        >
                        <template v-slot:activator="{ on }">
                            <v-text-field
                                class="min400"
                                v-model="patient.diagnosis_date"
                                prepend-inner-icon="mdi-calendar"
                                readonly
                                label="Diagnosis Date"
                                v-on="on"
                            ></v-text-field>
                        </template>
                        <v-date-picker 
                            v-model="patient.diagnosis_date" 
                            :max="todayDate"
                            no-title 
                            scrollable
                            @input="menu2=false">
                        </v-date-picker>
                    </v-menu>
                    <v-menu
                        v-model="menu3"
                        :close-on-content-click="false"
                        transition="slide-y-transition"
                        offset-y
                        min-width="290px"
                        mr-2
                        >
                        <template v-slot:activator="{ on }">
                            <v-text-field
                                class="min400"
                                v-model="patient.onset_date"
                                prepend-inner-icon="mdi-calendar"
                                readonly
                                label="Symptom Onset Date"
                                v-on="on"
                            ></v-text-field>
                        </template>
                        <v-date-picker 
                            v-model="patient.onset_date" 
                            :max="todayDate"
                            no-title 
                            scrollable
                            @input="menu3=false">
                        </v-date-picker>
                    </v-menu>
                    <v-menu
                        v-model="menu4"
                        :close-on-content-click="false"
                        transition="slide-y-transition"
                        offset-y
                        min-width="290px"
                        mr-2
                        >
                        <template v-slot:activator="{ on }">
                            <v-text-field
                                class="min400"
                                v-model="patient.last_worked_date"
                                prepend-inner-icon="mdi-calendar"
                                readonly
                                label="Last Date at Work/School"
                                v-on="on"
                            ></v-text-field>
                        </template>
                        <v-date-picker 
                            v-model="patient.last_worked_date" 
                            :max="todayDate"
                            no-title 
                            scrollable
                            @input="menu4=false">
                        </v-date-picker>
                    </v-menu>
                    <v-select
                        label="Symptoms"
                        :items="symptomList"
                        multiple
                        chips
                        item-value="key"
                        item-text="status"
                        class="my-0 py-0 min400"
                        v-model="patient.symptoms"
                    >
                    </v-select>
                    <v-select
                        label="Suspected Exposure"
                        :items="symptomList"
                        multiple
                        chips
                        item-value="key"
                        item-text="status"
                        class="my-0 py-0 min400"
                        v-model="patient.suspected_exposure"
                    ></v-select>
                    <v-select
                        label="Pre-existing Conditions"
                        :items="symptomList"
                        multiple
                        chips
                        item-value="key"
                        item-text="status"
                        class="my-0 py-0 min400"
                        v-model="patient.preexisting_conditions"
                    >
                    </v-select>
                     <Selector 
                        class="min400"
                        field="self_isolate"
                        v-model="patient.self_isolate"
                    />
                </v-row>
                <TFToggle
                    v-model="patient.symptomatic"
                    label="Is this person currently showing symptoms?"
                />
                <TFToggle
                    v-model="patient.travelled"
                    label="Has this person travelled recently?"
                />
                <TFToggle
                    v-model="patient.saw_doctor"
                    label="Has this person seen a doctor?"
                />
                <TFToggle
                    v-model="patient.knows_status"
                    label="Does this person know if they are sick?"
                />
                
                <v-row class="mt-4">
                    <h3 class="ml-6"> Other Information </h3>
                </v-row>
                <v-row class="d-flex flex-wrap justify-space-around"> 
                    <Selector 
                        class="min400"
                        field="employment"
                        v-model="patient.employment"
                    />
                    <Selector 
                        class="min400"
                        field="insurance"
                        v-model="patient.insurance"
                    />
                </v-row>
                <v-row class="d-flex flex-wrap justify-space-around"> 
                    <v-text-field
                        class="min400"
                        label="Shelter Name"
                        v-model="patient.shelter_name"
                    >
                    </v-text-field>
                    <v-text-field
                        class="min400"
                        label="Home Address"
                        v-model="patient.home_address"
                    >
                    </v-text-field>
                </v-row>
                <TFToggle
                    v-model="patient.housing_insecure"
                    label="Is this person housing insecure?"
                />
                <TFToggle
                    v-model="patient.referral"
                    label="Was this person referred?"
                />
                <TFToggle
                    v-model="patient.flagged"
                    label="Does this person need to be prioritized?"
                />
                <v-row v-if="patient.flagged">
                    <Selector 
                        class="min400"
                        field="reason_flagged"
                        v-model="patient.reason_flagged"
                    />
                </v-row>
                <v-row>
                    <v-select
                        label="Assistance Requested"
                        :items="symptomList"
                        multiple
                        chips
                        item-value="key"
                        item-text="status"
                        class="my-0 py-0 min400"
                        v-model="patient.assistance"
                    >
                    </v-select>
                </v-row>
                <v-row class="mx-6">
                    <v-textarea
                        auto-grow
                        label="Notes"
                        rows="1"
                        v-model="patient.notes"
                    >
                    </v-textarea>
                </v-row>
            </v-container>
        </v-form>
    </div>
</template>

<script>
import moment from 'moment'
import Selector from "@/components/Selector"
import TFToggle from '@/components/TFToggle'

export default {
    name: "NewCaseForm",
    components: {
        Selector, TFToggle
    },
    data: () => {
        return {
            patient: {
                // personal information
                patient_id: -1,
                first_name: undefined,
                last_name: undefined,
                username: undefined,
                password: undefined,
                gender: undefined,
                phone_number: undefined,
                language: undefined,
                email: undefined,
                dob: '',
                race: undefined,

                // admin information
                requested_interview: false,
                // TODO GET MANAGER ID FROM CURRENT ID IN STORE
                manager_id: null,
                volunteer_id: null,
                notes: undefined,
                case_call_status: undefined,
                times_called: 0,

                // case information
                diagnosis_date: '',
                onset_date: '',
                last_worked_date: '',
                travelled: undefined,
                saw_doctor: undefined,
                knows_status: undefined,
                symptomatic: undefined,
                symptoms: [],
                self_isolate: undefined,
                preexisting_conditions: [],

                // meta information
                employment: undefined,
                insurance: undefined,
                suspected_exposure: [],
                home_address: undefined,
                housing_insecure: undefined,
                shelter_name: undefined,
                assistance: [],
                referral: undefined,
                flagged: undefined,
                reason_flagged: undefined
            },
            todayDate: moment().format('YYYY-MM-DD'),
            menu1: false,
            menu2: false,
            menu3: false,
            menu4: false,
            symptomList: []
        }
    },
    async mounted() {
        let newID = await this.$store.dispatch('addPatient', Object.assign({}, this.patient))
        this.patient.patient_id = newID
    },
    props: {
        save: {
            Boolean
        }
    },
    computed: {
        manager_id() {
            if(this.$store.state.loggedIn) {
                return this.$store.state.userInfo.manager_id
            } else {
                return 1
            }
        }
    },
    watch: {
        async save() {
            // validate the form
            let newID = await this.$store.dispatch('addPatient', Object.assign({}, this.patient))
            this.patient.patient_id = newID
        }
    }
}
</script>

<style scoped>
.min400 {
    width: 300px;
    margin-left: 40px;
    margin-right: 40px;
}
.min500 {
    width: 350px;
    margin-left: 40px;
    margin-right: 40px;
}

</style>