<template>
    <div class="bold">
    <br> 
    
    <!-- TODO: ideally this break would be in css padding, but that is yet to come -->
        <b-container fluid>
            <h3 class="large">Interview Form</h3>
            <br>
            <b-form>
                <!-- make an Interview Day for each day in $v. 
                day.$model is double bound with the day arrays in our data. ie $v mirrors our data.
                the perfect mirroring is crucial to validation. -->
                <InterviewDay class="day-margins"
                    v-for="day in $v.days.$each.$iter"
                    :key="day.$model.dayID"
                    :date="day.$model.date"
                    :v="day"
                    v-model="day.$model.events" />
                <b-button @click="onSubmit" class="navbar-custom submit shadow"> Submit </b-button>
            </b-form>
        </b-container>
    </div>
</template>

<script>
import InterviewDay from './InterviewDay'
import formMixin from '@/mixins/formMixin'
// validation rules to check input
import { email, numeric } from 'vuelidate/lib/validators'
import { isName } from "@/constants/validators"
import apiCalls from '@/apiCalls'

export default {
    name: 'InterviewForm',

    components: {
        InterviewDay,
    },

    // imports methods for validation from mixin, also handles scroll to first error
    mixins: [formMixin],

    // validations, which is referenced as $v, mirrors the data in days[] all the way down
    // the $each keyword indicates that the enclosing object is an array composed of the enclosed elements
    // also note: $each arrays MUST be named, even if not explicitly named elsewhere
    validations: {
        days: {
            $each: {
                dayID: {},
                date: {},
                events: {
                    $each: {
                        event: {
                            name: { isName },
                            email: { email },
                            phone: { numeric },
                            location: {}
                        },
                        eventID: {}
                    }
                }
            }
        }
    },

    data() {
        return {
            days: [], 
            // TODO: create a first form to choose starting day so this isn't hardcoded as current day
        }
    }, 

    computed: {
        // flag for recursive scrolling function, each component in InterviewForm has such a flag
        // $error = $dirty && $invalid, has been touched and is invalid
        status: function() {
            return this.$v.$error
        }
    },

    mounted: function() {
        if (!this.$store.state.loggedIn) {
            this.$cookies.set('from', "InterviewForm")
            this.$router.push({ name: 'LoginPage' });
        }
        // create array of past dates
        var dates = [];
        var date = new Date(); // this is today! 
        for (var i = 0; i < 7; i++) {
            var tempDate = new Date();
            tempDate.setDate(date.getDate() - i);
            dates.push(tempDate)
        } 
        // initialize empty days with dayID
        var counter = 0
        let day
        for (day of dates) { 
            var dayID = day.getFullYear() +  "-" +  this.pad(day.getMonth()+1) + "-" + this.pad(day.getDate());
            var dateString = this.dateConstructor(day) // set this to be human readable nice string
            // this.$set triggers DOM update
            this.$set(this.days, counter, {
                "dayID": dayID,
                "date": dateString, 
                "events": []
            })
            counter += 1
        }
    },

    methods: {
        pad(n) {
            return ((n < 10) ? ("0" + n) : n)
        },
        //takes as input a date object and returns a human-readable string
        // of the form "Wednesday, March 6"
        dateConstructor(day) {
            var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
            var months = ["January", "February", "March", "April", "May", "June", "July", "August",
                            "September", "October","November","December"]
            return (days[day.getDay()] + ", " + months[day.getMonth()] + " " + day.getDate());
        },
        
        onSubmit: async function(button) {
            button.preventDefault()
            // checks if there is any error in the form and scrolls to first error
            if(this.$v.$anyError) {
                this.focusFirstStatus()
                return
            }

            var locations = this.getLocationArray(this.days);
            console.log(locations);
            
            // insert dummy marker for now
            // TODO: insert all markers into endpoint
            for (var location of locations) {
                console.log(location)
                await apiCalls.insertMarker(location);
            }

            console.log(JSON.stringify(this.days))
        },

        /*
            takes as input the form, creates an array of objects: 
            {
                "trace_id": dummyID
                "start_time": beginning of day in ISO format
                "latitude": latitude
                "longitude": longitude
                "end_time": end of day in ISO format
                "confirmed": true
            }
            */
        getLocationArray(dayArray) {
            var locationArray = [];
            let trace_id = 5;
            let confirmed = true;
            for(var day of dayArray) {
                var start_time = (day.dayID + "T00:00:00.000Z")
                var end_time = (day.dayID + "T23:59:59.000Z")
                for(var ev of day.events) {
                    if(ev.event.latlon != null) {
                        locationArray.push({
                            "trace_id": trace_id,
                            "start_time": start_time,
                            "geom" : {
                                "type" : "Point",
                                "coordinates" : [ev.event.latlon.lat, ev.event.latlon.lng]
                            },
                            "end_time": end_time,
                            "confirmed": confirmed
                        })
                    }
                }
            }
            console.log(locationArray);
            return locationArray;
        }
    }
}
</script>

<style lang="scss" scoped>

.bold {
    font-weight : bold;
}
.day-margins {
    margin-bottom: 5px;
}
.submit {
    position: fixed;
     bottom: 20px;
    right: 40px;
}
</style>
