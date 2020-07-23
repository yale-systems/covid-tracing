<template>
    <!-- for the name -->
    <v-container>
        <v-row class="mb-0">
            <h1> {{gettersHelper(value, 'name')}} </h1>
        </v-row>
        <v-row class="mb-0 mt-0 pb-0"> 
            <p class="pb-0 mt-0 mb-1" style="font-size:20px;"> {{gettersHelper(value, 'phone')}} </p>
        </v-row>
        <v-row class="mt-0"> 
            <p class="pt-0 mt-0"> {{gettersHelper(value, 'email')}} </p>
        </v-row>
        <v-row style="align-items:center;"> 
            <p> {{gettersHelper(value, 'age')}}{{gettersHelper(value, 'age') ? ', ' : ''}}speaks {{gettersHelper(value, 'language')}} </p>
        </v-row>

        <!-- <v-row class="mb-3 mt-5">
            <h4> Notification Information </h4>
        </v-row> -->
        <v-layout column justify-center align-center>
    <!-- <v-flex xs12 sm8 md6>
      <v-card color="secondary" elevation="0">
        <v-card-title class="{'subheading': $vuetify.breakpoint.xs}">
          <v-icon color="white" class="pb-4 pr-2">mdi-virus</v-icon>Welcome to the Vuetify + Nuxt.js template
        </v-card-title>
      </v-card>
    </v-flex> -->
  </v-layout>
            <v-row class="mb-3 mt-0">
                <v-col cols="5">
                <v-card color="secondary" elevation="0">
                    <v-container fluid>
                        <v-row justify="center" class="update-cards text-center pl-2 pr-2"> 
                        <v-icon color="white" class="pb-4 pr-2" style="font-size:1.65vw;">mdi-virus</v-icon><b><p style="font-size:1.65vw; color:white;"> Exposed {{exposedAgo}} </p></b>
                        </v-row>
                    </v-container>
                </v-card>
                </v-col>
                <v-col>
                <v-card color="secondary" elevation="0">
                    <v-container fluid>
                        <v-row justify="center" class="update-cards text-center pl-2 pr-2"> 
                        <v-icon color="white" class="pb-4 pr-3" style="font-size:1.65vw;">mdi-clock</v-icon><b><p style="font-size:1.65vw; color:white;"> {{gettersHelper(value, 'contact_call_status') + ' (' + updateAgo + ')'}} </p></b>
                        </v-row>
                    </v-container>
                </v-card>
                </v-col>
            </v-row>
                
        <v-row class="mt-5 mb-3">
            <h4> Personal Information </h4>
        </v-row>
        <v-row>
            <v-col>
                <v-row class="mt-0 pt-0"> 
                    <v-icon class="mr-2 mb-5"> mdi-home </v-icon>
                    <p> {{ gettersHelper(value, 'household') ? "is a household contact" : "is not a household contact"}} </p>
                </v-row>
                <v-row>
                    <v-icon class="mr-2 mb-5"> mdi-hand-left </v-icon>
                    <p> was in {{gettersHelper(value, 'contact_type')}} contact </p>
                </v-row>
                <v-row>
                    <v-icon class="mr-2 mb-5"> mdi-thermometer-alert </v-icon>
                    <p> is {{ gettersHelper(value, 'symptomatic') ? "" : "not"}} known to be exhibiting symptoms </p>
                </v-row>
            </v-col>
            <v-col>
                <v-row class="mt-0 pt-0">
                    <v-icon class="mr-2 mb-5"> mdi-account-supervisor </v-icon>
                    <p> is a {{gettersHelper(value, 'relationship')}} of the contact </p>
                </v-row>
                <v-row>
                    <v-icon class="mr-2 mb-5"> mdi-medical-bag </v-icon>
                    <p> {{ gettersHelper(value, 'healthcare_worker') ? "works" : "does not work"}} in healthcare </p>
                </v-row>
            </v-col>
        </v-row>
        <v-row class="mb-4 mt-5">
            <h4> Voicemail </h4>
        </v-row>
        <v-row>
            <p> Hello. This is {{gettersHelper(user, 'name')}} working in cooperation with {{user.department}}.
                I am trying to reach {{gettersHelper(value, 'first_name')}}. There is an important health matter 
                that I need to discuss with you and would appreciate if you can return this call 
                at your earliest convenience.  I may be reached at [your phone number].
            </p>
        </v-row>
        <v-row class="mb-4 mt-5">
            <h4> Call </h4>
        </v-row>
        <v-row>
            <p> Hello.  My name is {{gettersHelper(user, 'name')}}.  I am calling from Yale School of Public Health.
            We are working with {{user.department}} on coronavirus response activities.
            May I speak with {{gettersHelper(value, 'first_name')}}?
            </p>
            <p> I am calling to let you know that you have been identified as someone who was exposed 
                to a person diagnosed with COVID-19, also called coronavirus.  This exposure occurred 
                {{exposedAgo}} at [nature of exposure].
            </p>
        </v-row>
        <v-row> 
            <v-col>
                Have you been tested for COVID-19?
            </v-col>
            <v-col>
                <ThreeToggle v-model="tested" :buttons="{first: 'yes', second: 'no', third: 'haven\'t been tested yet'}"/>
            </v-col>
        </v-row>
        <v-row style="align-items:center;" class="my-0 py-0 d-flex justify-left">
            <v-col class="pt-0">
                <p> Have you been experiencing any symptoms such as a fever, cough, or shortness of breath?
                </p>
            </v-col>
            <v-col cols="4" class="pt-0 input-size">
                <TFToggle v-model="hasSymptoms"/>
            </v-col>
        </v-row>
        <v-row v-if="hasSymptoms" style="align-items:center;" class="my-0 py-0">
            <v-col class="pt-0">
                <p> What symptoms do you have? </p>
            </v-col>
            <v-col class="pt-0 ml-3">
                <v-select
                    v-model="symptoms"
                    :items="symptomList"
                    multiple
                    chips
                    item-value="key"
                    item-text="value"
                    class="my-0 py-0"
                >
                </v-select>
            </v-col>
        </v-row>
        <v-row v-if="gettersHelper(value, 'symptomatic')">
            <p> Please remain at home for at least the next 14 days. Please avoid contact with 
                others in your home, and if anyone is taking care of you, they should also remain 
                home for 14 days after you recover. This means that you should not go to work, school, 
                or any other public or private settings in order to help protect those around you. 
                There is no need to go to a doctor just to get tested; if you are feeling well enough 
                to stay at home and recover from your illness please do so. Continue monitoring your 
                symptoms and if you need medical care, please call your doctor or emergency room before 
                going there.
            </p>
        </v-row>
        <v-row v-if="!gettersHelper(value, 'symptomatic')">
            <p> Due to your exposure, you should stay at home until 14 days after your last exposure [end date].
                This means that you should not go to work, school, or any other public or private settings in order 
                to help protect those around you.
            </p>
        </v-row>
        <v-row class="d-flex align-center mb-0 pb-0">
            <v-col class="pt-0">
                <p class="pt-4 mr-4"> Are you able to self-isolate? </p>
            </v-col>
            <v-col cols="auto" class="py-0 my-0 input-larger">
                <v-select
                    v-model="self_isolate"
                    :items="selfIsoStatuses"
                    item-value="key"
                    item-text="value"
                    class="ml-4 my-0 py-0"
                    min-width="100px">
                </v-select>
            </v-col>
        </v-row>
        <v-row v-if="value.self_isolate == 1" style="align-items:center;" class="my-0 py-0">
            <v-col class="pt-0">
                <p> What kind of assistance do you need? </p>
            </v-col>
            <v-col class="pt-0 ml-3">
                <v-select
                    v-model="assistance"
                    :items="assistanceStatuses"
                    multiple
                    chips
                    item-value="key"
                    item-text="value"
                    class="my-0 py-0"
                >
                </v-select>
            </v-col>
        </v-row>
        <v-row v-if="!gettersHelper(value, 'symptomatic') && gettersHelper(value, 'healthcare_worker')">
            <p> Please call your employer for additional guidance; they may have special instructions or recommendations 
                for you that you should follow. You can let them know about this phone call and then follow their guidance.
            </p>
        </v-row>
        <v-row v-if="!gettersHelper(value, 'symptomatic')">
            <p> Please monitor yourself for symptoms and take your temperature twice a day.  If you develop fever, cough, 
                or shortness of breath, these may be signs of COVID-19. 
                If you do become sick with these symptoms, please stay home for at least the next 14 days.  
                Please avoid contact with others in your home, and if anyone is taking care of you they should also 
                remain home for 14 days after you recover. There is no need to go to a doctor just to get tested; 
                if you are feeling well enough to stay at home and recover from your illness please do so. 
                If you need medical care, please call your doctor or emergency room before going there

            </p>
        </v-row>
        
        <v-row>
            <p> 
                If possible, please try to stay home {{endDate}} and monitor for symptoms.
                Thank you for your time. Do you have any other questions?
            </p>
        </v-row>
        <v-row>
            <p> <i>If you feel comfortable answering questions based on the FAQ please do so.  If not, please take down 
                the contacts name, number, and questions and send this information to YSPH.covid-contact@yale.edu for response. 
                In the meantime, you can tell the contact:</i></p>
            <p> I do not have the answer to your question right now. For now, we are asking you stay home for {{endDate}}. 
                I will find the answer to your question(s) and call you back.
            </p>
        </v-row>
        <v-row class="mb-4 mt-5">
            <h4> Notes </h4>
        </v-row>
        <v-row>
            <v-textarea filled rows="2" counter :rules="rules" v-model="value.notes"></v-textarea>
        </v-row>
        <v-row style="align-row">
            <v-col>
                <b> Were you able to get in contact with {{gettersHelper(value, 'first_name')}}?  </b>
            </v-col>
            <v-col>
                <v-btn  
                    color="secondary" 
                    class="mr-4"
                    :outlined="!notified"
                    @click="notified = true">
                    yes
                </v-btn>
                <v-btn 
                    color="secondary"
                    :outlined="notified"
                    @click="notified = false">
                    no
                </v-btn>
            </v-col>
        </v-row>
        <v-row>
            <v-col>
            </v-col>
            <v-col v-if="notified">
                <v-radio-group 
                    v-model="contact_call_status" 
                    >
                    <v-radio
                        v-for="item in notifiedStatuses"
                        :key="item.key"
                        :label="item.value"
                        :value="item.key"
                        color="secondary"
                    ></v-radio>
                </v-radio-group>
            </v-col>
            <v-col v-if="!notified">
                <v-radio-group 
                    v-model="contact_call_status"
                >
                    <v-radio
                        v-for="item in unNotifiedStatuses"
                        :key="item.key"
                        :label="item.value"
                        :value="item.key"
                        color="secondary"
                    ></v-radio>
                </v-radio-group>
            </v-col>
        </v-row>
        <v-row class="mt-2">
            <v-spacer> </v-spacer>
            <v-btn @click="handleSave" color="secondary">
                Save Contact Information
            </v-btn>
        </v-row>
    </v-container>
