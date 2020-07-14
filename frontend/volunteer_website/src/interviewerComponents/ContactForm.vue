<template>
    <v-container class="mb-0 pb-0">
        <v-card-title>
            <span class="headline"><b>{{title}}</b></span>
        </v-card-title>
        
        <v-card-text>
        <v-form ref="form">
        <v-row style="margin-top:-10px">
            <v-col>
                <v-text-field
                    label="First Name*"
                    :error-messages="firstNameErrors"
                    v-model="data.firstName"
                    @focus="$v.data.firstName.$reset"
                    @blur="setPersonText"
                ></v-text-field>
            </v-col>
            <v-col>
                <v-text-field
                    label="Last Name"
                    v-model="data.lastName"
                    :error-messages="lastNameErrors"
                    @focus="$v.data.lastName.$reset"
                    @blur="$v.data.lastName.$touch"
                ></v-text-field>
            </v-col>
        </v-row>
        <v-row style="margin-top:-10px">
            <v-col>
                <v-text-field
                    label="Phone Number"
                    v-model="data.phone"
                    :error-messages="phoneErrors"
                    @focus="$v.data.phone.$reset"
                    @blur="$v.data.phone.$touch"
                ></v-text-field>
            </v-col>
            <v-col>
                <v-text-field
                    label="Email Address"
                    v-model="data.email"
                    :error-messages="emailErrors"
                    @focus="$v.data.email.$reset"
                    @blur="$v.data.email.$touch"
                ></v-text-field>
            </v-col>
        </v-row>
        <v-row>
            <v-col>
                <v-select 
                    :items="relationshipTypes"
                    label="Relationship to Contact*"
                    v-model="data.relationshipType"
                    :error-messages="relationshipErrors"
                    @focus="$v.data.relationshipType.$reset"
                    @blur="$v.data.relationshipType.$touch"
                ></v-select>
            </v-col>
            <v-col>
                <v-select
                    :items="languageTypes"
                    label="Language"
                    v-model="data.language"
                ></v-select>
            </v-col>
        </v-row>
        <v-row style="margin-top:-10px">
            <v-col v-if="household"
            >
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
                            class="mr-4"
                            v-model="data.date"
                            label="Last Date of Contact*"
                            prepend-icon="mdi-calendar"
                            :placeholder="'select the day you last had contact with with ' + personName"
                            :error-messages="dateErrors"
                            readonly
                            v-on="on"
                            @click:prepend="menu=true"
                        ></v-text-field>
                    </template>
                    <v-date-picker 
                        v-model="data.date" 
                        :max="endDate"
                        :min="startDate"
                        no-title 
                        scrollable
                        @input="menu=false">
                    </v-date-picker>
                </v-menu>
            </v-col>  
        </v-row>
        <v-row style="margin-top:-30px">
            <v-col
            :cols=1 style="margin-right:80px;"
            >
                <v-radio-group v-model="data.age" row>
                    <v-radio label="Minor" value="minor"></v-radio>
                    <v-radio label="Adult" value="adult"></v-radio>
                    <v-radio label="Elderly" value="elderly"></v-radio>
                </v-radio-group>
            </v-col>
            <v-col>
                <v-checkbox
                    :label="'Does ' + personName + ' work in healthcare?'"
                    v-model="data.healthcareWorker"
                ></v-checkbox>
            </v-col>
            <v-col style="margin-right:-90px;">
                <v-checkbox
                    :label="'Is ' + personName + ' currently sick?'"
                    v-model="data.symptomatic"
                ></v-checkbox>
            </v-col>  
        </v-row>
        </v-form>
        </v-card-text>
    </v-container>
</template>

<script>
import { validationMixin } from 'vuelidate'
import { email, required, requiredIf } from 'vuelidate/lib/validators'
import { isName, isPhone } from '@/constants/validators'

