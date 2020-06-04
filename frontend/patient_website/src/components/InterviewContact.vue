<template>
    <div v-if="!this.deleted">
        <v-row>
            <v-col>
                <v-text-field
                    label="First Name"
                    :error-messages="firstNameErrors"
                    v-model="value.firstName"
                    @focus="v.firstName.$reset"
                    @blur="v.firstName.$touch"
                ></v-text-field>
            </v-col>
            <v-col>
                <v-text-field
                    label="Last Name"
                    v-model="value.lastName"
                    :error-messages="lastNameErrors"
                    @focus="v.lastName.$reset"
                    @blur="v.lastName.$touch"
                ></v-text-field>
            </v-col>
        </v-row>
        <v-row>
            <v-col>
                <v-text-field
                    label="Phone Number"
                    v-model="value.phone"
                    :error-messages="phoneErrors"
                    @focus="v.phone.$reset"
                    @blur="v.phone.$touch"
                ></v-text-field>
            </v-col>
            <v-col>
                <v-text-field
                    label="Email Address"
                    v-model="value.email"
                    :error-messages="emailErrors"
                    @focus="v.email.$reset"
                    @blur="v.email.$touch"
                ></v-text-field>
            </v-col>
        </v-row>
        <v-row>
            <v-col>
                <v-select
                    :items="contactTypes"
                    label="Type of Contact"
                    v-model="value.contactType"
                    :error-messages="contactTypeErrors"
                    @focus="v.contactType.$reset"
                    @blur="v.contactType.$touch"
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
                    @focus="v.contactNature.$reset"
                    @blur="v.contactNature.$touch"
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

<script lang="ts">
import Vue from 'vue'
import InterviewContact from '@/components/InterviewContact.vue'

export default Vue.extend({
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
    computed: {
        firstNameErrors() {
            const errors = []
            if (!this.v.firstName.$dirty) return errors
            !this.v.firstName.required && errors.push(`First name is required.`)
            !this.v.firstName.isName && errors.push('Names can only contain alphabetic characters.')
            return errors
        },
        lastNameErrors() {
            const errors = []
            if (!this.v.lastName.$dirty) return errors
            !this.v.lastName.required && errors.push(`Last name is required.`)
            !this.v.lastName.isName && errors.push('Names can only contain alphabetic characters.')
            return errors
        },
        emailErrors () {
            const errors = []
            if (!this.v.email.$dirty) return errors
            !this.v.email.email && errors.push('Invalid email -- emails must be of the form jane@doe.com')
            return errors
        },
        phoneErrors() {
            const errors = []
            if (!this.v.phone.$dirty) return errors
            !this.v.phone.numeric && errors.push('Phone number can only contain numeric digits')
            return errors
        },
        contactTypeErrors() {
            const errors = []
            if (!this.v.contactType.$dirty) return errors
            !this.v.contactType.required && errors.push('Please select the type of contact from the dropdown menu.')
            return errors
        }
    },
    methods : {
        deleteContact() {
            this.v.$reset
            this.deleted = true
            this.$emit('delete-contact', this.value.contactID)
        }
    }
})
</script>

<style scoped>

</style>