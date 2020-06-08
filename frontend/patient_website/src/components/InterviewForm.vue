<template>
    <div>
        <v-expansion-panels
            v-model="panel">
            <InterviewEvent 
                v-for="event in $v.events.$each.$iter"
                :key="event.$model.eventID"
                :ID="event.$model.eventID"
                v-model="event.$model"
                :v="event"
            />
        </v-expansion-panels>
        <v-row>
            <v-spacer></v-spacer>
            <v-btn 
                fab small
                @click="newEvent"
                class="mr-7 mt-3">
                <v-icon> mdi-plus </v-icon>
            </v-btn>
        </v-row>
    </div>
</template>

<script>
import InterviewEvent from '@/components/InterviewEvent.vue'
import formMixin from '../mixins/formMixin.js'
// validation rules to check input
import { email, numeric, required } from 'vuelidate/lib/validators'
import { isName } from '../constants/validators'
import apiCalls from '@/apiCalls.js'
import geocoder from '@/geocoder.js'

export default {
    name : "InterviewForm",
    mixins: [formMixin],
    validations : {
        events : {
            $each : {
                eventID : {},
                date : { required },
                location : { },
                contacts : {
                    $each : {
                        contactID : {},
                        firstName : { isName, required },
                        lastName : { isName, required },
                        phone : { numeric },
                        email : { email },
                        contactType : { required },
                        contactNature : { },
                        healthcareWorker : { },
                        age : {}
                    }
                }
            }
        }
    },
    components : {
        InterviewEvent
    },
    props : {
        save: Boolean,
        submit: Boolean
    },
    data () {
        return {
            // TODO: fill in data for each interview event
            events: [],
            panel: Number,
            geocoder: null,
            locations: []
        }
    },
    computed : {
        newID() {
            if (this.events.length > 0) {
                return this.events[this.events.length - 1].eventID + 1
            } else {
                return 1
            }
        }
    },
    methods: {
        newEvent() {
            var event = {
                eventID: this.events.length + 1,
                date: '',
                location : {
                    streetName: '',
                    coordinates: {}
                },
                contacts: []
            }
            
            this.events.push(event)
            this.panel = this.events.length - 1
        },
        async loadLocations() {
            console.log("this is the geocoder in interviewform")
            console.log(this.geocoder)
            if (this.$store.state.loggedIn) {
                // try to get patient locations
                const link = this.$store.state.patientInfo.links.get_locations.href
                let curr = this
                await apiCalls.getLocations(link)
                    .then(async function(locations) {
                    
                    if (locations.length == 0) {
                        this.newEvent();
                    } else {
                        curr.locations = locations
                        let len = (locations.length >=5) ? 5 : locations.length

                        // make an event for each date, feed the date in
                        for (var i = 0; i < len; i++) {
                            let e = i
                            setTimeout(() => { curr.makeOldEvent( e ) }, 200 * e);
                            
                        }
                    }
                })
            } 
        },
        makeOldEvent(i) {
            let l = this.locations[i]
            console.log(l)
            const date = l.start_time.substring(0, 10)
            const position = {
                lng: l.geom.coordinates[0], 
                lat: l.geom.coordinates[1]
            }
            let curr = this;
            geocoder.getStreetName(position, curr.geocoder, function(response) {
                console.log(response)
                    let event = {
                        eventID: l.id,
                        date: date,
                        location: {
                            streetName: response,
                            coordinates: position,
                        },
                        contacts: []
                    }
                    curr.events.push(event)
            })
        }
    },
    async mounted() {
        console.log("LOL this did in fact work")
        this.geocoder = await geocoder.getGeocoder()
        this.loadLocations()
    },
    watched: {
        save: () => {
            // TODO: validate, scroll to any errors 
            // if all is correct, emit to change the state of button (loading)
            // submit to backend (await), then emit to say saved
        },
        submit: function () {
            console.log("submit pushed")
            
            // code red! code red!
            for (var i = 0; i < this.events.length; i++) {
                var event = this.$v.events.$each.$iter[i]
                if (event.$anyDirty) {
                    event.date.$touch();
                }
                for (var contact in event.contacts.$each.$iter) {
                    //console.log(contact)
                    var cat = event.contacts.$each.$iter[contact];
                    if(cat.$anyDirty) {
                        //console.log("trying to make things dirty")
                        cat.$touch();
                    }
                }
            }

            if(this.$v.$anyError) {
                this.expandProblem()
                return
            }
            // if all correct, emit to show progress screen
            this.$emit('submitting')
            // TODO: submit to backend, 
            
            //emit to change to submit screen
            this.$emit('submitted')
        }
    }
}
</script>

<style scoped>

</style>