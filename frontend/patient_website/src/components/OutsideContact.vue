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
                    class="py-0">
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
            contactTypes: ["Minimal", "Close"],
            selectedID: undefined,
            dialogForceOpen: {
                showDialog: false
            }
        }
    },
    props: {
        value: {
            Number,
            required: true
        }
    },
    components: {
        ContactDialog
    },
    computed: {
        contactNames() {
            this.$store.state.fuckThis
            let contacts = this.$store.state.contacts
            var names = []
            for (var key in contacts) {
                names.push({
                    id: parseInt(key, 10),
                    name: this.$store.getters.fullName(key)
                })
            }
            names.push({
                id: -1,
                name: "Make New Contact"
            })
            return names
        },
        showView() {
            if (this.selectedID == undefined || this.selectedID == -1) {
                return true
            } else {
                return false
            }
        }
    },
    watch: {
        selectedID() {
            //toggle it just long enough to open the dialog... 
            if(this.selectedID == -1) {
                this.dialogForceOpen.showDialog = true
            }
        }
    },
    methods: {
        deleteContact() {
            this.$emit('splice-contact', this.value)
        },
        getHousehold() {
            console.log(this.selectedID)
            if(this.selectedID === -1 || this.selectedID === undefined) {
                return false
            } else {
                return this.$store.state.contacts[this.selectedID].household
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