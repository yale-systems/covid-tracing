<template>
    <v-container fluid>
        <v-card class="submit-margins align-center justify-center ma-10">
            <v-card-title style="font-size:22px;"> Thank you for your time. </v-card-title>
            <v-card-text style="font-size: 18px;">
                    We appreciate and value the time you took to fill out this form. 
                The information you provided us will be used to help slow the 
                spread of COVID-19. We'll be reaching out to the contacts 
                you provided us over the next few days to assist them and inform them
                of their exposure, and the public locational data you provided will 
                aid researchers and the greater New Haven community alike. 
                Once again, thank you.

                <br><br>We know this is an incredibly hard time, and many are
                coping with significant loss — if you’re struggling during this time,
                whether financially, mentally, or emotionally, and would like support, 
                we’ve set up a list of resources to help. Click the "resources" button 
                below to access these materials.

                <br><br>If you want to see your full submission, edit your response, or add 
                more information, click the “edit submission” button.
            </v-card-text>
            <v-card-actions>
                <v-spacer> </v-spacer>
                <v-btn text color="primary" @click="handleResources" depressed> View Resources </v-btn> 
                <v-btn dark color="primary" @click="handleEdit">  Edit Submission </v-btn> 
            </v-card-actions>
        </v-card>
    </v-container>
</template>

<script>
import Vue from 'vue'
export default Vue.extend({
    name : "SubmitPage",
    methods : {
        handleEdit() {
            this.$router.push({path: "/completeform/3"})
        },
        handleResources() {
            this.$router.push({path: "/resources"})
        }
    }
})
</script>

<style scoped>

.submit-margins {
    padding: 2%;
}
</style>