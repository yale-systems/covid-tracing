<template>
    <v-sheet>
        <v-divider></v-divider>
        <v-container v-if="patient === undefined" class="d-flex align-center justify-center">
            <p> Select a case to see more details </p>
        </v-container>
        <v-container class="mt-2" fluid v-else>
            <v-row class="align-center">
                <h2 class="mx-2"> {{gettersHelper(patient, 'name')}} </h2> 
                <v-progress-circular 
                    class="mx-2"
                    :value="progressValue"
                    size=25
                    color="green"
                />
                <v-spacer></v-spacer>
                <v-btn outlined color="primary">View all case data</v-btn>
            </v-row>
            <v-row class="mt-2">
                <v-col>
                    <h3> Personal Information </h3>
                    <v-row class="mx-4">
                        <v-col>
                            <v-row>
                                <b class="mr-1">Date of Birth:</b> {{gettersHelper(patient, 'dob')}}
                            </v-row>
                            <v-row>
                                <b class="mr-1">Language:</b> {{gettersHelper(patient, 'language')}}
                            </v-row>
                            <v-row>
                                <b class="mr-1">Race:</b> {{gettersHelper(patient, 'race')}}
                            </v-row>
                            <v-row>
                                <b>Gender</b>: {{gettersHelper(patient, 'gender')}}
                            </v-row>
                        </v-col>
                    </v-row>
                </v-col>
                <v-col>
                    <h3> Case Information </h3>
                    <v-row class="mx-4">
                        <v-col>
                            <v-row>
                                <b class="mr-1">Diagnosis Date:</b> {{gettersHelper(patient, 'diagnosis_date')}}
                            </v-row>
                            <v-row>
                                <b class="mr-1">Symptomatic:</b> {{gettersHelper(patient, 'symptomatic')}}
                            </v-row>
                        </v-col>
                    </v-row>
                </v-col>
                <v-col>
                    <h3> Interview Information </h3>
                        <v-row class="mx-4">
                            <v-col>
                                <v-row>
                                    <b class="mr-1">Interview Requested:</b> {{gettersHelper(patient, 'requested_interview')}}
                                </v-row>
                                <v-row>
                                    <b class="mr-1">Call Status:</b> {{gettersHelper(patient, 'case_call_status')}}
                                </v-row>
                                <v-row>
                                    <b class="mr-1">Volunteer:</b> {{volName}}
                                </v-row>
                            </v-col>
                        </v-row>
                </v-col>
            </v-row>
            <v-row>
                <v-col>
                    <h3> Contact Information </h3>
                    <v-row class="mx-4">
                        <v-col>
                            <v-row>
                                <b class="mr-1">Email:</b> {{gettersHelper(patient, 'email')}}
                            </v-row>
                            <v-row>
                                <b class="mr-1">Phone:</b> {{gettersHelper(patient, 'phone')}}
                            </v-row>
                        </v-col>
                    </v-row>
                </v-col>
                <v-col>
                    <h3> Flagged Information </h3>
                    <v-row class="mx-4">
                        <v-col>
                            <v-row>
                                <b class="mr-1">Self-isolate:</b> {{gettersHelper(patient, 'self_isolate')}}
                            </v-row>
                            <v-row>
                                <b class="mr-1">Resources requested:</b> {{gettersHelper(patient, 'assistance')}}
                            </v-row>
                            <v-row>
                                <b class="mr-1">Pre-existing conditions:</b> {{gettersHelper(patient, 'preexisting_conditions')}}
                            </v-row>
                        </v-col>
                    </v-row>
                </v-col>
                <v-col>
                    <h3> Notes </h3>
                        <v-row class="mx-4">
                            <v-col>
                                <v-row>
                                    <v-textarea auto-grow outlined rows="2"
                                    class="mt-2 mr-6 ml-1">
                                        {{gettersHelper(patient, 'notes')}}
                                    </v-textarea>
                                </v-row>
                            </v-col>
                        </v-row>
                </v-col>
            </v-row>
        </v-container>
    </v-sheet>
</template>

<script>
import allGetters from '@/constants/methods';

export default {
    name: 'PatientCard',
    mixins: [allGetters],
    props: {
        patient: {
            type: Object,
            required: true
        }
    },
    computed: {
        progressValue() {
            return this.gettersHelper(this.patient, 'progress')
        },
        volName() {
            let vol_id = this.gettersHelper(this.patient, 'volunteer_id')
            if(vol_id == null) {
                return ''
            } else {
                let vol = this.$store.state.data.volunteers[vol_id]
                return this.gettersHelper(vol, 'name')
            }
        }
    },
    
}
</script>

<style>

</style>