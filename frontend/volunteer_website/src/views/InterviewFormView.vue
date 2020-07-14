<template>
    <div>
        <v-app-bar flat color="#e8f5ff" class="sticky shadow">
            <v-row class="d-flex" align="center">
                <v-col cols="2"> 
                    <v-btn text @click="handleBack">
                        <v-icon> 
                            mdi-arrow-left
                        </v-icon>
                        back
                    </v-btn>
                </v-col>
            </v-row>
        </v-app-bar>
        <v-row class="darkRow pl-2">
            <v-col class="separated full overflow-y-auto " cols=3 >
                <!-- todo: import these colors from a constants file -->
                <v-container class="pb-1 pt-0">
                    <v-container fluid class="pt-0">
                        <v-row class="my-0">
                            <h1> {{getFullName(patient)}} </h1>
                        </v-row>
                        
                    <v-item-group v-model="selectedIndex" class="mt-2">
                        <v-row class="pb-0">
                            <v-item v-slot:default="{ active, toggle }"> 
                                <v-sheet @click="toggle()"
                                    class="customStepper my-0"
                                  
                                    :elevation="active ? 4 : 1"
                                    :color="active ? '#e8f5ff' : 'white'"> 
                                        <circleicon class="customStepperIcon"
                                            :color="active ? '#00579a' : 'rgba(255, 255, 255, 0)'" 
                                            :textColor="active ? '#ffffff' : '#00579a'">1</circleicon> 
                                        <div class="stepperText"> Patient Information </div>
                                </v-sheet>
                            </v-item>
                        </v-row>
                        <v-row class="mt-0">
                            <v-item v-slot:default="{ active, toggle }"> 
                                <v-sheet @click="toggle()"
                                    class="customStepper mb-0"
                                    :elevation="active ? 4 : 1"
                                    :color="active ? '#e8f5ff' : 'white'"> 
                                        <circleicon class="customStepperIcon"
                                            :color="active ? '#00579a' : 'rgba(255, 255, 255, 0)'"
                                            :textColor="active ? '#ffffff' : '#00579a'">2</circleicon> 
                                        View All Contacts
                                </v-sheet>
                            </v-item>
                        </v-row>
                        <v-row>
                            <v-item v-slot:default="{ active, toggle }"> 
                                <v-sheet @click="toggle()"
                                    class="customStepper"
                                    :elevation="active ? 4 : 1"
                                    :color="active ? '#e8f5ff' : 'white'"> 
                                        <circleicon class="customStepperIcon"
                                            :color="active ? '#00579a' : 'rgba(255, 255, 255, 0)'" 
                                            :textColor="active ? '#ffffff' : '#00579a'">3</circleicon> 
                                        Events
                                </v-sheet>
                            </v-item>
                        </v-row>
                    </v-item-group>
                </v-container>
                </v-container>
                <!-- todo: make this height a computed value -->
                <v-container fluid class="my-0 py-0">
                    <v-textarea filled class ="ml-1 mb-5" auto-grow hide-details rows="20" row-height="14" placeholder="Scratchpad - use this space to take notes during the interview.">
                    </v-textarea>
                    <v-btn block class="ml-1 mt-0 mr-5 mb-0" outlined color='primary'> Save </v-btn>
                    <v-dialog v-model="dialog" width="500">
                        <template v-slot:activator="{ on, attrs }">
                            <v-btn block class="ml-1 mr-5 mt-3" color='primary' v-bind="attrs" v-on="on"> Save and Exit </v-btn>
                        </template>
                        <v-card>
                            <v-container fluid>
                                <v-card-title primary-title>
                                    Were you able to reach {{getFullName(patient)}}?
                                </v-card-title>
                                    <v-container fluid class="mx-4 px-4" style="max-width:93%;">
                                        <v-row>
                                            <p class="pb-0 mb-0"> Status: </p>
                                        </v-row>
                                        <v-row>
                                            <v-select class="mt-0 pt-0"
                                            v-model="patient.callStatus"
                                            :items="callStatuses"
                                            item-value="key"
                                            item-text="status">
                                            </v-select>
                                        </v-row>
                                        <v-row>
                                            <p> Notes: </p>
                                        </v-row>
                                        <v-row>
                                            <v-textarea rows="2" auto-grow class="mt-0 pt-0"></v-textarea>
                                        </v-row>
                                        <v-row>
                                            <v-spacer></v-spacer>
                                            <v-btn color="primary" @click="handleBack">
                                                save and exit
                                            </v-btn>
                                        </v-row>
                                    </v-container>             
                                <!-- <v-card-actions>
                                    <v-spacer></v-spacer>
                                    <v-btn
                                    color="primary"
                                    text
                                    @click="dialog = false"
                                    >
                                    I accept
                                    </v-btn>
                                </v-card-actions> -->
                            </v-container>
                        </v-card>
                    </v-dialog>
                </v-container>
            </v-col>
            <v-col class="overflow-y-auto full ma-0 pa-0">
                <v-container fluid class="pa-0 ma-0">
                    <component :is="formComponent" v-bind="formComponentProps"></component>
                </v-container> 
            </v-col>
        </v-row>
    </div>
