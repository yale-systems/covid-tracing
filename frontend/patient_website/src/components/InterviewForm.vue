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
            panel: Number
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
            //console.log(events.length)
            this.panel = this.events.length - 1
        },
        expandProblem() {
            var count = 0;
            for (event in this.$v.events.$each.$iter) {
                if (this.$v.events.$each[event].$anyError) {
                    break
                }
                count = count + 1
            }
            this.panel = count;
        }
    },
    watch : {
        save : () => {
            // TODO: validate, scroll to any errors 
            // if all is correct, emit to change the state of button (loading)
            // submit to backend (await), then emit to say saved
        },
        submit : function () {
            console.log("submit pushed")
            // TODO: validate, open up event containing first error
            
            if(this.$v.$anyError) {
                this.expandProblem()
                this.$emit('errorFound')
                return
            }
            // if all correct, emit to show progress screen
            this.$emit('submitting')
            // TODO: submit to backend, 
            
            //emit to change to submit screen
            this.$emit('submitted')
        }
    },
    mounted() {
        console.log(this.$v)
        this.newEvent()
    }
}
</script>

<style scoped>

</style>