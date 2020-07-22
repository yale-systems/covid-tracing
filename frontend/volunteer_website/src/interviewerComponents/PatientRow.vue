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
                            {{gettersHelper(patient, 'onset_date')}}
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
                        <p class="pa-0 ma-0"> Notes: </p>
                    </v-row>
                    <v-row>
                        <v-textarea rows="2" auto-grow class="mt-0 pt-0"></v-textarea>
                    </v-row>
                    <v-row>
                        <v-spacer></v-spacer>
                        <v-btn text color="primary" @click="handleSave">
                            save
                        </v-btn>
                    </v-row>
                </v-expansion-panel-content>
            </v-expansion-panel>
        </v-expansion-panels>
        <v-divider></v-divider>
    </div>
</template>

<script>
import getter from '@/methods.js'
import constants from '@/constants.js'

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
        }
    },
    computed: {
        callStatuses() {
            return constants.callStatuses;
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
        handleSave() {
            // todo: update vuex, push changes to backend
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