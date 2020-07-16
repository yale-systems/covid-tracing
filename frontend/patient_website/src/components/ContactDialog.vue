<template>
    <v-dialog 
        v-model="value.showDialog" 
        persistent 
        :scrollable="false"
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

import ContactForm from '@/components/ContactForm.vue'

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
        async submitAndReload(data) {
            // when opened, was new contact
            if (this.id == -1) {
                let newID = await this.$store.dispatch('contacts/add', data)
                if(newID < 0) {
                    alert("Contact was not able to be added, please try again.")
                    return
                } else {
                    this.$nextTick(() => {
                        this.$emit('reload', newID)
                    })
                }
            } else {
                let updated = this.$store.dispatch('contacts/update', data)
                if (!updated) {
                    alert("there was an error updating your request, please enter the information andtry again")
                    return
                }
                this.$emit('reload', this.id)
            }
            this.value.showDialog = false
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


