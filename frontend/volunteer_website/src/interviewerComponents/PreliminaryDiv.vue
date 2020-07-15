<template>
    <v-container fluid class="ma-5" style="max-width:95%; align-items:center;">
        <div>
            <p class="title"> {{ name }} </p>
            {{phone}}
            <p> {{age}}, speaks {{language}} </p>
            <p> {{symptomatic ? "Is currently known to have symptoms" : "Is not known to have symptoms"}} </p>
        </div><hr class="mt-6" style="border-top: 1px solid rgb(226, 226, 226);"><br>
        <div>
            <h4 class="header"> Voicemail </h4><br>
            <p class="font-weight-medium"> My name is [user.name] and I am calling from [user.department]. This message is for {{ name }}. 
                Please call me back as soon as you are able at the following number (provide Google phone #). Thank you. 
            </p>
            <p style="color:#616161; font-size:small;"><i> Try calling back 30 minutes or so later as the case may be screening calls and the voicemail might help clarify your purpose/intention.
            </i></p><hr class="mt-6" style="border-top: 1px solid rgb(226, 226, 226);"><br>
            <h4 class="header"> Call </h4><br>
            <p class="font-weight-medium"> Hello, my name is [user.name] and I’m calling on behalf of [user.department]. Can I please speak with {{ name }}?  Would you prefer to continue in English or another language?
            </p>
            <p><i style="color:#616161; font-size:small;"> If not English, please indicate in the "Call Outcome Survey"
            </i></p>
            <p class="font-weight-medium"> First, to ensure I am talking to the right person, can you please verify your date of birth?
            </p>
            <p class="font-weight-medium header"><i style="font-size:small;"> DOB:
            </i></p>
            <p><i style="color:#616161; font-size:small;"> Confirm if DOB matches; if not, ensure that you are talking to the correct person or need to speak to an adult/guardian proxy for a child, someone incapacitated, or still in the hospital.
            </i></p>
            <p class="font-weight-medium"> Great, I understand that you were recently tested for COVID-19. I am calling from the New Haven Health Department to follow-up and to better understand your situation. What have you heard about your COVID-19 test result? (Please select appropriate selection box below to continue script/interview). 
                <!-- Hello, this is _____ calling in cooperation with Yale Health, may I speak with {{ name }}? 
                I'm working with Yale Health as a contact tracer in response to coronavirus.
                Thank you for helping us with the contact tracing project. -->
            </p>
            <h1>Add radio buttons here</h1>
            <p> How are you feeling right now? Are you experiencing or have you experienced symptoms related to your COVID illness?</p>
            <v-row style="align-items:center">
                <v-col cols="7">
                    <p class="font-weight-medium"> How are you feeling right now? Are you experiencing or have you experienced symptoms related to your COVID illness? <br/>
                        <v-tooltip 
                            bottom
                            max-width="240px"
                            transition="fade-transition">
                            <template v-slot:activator="{ on }">
                            <small 
                                v-on="on"> 
                                <a> I don't know what this means </a> 
                                <v-icon small class="pb-1 pointerOnHover">mdi-help-circle-outline</v-icon>
                            </small> 
                            </template>
                            <span>Select "Patient is symptomatic" if they had any COVID-19 symptoms (e.g shortness of breath, cough, or fever). If they feel healthy but tested positive for COVID-19, select "Patient is not symptomatic"</span>
                        </v-tooltip>
                    </p>
                </v-col>
                <v-col>
                    <v-select v-model="symptomaticResult" placeholder="Click to choose an option" :items="symptoms"> </v-select>
                </v-col>
            </v-row>
            <v-row class="mt-0" style="align-items:center">
                <v-col v-if="symptomaticResult != ''" cols="6">
                    <p class="font-weight-medium"> {{ dateMessage}} </p>
                </v-col>
                <v-col v-if="symptomaticResult != ''">
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
                                class="mr-4 pb-2"
                                v-model="date"
                                placeholder="Click to choose a date"
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
                </v-col>
            </v-row>
            <h1>Add Are you able to self isolate and then add assitance below</h1>
            <v-row style="align-items:center">
                <v-col>
                    <p class="font-weight-medium"> Have you traveled outside CT in the last 14 days before your illness started (onset)?
                    </p>
                </v-col>
                <v-col cols="3">
                    <v-btn  
                        outlined
                        color="primary" 
                        class="mr-4 mb-4"
                        >
                        yes
                    </v-btn>
                    <v-btn 
                        outlined
                        color="primary"
                        class="mb-4"
                        >
                        no
                    </v-btn>
                </v-col>
            </v-row>
            <v-row style="align-items:center">
                <v-col>
                    <p class="font-weight-medium"> Did you see a primary care physician or doctor for your COVID-19 condition/symptoms?
                    </p>
                </v-col>
                <v-col cols="5">
                    <v-btn  
                        outlined
                        color="primary" 
                        class="mr-4 mb-4"
                        >
                        yes
                    </v-btn>
                    <v-btn 
                        outlined
                        color="primary"
                        class="mr-4 mb-4"
                        >
                        no
                    </v-btn>
                    <v-btn 
                        outlined
                        color="primary"
                        class="mb-4"
                        >
                        Don't have one
                    </v-btn>
                </v-col>
            </v-row>
            <v-row style="align-items:center">
                <v-col>
                    <p class="font-weight-medium"> Did you learn of your COVID-19 lab result from your physician/doctor's office already?
                    </p>
                </v-col>
                <v-col cols="3">
                    <v-btn  
                        outlined
                        color="primary" 
                        class="mr-4 mb-4"
                        >
                        yes
                    </v-btn>
                    <v-btn 
                        outlined
                        color="primary"
                        class="mb-4"
                        >
                        no
                    </v-btn>
                </v-col>
            </v-row>
            <v-row style="align-items:center">
                <v-col>
                    <p class="font-weight-medium"> What health insurance do you currently have/use?
                    </p>
                </v-col>
                <v-col cols="6">
                    <v-select placeholder="Click to choose an option"> </v-select>
                </v-col>
            </v-row>
        </div>
    </v-container>
</template>

<script>
import moment from 'moment'

export default {
    name: "PreliminaryDiv",
    props: {
        phone: '',
        name: '',
        age: '',
        language: '',
        symptomatic: {
            default: false
        }
    },
    data: () => {
        return {
            symptoms: ["Patient is symptomatic", "Patient is not symptomatic"],
            symptomaticResult: "",
            menu: false,
            date: "",
        }
    },
    computed: {
        todayDate() {
            return this.$store.state.todayDate
        },
        dateMessage() {
            if (this.symptomaticResult == "Patient is symptomatic") {
                return "When did you first begin experiencing symptoms?"
            } else if (this.symptomaticResult == "Patient is not symptomatic") {
                return "When were you diagnosed?"
            }
        },
    },
   
    watch: {
        date: function() {
            this.$store.commit('setDate', moment(this.date, 'YYYY-MM-DD'))
        },
    }
}

</script>

<style scoped>

.inside-stepper-spacing {
    max-width: 630px;
}

.pointerOnHover {
    cursor: pointer;
}
.header {
    color:#01579B;
}
</style>