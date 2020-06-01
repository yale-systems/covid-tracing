<template>
    <v-expansion-panel>
        <v-expansion-panel-header >
            <h2 contenteditable @click.native.stop> {{defaultTitle}} </h2>
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
                        v-model="location"
                        label="Location"
                        prepend-icon="mdi-map-marker"
                    >
                    </v-text-field>
                </v-row>
                <v-divider></v-divider>
                <v-container>
                    <v-row class="mb-2">
                        <h3> Contacts </h3>
                        <v-spacer></v-spacer>
                        <v-btn 
                            icon
                            @click="contactCount++"
                            justify-right>
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
    </v-expansion-panel>
</template>

<script lang="ts">
import Vue from 'vue'
import InterviewContact from '@/components/InterviewContact.vue'

export default Vue.extend({
    name : "InterviewEvent",
        components : {
        InterviewContact
    },
    props: {
        ID: Number
    },
    data () {
        return {
            date: new Date().toISOString().substr(0, 10),
            menu: false,
            contactCount : 1
        }
    },
    computed : {
        defaultTitle () : string {
            return 'Event' + this.ID.toString()
        }
    }
})
</script>

<style scoped>

</style>