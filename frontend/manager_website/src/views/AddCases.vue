<template>
    <v-stepper v-model="patientNum">
        <v-stepper-items>
          <v-stepper-content
            v-for="n in totalPatientNum"
            :key="`${n}-content`"
            :step="n"
          >
            <v-container fluid>
            <!-- Patient form goes here -->
            <v-card class="overflow-y-auto">
                <NewCaseForm />
            </v-card>
            <v-row class="mt-4">
              <v-btn 
                @click="handleBack">Back to Dashboard</v-btn>
              <v-spacer></v-spacer>
              <v-btn class="mr-2" outlined color="primary"
                @click="prevStep(n)">See Previous Case</v-btn>
              <v-btn
                color="primary"
                @click="nextStep(n)"
              >
                Add Case
              </v-btn>
            </v-row>
            </v-container>
          </v-stepper-content>
        </v-stepper-items>
      </v-stepper>
</template>

<script> 
import NewCaseForm from '@/components/NewCaseForm'
export default {
    name: "AddCases",
    components: {
        NewCaseForm
    },
    data: () => {
        return {
            patientNum: 1,
            totalPatientNum: 1
        }
    },
    methods: {
        nextStep(n) {
          if (n === this.totalPatientNum) {
            this.totalPatientNum += 1
            this.$nextTick(() => {
              this.patientNum = n + 1
            })
          } else {
            this.patientNum = n + 1
          }
        },
        prevStep(n) {
          if (n === 1) {
            return
          } else {
            this.patientNum -= 1
          }
        },
        handleBack() {
			  this.$store.commit('clearSelect')
            this.$router.push({name: 'PDash'})
        },
    }
}
</script>

<style>

</style>