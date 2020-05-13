<template>
    <div>
        <!-- import icon to add event -->
        <!-- TODO: link stylesheet outside of template -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!-- TODO: style -->
        <h3 class="card-date sticky"> {{date}} </h3>
        <!-- make InterviewCard for each event, using v, which is $v passed in from the parent -->
        <InterviewCard
           class="icard card-background" v-for="card in v.events.$each.$iter"
            :key="card.eventID.$model"
            :v="card.event"
            :defaultEventNum="card.eventID.$model + 1"
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
            count: 0,
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
            this.$set(this.value, this.count, {
                eventID: this.count, 
                event: Object.assign({}, this.newEvent)
            })
            this.count += 1
        }
    },
}
</script>

<style scoped>

.card-date {
    font-size: 24px;
    text-align: left;
    color: black;
    background-color: rgb(148, 174, 219);
    padding-top: 10px;
    padding-bottom: 10px;
    padding-left: 20px;
    margin-left: 10%;
    margin-right: 10%;
}

.centered {
    justify-content: center;
    display: flex;
    align-items:center;
    padding-bottom: 10px;
    padding-top: 8px;
}

.material-icons:hover{
    color: darkgray;
    cursor: pointer
}

.sticky {
position: sticky;
  left: 0px;
  top: 0px;
  z-index: 1;
}

</style>