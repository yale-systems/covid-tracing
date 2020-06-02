<template>
    <v-container text-align="center" text-justify="center">
        <h1 > Welcome </h1> 
        <br>
        <p> Thank you for taking the time to fill out this contact tracing 
            interview form. You will be asked to recall events of the past 
            two weeks -- who you've seen, where you've been -- to help us 
            notify others. At any time, you can request an interview with a 
            volunteer, and someone will call you to go over the form with you.
        </p>
        <br>
        <router-link to="tutorial" class="align-center"> take a tutorial </router-link>
        <br>
        <v-dialog
            v-model="dialog"
            width="700"
        >
            <template v-slot:activator="{ on }">
                <a v-on="on" class="align-center"> request an interview </a>
            </template>

            <v-card v-if="!request">
                <v-card-title primary-title>
                    Want to talk to a volunteer?
                </v-card-title>
                <v-card-text>
                    If you would like someone to call you and help you fill out 
                    the form together, feel free to request an interview with a 
                    volunteer. Someone will reach out to you by phone.
                </v-card-text>

                <v-divider></v-divider>
  
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn @click="dialog = false"> Cancel </v-btn>
                    <v-btn color="primary" @click="request = true"> Yes, I want to talk to someone </v-btn>
                </v-card-actions>
            </v-card>

            <v-card v-if="request">
                <v-card-title primary-title> Your interview has been requested </v-card-title>
                <v-card-text>
                    A volunteer will be in touch with you shortly. In the meantime, feel free to
                    close the form until then or continue to fill out the form.
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="primary" text @click="dialog = false"> Got it </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <br>
        <v-btn class="mt-auto align-center" @click="handleStart"> Start Form </v-btn>
    </v-container>
</template>

<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
    name: "Welcome",
    data () {
        return {
            dialog : false,
            request : false
        }
    },
    methods : {
        handleStart() {
            this.$router.push({name : 'form'})
        }
    }
})
</script>

<style scoped>

</style>