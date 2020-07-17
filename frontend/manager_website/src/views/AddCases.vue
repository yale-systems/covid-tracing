<template>
  <div>
    <v-row>
      <v-col cols=3>
        <AddPatientSidebar v-model="smolPatientNum" />
      </v-col>
      <v-col>
        <v-stepper v-model="patientNum">
            <v-stepper-items>
              <v-stepper-content
                v-for="n in totalPatientNum"
                :key="`${n}-content`"
                :step="n"
              >
                <v-container fluid>
                  <div> hello </div>
                  <v-card class="overflow-y-auto">
                      <NewCaseForm />
                  </v-card>
                <v-row>
                  <v-btn 
                    @click="prevStep(n)">See Previous Case</v-btn>
                  <v-spacer></v-spacer>
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
            patientNum: 1,
            totalPatientNum: 1
        }
    },
    computed: {
      smolPatientNum: {
        get() {
          return this.patientNum - 1
        }, 
        set(newVal) {
          console.log(newVal)
          this.patientNum = newVal + 1
        }
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