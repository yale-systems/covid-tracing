<template>
    <div>
        <v-expansion-panels v-model="panel" flat :readonly="readonly">
            <v-expansion-panel>
                <v-expansion-panel-header hide-actions class="pa-0">
                    <v-row class="d-flex align-center mt-0">
                        <v-col cols="3">

                            <v-row>
                                <v-progress-circular 
                                    rotate="-90"
                                    class="mb-2 mr-2"
                                    :value="gettersHelper(patient, 'progress')"
                                    size=20
                                    color="green"
                                    v-if="gettersHelper(patient, 'progress') >= 0"
                                ></v-progress-circular>
                                <v-icon v-else class="pr-2 pb-2" color="red">mdi-close-thick</v-icon>
                                <!-- <v-icon class="mr-4" :color="getProgressColor(patient)"> mdi-checkbox-blank-circle </v-icon> -->
                                <h4 class="mt-1"> {{gettersHelper(patient, 'name')}} </h4>
                            </v-row>
                        </v-col>
                        <v-col cols="2">
                            {{gettersHelper(patient, 'diagnosis_date').format('MMMM Do, YYYY')}}
                        </v-col>
                        <v-col cols="3">
                            {{gettersHelper(patient, 'case_call_status')}}
                        </v-col>
                        <v-col cols="2">
                            {{gettersHelper(patient, 'phone')}}
                        </v-col>
                        <v-col cols="1" class="d-flex align-end">
                            <v-btn color="primary" @click="handleStart">
                                start
                            </v-btn>
                        </v-col>
                        <v-col>
                            <v-btn text color="primary" @click="togglePanel"><v-icon>mdi-menu</v-icon></v-btn>
                        </v-col>
                    </v-row>
                </v-expansion-panel-header>
                <v-expansion-panel-content >
                    <v-row>
                    <v-col>
                        <v-row>
                            <v-icon>mdi-account-outline</v-icon>{{ gettersHelper(patient, 'age') }} {{ gettersHelper(patient, 'gender') }}
                        </v-row>
                        <v-row>
                            <v-icon>mdi-phone-outline</v-icon>speaks {{ gettersHelper(patient, 'language') }}
                        </v-row>
                        <v-row>
                            <v-icon>mdi-virus-outline</v-icon> {{ gettersHelper(patient, 'symptomatic') }}
                        </v-row>
                    </v-col>
                    <v-col>
                        <v-row>
                            <p> Status </p>
                            <v-select :items="statuses" item-text="value" item-value="key"> </v-select>
                        </v-row>
                        <v-row>
                            <p class="pa-0 ma-0"> Notes: </p>
                        </v-row>
                        <v-row>
                            <v-textarea rows="2" auto-grow class="mt-0 pt-0" v-model="notes"></v-textarea>
                        </v-row>
                        <v-row>
                            <v-spacer></v-spacer>
                            <v-btn text color="primary" @click="handleSave">
                                {{ saveMessage }}
                            </v-btn>
                        </v-row>
                    </v-col>
                    </v-row>
                </v-expansion-panel-content>
            </v-expansion-panel>
        </v-expansion-panels>
        <v-divider></v-divider>
    </div>
</template>

<script>
import getter from '@/methods.js'

export default {
    name: 'PatientRow',
    mixins: [ getter ],
    props: {
        patient: {
            Object,
            required: true
        }
    },
    data: () => {
        return {
            panel: undefined,
            readonly: true,
            panelMsg: 'show details',
            saveMessage: 'save'
        }
    },
    computed: {
        statuses() {
            return this.$store.state.enums.CaseCallStatus
        },
        notes: {
            get() {
                return this.patient.notes
            },
            set(newVal) {
                let newPat = this.patient
                newPat.notes = newVal
                this.$store.commit('patients/updatePatient', newPat)
            }
        },
        case_call_status: {
            get() {
                return this.patient.case_call_status
            },
            set(newVal) {
                let newPat = this.patient
                newPat.case_call_status = newVal
                this.$store.commit('patients/updatePatient', newPat)
            }
        }
    },
    methods: {
        togglePanel() {
            this.readonly = !this.readonly

            if(this.panel == undefined) {
                console.log("A")
                this.panelMsg = 'hide details'
                this.panel = 0
            } else {
                console.log("B")
                this.panelMsg = 'show details'
                this.panel = undefined
            }
            let curr = this
            this.$nextTick(() => {
                curr.readonly = !curr.readonly
            })
        },
        handleStart() {
            let pid = this.gettersHelper(this.patient, 'patient_id')
            this.$router.push({path: `/form/${pid}`})
        },
        async handleSave() {
            // todo: update vuex, push changes to backend
            this.saveMessage = 'saving...'
            let curr = this
            await this.$store.dispatch('patients/update', this.patient)
                .then(() => {
                    curr.saveMessage = 'save'
                })
        }
    },
    mounted() {
        if (this.$store.state.openPID == this.gettersHelper(this.patient, 'patient_id')) {
            this.togglePanel()
        }
    }

}
</script>

<style>

</style>