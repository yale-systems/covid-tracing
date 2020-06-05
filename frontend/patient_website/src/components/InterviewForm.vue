<template>
    <div>
        <v-expansion-panels>
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
import formMixin from '../mixins/formMixin'
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
        save : Boolean,
        submit : Boolean
    },
    data () {
        return {
            // TODO: fill in data for each interview event
            events: [],
            geocoder: null
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
    methods : {
        newEvent() {
            var event = {
                eventID : this.events.length + 1,
                date : '',
                location : {
                    streetName : '',
                    coordinates : {}
                },
                contacts : []
            }
            this.events.push(event)
        },
        async loadLocations() {
            console.log("this is the geocoder in interviewform")
            console.log(this.geocoder)
            if (this.$store.state.loggedIn) {
                // try to get patient locations
                const link = this.$store.state.patientInfo.links.get_locations.href
                var locations = await apiCalls.getLocations(link)
                if (locations.length == 0) {
                    this.newEvent();
                } else {
                    // make an event for each date, feed the date in
                    for (var i = 0; i < 1; i++) {
                        let l = locations[i]
                        // console.log(l)
                        const date = l.start_time.substring(0, 10)
                        const position = {
                            lng: l.geom.coordinates[0], 
                            lat: l.geom.coordinates[1]
                        }
                        let curr = this;
                        await geocoder.getStreetName(position, this.geocoder)
                            .then(function(response) {
                                console.log(response)
                                let event = {
                                    eventID : l.id,
                                    date : date,
                                    location : {
                                        streetName : response,
                                        coordinates : position,
                                        contacts : []
                                    }
                                }
                                curr.events.push(event)
                            })
                    }
                }
            } 

            // await apiCalls.getLocations()
        }
    },
    async mounted() {
        this.geocoder = await geocoder.getGeocoder()
        this.loadLocations()
    },
    watched : {
        save : () => {
            // TODO: validate, scroll to any errors 
            // if all is correct, emit to change the state of button (loading)
            // submit to backend (await), then emit to say saved
        },
        submit : () => {
            // TODO: validate, scroll to any errors
            // if all correct, emit to show progress screen
            // submit to backend, emit to change to submit screen
        }
    }
}
</script>

<style scoped>

</style>