<template>
    <tr>
        <td> {{ contactInfo.name }} </td>

    
        <td v-if="contactInfo.date != undefined"> {{ contactInfo.date }} </td>
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
                phone: contact.phone_number === undefined ? "missing phone number" : contact.phone_number,
                date: contact.date,
                email: contact.email === undefined ? "missing email" : contact.email
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
    background-color: pink;
    opacity: 0.80;
}


</style>