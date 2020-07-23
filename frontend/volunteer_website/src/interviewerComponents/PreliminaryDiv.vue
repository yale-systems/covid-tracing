<template>
    <v-container fluid class="ma-5" style="max-width:95%; align-items:center;">
        <div>
            <p class="title"> {{ gettersHelper(patient, 'name') }} </p>
            {{gettersHelper(patient, 'phone')}}
            <p> {{ gettersHelper(patient, 'age')}}{{ gettersHelper(patient, 'age') ? ', ': ''}}speaks {{ gettersHelper(patient, 'language')}} </p>
            <p> {{gettersHelper(patient, 'symptomatic') ? "Is currently known to have symptoms" : "Is not known to have symptoms"}} </p>
        </div><hr class="mt-6" style="border-top: 1px solid rgb(226, 226, 226);"><br>
        <div>
            <h4 class="header"> Voicemail </h4><br>
            <p class="font-weight-medium"> My name is {{ volunteer.first_name }} and I am calling from [user.department]. This message is for {{ gettersHelper(patient, 'name') }}. 
                Please call me back as soon as you are able at the following number ___________. Thank you. 
            </p>
            <p style="color:#616161; font-size:small;"><i> Try calling back 30 minutes or so later as the case may be screening calls and the voicemail might help clarify your purpose/intention.
            </i></p><hr class="mt-6" style="border-top: 1px solid rgb(226, 226, 226);"><br>
            <h4 class="header"> Call </h4><br>
            <p class="font-weight-medium"> Hello, my name is {{ volunteer.first_name }} and I’m calling on behalf of [user.department]. Can I please speak with {{ gettersHelper(patient, 'name') }}?  Would you prefer to continue in English or another language?
            </p>
            <p><i style="color:#616161; font-size:small;"> If not English, please indicate in the "Call Outcome Survey"
            </i></p>
            <p class="font-weight-medium"> To ensure I am talking to the right person, can you please verify your date of birth?
            </p>
            <p class="font-weight-medium header"><i style="font-size:small;"> DOB: {{ gettersHelper(patient, 'dob').format('MMMM Do, YYYY')}}
            </i></p>
            <p><i style="color:#616161; font-size:small;"> Confirm if DOB matches; if not, ensure that you are talking to the correct person or need to speak to an adult/guardian proxy for a child, someone incapacitated, or still in the hospital. If the case has passed away, please note this in the "Call Outcome Survey".
            </i></p>
            <p class="font-weight-medium"> I understand that you were recently diagnosed with COVID-19. I am calling from the New Haven Health Department to follow-up and to better understand your situation. (Please select appropriate selection box below to continue script/interview). 
            </p>
            <v-divider></v-divider>
            <h4 class="header mt-6"> Questionnaire </h4><br>
            <v-row style="align-items:center">
                <v-col cols="7">
                    <p class="font-weight-medium"> How are you feeling right now? Are you experiencing or have you experienced symptoms related to your COVID illness? <br/>
                        <v-tooltip 
                            bottom
                            max-width="240px"
                            transition="fade-transition">
                            <template v-slot:activator="{ on }">
                            <small 
                                v-on="on"> 
                                <a> I don't know what this means </a> 
                                <v-icon small class="pb-1 pointerOnHover">mdi-help-circle-outline</v-icon>
                            </small> 
                            </template>
                            <span>Select "Patient is symptomatic" if they had any COVID-19 symptoms (e.g shortness of breath, cough, or fever). If they feel healthy but tested positive for COVID-19, select "Patient is not symptomatic"</span>
                        </v-tooltip>
                    </p>
                </v-col>
                <v-col>
                    <v-select placeholder="Click to choose an option" :items="symptomaticItems" item-value="key" item-text="value" v-model="symptomatic"> </v-select>
                </v-col>
            </v-row>
            <v-row class="mt-0" style="align-items:center">
                <v-col v-if="symptomatic != null && symptomatic != undefined" cols="6">
                    <p class="font-weight-medium"> {{ dateMessage}} </p>
                </v-col>
                <v-col v-if="symptomatic != null && symptomatic != undefined">
                    <v-menu
                        ref="menu"
                        v-model="menu"
                        :close-on-content-click="false"
                        transition="slide-y-transition"
                        offset-y
                        min-width="290px"
                        mr-2
                        >
                        <template v-slot:activator="{ on }">
                            <v-text-field
                                class="mr-4 pb-2"
                                v-model="critical_date"
                                placeholder="Click to choose a date"
                                prepend-inner-icon="mdi-calendar"
                                readonly
                                v-on="on"
                            ></v-text-field>
                        </template>
                        <v-date-picker 
                            v-model="critical_date" 
                            :max="todayDate"
                            no-title 
                            scrollable
                            @input="menu=false">
                        </v-date-picker>
                    </v-menu>                        
                </v-col>
            </v-row>
            <v-row style="align-items:center;">
                <v-col>
                    <p class="font-weight-medium"> Are you able to self-isolate?</p>
                </v-col>
                <v-col>
                    <v-select :items="selfIsoItems" item-text="value" item-value="key" placeholder="Click to choose an option" v-model="self_isolate">
                    </v-select>
                </v-col>
            </v-row>
            <v-row v-if="self_isolate == 1">
                <v-col>
                    <p class="font-weight-medium"> What kind of assistance do you need? </p>
                </v-col>
                <v-col>
                    <v-select 
                        :items="assistanceItems" 
                        item-text="value" 
                        item-value="key"
                        placeholder="choose all that apply"
                        multiple
                        chips
                        clearable
                        v-model="assistance">
                    </v-select>
                </v-col>
            </v-row>
            <v-row style="align-items:center">
                <v-col>
                    <p class="font-weight-medium"> Have you traveled outside CT in the last 14 days before your illness started (onset)?
                    </p>
                </v-col>
                <v-col cols="3">
                    <TFToggle v-model="travelled"/>
                </v-col>
            </v-row>
            <v-row style="align-items:center">
                <v-col>
                    <p class="font-weight-medium"> Did you see a primary care physician or doctor for your COVID-19 condition/symptoms?
                    </p>
                </v-col>
                <v-col cols="5">
                    <ThreeToggle v-model="saw_doctor" />
                </v-col>
            </v-row>
            <v-row style="align-items:center">
                <v-col>
                    <p class="font-weight-medium"> Did you learn of your COVID-19 lab result from your physician/doctor's office already?
                    </p>
                </v-col>
                <v-col cols="3">
                    <TFToggle v-model="knows_status" />
                </v-col>
            </v-row>
            <v-row style="align-items:center">
                <v-col>
                    <p class="font-weight-medium"> What health insurance do you currently have/use?
                    </p>
                </v-col>
                <v-col cols="6">
                    <v-select placeholder="Click to choose an option" :items="healthcareItems" item-text="value" item-value="key" v-model="insurance"> </v-select>
                </v-col>
            </v-row>
        </div>
    </v-container>
