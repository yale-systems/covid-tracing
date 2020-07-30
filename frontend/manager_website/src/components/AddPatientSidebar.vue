<template>     
    <v-container class="full-height">
    <v-item-group v-model="patientNum" class="mt-2">
        <v-row class="mt-2 ml-3 pb-0" v-for="(patient, i) in patients"
            :key="i">
            <v-item v-slot:default="{ active, toggle }"> 
                <v-sheet @click="toggle()"
                    class="customStepper my-0"
                    :elevation="active ? 4 : 1"
                    :color="active ? '#f0ebf7' : 'white'">  
                        <div class="customStepperText" style="align-items:center;"> <v-progress-circular :value="getFormProgress(patient)" rotate='90' size='25' class="mr-2 mb-1"> </v-progress-circular> {{ getName(patient)}} </div>
                </v-sheet>
            </v-item>
        </v-row>
    <!-- <v-row class="pb-0">
        <v-item class="ml-7" v-slot:default="{ active, toggle }"> 
            <v-sheet @click="toggle()"
                class="customStepper my-0"
                
                :elevation="active ? 4 : 1"
                :color="active ? '#f0ebf7' : 'white'">  
                    <div class="customStepperText ml-2"> Patient Information </div>
            </v-sheet>
        </v-item>
    </v-row> -->
    </v-item-group>
    <v-row class="my-2 ml-3 px-1">
        <v-btn block color="primary"> add patients </v-btn>
    </v-row>
    <v-row class="mb-2 ml-3 px-1">
        <v-btn block outlined color="primary"> back to dashboard </v-btn>
    </v-row>
    </v-container>
</template>

<script>
export default {
    name: "AddPatientSidebar",
    props: {
        value: {
            Number,
            required: true
        }
    },
    computed: {
        patientNames() {
            return this.$store.getters['patients/addPatientsNames']
        },
        patients() {
            return this.$store.getters['patients/addPatients']
        },
        patientNum: {
            get() {
                return this.value
            },
            set(newVal) {
                let oldVal = this.value
                this.$emit('input', newVal)
                if(newVal == undefined) {
                    this.$nextTick(() => { this.$emit('input', oldVal) } )
                } 
            }
        }
    },
    methods: {
        getName(patient) {
            if ((patient.first_name == undefined || patient.first_name == '')
					&& (patient.last_name == undefined || patient.last_name == '')) {
					return "New Case"
				}
            let first = patient.first_name == undefined ? '' : patient.first_name
            let last = patient.last_name == undefined ? '' : patient.last_name
            return first + ' ' + last
        },
        getFormProgress(patient) {
            // booleans to denote if they are undefined or not
            let first_name = (patient.first_name === undefined || patient.first_name == '')
            let last_name = (patient.last_name === undefined || patient.last_name == '')
            let email = (patient.email === undefined || patient.email == '') 
            let phone_number = (patient.phone_number == undefined || patient.phone_number == '')
            let name = (first_name || last_name)
            let contact = (email || phone_number)
            if(name && contact) {
                return 0
            } else if (name || contact) {
                return 50
            } else {
                return 100
            }
        }
    }
}
</script>

<style>
.customStepperText {
    color: #520078;
    font-weight: 500;
    font-size: large;
    margin-left: 5px;
}

.customStepper{
    height: 50px;
    width: 100%;
    display: flex;
    justify-content: left;
    align-items: center;
    padding: 10px;
    margin: 5px;
    box-shadow: 0 0 0 .5pt #520078;
    transition-property: background-color;
    transition-duration: .4s;
}
.customStepper:hover{
    cursor: pointer;
}
.separated {
    border-right: 1px solid #E2E2E2;
}
</style>