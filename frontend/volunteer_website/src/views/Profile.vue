<template>
    <div>
        <Hamburger /> 
        <v-container>
            <v-row class="mt-6">
                <h1> 
                    <v-icon x-large>
                        mdi-cogs
                    </v-icon>
                    Profile Settings
                </h1>
            </v-row>
            <v-card class="card-spacing">
                <v-container fluid class="inside-card">
                    <v-row style="align-items:center;">
                        <v-col flex class="margin-right">
                            <b> Name: </b> {{gettersHelper(volunteer, 'name')}}
                        </v-col>
                    </v-row>
                    <br>
                    <v-row>
                        <v-col cols="2">
                            <h4> Your Languages: </h4>
                        </v-col>
                        <v-col class="language">
                                <v-select
                                    v-model="languages"
                                    :items="languageTypes"
                                    multiple
                                    clearable
                                    item-text="value"
                                    item-value="key"
                                >
                                </v-select>
                        </v-col>
                        <v-col>
                        </v-col>
                    </v-row>
                    <v-row style="align-items:center;">
                        <v-col flex class="margin-right" cols="auto">
                            <b> Your capacity is</b> 
                        </v-col>
                        <v-col flex class="justify-left" cols="auto">
                            <v-text-field
                                v-model="capacity"
                                class="text-center"
                                suffix="hrs/week">
                            </v-text-field>
                        </v-col>
                        <v-col cols="auto">
                            <v-btn
                                @click="addCapacity"
                                icon
                                class="plus-spacing">
                                <v-icon>
                                    mdi-plus
                                </v-icon>
                            </v-btn>
                            <v-btn
                                @click="subCapacity"
                                icon>
                                <v-icon>
                                    mdi-minus
                                </v-icon>
                            </v-btn>
                        </v-col>
                        <v-col>
                            <v-alert
                                v-model="showAlert"
                                type="warning"
                                outlined>
                                The maximum number of hours is {{MAX_CAPACITY}}.
                            </v-alert>
                        </v-col>
                    </v-row>
                    
                    <v-row class="save-spacing">
                        <v-btn color="primary" @click="handleSave">
                            Save
                        </v-btn>
                    </v-row>
                </v-container>
            </v-card>
        </v-container>
    </div>
</template>

<script>
import Hamburger from "@/sharedComponents/Hamburger"
import getters from '@/methods.js'

export default {
    name: "Profile",
    data: () => {
       return {
           languages: [],
           capacity: 0,
           MAX_CAPACITY: 10,
           editPW : false,
           currentPassword: '',
           showAlert: false
       } 
    },
    components: {
        Hamburger
    },
    mixins: [ getters ],
    methods: {
        remove (item) {
        this.languages.splice(this.languages.indexOf(item), 1)
        this.languages = [...this.languages]
        },
        addCapacity() {
            if (this.capacity == this.MAX_CAPACITY) {
                this.showAlert = true
                let curr = this
                setTimeout(() => {
                    curr.showAlert = false
                }, 1000)
            } else {
                this.capacity++;
            }
        },
        subCapacity() {
            if (this.capacity > 0) {
                this.capacity--;
            }
        },
        async handleSave() {
            let newVol = this.volunteer
            newVol.languages = this.languages
            newVol.total_capacity = this.capacity
            let res = await this.$store.dispatch('volunteers/update', newVol)
            if(res) {
                // show that it was saved
            } else {
                //give feedback
            }
        }
    },
    computed: {
        volunteer() {
            return this.$store.getters['volunteers/active']
        },
        languageTypes() {
            return this.$store.state.enums.Lanuages
        }
    },
    mounted() {
        if(this.volunteer.languages != null) {
            this.languages = this.volunteer.languages
        }
        if(this.volunteer.capacity != null) {
            this.capacity = this.volunteer.total_capacity
        }
    }
}
</script>

<style>

.plus-spacing {
    margin-right: 10px;
}

.card-spacing {
    margin-top: 30px;
}
.inside-card {
    padding: 5%;
}

.margin-right {
    margin-right: 10px;
}

.margin-capacity {
    max-width: 100px;
    margin-left: 2%;
    margin-right: 2%;
}
.save-spacing {
    margin-top: 5px;
}
.language {
    margin-bottom: -2%;
}
</style>