</template>

<script>
import circleicon from "@/sharedComponents/circleicon.vue"
import PreliminaryDiv from "@/interviewerComponents/PreliminaryDiv.vue"
import HouseholdContactDiv from "@/interviewerComponents/HouseholdContactDiv.vue"
import EventsDiv from "@/interviewerComponents/EventsDiv.vue"
import patientGetters from "@/patientGetters.js"
import constants from '@/constants.js'

export default {
    name: "InterviewFormView",
    data: () => {
        return {
            selectedIndex: 0,
            dialog: false,
        }
    },
    components: {
        circleicon,
        PreliminaryDiv,
        HouseholdContactDiv,
        EventsDiv
    },
    computed: {
        patientID() {
            return parseInt(this.$route.params.id)
        },
        patient() {
            return this.$store.getters.getPatientById(this.patientID)
        },
        formComponent() {
            if(this.selectedIndex == undefined) {
                return ''
            }
            if (this.selectedIndex == 0) {
                return 'PreliminaryDiv'
            } else if (this.selectedIndex == 1) {
                return 'HouseholdContactDiv'
            } else {
                return 'EventsDiv'
            }
        },
        formComponentProps() {
            if (this.selectedIndex == 0) {
                return {
                    name: this.getFullName(this.patient),
                    phone: this.getPhone(this.patient),
                    age: this.getAge(this.patient),
                    language: this.getLanguage(this.patient),
                    symptomatic: this.getSymptomatic(this.patient)
                }
            } else {
                return null
            }

        },
        callStatuses() {
            return constants.callStatuses;
        }
    },
    watch: {
        selectedIndex(newVal, oldVal) {
            if(newVal === undefined) {
                this.$nextTick(() => {
                    this.selectedIndex = oldVal
                })
            }
        },
    },
    mounted() {
        this.$store.commit('setDate', this.patient.date)
    },
    methods: {
        getFullName: patientGetters.getFullName,
        getPhone: patientGetters.getPhone,
        getAge: patientGetters.getAge,
        getLanguage: patientGetters.getLanguage,
        getSymptomatic: patientGetters.getSymptomatic,

        handleBack() {
            let pid = this.patientID;
            this.$store.commit('setOpenPID', pid)
            this.$router.push({name: 'PDash'})
        }
    }
}
</script>

<style scoped>
.customStepperIcon{
    box-shadow: 0 0 0 .9pt #00579a;
}

.customStepperText {
    color: #00579a;
}
.customStepper{
    height: 50px;
    width: 100%;
    display: flex;
    justify-content: left;
    align-items: center;
    padding: 10px;
    margin: 5px;
    box-shadow: 0 0 0 .5pt #00579a;
    transition-property: background-color;
    transition-duration: .4s;
}
.customStepper:hover{
    cursor: pointer;
}

.darkRow {
    background-color: #f8f9fa;
    height: 91vh;
}

.separated {
    border-right: 1px solid #E2E2E2;
}

::-webkit-scrollbar { 
    display: none; 
}

.full {
    height:91vh;
}

.shadow {
    box-shadow: 0px 0px 8px rgba(0, 0, 0, .5);
}
</style>