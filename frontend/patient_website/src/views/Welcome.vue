<template>
<v-app id="inspire" class="gradient">
    <v-row
        align="center"
        justify="center">
        <v-col class="text-center welcome-padding" cols="12">
          <v-card>
            <v-container class="welcome-box" text-align="center" text-justify="center">
                <h1 > Welcome </h1> 
                <br>
                <p> Thank you for taking the time to fill out this contact tracing 
                    interview form. Contact tracing has been used by public health 
                    for decades to slow the spread of infectious disease. Connecticut 
                    uses contact tracing to help people who are test postivie for 
                    COVID-19 get medical care and figure out who they might have 
                    accidentally exposed, so those individuals can be contacted as well.  
                    You will be asked to recall events of the past 
                    two weeks -- who you've seen, where you've been -- to help us 
                    notify others. At any time, you can request an interview with a 
                    volunteer, and someone will call you to go over the form with you. 
                    This form should take you fewer than 10 minutes.
                    <br><br><b> All the information you provide is strictly confidential and we 
                    will never reveal your name to anyone, including people whom you may
                    have exposed.</b>
                </p>
                <v-dialog
                    v-model="dialog"
                    width="700"
                >
                    <template v-slot:activator="{ on }">
                        <a v-on="on" class="align-center" style="text-decoration: underline;"> Request an Interview </a>
                    </template>
                    <InterviewRequestCard v-on:exitDialog="dialog=false"> </InterviewRequestCard>
                </v-dialog>
                <v-select
                    label="Language"
                    :items="languages"
                    v-model="language"
                >
                </v-select>
                <v-btn color='primary' dark class="mt-auto align-center" @click="handleStart"> Start Form </v-btn>
                <v-btn text color="primary" class="mt-auto align-center" @click="handleResources"> View Resources </v-btn>
            </v-container>
          </v-card>
        </v-col>
    </v-row>
</v-app>
</template>

<script>
import InterviewRequestCard from '@/components/InterviewRequestCard'

export default {
    name: "Welcome",
    data () {
        return {
            dialog : false,
            request : false,
            languages: ["English", "Español", "中文"],
            language: "English"
        }
    },
    components: {
        InterviewRequestCard
    },
    methods : {
        handleStart() {
            this.$store.commit('toggleNavBarToTrue')
            this.$router.push({name : 'completeForm'})
        },
        handleResources() {
            this.$router.push({name : 'resources'})
        }
    },
    mounted() {
        // load in the contacts and the events
        let id = this.$store.state.activePatientId
        this.$store.dispatch('events/load', id)
        this.$store.dispatch('contacts/load', id)
    }
}
</script>

<style scoped>

.welcome-padding {
    padding-right: 15%;
    padding-left: 15%;
    margin-top: -5%;
}

.welcome-box {
    padding: 4%;
}

.gradient { 
    background-image: linear-gradient(to top, #E0F2F1, rgba(255, 255, 255, .99));
}
</style>