export default {
    name: "ContactForm",
    props: {
        household: Boolean,
        openClicked: Boolean,
        validate: Boolean,

        // -1 if new, undefined if button needs to be disabled, otherwise ID is the contactID
        id: { 
            Number,
            required: true
        }
    },
    mixins: [validationMixin],
    validations: {
        data: {
            date: {
                required: requiredIf(function() {
                    return this.household
                })
            },
            firstName: { 
                isName, 
                required 
            },
            lastName: { isName },
            phone: { isPhone },
            email: { email },
            relationshipType: { required },
            healthcareWorker: {},
            age: {},
            language: {}
        }
    },
    data: () => {
        return {
            data: {
                firstName: undefined,
                lastName: undefined,
                phone: undefined,
                email: undefined,
                relationshipType: undefined,
                healthcareWorker: false,
                age: undefined,
                symptomatic: false,
                household: undefined,
                date: undefined
            },
            menu: false,
            languageTypes: [
                "English", "Spanish", "Chinese", "Arabic", "Other"
            ],
            personName: 'this person'
        }
    },
    computed: {
        endDate() {
            return this.$store.state.endDate.format('YYYY-MM-DD')
        },
        startDate() {
            return this.$store.state.startDate.format('YYYY-MM-DD')
        },
        title() {
            if (this.household && this.id == -1) {
                return "Add Household Contact"
            } else if (this.household && this.id != undefined) {
                return "Edit Household Contact"
            } else if (!this.household && this.id == -1) {
                return "Add Outside Contact"
            } else {
                return "Edit Outside Contact"
            }
        },
        relationshipTypes() {
            if(this.household) {
                return ["Parent", "Sibling", "Grandparent", "Child", "Other family", "Non-family", "Other/Don't want to say"]
            } else {
                return ["Friend", "Work colleague", "Parent", "Sibling", "Grandparent", "Child", "Other family", "Non-family", "Other/Don't want to say"]
            }
        },
        firstNameErrors() {
            const errors = []
            if (!this.$v.data.firstName.$dirty) return errors
            !this.$v.data.firstName.required && errors.push(`First name is required.`)
            !this.$v.data.firstName.isName && errors.push('Names can only contain alphabetic characters.')
            return errors
        },
        lastNameErrors() {
            const errors = []
            if (!this.$v.data.lastName.$dirty) return errors
            !this.$v.data.lastName.isName && errors.push('Names can only contain alphabetic characters.')
            return errors
        },
        emailErrors () {
            const errors = []
            if (!this.$v.data.email.$dirty) return errors
            !this.$v.data.email.email && errors.push('Invalid email -- emails must be of the form jane@doe.com')
            return errors
        },
        phoneErrors() {
            const errors = []
            if (!this.$v.data.phone.$dirty) return errors
            !this.$v.data.phone.isPhone && errors.push('Phone number can only contain numeric digits')
            return errors
        },
        relationshipErrors() {
            const errors = []
            if (!this.$v.data.relationshipType.$dirty) return errors
            !this.$v.data.relationshipType.required && errors.push('Please select the type of contact from the dropdown menu.')
            return errors
        },
        dateErrors() {
            const errors = []
            if (!this.$v.data.date.$dirty) return errors
            !this.$v.data.date.required && errors.push('Last Date of contact is required')
            return errors
        }
    },

    watch: {
        openClicked() { 
            this.open()
        },

        validate() {
            this.$v.data.$touch()
            if (this.$v.data.$anyError) {
                return
            } else {
                this.$emit('contact-success', this.data)
                return
            }
        }
    },
    mounted() {
        this.data.household = this.household 
        this.data.contactID = this.id
        this.open()
    },
    methods: {
        open() {
            this.data.contactID = this.id
            this.data.household = this.household
            if(this.id == -1) {
                this.personName = 'this person'
                this.$v.$reset()
                this.$refs.form.reset()
            } else {
                if (this.id == undefined || this.$store.state.contacts[this.id] == undefined) {
                    return
                }
                let contact = this.$store.state.contacts[this.id]
                this.data.firstName = contact.firstName
                this.personName = contact.firstName
                this.data.lastName = contact.lastName
                this.data.phone = contact.phone
                this.data.email = contact.email
                this.data.relationshipType = contact.relationshipType
                this.data.healthcareWorker = false
                this.data.age = contact.age
                this.data.symptomatic = contact.symptomatic
                this.data.date = contact.date
            }
        },
        setPersonText() {
            this.$v.data.firstName.$touch
            this.$nextTick(() => {
                if (this.data.firstName === '') {
                    this.personName = "this person"
                } else {
                    this.personName = this.data.firstName
                }
                
            })
        }
    }
}
</script>

<style scoped>

</style>