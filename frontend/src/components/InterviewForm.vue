<template>
    <div class="bold">
    <br> 
    <!-- TODO: ideally this break would be in css padding, but that is yet to come -->
        <b-container fluid>
            <b-form>
                <!-- make an Interview Day for each day in $v. 
                day.$model is double bound with the day arrays in our data. ie $v mirrors our data.
                the perfect mirroring is crucial to validation. -->
                <InterviewDay
                    v-for="day in $v.days.$each.$iter"
                    :key="day.$model.dayID"
                    :date="day.$model.date"
                    :v="day"
                    v-model="day.$model.events" />
                <b-button type="submit" @click="onSubmit" variant="primary"> Submit </b-button>
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
            // TODO: create a first form to choose starting day so this isn't hardcoded
            // then write function to convert between ISO and human readable
            dayLabels: ["Monday, May 4", "Sunday, May 3", 
                "Saturday, May 2", "Friday, May 1", 
                "Thursday, April 30", "Wednesday, April 29",
                "Tuesday, April 28", "Monday, April 27"]
        }
    }, 

    computed: {
        // flag for recursive scrolling function, each component in InterviewForm has such a flag
        // $error = $dirty && $invalid, has been touched and is invalid
        status: function() {
            return this.$v.$error
        }
    },

    mounted() {
        // initialize empty days with dayID
        var counter = 0
        let day
        for (day of this.dayLabels) {
            // this.$set triggers DOM update
            this.$set(this.days, counter, {
                dayID: counter,
                date: day, 
                events: []
            })
            counter += 1
        }
    },

    methods: {
        onSubmit: function(button) {
            button.preventDefault()
            // checks if there is any error in the form and scrolls to first error
            if(this.$v.$anyError) {
                this.focusFirstStatus()
                return
            }
            // insert dummy marker for now
            // TODO: insert all markers into endpoint
            apiCalls.insertMarker({
                "trace_id": 4105,
                "start_time": "2008-02-03T10:17:44.000+0000",
                "latitude": 39.9070312,
                "longitude": 116.43843,
                "end_time": "2008-02-03T10:19:44.000+0000",
                "confirmed": false
            })
            console.log(JSON.stringify(this.days))
        }
    }
}
</script>

<style lang="scss" scoped>

.bold {
    font-weight : bold;
}

</style>