</template>

<script>
import moment from 'moment'
import getters from '@/methods.js'
import TFToggle from '@/sharedComponents/TFToggle.vue'
import ThreeToggle from '@/sharedComponents/ThreeToggle.vue'
import enums from '@/constants/enums.js'

export default {
    name: "PreliminaryDiv",
    props: {
        patient_id: {
            type: Number,
            required: true
        }
    },
    mixins: [ getters ],
    components: {
        TFToggle, ThreeToggle
    },
    data: () => {
        return {
            symptomaticItems: [
                { 
                    key: true,
                    value: "Patient is symptomatic" 
                },
                {
                    key: false,
                    value: "Patient is not symptomatic"
                }
            ],
            symptomaticResult: "",
            menu: false,
        }
    },
    computed: {
        todayDate() {
            return moment().format('YYYY-MM-DD')
        },
        dateMessage() {
            if (this.patient.symptomatic == 0) {
                return "When did you first begin experiencing symptoms?"
            } else {
                return "When were you diagnosed?"
            }
        },
        volunteer() {
            return this.$store.getters['volunteers/active']
        },
        patient() {
            return this.$store.getters['patients/id'](this.patient_id)
        },
        healthcareItems() {
            return enums.insurance.asDict
        },
        assistanceItems() {
            return enums.assistance.asDict
        },
        selfIsoItems() {
            return enums.self_isolate.asDict
        },
        // v-modeling in vuex store babyyyy
        symptomatic: {
            get() {
                return this.patient.symptomatic == 0 ? true : false
            },
            set(newVal) {
                let value = newVal ? 0 : 2
                this.patient.symptomatic = value
                this.updatePatient()
            }
        },
        critical_date: {
            get() {
                if (this.symptomatic) {
                    return this.patient.onset_date ? this.patient.onset_date.format('YYYY-MM-DD') : ''
                } else if (this.symptomatic == false) {
                    return this.patient.diagnosis_date ? this.patient.diagnosis_date.format('YYYY-MM-DD') : ''
                } else {
                    return ''
                }
            },
            set(newVal) {
                let date = moment(newVal)
                if (this.symptomatic) {
                    this.patient.onset_date = date
                } else if (this.symptomatic == false) {
                    this.patient.diagnosis_date = date
                }
                this.updatePatient()
            }
        },
        self_isolate: {
            get() {
                return this.patient.self_isolate
            },
            set(newVal) {
                this.patient.self_isolate = newVal
                this.updatePatient()
            }
        },
        travelled: {
            get() {
                return this.patient.travelled
            },
            set(newVal) {
                this.patient.travelled = newVal
                this.updatePatient()
            }
        },
        knows_status: {
            get() {
                return this.patient.knows_status
            },
            set(newVal) {
                this.patient.knows_status = newVal
                this.updatePatient()
            }
        },
        assistance: {
            get() {
                return this.patient.assistance
            },
            set(newVal) {
                this.patient.assistance = newVal
                this.updatePatient()
            }
        },
        saw_doctor: {
            get() {
                return this.patient.saw_doctor
            },
            set(newVal) {
                this.patient.saw_doctor = newVal
                this.updatePatient()
            }
        },
        insurance: {
            get() {
                return this.patient.insurance
            },
            set(newVal) {
                this.patient.insurance = newVal
                this.updatePatient()
            }
        },
    },
    watch: {
        date: function() {
            this.$store.commit('setDate', moment(this.date, 'YYYY-MM-DD'))
        },
    },
    methods: {
        updatePatient() {
            this.$store.commit('patients/updatePatient', this.patient)
        },
        makeVuexModel(fieldName) {
            return {
                get: function() {
                    return this.patient[fieldName]
                },
                set: function(newVal) {
                    this.patient[fieldName] = newVal
                    console.log("i have been called")
                    this.updatePatient()
                }
            }
        }
    }
}

</script>

<style scoped>

.inside-stepper-spacing {
    max-width: 630px;
}

.pointerOnHover {
    cursor: pointer;
}
.header {
    color:#01579B;
}
</style>