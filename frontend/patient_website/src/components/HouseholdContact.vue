<template>
  <v-card class="household-spacing">
    <v-container fluid>
        <v-list-item>
            <v-list-item-content>
                <v-row style="align-items:center" class="mr-0">
                    <v-col cols = "3">
                        <h3> {{ contactInfo.name }} </h3>
                    </v-col>
                    <v-col cols = "3">
                        <p class="mb-0"> Date: {{ contactInfo.date }} </p>
                    </v-col>                    
                    <v-col cols ="4">
                        <p :class="{'mb-0': true, 'pb-3': (contactInfo.email != undefined && contactInfo.email != '')}" 
                        v-if="(contactInfo.phone != undefined && contactInfo.phone != '')"> 
                            Phone: {{ contactInfo.phone }} 
                        </p>
                        <p class="mb-0" v-if="(contactInfo.email != undefined && contactInfo.email != '')"> 
                            Email: {{ contactInfo.email }} 
                        </p>
                        <p class="mb-0 tall-lines" 
                            v-if="(contactInfo.phone == undefined || contactInfo.phone == '')
                             && (contactInfo.email == undefined || contactInfo.email == '')"> 
                            We won't be able to contact this person for you - 
                            <a @click="dialogToggle.showDialog = true"> want to add a phone number or email? </a>  
                        </p> 
                    </v-col>
                    <spacer></spacer>
                </v-row>
            </v-list-item-content>
            <v-col cols="2" md="2">
                
                <v-btn color="error" 
                    small 
                    outlined
                    @click="deleteContact"
                    class="mx-1 mb-1">
                    delete
                </v-btn>
                
                <v-btn
                    small
                    outlined
                    @click="dialogToggle.showDialog = true"
                    class="mb-1"
                >
                    edit
                </v-btn>
            </v-col>
        </v-list-item>
    </v-container>
    <ContactDialog
        style="background-color:green;"
        v-model="dialogToggle"
        :household="true"
        :id="contactID"
    />
  </v-card>
</template>

<script>
import ContactDialog from '@/components/ContactDialog.vue'
export default {
    name: "HouseholdContact",
    components: {
        ContactDialog
    },
    props: {
        contactID: {
            Number,
            required: true
        }
    },
    data: () => {
        return {
            renderComponent: 0,
            dialogToggle: {
                showDialog: false
            }
        }
    },
    computed: {
        contactInfo() {
            this.$store.state.fuckThis;
            let contact = this.$store.state.contacts[this.contactID]
            return { 
                name: this.$store.getters.fullName(this.contactID),
                phone: contact.phone,
                date: contact.date,
                email: contact.email
            }
        }
    },
   
    methods: {
        deleteContact() {
            this.$store.commit('deleteContact', this.contactID)
        },
    },

}
</script>

<style>

.tall-lines{
    line-height: 1.3em
}

.household-spacing {
    margin-top: 10px;
}
</style>