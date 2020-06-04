<template>
    <div>
    <v-stepper 
        v-model="currentStep"
        vertical
        >
            <!-- <v-stepper-step 
                :complete="currentStep > 1"
                step="1"
                >
                Select a Language
                <small>What language would you like the form to be in?</small>
            </v-stepper-step>
            
            <v-stepper-content step="1">
                <v-card color="grey lighten-1" class="mb-12" height="200px"></v-card>
                <v-btn color="primary" @click="currentStep = 2">Next</v-btn>
            </v-stepper-content> -->
            
            <v-stepper-step 
                :complete="currentStep > 1"
                step="1"
                >
                Tell us about your diagnosis
                <small>Due to CDC guidelines, symptomatic and asymptomatic COVID diagnoses use different form setups </small>
            </v-stepper-step>

            <v-stepper-content step="1">
                <v-container fluid>
                    <v-row align="center">
                        <v-col>
                            I am 
                        </v-col>
                        <v-col>
                            <v-select v-model="symptomatic" :items="items"> </v-select>
                        </v-col>
                    </v-row>
                </v-container>
                <!-- disable button until this field is filled out... -->
                <v-btn 
                    color="primary" 
                    :disabled="symptomatic == ''"
                    @click="currentStep = 2"
                >
                    Next
                </v-btn>
                <!-- <v-btn text @click="currentStep = 1">Previous</v-btn> -->
            </v-stepper-content>

            <v-stepper-step 
                :complete="currentStep > 2"
                step="2"
                >
                Help us choose the date range for your form
                <small>Answer a couple questions so we can initialize your form with the appropriate dates</small>
            </v-stepper-step>

            <v-stepper-content step="2">
                
                <v-container fluid v-if="symptomatic=='symptomatic'"> 
                    When did you first begin experiencing symptoms? 
                </v-container>
                <v-container fluid v-if="symptomatic=='asymptomatic'"> 
                    On what date were you diagnosed? 
                </v-container>

                <v-menu
                        ref="menu"
                        v-model="menu"
                        :close-on-content-click="false"
                        transition="slide-y-transition"
                        offset-y
                        min-width="290px"
                        mr-2
                        >
                        <template v-slot:activator="{ on }">
                            <v-text-field
                                class="mr-4"
                                v-model="date"
                                placeholder="Click this text to choose a date"
                                prepend-inner-icon="mdi-calendar"
                                readonly
                                v-on="on"
                            ></v-text-field>
                        </template>
                        <v-date-picker 
                            v-model="date" 
                            :max="todayDate"
                            no-title 
                            scrollable
                            @input="menu=false">
                        </v-date-picker>
                    </v-menu>

                <v-btn 
                    color="primary"
                    :disabled="date == ''"
                    to="form" >
                    Begin Form
                </v-btn>
                <v-btn text @click="currentStep = 1">Previous</v-btn>
            </v-stepper-content>
    </v-stepper>
    </div>
</template>

<script>
export default {
    name: "PreForm",
    data () {
        return {
            currentStep: 1,
            items: ["symptomatic", "asymptomatic"],
            symptomatic: "",
            menu: false,
            date: ""
        }
    },
    computed: {
        todayDate() {
            let today = new Date();
            let day = String(today.getDate()).padStart(2, '0');
            let month = String(today.getMonth() + 1).padStart(2, '0');
            let year = today.getFullYear();

            return (year + '-' + month + '-' + day)
        }
    }  
}
</script>

<style scoped>

</style>