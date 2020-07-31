<template>
  <div>
    <v-container fluid class="pb-0 pt-0 ml-n3">
      <v-row>
        <v-col class="pa-0" overflow-y-auto full fill-height cols=3>
          <v-container class="pa-0 mb-0 full-height">
            <AddPatientSidebar v-model="patientNum" class="main"/>
          </v-container>
        </v-col>
          <v-divider vertical style="border-color:white;"> </v-divider>
        <v-col overflow-y-auto full fill-height class="pa-0">
          <v-container class="pa-0 mb-0 full-height main">
            <v-stepper v-model="patientNum" class="pa-0">
                <v-stepper-items>
                  <v-stepper-content
                    v-for="n in totalPatientNum"
                    :key="`${n}-content`"
                    :step="n-1"
                  >
                    <v-container fluid>
                      <NewCaseForm :save="save"/>
                      <v-row>
                        <v-btn @click="prevStep(n)" v-if="n != 1">
                          See Previous Case
                          </v-btn>
                        <v-spacer></v-spacer>
                        <v-btn text color="primary"
                          @click="handleSave">
                          save
                        </v-btn>
                        <v-btn
                          color="primary"
                          @click="nextStep(n)">
                          Save and add case
                        </v-btn>
                      </v-row>
                    </v-container>
                  </v-stepper-content>
                </v-stepper-items>
              </v-stepper>
            </v-container>
          </v-col>
        </v-row>
      </v-container>
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
    beforeMount() {
      this.$store.commit('patients/clearAddPatients')
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
        }
    }
}
</script>

<style scoped>
.sidebar {
  height: 100vh;
  overflow: auto;
  float: left;
}

.main {
  height: 90vh;
  overflow-y: auto;
}

</style>