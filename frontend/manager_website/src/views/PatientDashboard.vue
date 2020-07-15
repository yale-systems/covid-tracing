<template>
		<div>
		<v-container fluid class="my-3" style="max-width:95%;">
			<v-row>
				<h1> Case Interview Assignments </h1>
<<<<<<< HEAD
				<v-spacer>
				</v-spacer>
				<v-btn class="mx-2"
					to='add'>
					Add Cases
				</v-btn>
				<v-btn
					to='reassign'>
					Assign Cases
				</v-btn>
=======
>>>>>>> b93c679a15b1d1797b4bfd2a38a3fb79230a4923
			</v-row>
			<DataTable 
				:people="patients" 
				:headers="headers" 
				type="patient" 
				:showSelect="false"
				:showSearch="true" 
				v-model="active"
			/>
			<hr>
			<PatientCard :patient="active" />
		</v-container>
	</div>
</template>

<script>
import DataTable from '@/components/DataTable.vue';
import PatientCard from '@/components/PatientCard.vue';

export default {
	name: "PatientDashboard",
	components: {
		DataTable, PatientCard
	},
	data: () => {
		return {
			assignDisabled: true,
			active: {}
		};
	},
	computed: {
		headers() {
			return this.$store.getters.activePatientFields
		},
		patients() {
			return this.$store.getters.patientsAsArray
		}
	},
	async mounted() {
		// console.log(patients);
		this.$store.commit('clearSelect')
		await this.$store.dispatch('loadPatients')
		await this.$store.dispatch('loadVolunteers')
		this.active = this.patients[0]
	}
};
</script>

<style>
.wide {
	width: 80vw;
}
</style>
