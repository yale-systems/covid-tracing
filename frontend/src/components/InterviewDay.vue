<template>
    <div>
        <!-- import icon to add event -->
        <!-- TODO: link stylesheet outside of template -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!-- TODO: style -->
        <h3 class="card-date shadow sticky"> {{date}} </h3>
        <!-- make InterviewCard for each event, using v, which is $v passed in from the parent -->
        <InterviewCard
           class="icard card-background" v-for="card in v.events.$each.$iter"
            :key="card.eventID.$model"
            :v="card.event"
            :defaultEventNum="card.eventID.$model + 1"
            @delete="removeCard"
            v-model="card.event.$model"/>
        <!-- add the plus sign -->
        <div class="centered">
            <i class="material-icons" @click="addEvent">add_circle_outline</i>
        </div>
    </div>
</template>

<script>
import InterviewCard from './InterviewCard'

export default {
    name: 'InterviewDay',

    props: {
        date: String,
        // creates double binding between data in Day and Form
        value: {
            type: Array, 
            required: true
        },
        // validation object, $v in parent InterviewForm
        v: {
            type: Object, 
            required: true
        }
    },

    components: {
        InterviewCard
    },

    data: function () {
        return {
            newEvent: {
                name: '',
                email: '',
                phone: '',
                location: '',
                latlon : null
            }
        }
    },

    computed: {
        // see InterviewForm; flag for recursive error checking
        status: function() {
            return this.v.$error
        }
    },

    
    methods: {
        // create new event on clicking plus button
        addEvent: function() {
            this.$set(this.value, this.value.length, {
                eventID: this.value.length, 
                event: Object.assign({}, this.newEvent)
            })
        },
        removeCard(eventID){
            console.log("trying to remove card with ID " + eventID)
            for (var counter = 0; counter < this.value.length; counter++) {
                if(this.value[counter].eventID == eventID) {
                    this.value.splice(counter, 1)
                }
            }
        }
    },
}
</script>

<style scoped>

.material-icons:hover{
    color: darkgray;
    cursor: pointer
}

</style>