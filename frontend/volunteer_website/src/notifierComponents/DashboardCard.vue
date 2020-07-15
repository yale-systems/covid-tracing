<template>
    <v-card class="pl-1" flat>
        <!-- title -->
        <v-card-title>
        <h2>{{getFullName(value)}}</h2>
        <v-btn icon>
            <v-icon>
            mdi-flag-variant
            </v-icon>
        </v-btn>
        </v-card-title>

        <v-card-text>
        <v-container>
            <v-row>
            <h3 class="pl-3">Interview Information</h3>
            <v-btn text small color="blue" class="">
                Update
            </v-btn>
            </v-row>

            <v-row>
            <v-col class="pl-3" cols="4">
                <p class="mb-0" font-color="gray">Call Status</p>
                <v-select v-model="value.callStatus" :items="callStatuses"
                    item-value="key"
                    item-text="status" class="mt-0 pt-0"> </v-select>
            </v-col>
            <v-col cols="2">
                <p class="mb-1">Time Spent</p>
                <p>0</p>
            </v-col>
            <v-col cols="6">
                <v-row>
                <p>Last Status</p>
                <p class="pl-2">date here</p>
                </v-row>
                <v-row>
                <p>Result Date</p>
                <p class="pl-2">date here</p>
                </v-row>
            </v-col>
            </v-row>

            <v-row>
            <v-col>
                <h3>Contact Information</h3>
                <p>Phone Number</p>
                <p>2032032033</p>
                <p>Email</p>
                <p>js@email.com</p>
                <p>Language</p>
                <p>English</p>
            </v-col>

            <v-col>
                <h3>Personal Information</h3>
                <p>Yale Department</p>
                <h4>None</h4>
                <p>City</p>
                <h4>New Haven</h4>
                <p>Age</p>
                <h4>30</h4>
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
</template>

<script>
import methods from "@/methods";
import constants from "@/constants";

export default {
    name: "DashboardCard",
    props: {
        value: Object
    },
    data: () => {
        return {
            callStatuses: constants.callStatuses
        }
    },
    methods: {
        getFullName: methods.getFullName
    }

}
</script>