<template>
    <div>
        <Hamburger /> 
        <v-container>
            <v-row class = "mt-6" justify="left">
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
                            <b> Name:</b> Full Name
                        </v-col>
                    </v-row>
                    <v-row style="align-items:center;">
                        <v-col flex class="margin-right">
                            <b> Username:</b> Username
                        </v-col>
                    </v-row>
                    <br>
                    <v-row justify="left">
                        <v-col cols="2">
                            <h4> Your Languages: </h4>
                        </v-col>
                        <v-col class="language">
                                <v-combobox
                                    v-model="volLanguages"
                                    :items="languageTypes"
                                    item-value="key"
                                    item-text="status"
                                    chips
                                    clearable
                                    multiple
                                    solo
                                >
                                    <template v-slot:selection="{ attrs, item, select, selected }">
                                        <v-chip
                                        v-bind="attrs"
                                        :input-value="selected"
                                        close
                                        @click="select"
                                        @click:close="remove(item)"
                                        >
                                        <strong>{{ item.status }}</strong>&nbsp;
                                        </v-chip>
                                    </template>
                                </v-combobox>
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
                        <v-btn color="primary">
                            Save
                        </v-btn>
                    </v-row>
                </v-container>
            </v-card>
        </v-container>
    </div>
</template>

<script>
import constants from "../constants.js"
import Hamburger from "@/sharedComponents/Hamburger"
export default {
    name: "Profile",
    data: () => {
       return {
           volLanguages: [],
           languageTypes: constants.languages,
           capacity: 3,
           MAX_CAPACITY: 10,
           editPW : false,
           currentPassword: '',
           showAlert: false
       } 
    },
    components: {
        Hamburger
    },
    methods: {
        remove (item) {
        this.volLanguages.splice(this.volLanguages.indexOf(item), 1)
        this.volLanguages = [...this.volLanguages]
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
        }
    },
    mounted() {
        console.log(constants)
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