</template>

<script>
import getters from '@/methods.js'
import cloner from 'lodash'
import constants from '@/constants.js'
import moment from 'moment'
import enums from '@/constants/enums.js'
import TFToggle from '@/sharedComponents/TFToggle.vue'
import ThreeToggle from '@/sharedComponents/ThreeToggle.vue'

export default {
    name: "ContactScript",
    components: {
        TFToggle, ThreeToggle
    },
    props: {
        value: {
            Object,
            required: true
        }
    },
    mixins: [getters],
    data: () => {
        return {
            notified: true,
            tempStatus: null,
            rules: [v => v.length <= 400 || 'Max 400 characters'],
            tested: undefined,
            hasSymptoms: undefined
        }
    },
    computed: {
        updateAgo () {
            return this.value.update_date.fromNow()
        },
        exposedAgo() {
            return this.value.contact_date.fromNow()
        },
        //this doesn't do the right thing at ALL lol 
        endDate() {
            var endDate = cloner.cloneDeep(this.value.contact_date)
            endDate = endDate.add(14, 'days')
            if (endDate.isAfter(moment())) {
                return "for " + endDate.toNow(true)
            } else {
                return ""
            }
        },
        symptomList() {
            return enums.symptoms.asDict
        },
        selfIsoStatuses() {
            return enums.self_isolate.asDict
        },
        unNotifiedStatuses() {
            let thing = enums.contact_call_status.asDict.slice(0, 5)
            console.log(thing)
            return thing
        },
        notifiedStatuses() {
            return enums.contact_call_status.asDict.slice(5, 8)
        },
        assistanceStatuses() {
            return enums.assistance.asDict
        }, 
        symptomaticStatuses() {
            return enums.symptomatic
        },
        user() {
            return this.$store.getters['volunteers/active']
        },
        contact() {
            return this.$store.getters['contacts/id'](this.value.contact_id)
        },
        // vuex model computed properties
        symptomatic: {
            get() {
                return this.value.symptomatic == 0 ? true : false
            }
        },
        symptoms: {
            get() {
                return this.value.symptoms 
            },
            set(newVal) {
                this.contact.symptoms = newVal
                this.updateContact()
            }
        },
        self_isolate: {
            get() {
                return this.value.self_isolate 
            },
            set(newVal) {
                this.contact.self_isolate = newVal
                this.updateContact()
            }
        },
        assistance: {
            get() {
                return this.value.assistance 
            },
            set(newVal) {
                this.contact.assitance = newVal
                this.updateContact()
            }
        },
        contact_call_status: {
            get() {
                return this.value.contact_call_status 
            },
            set(newVal) {
                this.contact.contact_call_status = newVal
                this.updateContact()
            }
        },
    },
    watch: {
        value() {
            this.tempStatus = null

        }
    },
    methods: {
        async handleSave() {
            this.contact.update_date = moment()
            await this.updateContact()
            // TODO: give the user feedback that we are saving

            let res = await this.$store.dispatch('contacts/update', this.contact)
            if(res) {
                this.$emit('reload')
            }
        },
        async updateContact() {
            let res = await this.$store.commit('contacts/updateContact', this.contact)
            if(!res) {
                // TODO: show some sort of alert here
            }
        }
    }
}
</script>

<style>
.update-cards {
    margin-bottom: -12px;
}
.input-size {
    max-width: 100px;
}
.input-larger {
    max-width: 270px;
}
</style>