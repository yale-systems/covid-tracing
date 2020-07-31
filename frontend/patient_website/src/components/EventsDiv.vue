<template>
    <v-container fluid>
        <p> Please add any places you've gone to and people you've come into contact with since <b>{{ $store.getters['patients/readableStartDate'] }}</b>
            until <b>{{ $store.getters['patients/readableEndDate'] }}</b>. This could include going to get groceries, social gatherings, going to work, etc.
            <b>We recommend pulling up your calendar and looking at your payment history over this period of time to jog your memory.</b>
        </p>
        <p>
            Each "event" represents one of these occurrences. It might be difficult to recall exactly which day something happened,
            so just do your best to select the date you think is accurate. For each event, you may supply a location, contacts information,
            or both if you feel comfortable sharing that information. 
        </p>
        <p>
            If you would like to speak to a volunteer to assist you in filling out the form, you can request an interview by clicking
            <v-dialog
                    v-model="dialog"
                    width="700px"
                >
                    <template v-slot:activator="{ on }">
                        <a v-on="on" class="align-center" style="text-decoration: underline;"> here</a>
                    </template>
                    <InterviewRequestCard v-on:exitDialog="dialog=false"> </InterviewRequestCard>
            </v-dialog>. 
        </p>
        <InterviewEvent 
            v-for="(event, i) in events"
            :key="event.event_id"
            :validate="childValidate"
            :id="events[i].event_id"
            v-on:splice="spliceEvent"
            ref="eventRefs"
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
    </v-container>
</template>

<script>
import InterviewEvent from '@/components/InterviewEvent.vue'
import InterviewRequestCard from '@/components/InterviewRequestCard.vue'
import VueScrollTo from 'vue-scrollto'

export default {
    name: "EventsDiv",
    data () {
        return {
            dialog: false,
            locationLinks: {}, // TODO: move these to the vuex store
            childValidate: false
        }
    },
    props: {
        validateDate: Boolean
    },
    computed: {
        p_id() {
            return this.$store.state.patients[0].patient_id
        },
        events() {
            return this.$store.getters['events/current']
        }
    },
    components: {
        InterviewEvent,
        InterviewRequestCard
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
</style>