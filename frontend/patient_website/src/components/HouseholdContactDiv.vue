<template>
    <div>
        <p>                         
            Please add any household contacts here, including anyone you live with, such as family members or housemates.
            Add people you have come into contact with since <b>{{ $store.getters['patients/readableStartDate'] }}</b>. On the next page, you will be able to 
            add people you have come into contact with outside the home. 
        </p>
        <v-container fluid> 
            <v-btn outlined @click="dialogToggle.showDialog = true">
                <v-icon>
                    mdi-plus
                </v-icon>
                add contact
            </v-btn>

            <v-container fluid class="mt-2">
                <template v-for="contact in householdContacts">
                    <HouseholdContact 
                        :key="contact.contact_id"
                        :contactID="contact.contact_id" 
                    />
                </template>
            </v-container>
        </v-container>
        <ContactDialog
            v-model="dialogToggle"
            :household="true"
            :id="-1"
            buttonTitle="eat"
        />
    </div>
</template>

<script>
import ContactDialog from '@/components/ContactDialog'
import HouseholdContact from '@/components/HouseholdContact'

export default {
    name: "HouseholdContactDiv",
    components: {
        ContactDialog,
        HouseholdContact
    },
    computed: {
        householdContacts() {
            return this.$store.getters['contacts/householdContacts']
        },
    },
    data: () => {
        return {
            dialogToggle: {
                showDialog: false
            }
        }
    }
}
</script> 