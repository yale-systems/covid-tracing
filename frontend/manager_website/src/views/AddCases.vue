<template>
  <div>
    <v-row>
      <v-col cols=3>
        <AddPatientSidebar v-model="patientNum" />
      </v-col>
      <v-col>
        <v-stepper v-model="patientNum">
            <v-stepper-items>
              <v-stepper-content
                v-for="n in totalPatientNum"
                :key="`${n}-content`"
                :step="n-1"
              >
                <v-container fluid>
                  <NewCaseForm :save="save"/>
                  <v-row>
                    <v-btn 
                      @click="prevStep(n)"
					  v-if="n != 1"
					>
						See Previous Case
					</v-btn>
                    <v-spacer></v-spacer>
                    <v-btn text color="primary"
                      @click="handleSave"
                    >
                      save
                    </v-btn>
                    <v-btn
                      color="primary"
                      @click="nextStep(n)"
                    >
                      Save and add case
                    </v-btn>
                  </v-row>
                </v-container>
              </v-stepper-content>
            </v-stepper-items>
          </v-stepper>
        </v-col>
      </v-row>
    </div>
</template>

<script> 
import NewCaseForm from '@/components/NewCaseForm'
import AddPatientSidebar from '@/components/AddPatientSidebar'

export default {
    name: "AddCases",
    components: {
        NewCaseForm,
        AddPatientSidebar
    },
    data: () => {
        return {
            patientNum: 0,
            totalPatientNum: 1,
            save: false
        }
    },
    methods: {
        nextStep(n) {
			this.save = !this.save
			if (n === this.totalPatientNum) {
				this.totalPatientNum += 1
				this.$nextTick(() => {
				this.patientNum = n
				})
			} else {
				this.patientNum = n
			}
        },
        prevStep(n) {
          if (n === 1) {
            return
          } else {
            this.patientNum -= 1
          }
        },
        handleSave() {
          this.save = !this.save
        },
        handleBack() {
			  this.$store.commit('clearSelect')
            this.$router.push({name: 'PDash'})
        },
    }
}
</script>