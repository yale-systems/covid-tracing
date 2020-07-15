<template>
    <v-dialog 
        v-model="value.showDialog" 
        persistent 
        scrollable="false"
        class="ma-0 pa-0"
        max-width="845px"
    >
        <v-card full class="ma-0 pa-0">
            <ContactForm 
                :household="household" 
                :openClicked="value.showDialog"
                :validate="validate"
                :id="id"
                v-on:contact-success="submitAndReload"> 
            </ContactForm>
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
        </v-card>
    </v-dialog>
</template>


<script>

import ContactForm from '@/interviewerComponents/ContactForm.vue'

export default {
    name: "ContactDialog",
    components: {
        ContactForm
    },
    props: {
        household: {
            Boolean,
            required: true
        },
        id: {
            Number,
            required: true
        },
        value: {
            required: true
        }
    },
    data: () => {
        return {
            validate: false
        }
    },
    methods: {
        closeAndReload() {
            this.value.showDialog = false
            this.$emit('reload', this.id)
        },
        submitAndReload(data) {
            this.value.showDialog = false
            // when opened, was new contact
            if (this.id == -1) {
                this.$store.commit('addContact', data)
                this.$nextTick(() => {
                    this.$emit('reload', this.$store.state.contactID - 1)
                })
            } else {
                this.$store.commit('modifyContact', data)
                this.$emit('reload', this.id)
            }
        }
    }
}

</script>

<style scoped>

.card-actions {
    margin-top: -80px;
    padding-bottom: 15px;
    padding-right: 20px;
}
</style>


