<template>
	<v-container fluid>
		<v-stepper :non-linear="true" v-model="currentTable">
			<v-stepper-header >
				<v-stepper-step step="1" :complete="currentTable > 1">
					Patients
				</v-stepper-step>
				<v-divider></v-divider>
				<v-stepper-step step="2" :complete="currentTable > 2">
					Volunteers
				</v-stepper-step>
				<v-divider></v-divider>
				<v-stepper-step step="3">
					Assign
				</v-stepper-step>
			</v-stepper-header>
			<v-stepper-items>
				<v-stepper-content step="1">
					<div>
						<v-row class="mx-3" v-if="priorityPatients.length > 0">
							<h3>
								Select priority patients to assign to one volunteer.
							</h3>
							<v-spacer>
							</v-spacer>
							<v-btn text @click="seeAllPatients"> skip to see all unassigned patients </v-btn>
						</v-row>
						<v-row v-else class="mx-3">
							<h3> Select patients to assign to one volunteer. </h3>
						</v-row>
						<DataTable class="ma-3" 
							v-model="activePatient"
							type="patient" 
							:headers="patientHeaders" 
							:people="seeAll ? unassignedPatients : priorityPatients" 
							:showSelect="true"
						/>
						<v-row class="mx-3 d-flex align-end">
							<v-btn @click="currentTable++" :disabled="selectedNames.length == 0">
								Next
							</v-btn>
						</v-row>
						<v-divider></v-divider>
						<PatientCard :patient="activePatient" />
					</div>
				</v-stepper-content>
				<v-stepper-content step="2">
					<v-row>
						<v-col cols="8">
							<h3>
								Select a volunteer to assign these patients to.
							</h3>
							<p> Selected patients are {{selectedNames}}. They speak {{ gettersHelper(item, 'languages') }} </p>
							<p> Selected volunteer is {{ activeVolunteer ? gettersHelper(activeVolunteer, 'name') : ''}}, who speaks {{ activeVolunteer ? gettersHelper(activeVolunteer, 'languages') : ''}}. </p>
						</v-col>
						<v-col cols="4">
							<v-row class="mx-3">
								<v-spacer></v-spacer>
								<v-btn @click="currentTable--">
									Previous
								</v-btn>
								<v-btn @click="currentTable++" :disabled="!activeVolunteer">
									Next
								</v-btn>
							</v-row>
						</v-col>
					</v-row>
					<DataTable class="ma-3" 
						v-model="activeVolunteer"
						type="volunteer" 
						:headers="volHeaders" 
						:people="volFilter == 0 ? hungryVolunteers : (volFilter == 1 ? fullVolunteers : volunteers)" 
					/>
				</v-stepper-content>
				<v-stepper-content step="3">
					<v-container v-if="!submitted">
						<v-row>
							<h3> Please confirm your assignment. </h3>
						</v-row>
						<v-row>
							<h3> Patients </h3>
							<v-col>
								<v-row v-for="name in selectedNames"
								:key="name">
									<h4> {{name}} </h4>
								</v-row>
							</v-col>
						</v-row>
						<v-row>
							<h3> will be assigned to volunteer </h3>
						</v-row>
						<v-row>
							<h4>
								{{ activeVolunteer ? gettersHelper(activeVolunteer, 'name') : ''}}
							</h4>
						</v-row>
						<v-row>
							<v-btn @click="currentTable--">
								Previous
							</v-btn>
							<v-btn @click="handleAssign">
								Confirm Assignment
							</v-btn>
						</v-row>
						<v-alert color="error" v-if="error">
							There was an error submitting the assignment. Please try again. 
						</v-alert>
					</v-container>
					<v-container v-else>
						<v-alert>
							Patients successfully assigned.
						</v-alert>
						<p v-if="priorityPatients.length > 0">
							Redirecting you to more patients...
						</p>
						<div v-else>
							<p> There are no other priority patients to assign. </p>
							<v-btn text @click="seeAllPatients">
								Go to all other patients 
							</v-btn> 
						</div>
					</v-container>
				</v-stepper-content>
			</v-stepper-items>
		</v-stepper>
		<v-btn @click="handleBack">
			<v-icon>"mdi-arrow-left"</v-icon>
			back to dashboard
		</v-btn>
	</v-container>
</template>

<script>
import DataTable from '@/components/DataTable.vue';
import allGetters from '@/constants/methods.js';
import PatientCard from '@/components/PatientCard.vue'

