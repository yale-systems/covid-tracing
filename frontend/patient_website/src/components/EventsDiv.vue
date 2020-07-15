<template>
    <v-container fluid>
        <p> Please add any places you've gone to and people you've come into contact with since <b>{{ $store.getters.readableStartDate }}</b>
            until <b>{{ $store.getters.readableEndDate }}</b>. This could include going to get groceries, social gatherings, going to work, etc.
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
            :key="event.eventID"
            :id="event.eventID"
            :validate="childValidate"
            v-model="events[i]"
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
import apiCalls from '@/apiCalls.js'
import geocoder from '@/geocoder.js'
import VueScrollTo from 'vue-scrollto'

export default {
    name: "EventsDiv",
    data () {
        return {
            dialog: false,
            events: [],
            locationLinks: {},
            geocoder: null,
            childValidate: false
        }
    },
    props: {
        validateDate: Boolean
    },
    computed: {
        p_id() {
            return this.$store.state.patientInfo.patient_id
        }
    },
    components: {
        InterviewEvent,
        InterviewRequestCard
    },
    methods: {
        // pushes one empty event onto the events list so users can see what it looks like
        newEvent() {
            let newEvent = {
                eventID: (this.events.length == 0) ? 0 : this.events[this.events.length-1].eventID + 1,
                date: '',
                location: {
                    streetName: '',
                    coordinates: {}
                },
                contactNature: undefined,
                contacts: [],
                add: true,
                dateValid: true
            }
            this.events.push(newEvent)
        },
        async loadLocations() {
            // if the user is logged in, load the locations using link given
            if (this.$store.state.loggedIn) {
                // TODO: write getter for patient links
                const link = this.$store.state.patientInfo.links.get_locations.href
                let curr = this
                await apiCalls.getLocations(link)
                    // after receiving locations, make an event for each date
                    .then(async function(locations) {
                        if (locations.length == 0) {
                            curr.newEvent();
                        } else {
                            // get the link to update, delete locations and make those links general
                            for (var link of locations[0].links) {
                                let href = link["href"].replace(/\d+$/, "")
                                curr.locationLinks[link["rel"]] = href
                            }
                            curr.locationLinks["insert_location"] = curr.$store.state.patientInfo.links.insert_location.href

                            // make an event for each date and put in the date
                            // for now we'll only do 5
                            let len = (locations.length >= 5) ? 5 : locations.length
                            for (var i  = 0; i < len; i++) {
                                // TODO: put below processing into apiCalls
                                let l = locations[i]
                                const date = l.start_time.substring(0, 10)
                                var position = {}
                                var placeholder = ''
                                if (l.geom) {
                                    position = {
                                        lng: l.geom.coordinates[0], 
                                        lat: l.geom.coordinates[1]
                                    }
                                    placeholder = "loading..."
                                }
                                let newEvent = {
                                    eventID: l.id,
                                    date: date,
                                    location: {
                                        streetName: placeholder,
                                        coordinates: position,
                                    },
                                    contactNature: undefined,
                                    contacts: [],
                                    add: false,
                                    dateValid: true
                                }
                                curr.events.push(newEvent)
                                
                                if (l.geom) {
                                    let e = i
                                    setTimeout(() => { curr.setStreetName( e, position ) }, 200 * e);
                                }
                            }
                        }
                    })
            }
        },
        setStreetName(i, position) {
            let curr = this;
            let e = i;
            geocoder.getStreetName(position, curr.geocoder, function(response) {
                curr.events[e].location.streetName = response
            });
        },
        //remove event locally
        spliceEvent(eventID) {
            for (var i = 0; i < this.events.length; i++) {
                if (this.events[i].eventID == eventID) {
                    this.events.splice(i, 1)
                }
            }
        },
        // recursive function to delete events from backend
        // takes in array of eventIDs to be deleted
        async deleteEvents(locations) {
            if (locations.length == 0) {
                return true
            } else {
                let id = locations.pop()
                if (this.deleteEvents(locations)) {
                    let curr = this
                    var success = true
                    await apiCalls.deleteLocation(this.locationLinks["delete"], id)
                    .then(function(response) {
                        if (response) {
                            curr.$store.commit('rmDeleteLocation', id)
                        } else {
                            curr.$emit('error')
                            success = false
                        }
                    })
                    return success
                } else {
                    return false
                }
            }
        },
        // recursively adds events to backend
        // takes in a dict of events to be added with eventID (local) as key, event fields as value
        async addEvents(events) {
            if (Object.keys(events).length == 0) {
                return true
            } else {
                // get the event itself
                let eventID = Object.keys(events)[0]
                let event = events[eventID]
                let curr = this
                // remove it from the events to pass down recursively
                delete events[eventID]
                if(this.addEvents(events)) {
                    let success = true
                    // if the previous one worked, then we also try!
                    // we're going to process the json over there
                    await apiCalls.addLocation(this.locationLinks["insert_location"], event, this.p_id)
                        .then(function(response) {
                            if(response) {
                                curr.$store.commit('rmAddLocation', eventID)
                            } else {
                                curr.$emit('error')
                                success = false
                            }
                        })
                    return success
                } else {
                    return false
                }
            }
        }
    },
    async mounted() {
        this.geocoder = await geocoder.getGeocoder()
        await this.loadLocations()
    },
    watch: {
        validateDate: async function() {
            this.childValidate = !this.childValidate
            let curr = this
            let datesValid = this.events.every(function (event, i){
                //TODO: fix this thank you it scrolls up not down rn
                if (!event.dateValid) {
                    let el = document.getElementById(event.eventID)
                    VueScrollTo.scrollTo(el)
                    return false
                }
                return true
            })

            if (datesValid) {
                this.$emit('all-dates-success')

                var success = await this.deleteEvents(this.$store.state.deleteLocations)
                if (success) {
                    for (let event of this.events) {
                        if (event.add) {
                            let e = event
                            this.$store.commit('qAddLocation', e)
                            event.add = false
                        }
                    }
                    // console.log(this.$store.state.addLocations)
                    success = await this.addEvents(this.$store.state.addLocations)
                    if (success) {

                        // TODO: update events here
                        this.$emit('all-success')
                    }
                }
            }
        }
    }
}
</script>

<style>
</style>