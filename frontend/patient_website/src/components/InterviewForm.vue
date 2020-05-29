<template>
    <div>
        <v-expansion-panels>
            <InterviewEvent 
                v-for="i in eventCount"
                :key="i"
                :ID="i"
            />
        </v-expansion-panels>
        <v-row>
            <v-spacer></v-spacer>
            <v-btn 
                icon
                @click="newEvent"
                class="mr-7">
                <v-icon> mdi-plus </v-icon>
            </v-btn>
        </v-row>
    </div>
</template>

<script lang="ts">
import Vue from 'vue'
import InterviewEvent from '@/components/InterviewEvent.vue'

export default Vue.extend({
    name : "InterviewForm",
    components : {
        InterviewEvent
    },
    data () {
        return {
            // TODO: fill in data for each interview event
            eventCount : 1
        }
    },
    methods : {
        newEvent() {
            // TODO: add to an array of events
            this.eventCount++;
        }
    }
})
</script>

<style scoped>

</style>