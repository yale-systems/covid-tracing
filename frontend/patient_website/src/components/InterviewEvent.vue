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
                                    v-model="event.dateValid"
                                >
                                <v-text-field
                                    class="mr-4"
                                    v-model="readableDate"
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
                                v-model="date" 
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
                            v-model="event.location.streetName"
                            label="Location"
                            prepend-icon="mdi-map"
                            placeholder="click the map icon to pick a location"
                            @click:prepend="showMap = true"
                            @click="showMap = true"
                            readonly
                            append-icon="mdi-close"
                            @click:append="event.location = ''"
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
                            v-model="event.notes"
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
                            v-for="(c, i) of event.contact_ids"
                            :key="i"
                            v-model="event.contact_ids[i]"
                            :index="returnNumber(i)"
                            v-on:splice-contact="deleteContact"
                            class= "pl-3"
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
import SearchMap from '@/components/map/SearchMap.vue'
import OutsideContact from '@/components/OutsideContact.vue'

export default {
    name: "InterviewEvent",
    components: {
        SearchMap,
        OutsideContact
    },
    props: {
        id: {
            type: Number,
            required: true
        },
        validate: Boolean
    },
    data () {
        return {
            endDate: '',
            startDate: '',
            menu: false,
            showMap : false,
            // fields for the search bar, doesn't go directly into value
            addressInfo : {
                adr: '',
                ll: null
            },
            dateRules: [
                v => !!v || 'Date is required'
            ],
            editTitle: false,
            title: '',
            event: Object.assign({}, this.$store.getters['events/id'](this.id))
        }
    },
    mounted() {
        this.event = Object.assign({}, this.$store.getters['events/id'](this.id))
        this.setTitle()
        this.startDate = this.$store.state.startDate 
        this.endDate = this.$store.state.endDate 
    },
    computed: {
        date: {
            get() {
                let date = this.event.start_time
                if(date) {
                    return date.format('YYYY-MM-DD')
                } else {
                    return ''
                }
            },
            set(newVal) {
                var moment = require('moment')
                this.$set(this.event, 'start_time', moment(newVal))
            }
        },
        readableDate() {
            let date = this.event.start_time
            if(date) {
                return date.format('MMMM Do, YYYY')
            } else {
                return ''
            }
        },
        defaultTitle() {
            let num = this.event.event_id
            return 'Event ' + num.toString()
        },
        titleID() {
            return 'title-' + this._uid
        }
    },
    methods: {
        handleOk() {
            this.showMap = !this.showMap
            this.event.location.streetName = this.addressInfo.adr
            this.event.location.coordinates = this.addressInfo.ll
        },
        newContact() {
            this.event.contact_ids.push(undefined)
        },
        deleteEvent() {
            // if we just added it, remove it
            if(this.event.add) {
                this.$store.commit('events/removeEvent', this.event.event_id)
            } else {
                this.$store.commit('events/deleteEvent', this.event.event_id)
            }
        },
        deleteContact(deleteIndex) {
            console.log(deleteIndex, this.event.contact_ids)
            this.event.contact_ids.splice(deleteIndex, 1)
            this.event = Object.assign({}, this.event)
            console.log(this.event.contact_ids)
        },
        setTitle() {
            if (this.event.notes == undefined) { 
                this.title = this.defaultTitle
                return
            }
            var res = this.event.notes.split(" ")
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
        },
        returnNumber(i) { return i}
    },
    watch: {
        event: {
            deep: true,
            handler() {
                this.$store.commit('events/updateEvent', this.event)
            }
        },
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