export default {
    name: 'Reassign',
    mixins: [allGetters],
    components: {
        DataTable,
        PatientCard
    },
    data: () => {
        return {
            volHeaders: [
                { text: "Name", value: "name" },
                { text: "Languages", value: "languages" },
                { text: "Remaining", value: "remaining_capacity" },
                { text: "Current caseload", value: "current_cases" },
                { text: "Total completed cases", value: "completed_cases"}
            ],
            patientHeaders: [
                { text: "Name", value: 'name' },
                { text: "Language", value: "language" },
                { text: "Interview Requested", value: 'requested_interview'},
                { text: "Call Status", value: 'case_call_status' }
            ],
            items: ["joe", "lizzie", "tom", "ivy fan"],
            activeVolunteer: null,
            activePatient: null,
            volNotes: '',
            item: {
                languages: []
            },
            filters: {
                volunteers: [ 
                    {
                        key: 'has capacity',
                        value: 0
                    },                    
                    {
                        key: 'full capacity',
                        value: 1
                    },
                    {
                        key: 'all',
                        value: 2
                    },
                ],
                patients: [ 
                    {
                        key: 'unassigned',
                        value: 0
                    },                    
                    {
                        key: 'assigned',
                        value: 1
                    },
                    {
                        key: 'all',
                        value: 2
                    },
                ]
            },
            volFilter: 0,
		  patFilter: 0,
		  currentTable: 1,
		  submitted: false,
		  seeAll: false,
		  error: false
        }
    },
    async mounted() {
        await this.$store.dispatch('loadVolunteers')
        await this.$store.dispatch('loadPatients')
        this.activePatient = this.patients[0]
    },
    computed: {
        volunteers() {
            return this.$store.getters.volunteersAsArray
        },
        fullVolunteers() {
            return this.volunteers.filter(volunteer => volunteer.remaining_capacity == 0)
        },
        hungryVolunteers() {
            return this.volunteers.filter(volunteer => volunteer.remaining_capacity > 0)
        },
        patients() {
            let v = this.$store.getters.patientsAsArray
            for (let patient of v) {
				patient.check = false
			}
            return v
        },
        unassignedPatients() {
            return this.patients.filter(patient => patient.volunteer_id == null)
        },
        assignedPatients() {
            return this.patients.filter(patient => patient.volunteer_id != null)
	   },
	   priorityPatients() {
		   return this.patients.filter(patient => patient.volunteer_id == null && patient.language != 0)
	   },
        selectedNames() {
            let selected = this.$store.state.view.selected
            let names = []
            for (let s of selected) {
                let person = this.$store.state.data.patients[s]
                names.push(this.gettersHelper(person, 'name'))
            }
            return names
        },
    },
    watch: {
        selectedNames() {
            let selected = this.$store.state.view.selected
            let l = this.item.languages
            for (let s of selected) {
                let person = this.$store.state.data.patients[s]
                // if the language is defined and not in the array already
                if(person.language != undefined && !l.includes(person.language)) {
                    l.push(person.language)
                }
            }
            this.item.languages = l
        }
    },
    methods: {
        handleBack() {
			this.$store.commit('clearSelect')
            this.$router.push({name: 'PDash'})
        },
        customFilter(item, queryText) {
            const text = this.gettersHelper(item, 'name').toLowerCase()
            const searchText = queryText.toLowerCase()
            return text.indexOf(searchText) > -1 ||
                text.indexOf(searchText) > -1
        },
	   async handleAssign() {
		   // dispatch here to both reassign in backend and fronten
		   await this.$store.dispatch('reassignPatient', this.activeVolunteer.volunteer_id)
		   	.then(response => {
				if (response) {
					this.error = false
					this.submitted = true
					let curr = this
					if(this.priorityPatients.length > 0) {
						setTimeout(() => {curr.currentTable = 1}, 1000)
					}
				} else {
					this.error = true
				}
			})
		//    console.log("sucess???")	
	   },
	   // switch to normal view with all patients, could just be a boolean
	   seeAllPatients() {
		   this.seeAll = true
		   this.currentTable = 1
	   }
    }
}
</script>

<style scoped>

.med-height{
    max-height: 20vh;
    
}
.target{
    position: relative;
}

.sticky-br {
    position: sticky;
    bottom: 0;
    right: 0;
}
</style>