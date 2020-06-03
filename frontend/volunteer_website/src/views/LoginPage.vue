<template>
    <v-container>
        <v-stepper v-model="cardProgress">
            <v-stepper-items>
                <v-stepper-content
                    step="1">
                    <v-card>
                        <v-card-title>
                            Welcome
                        </v-card-title>
                        <v-card-subtitle>
                            Please choose a user
                        </v-card-subtitle>
                        <v-card-content>
                            <v-btn-toggle
                                v-model="usertype"
                                color="blue"
                                mandatory
                                group
                            >
                                <v-btn value="volunteer" outlined>
                                Volunteer
                                </v-btn>
                    
                                <v-btn value="manager" outlined>
                                Manager
                                </v-btn>
                            </v-btn-toggle>
                        </v-card-content>
                        <v-card-actions class="mt-10">
                            <v-btn
                                @click="cardProgress=2"
                            >
                                Continue
                            </v-btn>
                        </v-card-actions>
                    </v-card>
                </v-stepper-content>
                <v-stepper-content
                    step="2">
                    <v-card>
                        <v-card-title>
                            Welcome
                        </v-card-title>
                        <v-card-subtitle>
                            Please login
                        </v-card-subtitle>
                        <v-card-content>
                            <v-form
                                ref="form"
                                class="mx-4">
                                <v-text-field
                                    v-model="username"
                                    label="Username"
                                    :rules="usernameRules"
                                    required
                                ></v-text-field>

                                <v-text-field
                                    v-model="password"
                                    ref="password"
                                    label="Password"
                                    :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                                    :type="showPassword ? 'text' : 'password'"
                                    :rules="passwordRules"
                                    @click:append="showPassword = !showPassword"
                                    @click="showAlert = false"
                                    @keyup.enter="handleSubmit"
                                    required
                                ></v-text-field>

                                <v-alert
                                    type="error"
                                    dense
                                    outlined
                                    v-if="showAlert"
                                >
                                    The username or password may be incorrect. Please try again.
                                </v-alert>
                            </v-form>
                        </v-card-content>
                        <v-card-actions>
                            <v-btn
                                @click="cardProgress=1"
                            >
                            Back
                            </v-btn>
                            <v-btn
                                :disabled="!valid"
                                class="mr-4"
                                @click="handleSubmit"
                            >
                            Submit
                            </v-btn>
                        </v-card-actions>
                    </v-card>
                </v-stepper-content>
            </v-stepper-items>
        </v-stepper>
    </v-container>
</template>

<script> 
import apiCalls from '@/apiCalls'

export default {
    name : "LoginPage",
    data () {
        return {
            valid : true,
            username : '',
            password : '',
            usernameRules : [
                (v) => !/\s/.test(v) || 'Username cannot include spaces',
                (v) => !!v || 'Username is required'
            ],
            passwordRules : [
                (v) => !!v || 'Password is required'
            ],
            showPassword : false,
            showAlert : false,
            cardProgress : 1,
            usertype : ''
        }
    },
    methods : {
        async handleSubmit () {
            console.log("clicked")
            // if the input is valid
            if (this.$refs.form.validate()) {
                console.log("valid input")
                // make call to API , and if that checks out, send to other page
                let credentials = {
                    username : this.username,
                    password  : this.password
                }
                let curr = this;
                // if it passes, send to welcome screen
                apiCalls.checkLogin(credentials)
                    .then(function (response ) {
                        if (response) {
                            curr.$store.commit('logIn')
                            curr.$router.push({ name : "Dashboard" });
                        } else {
                            console.log("not accepted")
                            // give feedback that something was wrong
                            curr.password = "";
                            curr.showAlert = true;
                        }
                    }) ;
            }
        },
    }
}
</script>

<style scoped>

</style>
