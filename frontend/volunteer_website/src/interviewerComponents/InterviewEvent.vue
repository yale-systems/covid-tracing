<template>
    <v-container fluid class="event-spacing">
        <v-card class="mx-2 my-2">
            <v-card-title class="pt-6 mb-0 pb-0 ml-2">
                
                <h2 v-text="title"></h2>
                <v-spacer></v-spacer>
                <v-btn
                    outlined
                    color="error"
                    @click="deleteEvent">
                    delete event
                </v-btn>
            </v-card-title>
                <!-- first row, includes the date and the contacts + add contacts button -->
                <v-row class="mx-4 pt-0 padding-bottom">
                    <v-col cols="4">
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
                                <v-form
                                    ref="dateForm"
                                    v-model="value.dateValid"
                                >
                                <v-text-field
                                    class="mr-4"
                                    v-model="value.date"
                                    label="Date"
                                    prepend-icon="mdi-calendar"
                                    readonly
                                    v-on="on"
                                    @click:prepend="menu=true"
                                    :rules="dateRules"
                                ></v-text-field>
                                </v-form>
                            </template>
                            <v-date-picker 
                                v-model="value.date" 
                                :max="endDate"
                                :min="startDate"
                                no-title 
                                scrollable
                                @input="menu=false">
                            </v-date-picker>
                        </v-menu>
                    </v-col>
                    <v-col>
                        <v-text-field
                            class="pr-3"
                            v-model="value.location.streetName"
                            label="Location"
                            prepend-icon="mdi-map"
                            placeholder="click the map icon to pick a location"
                            @click:prepend="showMap = true"
                            @click="showMap = true"
                            readonly
                            append-icon="mdi-close"
                            @click:append="value.location = ''"
                        > </v-text-field>
                    </v-col>
                </v-row>
                
                <v-row class="mx-4 pt-0 ">
                    <v-col>
                        <v-text-field
                            class="pr-3"   
                            label="Nature of Contact"       
                            prepend-icon="mdi-account"
                            placeholder="e.g. Dinner with Susan"
                            v-model="value.contactNature"
                            @blur="setTitle"
                        > </v-text-field>
                    </v-col>
                </v-row>
                <v-row class="mx-5 pt-0">
                    <v-col cols="2" style="padding-left:1%; padding-bottom: 3%;" >
                        <v-btn
                            outlined
                            @click="newContact"> 
                            <v-icon> mdi-plus </v-icon>
                            add contact
                        </v-btn>
                    </v-col>
                    <v-col style="margin-top:-25px;">
                        <OutsideContact 
                            v-for="c of contacts"
                            :key="c"
                            :value="c"
                            v-on:splice-contact="deleteContact"
                            class= "pl-3"
                            v-on:showDialog="$emit('showDialog', $event)"
                        />
                    </v-col>
                </v-row>
        </v-card>

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
    </v-container>
</template>

<script>
import SearchMap from '@/sharedComponents/SearchMap.vue'
import OutsideContact from '@/interviewerComponents/OutsideContact.vue'

export default {
    name: "InterviewEvent",
    components: {
        SearchMap,
        OutsideContact
    },
    props: {
        value: {
            type: Object,
            required: true
        },
        noContacts: null,
        validate: Boolean
    },
    data () {
        return {
            endDate: '',
            startDate: '',
            menu: false,
            showMap : false,
            contacts: [],
            // fields for the search bar, doesn't go directly into value
            addressInfo : {
                adr: '',
                ll: null
            },
            contacts: [],
            dateRules: [
                v => !!v || 'Date is required'
            ],
            editTitle: false,
            title: '',
            incrementVal: 0,
        }
    },
    mounted() {
        this.title = this.defaultTitle
        this.startDate = this.$store.state.startDate.format('YYYY-MM-DD')
        this.endDate = this.$store.state.endDate.format('YYYY-MM-DD')
    },
    computed: {
        defaultTitle() {
            let num = this.value.eventID + 1
            return 'Event ' + num.toString()
        },
        titleID() {
            return 'title-' + this._uid
        }
    },
    methods: {
        handleOk() {
            this.showMap = !this.showMap
            this.value.location.streetName = this.addressInfo.adr
            this.value.location.coordinates = this.addressInfo.ll
        },
        newContact() {
            this.contacts.push(this.incrementVal)
            this.incrementVal += 1
        },
        deleteEvent() {
            // if originally loaded in, queue the event to delete from the backend as well
            if (this.value.add == false) {
                this.$store.commit('qDeleteLocation', this.value.eventID)
            }
            this.$emit('splice', this.value.eventID)
        },
        deleteContact(deleteMe) {
            for(var c in this.contacts) {
                if (this.contacts[c] == deleteMe) {
                    this.contacts.splice(c, 1)
                }
            }
        },
        setTitle() {
            var res = this.value.contactNature.split(" ")
            if (res.length == 1 && res[0] == "") {
                this.title = this.defaultTitle
                return
            }
            let end = res.length > 5 ? 5 : res.length
            this.title = res[0]
            for (var i = 1; i < end; i++) {
                this.title += " " + res[i]
            }
            if (res.length > 5) {
                this.title += "..."
            }
        }
    },
    watch : {
        validate: function() {
            this.$refs.dateForm.validate()
        }
    }

}
</script>

<style>

.padding-bottom {
    margin-bottom: -25px;
}
.search-map {
    height: 400px;
}

.event-spacing {
    margin-bottom: -25px;
}


</style>