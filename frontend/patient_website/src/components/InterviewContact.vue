<template>
    <v-card class="ma-2">
        <v-card-title>
            <v-text-field
                label="Name"
            ></v-text-field>
        </v-card-title>
        <v-card-text>
            <v-row>
                <v-col>
                    <v-text-field
                        label="Phone Number"
                    ></v-text-field>
                </v-col>
                <v-col>
                    <v-text-field
                        label="Email Address"
                    ></v-text-field>
                </v-col>
            </v-row>
            <v-row>
                <v-col>
                    <v-select
                        :items="contactTypes"
                        label="Type of Contact"
                        v-model="contactType"
                    ></v-select>
                </v-col>
                <v-spacer></v-spacer>
                <v-col>
                    <v-checkbox
                        label="Healthcare Worker?"
                        v-model="healthcare"
                    ></v-checkbox>
                </v-col>
                <v-col>
                    <v-radio-group v-model="age" row>
                        <v-radio label="Adult" value="adult"></v-radio>
                        <v-radio label="Minor" value="minor"></v-radio>
                    </v-radio-group>
                </v-col>
            </v-row>
            <v-row>
                <v-col>
                    <v-textarea
                        label="Nature of Contact"
                        placeholder="What did you do together?"
                        rows="1"
                        auto-grow
                    ></v-textarea>
                </v-col>
                <v-col cols="auto">
                    <v-btn icon @click="deleteContact">
                        <v-icon> mdi-delete </v-icon>
                    </v-btn>
                </v-col>
            </v-row>
        </v-card-text>
    </v-card>
</template>

<script lang="ts">
import Vue from 'vue'
import InterviewContact from '@/components/InterviewContact.vue'

export default Vue.extend({
    name : "InterviewContact",
    data () {
        return {
            contactType : '',
            contactTypes: [
                "Close contact", "Prolonged close contact", "Minimal Contact"
            ],
            healthcare : false,
            age: "adult"
        }
    }
})
</script>

<style scoped>

</style>