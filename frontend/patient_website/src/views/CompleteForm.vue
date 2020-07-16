<template>
    <div>
    <v-container fluid>
        <v-stepper non-linear v-model="currentStep" class="elevation-0">
            <v-stepper-header class="elevation-0" >
                <v-stepper-step color="primary" :complete="currentStep > 1" step="1"> Date Range </v-stepper-step>
                    <v-divider></v-divider>
                <v-stepper-step color="primary" :complete="currentStep > 2" step="2"> Household Contacts </v-stepper-step>
                    <v-divider></v-divider>
                <v-stepper-step color="primary" editable :complete="currentStep > 3" step="3"> Outside Contacts </v-stepper-step>
            </v-stepper-header>

            <v-stepper-items>
                <v-stepper-content step="1">
                    <PreliminaryDiv></PreliminaryDiv>
                </v-stepper-content> 
                <v-stepper-content step="2">
                    <HouseholdContactDiv></HouseholdContactDiv>
                </v-stepper-content>
                <v-stepper-content step="3">
                    <EventsDiv 
                        :validateDate="validateDate"
                        v-on:all-dates-success="validated"
                        v-on:error="error = true; loading = false"
                        v-on:all-success="handleSuccess"
                    />
                </v-stepper-content>    
            </v-stepper-items>
        </v-stepper>
        <div id="stepperButtons">
            <v-btn
                text
                class="button-padding"
                color='primary'
                v-if="currentStep > 1 && currentStep < 4"
                @click="currentStep--">
                Previous
            </v-btn>
            <v-btn
                :disabled="date == '' || date == undefined || date == null"
                :dark="date != '' && date != undefined"
                color="primary"
                class="button-padding"
                @click="handleNext"
                >
                {{ nextMessage }}
            </v-btn>
        </div>
    </v-container>

    <LoadingDialog v-model="loading"></LoadingDialog>
    <ErrorDialog v-model="error" v-on:close="error=false"></ErrorDialog>
        
    </div>
</template>

<script>
import PreliminaryDiv from "@/components/PreliminaryDiv.vue"
import HouseholdContactDiv from '@/components/HouseholdContactDiv.vue'
import EventsDiv from '@/components/EventsDiv.vue'
import LoadingDialog from '@/components/LoadingDialog.vue'
import ErrorDialog from '@/components/ErrorDialog.vue'


export default {
    name: "CompleteForm",
    components: {
        PreliminaryDiv, // first step
        HouseholdContactDiv, //second step
        EventsDiv, // third step
        LoadingDialog,
        ErrorDialog
    },
    data: () => {
        return {
            currentStep: 1,
            loading: false,
            error: false,
            validateDate: false,
            whichButton: '',
        }
    },
    computed: {
        date() {
            return this.$store.getters['patients/criticalDate']
        },
        nextMessage() {
            if (this.currentStep == 3) {
                return "Submit"
            } else {
                return "next"
            }
        },
    },
    methods : {
        handleNext() {
            if (this.currentStep == 3) {
                this.validateDate = !this.validateDate
                this.whichButton = 'submit'
            } else {
                this.currentStep++;
            }
        },
        validated() {
            if (this.whichButton == 'submit') {
                setTimeout(() => {
                    this.loading = true
                }, 800)
            }
        },
        handleSuccess() {
            if (this.whichButton == 'submit') {
                this.$router.push({name: 'submitted'})
            } else {
                // TODO: save here 
            }
        },
    },
    mounted() {
        if(this.$store.state.loggedIn && this.date) {
            this.currentStep = 3
        }
    }
}
</script>

<style scoped>

.contact-spacing {
    margin-bottom: 10px;
}

.medium {
    font-size: 16px;
}
.stepper-spacing {
    margin-left: 8%;
    margin-right: 8%;
}
.inside-stepper-spacing {
    max-width: 630px;
}
.subtitle-spacing {
    padding-top: 4px;
}

.assist-padding {
    padding-left: 2%;
    z-index: 2;
}

#phone {
    position : fixed;
    top : 65px;
    right: 0;
}

#save {
    position : fixed;
    top : 120px;
    right : 0;
}

#stepperButtons {
    position: absolute;
    right: 5%;
    padding-bottom: 3%;
}

.button-padding {
    margin-left: 10px;

}

</style>