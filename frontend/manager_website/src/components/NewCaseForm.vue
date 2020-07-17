<template>
    <div>
        <v-form ref="form">
            <v-container>
                <v-row class="mt-4">
                    <h3 class="ml-6"> Basic Information </h3>
                </v-row>
                <v-row class="d-flex flex-wrap justify-space-around">
                    <v-text-field class="min400" min-width="400px" label="First Name*"> </v-text-field>
                    <v-text-field class="min400" label="Last Name"> </v-text-field>
                    <Selector 
                        class="min400"
                        field="gender"
                        v-model="gender"
                    />
                    <Selector 
                        class="min400"
                        field="race"
                        v-model="race"
                    />
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
                                class="min400"
                                v-model="fakeDate"
                                prepend-inner-icon="mdi-calendar"
                                readonly
                                label="Date of Birth"
                                v-on="on"
                            ></v-text-field>
                        </template>
                        <v-date-picker 
                            v-model="fakeDate" 
                            :max="todayDate"
                            no-title 
                            scrollable
                            @input="menu=false">
                        </v-date-picker>
                    </v-menu>
                </v-row>
                <v-row class="mt-4">
                    <h3 class="ml-6"> Contact Information </h3>
                </v-row>
                <v-row class="d-flex flex-wrap justify-space-around"> 
                    <v-text-field
                        class="min400" label="Phone Number"
                    ></v-text-field>
                    <v-text-field
                        class="min400" label="Email Address"
                    ></v-text-field>
                    <Selector 
                        class="min400"
                        field="language"
                        v-model="language"
                    />
                    <div class="min500">
                        <v-row class="mt-2">
                            <p class="mt-2"> Requested Interview </p>
                            <v-btn class="mx-2"> yes </v-btn>
                            <v-btn> no </v-btn>
                        </v-row>
                    </div>
                </v-row>
                <v-row class="mt-4">
                    <h3 class="ml-6"> Case Information </h3>
                </v-row>
                <v-row class="d-flex flex-wrap justify-space-around"> 
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
                                class="min400"
                                v-model="fakeDate"
                                prepend-inner-icon="mdi-calendar"
                                readonly
                                label="Diagnosis Date"
                                v-on="on"
                            ></v-text-field>
                        </template>
                        <v-date-picker 
                            v-model="fakeDate" 
                            :max="todayDate"
                            no-title 
                            scrollable
                            @input="menu=false">
                        </v-date-picker>
                    </v-menu>
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
                                class="min400"
                                v-model="fakeDate"
                                prepend-inner-icon="mdi-calendar"
                                readonly
                                label="Symptom Onset Date"
                                v-on="on"
                            ></v-text-field>
                        </template>
                        <v-date-picker 
                            v-model="fakeDate" 
                            :max="todayDate"
                            no-title 
                            scrollable
                            @input="menu=false">
                        </v-date-picker>
                    </v-menu>
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
                                class="min400"
                                v-model="fakeDate"
                                prepend-inner-icon="mdi-calendar"
                                readonly
                                label="Last Date at Work/School"
                                v-on="on"
                            ></v-text-field>
                        </template>
                        <v-date-picker 
                            v-model="fakeDate" 
                            :max="todayDate"
                            no-title 
                            scrollable
                            @input="menu=false">
                        </v-date-picker>
                    </v-menu>
                    <Selector 
                        class="min400"
                        field="symptomatic"
                        v-model="symptomatic"
                    />
                    <v-select
                        label="Symptoms"
                        :items="symptomList"
                        multiple
                        chips
                        item-value="key"
                        item-text="status"
                        class="my-0 py-0 min400"
                    >
                    </v-select>
                    <v-select
                        label="Pre-existing Conditions"
                        :items="symptomList"
                        multiple
                        chips
                        item-value="key"
                        item-text="status"
                        class="my-0 py-0 min400"
                    >
                    </v-select>
                     <Selector 
                        class="min400"
                        field="self_isolate"
                    />
                </v-row>
                <v-row class="mt-2 pl-10">
                    <p class="mt-2 mr-4" style="width:300px;"> Has this person travelled recently? </p>
                    <v-btn class="mr-2"> Yes </v-btn>
                    <v-btn> No </v-btn>
                </v-row>
                <v-row class="mt-2 pl-10">
                    <p class="mt-2 mr-4" style="width:300px;"> Has this person seen a doctor? </p>
                    <v-btn class="mr-2"> Yes </v-btn>
                    <v-btn> No </v-btn>
                </v-row>
                <v-row class="mt-2 pl-10">
                    <p class="mt-2 mr-4" style="width:300px;"> Does this person know if they are sick? </p>
                    <v-btn class="mr-2"> Yes </v-btn>
                    <v-btn> No </v-btn>
                </v-row>
               
                <v-row>

                </v-row>
                
                <v-row class="mt-4">
                    <h3 class="ml-6"> Other Information </h3>
                </v-row>
                <v-row class="d-flex flex-wrap justify-space-around"> 
                    <Selector 
                        class="min400"
                        field="employment"
                    />
                    <Selector 
                        class="min400"
                        field="insurance"
                    />
                </v-row>
                <v-row class="d-flex flex-wrap justify-space-around">
                    <v-textarea
                        auto-grow
                        label="Notes"
                        rows="1"
                        style="max-width: 92%" 
                    >
                    </v-textarea>
                </v-row>
            </v-container>
        <!-- <v-expansion-panels accordion multiple v-model="selected">
            <v-expansion-panel>
                <v-expansion-panel-header>Name:</v-expansion-panel-header>
                <v-expansion-panel-content>
                    <v-row style="margin-top:-10px">
                        <v-col>
                            <v-text-field
                                label="First Name*"
                            ></v-text-field>
                        </v-col>
                        <v-col>
                            <v-text-field
                                label="Last Name"
                            ></v-text-field>
                        </v-col>
                    </v-row>
                </v-expansion-panel-content>
            </v-expansion-panel>

            <v-expansion-panel>
                <v-expansion-panel-header>Case Contact Information:</v-expansion-panel-header>
                <v-expansion-panel-content>
                    <v-row style="margin-top:-10px">
                        <v-col class="ml-3"> 
                            <v-text-field
                                label="Phone Number"
                            ></v-text-field>
                            <v-text-field
                                label="Email Address"
                            ></v-text-field>
                            <Selector 
                                field="language"
                                v-model="language"
                            />
                        </v-col> 
                    </v-row>
                </v-expansion-panel-content>
            </v-expansion-panel>

            <v-expansion-panel>
                <v-expansion-panel-header>Case Information: </v-expansion-panel-header>
                <v-expansion-panel-content>
                    <v-row style="margin-top:-10px">
                        <v-col class="ml-3"> 
                            <v-text-field
                                label="Diagnosis Date"
                            ></v-text-field>
                            <Selector 
                                field="symptomatic"
                                v-model="symptomatic"
                            />
                            <Selector 
                                field="symptoms"
                                v-model="symptoms"
                            />
                            add more case information here
                        </v-col> 
                    </v-row>
                </v-expansion-panel-content>
            </v-expansion-panel>

            <v-expansion-panel>
                <v-expansion-panel-header>Personal Information:</v-expansion-panel-header>
                <v-expansion-panel-content>
                    <v-row style="margin-top:-10px">
                        <v-col class="ml-3">
                            <Selector 
                                field="gender"
                                v-model="gender"
                            />
                            <Selector 
                                field="race"
                                v-model="race"
                            />
                            <v-text-field
                                label="Date of Birth"
                            ></v-text-field>
                            <v-text-field
                                label="Pre-existing Conditions"
                            ></v-text-field>
                            v select here for personal information
                        </v-col>
                    </v-row>
                </v-expansion-panel-content>
            </v-expansion-panel>
        </v-expansion-panels> -->
        </v-form>
    </div>
</template>

<script>
import moment from 'moment'
import Selector from "@/components/Selector"
export default {
    name: "NewCaseForm",
    components: {
        Selector
    },
    data: () => {
        return {
            selected: [0, 1, 2, 3],
            language: undefined,
            symptomatic: undefined,
            symptoms: undefined,
            gender: undefined,
            race: undefined,
            fakeDate: '',
            todayDate: moment().format('YYYY-MM-DD'),
            symptomList: [],
            menu: false
        }
    },
}
</script>

<style scoped>
.min400 {
    width: 300px;
    margin-left: 40px;
    margin-right: 40px;
}
.min500 {
    width: 350px;
    margin-left: 40px;
    margin-right: 40px;
}

</style>