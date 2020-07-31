<template>
    <div>
        <v-row class="my-0 mr-0 pr-0">
            <v-col>
                <v-autocomplete
                    label="Contact Name"
                    :items="contactNames"
                    item-value="id"
                    item-text="name"
                    v-model="selectedID"
                    class="py-0"
                    >
                </v-autocomplete>
            </v-col>
            <v-col>
                <v-select
                    label="Type of Contact"
                    :items="contactTypes"
                    class="py-0">
                </v-select>
            </v-col>
            <v-col cols="3" class="pt-6 mr-1">
                <v-btn color="error" 
                class="mx-0 mb-1" 
                small 
                outlined @click="deleteContact"
                :disabled="deleteDisabled">
                    delete
                </v-btn>
                <v-btn color="black"
                    small
                    outlined
                    class="mb-1 ml-1"
                    @click="emitThing" 
                    >
                    {{viewMessage}}
                </v-btn>
            </v-col>
        </v-row>
        </div>
</template>

<script>
// import ContactCard from '@/interviewerComponents/ContactCard.vue'
import get from '@/methods.js'
export default {
    name: "OutsideContact",
    data () {
        return {
            contactTypes: ["Minimal", "Close"],
            
        }
    },
    mixins: [get],
    props: {
        value: {
            Number,
            required: true
        }
    },
    computed: {
        selectedID: {
            get() {
                return this.value
            },
            set(newVal) {
                this.$emit('input', newVal)
            }
        },
        //update this as well! 
        stateChange() {
            return this.$store.state.contacts.touched;
        },
        //and this too
        closed() {
            return this.$store.state.dialogClosed;
        },
        contactNames() {
            let contacts = this.$store.getters['contacts/contacts']
            var names = []
            for (var contact of contacts) {
                names.push({
                    id: contact.contact_id,
                    name: this.gettersHelper(contact, 'name')
                })
            }
            names.push({
                id: -1,
                name: "Make New Contact"
            })
            return names
        },
        deleteDisabled() {
            if(this.selectedID == undefined || this.selectedID == -1) {
                return true
            }
            return false
        },
        viewMessage() {
            if (this.selectedID == undefined || this.selectedID == -1) {
                return "new"
            } else {
                return "view"
            }
        }
    },
    watch: {
        closed() {
            if (this.selectedID == -1) {
                this.selectedID = undefined
            }
        },
        stateChange() {
            console.log("oh look i was called")
            if (this.selectedID == -1) {
                this.selectedID = this.$store.getters['contacts/newContactId']
            }
        },
        selectedID() {
            if(this.selectedID == -1) {
                this.$emit('showDialog', this.selectedID)
            }
        }
    },
    methods: {
        deleteContact() {
            this.$emit('splice-contact', this.value)
        },
        emitThing() {
            if (this.selectedID == undefined) {
                this.selectedID = -1
            }
            this.$emit('showDialog', this.selectedID)
        }
    }
}
</script>