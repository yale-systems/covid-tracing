<template>
    <v-expansion-panel v-on:delete-contact="deleteContact">
        <v-expansion-panel-header >
            <h2> {{defaultTitle}} </h2>
        </v-expansion-panel-header>
        <v-expansion-panel-content>
            <v-form>
                <v-row>
                    <v-menu
                        ref="menu"
                        v-model="menu"
                        :close-on-content-click="false"
                        transition="slide-y-transition"
                        offset-y
                        min-width="290px"
                        mr-2
                        >
                        <template v-slot:activator="{ on }">
                            <v-text-field
                            class="mr-4"
                            v-model="value.date"
                            label="Date"
                            prepend-icon="mdi-calendar"
                            readonly
                            v-on="on"
                            :error-messages="dateErrors"
                            @focus="v.date.$reset"
                            @blur="v.date.$touch"
                            ></v-text-field>
                        </template>
                        <v-date-picker 
                            v-model="value.date" 
                            :max="todayDate"
                            no-title 
                            scrollable
                            @input="menu=false">
                        </v-date-picker>
                    </v-menu>
                    <v-text-field
                        class="ml-4"
                        v-model="value.location.streetName"
                        label="Location"
                        prepend-icon="mdi-map"
                        placeholder="choose a location using the map icon to the left"
                        @click:prepend="showMap = true"
                        readonly
                        append-icon="mdi-close"
                        @click:append="location = ''"
                    >
                    </v-text-field>
                </v-row>
                <v-divider></v-divider>
                <v-container>
                    <v-row class="mb-2">
                        <h3> Contacts </h3>
                        <v-spacer></v-spacer>
                        <v-btn 
                            @click="newContact"
                            justify-right
                            outlined>
                            Add contact
                            <v-icon> mdi-plus </v-icon>
                        </v-btn>
                    </v-row>
                    <InterviewContact 
                        v-for="contact in v.contacts.$each.$iter"
                        :key="contact.$model.contactID"
                        :ID="contact.$model.contactID"
                        v-model="contact.$model"
                        :v="contact"
                    />
                </v-container>
            </v-form>
        </v-expansion-panel-content>
        <v-dialog
            v-model="showMap"
            >
            <v-card>
                <v-card-title> </v-card-title>
                <v-card-text>
                    <SearchMap class="search-map" v-model="this.addressInfo"/>
                </v-card-text>
                <v-card-actions>
                    <v-spacer> </v-spacer>
                    <v-btn depressed
                        @click="showMap = !showMap">
                        Cancel
                    </v-btn>
                    <v-btn
                        color="primary"
                        @click="handleOk">
                        OK
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-expansion-panel>

</template>

<script>
import InterviewContact from '@/components/InterviewContact.vue'
import SearchMap from '@/components/SearchMap.vue'

export default {
    name : "InterviewEvent",
    components : {
        InterviewContact,
        SearchMap
    },
    props: {
        value : {
            type : Object,
            required : true
        },
        v : {
            type : Object,
            required : true
        }
    },
    data () {
        return {
            date: new Date().toISOString().substr(0, 10),
            menu: false,
            showMap : false,
            addressInfo : {
                adr: '',
                ll: null
            },
        }
    },
    computed : {
        defaultTitle () {
            return 'Event ' + this.value.eventID.toString()
        },
        dateErrors() {
            const errors = []
            if (!this.v.date.$dirty) return errors
            !this.v.date.required && errors.push('This field is required, please select a date.')
        },
        todayDate() {
            let today = new Date();
            let day = String(today.getDate()).padStart(2, '0');
            let month = String(today.getMonth() + 1).padStart(2, '0');
            let year = today.getFullYear();

            return (year + '-' + month + '-' + day)
        }
    },
    methods : {
        handleOk() {
            this.showMap = !this.showMap
            this.value.location.streetName = this.addressInfo.adr
            this.value.location.coordinates = this.addressInfo.ll
        },
        newContact() {
            let contact = {
                firstName : '',
                lastName : '',
                phone : null,
                email : '',
                healthcareWorker : false,
                age : 'adult',
                contactType : null,
                contactNature : '',
                contactID : this.value.contacts.length
            }
            this.value.contacts.push(contact)
        },
        deleteContact(contactID) {
            for (contact in this.value.contacts) {
                if (contact.contactID = contactID) {
                    this.value.contacts.splice(contactID, 1)
                }
            }
        }
    },
    mounted () {
        this.newContact()
    }
}
</script>

<style>
.search-map {
    height: 400px;
}
</style>