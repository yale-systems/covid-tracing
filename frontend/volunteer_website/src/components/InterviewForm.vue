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
            events: []
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
        }
    },
    mounted() {
        this.newEvent()
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