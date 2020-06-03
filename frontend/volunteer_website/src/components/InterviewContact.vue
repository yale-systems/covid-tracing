<template>
    <div v-if="!this.deleted">
        <v-row>
            <v-col>
                <v-text-field
                    label="First Name"
                    v-model="value.firstName"
                ></v-text-field>
            </v-col>
            <v-col>
                <v-text-field
                    label="Last Name"
                    v-model="value.lastName"
                ></v-text-field>
            </v-col>
        </v-row>
        <v-row>
            <v-col>
                <v-text-field
                    label="Phone Number"
                    v-model="value.phone"
                ></v-text-field>
            </v-col>
            <v-col>
                <v-text-field
                    label="Email Address"
                    v-model="value.email"
                ></v-text-field>
            </v-col>
        </v-row>
        <v-row>
            <v-col>
                <v-select
                    :items="contactTypes"
                    label="Type of Contact"
                    v-model="value.contactType"
                ></v-select>
            </v-col>
            <v-spacer></v-spacer>
            <v-col>
                <v-checkbox
                    label="Healthcare Worker?"
                    v-model="value.healthcareWorker"
                ></v-checkbox>
            </v-col>
            <v-col>
                <v-radio-group v-model="value.age" row>
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
                    v-model="value.contactNature"
                ></v-textarea>
            </v-col>
            <v-col cols="auto">
                <v-btn color="error" outlined @click="deleteContact">
                    delete contact <v-icon> mdi-close </v-icon>
                </v-btn>
            </v-col>
        </v-row>
         <v-divider></v-divider>
    </div>
</template>

<script>
import InterviewContact from '../components/InterviewContact.vue'

export default {
    name : "InterviewContact",
    props : {
        value : {
            type : Object,
            required : true
        },
        v : {
            type : Object,
            required : true
        }
    },
    data () {
        return {
            contactTypes: [
                "Close contact", "Prolonged close contact", "Minimal Contact"
            ],
            deleted : false
        }
    },
    methods : {
        deleteContact() {
            this.deleted = true
            this.$emit('delete-contact', this.value.contactID)
        }
    }
}
</script>

<style scoped>

</style>
