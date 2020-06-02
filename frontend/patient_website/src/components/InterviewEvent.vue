<template>
    <v-expansion-panel>
        <v-expansion-panel-header >
            <h2 contenteditable > {{defaultTitle}} </h2>
        </v-expansion-panel-header>
        <v-expansion-panel-content>
            <v-form>
                <v-row>
                    <v-menu
                        ref="menu"
                        v-model="menu"
                        :close-on-content-click="false"
                        :return-value.sync="date"
                        transition="slide-y-transition"
                        offset-y
                        min-width="290px"
                        mr-2
                        >
                        <template v-slot:activator="{ on }">
                            <v-text-field
                            class="mr-4"
                            v-model="date"
                            label="Date"
                            prepend-icon="mdi-calendar"
                            readonly
                            v-on="on"
                            ></v-text-field>
                        </template>
                        <v-date-picker v-model="date" no-title scrollable>
                            <v-spacer></v-spacer>
                            <v-btn text color="primary" @click="menu = false">Cancel</v-btn>
                            <v-btn text color="primary" @click="$refs.menu.save(date)">OK</v-btn>
                        </v-date-picker>
                    </v-menu>
                    <v-text-field
                        class="ml-4"
                        v-model="location"
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
                            @click="contactCount++"
                            justify-right
                            outlined>
                            Add contact
                            <v-icon> mdi-plus </v-icon>
                        </v-btn>
                    </v-row>
                    <InterviewContact 
                        v-for="i in contactCount"
                        :key="i"
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

<script lang="ts">
import Vue from 'vue'
import InterviewContact from '@/components/InterviewContact.vue'
import SearchMap from '@/components/SearchMap.vue'

export default Vue.extend({
    name : "InterviewEvent",
    components : {
        InterviewContact,
        SearchMap
    },
    props: {
        ID: Number
    },
    data () {
        return {
            date: new Date().toISOString().substr(0, 10),
            menu: false,
            contactCount : 1,
            showMap : false,
            addressInfo : {
                adr: '',
                ll: null
            },
            location : '',
            latlong : null
        }
    },
    computed : {
        defaultTitle () : string {
            return 'Event' + this.ID.toString()
        }
    },
    methods : {
        handleOk() {
            this.showMap = !this.showMap
            this.location = this.addressInfo.adr
            this.latlong = this.addressInfo.ll
        }
    }
})
</script>

<style>
.search-map {
    height: 400px;
}
</style>