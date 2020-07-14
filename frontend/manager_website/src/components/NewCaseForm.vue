<template>
    <div>
        <v-form ref="form">

        <v-expansion-panels accordion multiple v-model="selected">
            <!-- name -->
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

            <!-- contact information -->
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

            <!-- case information -->
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
                            <!-- add more case information here -->
                            add more case information here
                        </v-col> 
                    </v-row>
                </v-expansion-panel-content>
            </v-expansion-panel>

            <!-- personal information -->
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
                            <!-- add more personal information -->
                            v select here for personal information
                        </v-col>
                    </v-row>
                </v-expansion-panel-content>
            </v-expansion-panel>
        </v-expansion-panels>
        </v-form>
    </div>
</template>

<script>
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
            race: undefined
        }
    },
}
</script>

<style>

</style>