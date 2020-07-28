<template>
    <v-container fluid class="ma-6 centered-flexbox" style="max-width:95%">
        <!-- dialog to make a contact show up for the interview event -->
        <div class="center">
            <transition name="slide-fade" >
                <ContactCard 
                    v-show="formToggle.viewContact"
                    v-model="formToggle"
                    :household="household"
                    :id="(selectedID == undefined) ? -1 : selectedID"
                />
            </transition> 
        </div>
        <div :class="(formToggle.viewContact) ? 'overlay top mr-5 pr-5' : 'top mr-5 pr-5'">
            <h4 class="header">Events</h4><br>
        <p> Please add any places you've gone to and people you've come into contact with since <b>{{ $store.getters['patients/readableStartDate'] }}</b>
            until <b>{{ $store.getters['patients/readableEndDate'] }}</b>. This could include going to get groceries, social gatherings, going to work, etc.
            <b>We recommend pulling up your calendar and looking at your payment history over this period of time to jog your memory.</b>
        </p>
        <p>
            Each "event" represents one of these occurrences. It might be difficult to recall exactly which day something happened,
            so just do your best to select the date you think is accurate. For each event, you may supply a location, contacts information,
            or both if you feel comfortable sharing that information. 
        </p>
        <InterviewEvent 
            v-for="(event, i) in events"
            :key="event.event_id"
            :id="event.event_id"
            :validate="childValidate"
            v-model="events[i]"
            v-on:splice="spliceEvent"
            ref="eventRefs"
            v-on:showDialog="open"
        />
        <v-btn
            outlined
            @click="newEvent"
            style="margin-top:20px;"
            class="ml-5"
        >
            <v-icon> mdi-plus </v-icon>
            add event
        </v-btn>
        
        <hr class="mt-6" style="border-top: 1px solid rgb(226, 226, 226);"><br>
            <h4 class="header">Closing Script</h4><br>
        <v-row style="align-items:center">
                <v-col>
                    <p class="font-weight-medium">
                        Do you give permission for a City of New Haven representative to reach out 
                        to you regarding your answers to the earlier basic needs or temporary relocation for isolation 
                        questions? By agreeing to this referral, you acknowledge that the City of New Haven team or its 
                        representatives may need to disclose your COVID-19 test result status, and you agree that we may do so.
                    </p>
                </v-col>
                <v-col cols="3">
                    <TFToggle v-model="referral" />
                </v-col>
            </v-row>
        <p class="font-weight-medium">
            Thank you very much for your time. If you have any general questions or concerns, 
            please feel free to call the City of New Haven 24/7 COVID-19 Hotline at <b>203-946-4949</b>. 
            You can also call <b>2-1-1</b> for any concerns regarding basic needs such as food, housing, 
            or social services. Always remember to call <b>9-1-1</b> if you experience a medical emergency 
            or consult your doctor if you have any medical questions/concerns.
        </p>
        <p class="font-weight-medium">
            You can also visit 
            the City of New Haven COVID-19 webpage for up-to-date info and to sign up for city alerts at 
            <b>covid19.newhavenct.gov.</b>
        </p>
        <p class="font-weight-medium">
            I hope you feel better soon and thank you again for all of your help.
        </p>
        </div>
    </v-container>
</template>

<script>
import InterviewEvent from '@/interviewerComponents/InterviewEvent.vue'
import ContactCard from '@/interviewerComponents/ContactCard.vue'
import VueScrollTo from 'vue-scrollto'
import TFToggle from '@/sharedComponents/TFToggle.vue'

export default {
    name: "EventsDiv",
    components: {
        InterviewEvent,
        TFToggle,
        ContactCard
    },
    data () {
        return {
            dialog: false,
            locationLinks: {}, // TODO: move these to the vuex store
            childValidate: false,
            formToggle: {
                viewContact: false
            },
            household: false,
            selectedID: undefined
        }
    },
    props: {
        validateDate: Boolean
    },
    computed: {
        p_id() {
            return this.$store.getters['patients/activePatient'].patient_id
        },
        events() {
            return this.$store.getters['events/current']
        },
        referral: {
            get() {
                return this.$store.getters['patients/activePatient'].referral
            },
            set(newVal) {
                let obj = this.$store.getters['patients/activePatient']
                obj.referral = newVal
                this.$store.commit('patients/updatePatient', obj)
            }
        }
    },
    methods: {
        newEvent() {
            this.$store.dispatch('events/addBlankEvent')
        },
        //remove event locally
        spliceEvent(eventID) {
            for (var i = 0; i < this.events.length; i++) {
                if (this.events[i].eventID == eventID) {
                    this.events.splice(i, 1)
                }
            }
        },
        open(id) {
            if(id === -1 || id === undefined) {
                this.household = false
            } else {
                this.household = this.$store.getters['contacts/id'](id).household
            }
            this.selectedID = id
            this.$nextTick(() => {  
                this.formToggle.viewContact = true
            });
        },
    },
    watch: {
        async validateDate() {
            this.childValidate = !this.childValidate
            let datesValid = this.events.every((event) => {
                if (!event.dateValid) {
                    let el = document.getElementById(event.eventID)
                    VueScrollTo.scrollTo(el)
                    return false
                }
                return true
            })

            if (datesValid) {
                this.$emit('all-dates-success')
                let success = await this.$store.dispatch('events/submit')
                let patient = this.$store.getters['patients/activePatient']
                let patSuccess = await this.$store.dispatch('patients/update', patient)
                console.log(success, patSuccess)
                if (success && patSuccess) { this.$emit('all-success') }
            }
        }
    }
}
</script>

<style>
.header {
    color:#01579B;
}
</style>