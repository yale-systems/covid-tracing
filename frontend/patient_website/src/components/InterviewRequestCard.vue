<template>
    <div>
    <v-card v-if="!request">
        <v-container fluid>
            <v-card-title primary-title>
                Want to talk to a volunteer?
            </v-card-title>
            <v-card-text>
                <p> 
                If you would like someone to call you and help you fill out 
                the form together, please request an interview with a 
                volunteer. Someone will reach out to you by phone. Please 
                fill out the fields below so we can contact you with your preferred
                phone number and at a time that's good for you.  
                </p> 
                <v-text-field
                        class="mx-3"
                        label="Phone Number"
                ></v-text-field>
                <v-text-field label="Preferred Time" 
                    class="mx-3"
                    placeholder="e.g. weekends after 6pm">
                </v-text-field>
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn text color="primary" @click="changeDialog"> Cancel </v-btn>
                <v-btn color="primary" dark @click="request = true"> Yes, I want to talk to someone </v-btn>
            </v-card-actions>
        </v-container>
    </v-card>

    <v-card v-if="request">
        <v-container fluid>
            <v-card-title primary-title> Your interview has been requested </v-card-title>
            <v-card-text>
                A volunteer will be in touch with you shortly. In the meantime, feel free to
                close the form until then or continue to fill out the form.
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="primary" text @click="changeDialog"> Got it </v-btn>
            </v-card-actions>
        </v-container>
    </v-card>
    </div> 
</template>

<script>
export default {
    data: () => {
        return {
            request: false
        }
    },
    methods: {
        changeDialog() {
            this.$emit('exitDialog')
        },
        
    }
}
</script>