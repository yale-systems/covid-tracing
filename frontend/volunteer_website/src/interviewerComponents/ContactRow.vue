<template>
    <tr>
        <td> {{ contactInfo.name }} </td>

    
        <td v-if="showDate == true"> {{ contactInfo.date }} </td>
        <td> {{ contactInfo.phone }} </td>
        <td> {{ contactInfo.email }} </td>      
    
        <td :style="'text-align: right;'"> 
            <v-btn
                small
                outlined
                @click="$emit('open', contactID)"
                class="mb-1">
                edit
            </v-btn>
            <v-btn color="error" 
                small 
                outlined
                @click="deleteContact"
                class="mx-1 mb-1">
                delete
            </v-btn>
        </td>
    </tr>
</template>

<script>
import getters from '@/methods.js'

export default {
    name: "ContactRow",
    mixins: [getters],
    props: {
        contactID: {
            Number,
            required: true
        },
        showDate: {
            Boolean,
            default: true
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
            let contact = this.$store.getters['contacts/id'](this.contactID)
            return { 
                name: this.gettersHelper(contact, 'name'),
                phone: (contact.phone_number == undefined || contact.phone_number == null || contact.phone_number == '') ? "missing phone number" : contact.phone_number,
                date: (contact.contact_date == undefined || contact.contact_date == null || contact.contact_date == '') ? "missing date" : contact.contact_date.format('MMMM Do, YYYY'),
                email: (contact.email == undefined || contact.email == null || contact.email == '') ? "missing email" : contact.email
            }
        },
    },
   
    methods: {
        deleteContact() {
            this.$store.commit('deleteContact', this.contactID)
        },
    },

}
</script>

<style scoped>

td {
  padding: 8px;
  text-align: left;
  border-bottom: 1px solid #ddd;
}

tr:hover {
    background-color: #e8f5ff;
    opacity: 0.80;
}

</style>