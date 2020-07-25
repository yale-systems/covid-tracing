<template>
    <div>
        <v-row class="my-0 mr-0 pr-0">
            <v-col>
                <v-select
                    label="Contact Name"
                    :items="contactNames"
                    item-value="id"
                    item-text="name"
                    v-model="selectedID"
                    class="py-0">
                </v-select>
            </v-col>
            <v-col>
                <v-select
                    label="Type of Contact"
                    :items="contactTypes"
                    item-value="key"
                    item-text="text"
                    class="py-0"
                    v-model="contact_type"
                    >
                </v-select>
            </v-col>
            <v-col cols="3" class="pt-6 mr-1">
                <v-btn color="error" 
                class="mx-0 mb-1" 
                small 
                outlined @click="deleteContact">
                    delete
                </v-btn>
                <v-btn color="black"
                    small
                    outlined
                    class="mb-1 ml-1"
                    @click="dialogForceOpen.showDialog = true"
                    :disabled="showView">
                    view
                </v-btn>
            </v-col>
        </v-row>
    <ContactDialog
        :household="getHousehold()"
        :id="selectedID"
        :value="dialogForceOpen"
        v-on:reload="setSelect"
    />
    </div>
</template>

<script>
import ContactDialog from '@/components/ContactDialog.vue'
export default {
    name: "OutsideContact",
    data () {
        return {
            contactTypes: [{key: 0, text: "Minimal"}, {key: 1, text: "Close"}],
            dialogForceOpen: {
                showDialog: false
            }
        }
    },
    props: {
        value: {
            Number,
            required: true
        },
        index: {
            Number
        }
    },
    components: {
        ContactDialog
    },
    computed: {
        contactNames() {
            let contacts = this.$store.getters['contacts/contacts']
            var names = []
            names.push({
                id: -1,
                name: "Make New Contact"
            })
            for (let contact of contacts) {
                names.push({
                    id: contact.contact_id,
                    name: this.$store.getters['contacts/fullName'](contact.contact_id)
                })
            }
            return names
        },
        showView() {
            if (this.value == undefined || this.value == -1) {
                return true
            } else {
                return false
            }
        },
        selectedID: {
            get() {
                return this.value
            },
            set(newVal) {
                this.$emit('input', newVal)
            }
        },
        contact_type: {
            get() {
                if(this.selectedID && this.selectedID >= 0) {
                    return this.$store.getters['contacts/id'](this.selectedID).contact_type
                } else {
                    return undefined
                }
            },
            set(newVal) {
                if(this.selectedID) {
                    let contact = this.$store.getters['contacts/id'](this.selectedID)
                    contact.contact_type = newVal
                    this.$store.dispatch('contacts/update', contact)
                }

            }
        }
    },
    watch: {
        selectedID() {
            //toggle it just long enough to open the dialog... 
            if(this.value == -1) {
                this.dialogForceOpen.showDialog = true
            }
        }
    },
    methods: {
        deleteContact() {
            this.$emit('splice-contact', this.index)
        },
        getHousehold() {
            if(this.selectedID === -1 || this.selectedID === undefined) {
                return false
            } else {
                return this.$store.getters['contacts/id'](this.selectedID).household
            }
        },
        setSelect(id) {
            if (id == -1) {
                this.selectedID = undefined
            } else {
                this.selectedID = id
            }
        }
    }
}
</script>

<style>
    
</style>