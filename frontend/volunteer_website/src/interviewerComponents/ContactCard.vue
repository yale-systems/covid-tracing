<template>
  <v-card class="tall" max-width="775px" elevation=10>
    <v-container fluid>
        <ContactForm 
            :household="household" 
            :openClicked="value.viewContact"
            :validate="validate"
            :id="id"
            v-on:contact-success="submitAndReload"></ContactForm>
        <v-card-actions class="card-actions">
            <v-spacer></v-spacer>

            <v-btn color="primary" 
                text 
                @click="closeAndReload"
            >Close</v-btn>
            <v-btn 
                color="primary"
                dark
                @click="validate = !validate"
            >Save</v-btn>
        </v-card-actions>
    </v-container>
  </v-card>
</template>

<script>
import ContactForm from "@/interviewerComponents/ContactForm"

export default {
    name: "ContactCard",
    components: {
        ContactForm
    },
    props: {
        value: {
            Object,
            required: true
        },
        household: {
            Boolean,
            required: true
        },
        id: {
            Number,
            required: true
        },
    },
    data: () => {
        return {
            validate: false
        }
    },
    methods: {
        closeAndReload() {
            this.value.viewContact = false
            this.$store.commit('closeDialog')
        },
        submitAndReload(data) {
            console.log("data from contact form is: ")
            console.log(data)
            this.value.viewContact = false
            // when opened, was new contact
            if (this.id == -1) {
                this.$store.dispatch('contacts/add', data)
            } else {
                this.$store.dispatch('contacts/update', data)
            }
        }
    }

}
</script>

<style scoped>
.tall{
    z-index: 8;
}
</style>