<template>
    <v-container fluid class="pa-0">
        <v-row>
            <!-- for the menu -->
            <v-col cols="4" class="pt-0">
                <v-toolbar
                    color="light-blue"
                    class="pt-0 mt-0"
                    flat
                    dark
                >
                    <v-toolbar-title
                        v-if="!showSearch"
                    > Patients </v-toolbar-title>
                    <v-spacer v-if="!showSearch"></v-spacer>

                    <v-text-field
                        placeholder="search patients"
                        v-show="showSearch"
                        @blur="hideSearch"
                        v-model="searchText"
                        ref="search"
                        class="mt-4">
                    </v-text-field>
                    <v-btn 
                        icon
                        @click="handleSearch"
                    >
                        <v-icon>mdi-magnify</v-icon>
                   </v-btn>

                    <v-btn icon>
                        <v-icon> mdi-sort </v-icon>
                    </v-btn>
                </v-toolbar>
                <v-list two-line>
                    <v-list-item-group
                    v-model="selected"
                    active-class="blue--text"
                    >
                    <template v-for="(item, index) in items">
                        <v-list-item :key="item.title" @click="print">
                        <template v-slot:default="{ active, toggle }">
                            <v-list-item-content>
                            <v-list-item-title v-text="item.title"></v-list-item-title>
                            <v-list-item-subtitle class="text--primary" v-text="item.headline"></v-list-item-subtitle>
                            <v-list-item-subtitle v-text="item.subtitle"></v-list-item-subtitle>
                            </v-list-item-content>
            
                            <v-list-item-action>
                            <v-list-item-action-text v-text="item.action"></v-list-item-action-text>
                            <v-icon
                                v-if="!active"
                                color="grey lighten-1"
                            >
                                mdi-flag-variant
                            </v-icon>
            
                            <v-icon
                                v-else
                                color="grey lighten-1"
                            >
                                mdi-flag-variant
                            </v-icon>
                            </v-list-item-action>
                        </template>
                        </v-list-item>
            
                        <v-divider
                        v-if="index + 1 < items.length"
                        :key="index"
                        ></v-divider>
                    </template>
                    </v-list-item-group>
                </v-list>
                <v-divider vertical> </v-divider>
            </v-col>
             <!-- for the card itself -->
            <v-col>
                <v-card class="pl-1" flat>
                    <v-card-title>
                        <h2> Name </h2>
                        <v-btn icon>
                            <v-icon>
                                mdi-flag-variant
                            </v-icon>
                        </v-btn>
                    </v-card-title>
                    <v-card-text>
                        <v-container>
                            <v-row>
                                <h3 class="pl-3"> Interview Information </h3>
                                <v-btn
                                    text
                                    small
                                    color="blue"
                                    class="">
                                    Update
                                </v-btn>
                            </v-row>
                            <v-row>
                                <v-col class="pl-3" cols="4">
                                        <p class="mb-0" font-color="gray"> Call Status </p>
                                        <v-select
                                            :items="callStatuses"
                                            class="mt-0 pt-0"
                                        > </v-select>
                                </v-col>
                                <v-col cols="2">
                                    <p class="mb-1"> Time Spent </p>
                                    <p > 0 </p>
                                </v-col>
                                <v-col cols="6">
                                    <v-row>
                                        <p> Last Status </p>
                                        <p class="pl-2"> date here </p>
                                    </v-row>
                                    <v-row>
                                        <p> Result Date </p>
                                        <p class="pl-2"> date here </p>
                                    </v-row>
                                </v-col>
                            </v-row>
                            <v-row>
                                <v-col>
                                    <h3> Contact Information </h3>
                                    <p> Phone Number </p>
                                    <p> 2032032033 </p>
                                    <p> Email </p>
                                    <p> js@email.com </p>
                                    <p> Language </p>
                                    <p> English </p>
                                </v-col>
                                <v-col>
                                    <h3> Personal Information </h3>
                                    <p> Yale Department </p>
                                    <h4> None </h4>
                                    <p> City </p>
                                    <h4> New Haven </h4>
                                    <p> Age </p>
                                    <h4> 30 </h4>
                                </v-col>
                            </v-row>
                        </v-container>
                    </v-card-text>
                    <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn>
                            Go to Interview Form
                        </v-btn>
                    </v-card-actions>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
export default {
    name : "Dashboard",
    data :() => {
        return {
            selected : [],
            items : [
                {
                    action: '2020-06-01',
                    title: 'Joe Shmo',
                    headline : 'Have not called yet'
                },
                {
                    action: '2020-06-02',
                    title: 'Jane Doe',
                    headline : 'Called, left a voicemail'
                },
                {
                    action: '2020-06-01',
                    title: 'Josh Bo',
                    headline : 'Called, did not leave voicemail'
                },
                {
                    action: '2020-05-31',
                    title: 'Juanxi Zhou',
                    headline : 'Partial interview completed'
                }
            ],
            callStatuses : [
                "Called, didn't leave voicemail",
                "Called, left voicemail",
                "Call again",
                "Does not want interview",
                "Family completed interview",
                "Partial completed interview",
                "Patient completed interview",
                "Unable to reach",
                "Unable to reach, bad number"
            ],
            searchText : '',
            showSearch : false
        }
    },
    methods : {
        print() {
            console.log(this.selected)
        },
        handleSearch() {
            if (!this.showSearch) {
                this.showSearch = true
                this.$refs.search.$el.focus()
                console.log(this.$refs.search)
            } else {
                // TODO: make call to find in data table ...how??  hm
            }
        },
        hideSearch(){
            if (this.searchText.length < 1) {
                this.showSearch = false
            }
        }
    }
}
</script>

<style>

</style> 
