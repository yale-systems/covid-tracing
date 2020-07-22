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
            :key="gettersHelper(patient, 'patient_id')"
            :patient="patient"></PatientRow>
    </v-card>
</template>

<script>
import PatientRow from '@/interviewerComponents/PatientRow'
import apiCalls from '@/apiCalls.js'
import getters from '@/methods.js'

export default {
    name: 'PatientTable',
    components: {
        PatientRow
    },
    mixins: [getters],
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
            console.log(this.$store.getters['patients/getAllPatients'])
            return this.$store.getters['patients/getAllPatients']
        }
    },
    methods: {
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
                if(this.gettersHelper(pat1, 'last_name') < this.gettersHelper(pat2, 'last_name')) {
                    return 1
                } else {
                    return -1
                }
            } else {
                if(this.gettersHelper(pat1, 'last_name') < this.gettersHelper(pat2, 'last_name')) {
                    return -1
                } else {
                    return 1
                }
            }
        },
        compareDates(pat1, pat2) {
            let date1 = this.gettersHelper(pat1, 'diagnosis_date')
            let date2 = this.gettersHelper(pat2, 'diagnosis_date')
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
                return (this.gettersHelper(pat1, 'progress') - this.gettersHelper(pat2, 'progress'))
            } else {
                return (this.gettersHelper(pat2, 'progress') - this.gettersHelper(pat1, 'progress'))
            }
        }, 
        comparePhones(pat1, pat2) {
            if(this.phoneToggle) {
                return (this.gettersHelper(pat1, 'phone') - this.gettersHelper(pat2, 'phone'))
            } else {
                return (this.gettersHelper(pat2, 'phone') - this.gettersHelper(pat1, 'phone'))
            }
        }
    }

}
</script>

<style>

</style>