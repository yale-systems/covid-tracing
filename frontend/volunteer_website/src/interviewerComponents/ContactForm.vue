<template>
    <v-container fluid style="padding-right:2%; padding-left:2%;">
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
                    v-model="data.first_name"
                    @focus="$v.data.first_name.$reset"
                    @blur="setPersonText"
                ></v-text-field>
            </v-col>
            <v-col>
                <v-text-field
                    label="Last Name"
                    v-model="data.last_name"
                    :error-messages="lastNameErrors"
                    @focus="$v.data.last_name.$reset"
                    @blur="$v.data.last_name.$touch"
                ></v-text-field>
            </v-col>
        </v-row>
        <v-row style="margin-top:-10px">
            <v-col>
                <v-text-field
                    label="Phone Number"
                    v-model="data.phone_number"
                    :error-messages="phoneErrors"
                    @focus="$v.data.phone_number.$reset"
                    @blur="$v.data.phone_number.$touch"
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
                    item-value="key"
                    item-text="value"
                    label="Relationship to Contact*"
                    v-model="data.relationship"
                    :error-messages="relationshipErrors"
                    @focus="$v.data.relationship.$reset"
                    @blur="$v.data.relationship.$touch"
                ></v-select>
            </v-col>
            <v-col>
                <v-select
                    :items="languageTypes"
                    label="Language"
                    item-text="value"
                    item-value="key"
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
                            v-model="readableDate"
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
                        v-model="date" 
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
                <v-radio-group v-model="data.age_group" row>
                    <v-radio label="Minor" value="0"></v-radio>
                    <v-radio label="Adult" value="1"></v-radio>
                    <v-radio label="Elderly" value="2"></v-radio>
                </v-radio-group>
            </v-col>
            <v-col>
                <v-checkbox
                    :label="'Does ' + personName + ' work in healthcare?'"
                    v-model="data.healthcare_worker"
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
import { isPhone } from '@/constants/validators'

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
            contact_date: {
                required: requiredIf(function() {
                    return this.household
                })
            },
            first_name: { 
                // isName, 
                required 
            },
            last_name: { 
                // isName 
            },
            phone_number: { isPhone },
            email: { email },
            relationship: { required },
            healthcare_worker: {},
            age_group: {},
            language: {}
        }
    },
    data: () => {
        return {
            displayDate: undefined,
            data: {},
            menu: false,
            personName: 'this person'
        }
    },
    computed: {
        date: {
            get() {
                let date = this.data.contact_date
                if(date) {
                    return date.format('YYYY-MM-DD')
                } else {
                    return ''
                }
            },
            set(newVal) {
                var moment = require('moment')
                this.$set(this.data, 'contact_date', moment(newVal))
            }
        },
        readableDate: {
            get() {
                let date = this.data.contact_date
                if(date) {
                    return date.format('MMMM Do, YYYY')
                } else {
                    return ''
                }
            },
            set(newVal) {
                if(this.date) {
                    this.date = newVal
                }

            }
        },
        endDate() {
            return this.$store.getters['patients/endDate']
        },
        startDate() {
            return this.$store.getters['patients/startDate']
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
            return this.$store.state.enums.Relationship
        },
        languageTypes() {
            return this.$store.state.enums.Language
        },
        firstNameErrors() {
            const errors = []
            if (!this.$v.data.first_name.$dirty) return errors
            !this.$v.data.first_name.required && errors.push(`First name is required.`)
            // !this.$v.data.first_name.isName && errors.push('Names can only contain alphabetic characters.')
            return errors
        },
        lastNameErrors() {
            const errors = []
            if (!this.$v.data.last_name.$dirty) return errors
            // !this.$v.data.last_name.isName && errors.push('Names can only contain alphabetic characters.')
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
            if (!this.$v.data.phone_number.$dirty) return errors
            // !this.$v.data.phone_number.isPhone && errors.push('Phone number can only contain numeric digits')
            return errors
        },
        relationshipErrors() {
            const errors = []
            if (!this.$v.data.relationship.$dirty) return errors
            !this.$v.data.relationship.required && errors.push('Please select the type of contact from the dropdown menu.')
            return errors
        },
        dateErrors() {
            const errors = []
            if (!this.$v.data.contact_date.$dirty) return errors
            !this.$v.data.contact_date.required && errors.push('Last Date of contact is required')
            return errors
        }
    },

    watch: {
        openClicked() { 
            console.log("trying to wipe data")
            this.open()
        },

        validate() {
            this.$v.data.$touch()
            if (this.$v.data.$anyError) {
                return
            } else {
                this.$emit('contact-success', Object.assign({}, this.data))
                return
            }
        }
    },
    mounted() {
        this.data.household = this.household 
        this.data.contact_id = this.id
        this.open()
    },
    methods: {
        open() {
            if(this.id == -1) {
                this.$v.$reset()
                this.$refs.form.reset()
                Object.keys(this.data).map((key) => {
                    this.data[key] = undefined
                })
                this.setPersonText()
            } else {
                if (this.id == undefined ) { return }
                let contact = this.$store.getters['contacts/id'](this.id)
                if(contact == null ) { return }
                this.data = Object.assign({}, contact)
                this.personName = `${contact.first_name} ${contact.last_name}`
            }
            this.data.contact_id = this.id
            this.data.household = this.household
        },
        setPersonText() {
            this.$v.data.first_name.$touch
            this.$nextTick(() => {
                if (this.data.first_name === '' || this.data.first_name == undefined) {
                    this.personName = "this person"
                } else {
                    this.personName = this.data.first_name
                }
                
            })
        }
    }
}
</script>

<style scoped>

</style>