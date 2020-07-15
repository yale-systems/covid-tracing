<template>
    <v-card style="width:100%;" flat>
        <!-- header of table -->
        <v-container class="pt-0 pb-0 mb-0">
            <v-row class="d-flex align-contents-center mt-0">
                <v-col cols="3">
                    <h4 style="font-color:grey;" class="ml-6"> 
                        Name 
                        <v-btn class="mb-1" @click="nameToggle = !nameToggle; filter('name')" icon ><v-icon small>mdi-filter-variant</v-icon>
                        </v-btn>
                    </h4>
                </v-col>
                <v-col cols="2">
                    <h4 color="grey"> Result Date 
                        <v-btn class="mb-1" @click="dateToggle = !dateToggle; filter('date')" icon ><v-icon small>mdi-filter-variant</v-icon>
                        </v-btn>
                    </h4>
                </v-col>
                <v-col cols="3">
                    <h4 color="grey"> Status 
                        <v-btn class="mb-1" @click="statusToggle = !statusToggle; filter('status')" icon ><v-icon small>mdi-filter-variant</v-icon>
                        </v-btn>
                    </h4>
                </v-col>
                <v-col cols="2">
                    <h4 color="grey"> Phone Number 
                        <v-btn class="mb-1" @click="phoneToggle = !phoneToggle; filter('phone')" icon ><v-icon small>mdi-filter-variant</v-icon>
                        </v-btn>
                    </h4>
                </v-col>
                <v-col>
                </v-col>
            </v-row>
            <v-divider></v-divider>
        </v-container>

        <PatientRow v-for="patient in patients"
            :key="getPatientID(patient)"
            :patient="patient"></PatientRow>
    </v-card>
</template>

<script>
import PatientRow from '@/interviewerComponents/PatientRow'
import apiCalls from '@/apiCalls.js'
import patientGetters from '@/patientGetters.js'

export default {
    name: 'PatientTable',
    components: {
        PatientRow
    },
    data: () => {
        return {
            showPatients: [],
            nameToggle: false,
            dateToggle: false,
            statusToggle: false,
            phoneToggle: false,
        }
    },
    computed: {
        patients() {
            return this.$store.state.patients
        }
    },
    async mounted() {
        await this.$store.dispatch('loadPatients')
        this.showPatients = this.patients
    },
    methods: {
        getPatientID: patientGetters.getPatientID,
        getLastName: patientGetters.getLastName,
        getDate: patientGetters.getDate,
        getProgressNum: patientGetters.getProgressNum,
        getPhoneNum: patientGetters.getPhoneNum,
        filter(type) {
            if (type == 'name') {
                this.showPatients = this.showPatients.sort(this.compareNames)
            } else if (type == 'date') {
                this.showPatients = this.showPatients.sort(this.compareDates)
            } else if (type == 'status') {
                this.showPatients = this.showPatients.sort(this.compareStatuses)
            } else {
                this.showPatients = this.showPatients.sort(this.comparePhones)
            }
        },
        compareNames(pat1, pat2) {
            if(this.nameToggle) {
                if(this.getLastName(pat1) < this.getLastName(pat2)) {
                    return 1
                } else {
                    return -1
                }
            } else {
                if(this.getLastName(pat1) < this.getLastName(pat2)) {
                    return -1
                } else {
                    return 1
                }
            }
        },
        compareDates(pat1, pat2) {
            let date1 = this.getDate(pat1)
            let date2 = this.getDate(pat2)
            if(this.dateToggle) {
                if(date1.isAfter(date2)) {
                return 1
                } else if (date1.isSame(date2)){
                return 0
                } else {
                return -1
                }
            } else {
                if(date1.isAfter(date2)) {
                return -1
                } else if (date1.isSame(date2)){
                return 0
                } else {
                return 1
                }
            }
        },
        compareStatuses(pat1, pat2) {
            if(this.statusToggle) {
                return (this.getProgressNum(pat1) - this.getProgressNum(pat2))
            } else {
                return (this.getProgressNum(pat2) - this.getProgressNum(pat1))
            }
        }, 
        comparePhones(pat1, pat2) {
            if(this.phoneToggle) {
                return (this.getPhoneNum(pat1) - this.getPhoneNum(pat2))
            } else {
                return (this.getPhoneNum(pat2) - this.getPhoneNum(pat1))
            }
        }
    }

}
</script>

<style>

</style>