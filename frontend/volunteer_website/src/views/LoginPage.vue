<template>
    <!-- controlling the size of the container will control the size of the stepper -->
    <v-container fluid class="px-9 login-spacing">
        <v-stepper v-model="cardProgress">
            <v-stepper-items>
                <v-stepper-content
                    step="1"
                    style="margin-bottom:5%;">
                            <v-row justify="center"> 
                            <v-card-title >
                                Welcome to the Oasis Volunteer Portal
                            </v-card-title>
                            </v-row>
                            <br>
                            <v-row justify="center">
                                <v-btn
                                    @click="cardProgress=2, usertype='patient'"
                                    color="primary"
                                    min-height=80px
                                    min-width=300px>
                                    I'm interviewing patients
                                </v-btn>
                            </v-row>
                            <v-row justify="center" class="button-spacing">
                                <v-btn
                                    @click="cardProgress=2; usertype='contact'"
                                    color="primary"
                                    min-height=80px
                                    min-width=300px>
                                        I'm notifying contacts
                                </v-btn>
                            </v-row>
                </v-stepper-content>
                <v-stepper-content step="2" style="margin-top:-2%;">
                        <v-card-title>
                            Welcome
                        </v-card-title>
                        <v-card-subtitle>
                            Please login
                        </v-card-subtitle>
                        <v-form ref="form" class="mx-4">
                            <v-text-field
                                v-model="username"
                                label="Username"
                                :rules="usernameRules"
                                required
                            ></v-text-field>

                            <v-text-field
                                v-model="password"
                                label="Password"
                                :rules="passwordRules"
                                required
                                password
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
                    
                        <v-card-actions>
                            <v-btn
                                text
                                color="primary"
                                @click="cardProgress=1"
                            >
                            Back
                            </v-btn>
                            <v-btn
                                :disabled="!valid"
                                color="primary"
                                @click="handleSubmit"
                            >
                            Submit
                            </v-btn>
                            <v-btn
                                @click="handleDemo"
                                
                                >
                                demo login
                            </v-btn>
                        </v-card-actions>         
                </v-stepper-content>
    </v-stepper-items>
    </v-stepper> 
    </v-container>
</template>

<script>
import apiCalls from "@/apiCalls";

export default {
    name : "LoginPage",
    data () {
        return {
            valid: true,
            username: '',
            password: '',
            usernameRules: [
                v => !/\s/.test(v) || 'Username cannot include spaces',
                v => !!v || 'Username is required'
            ],
            passwordRules: [
                v => !!v || 'Password is required'
            ],
            showPassword: false,
            showAlert: false,
            cardProgress: 1,
            usertype: ''
        }
    },
    methods: {
        async handleSubmit() {
            // if the input is valid
            let validate = this.$refs.form.validate()
            if (validate) {
                // make call to API , and if that checks out, send to other page
                let credentials = {
                    username: this.username,
                    password : this.password
                }
                let curr = this;
                // if it passes, send to welcome screen
                apiCalls.checkLogin(credentials)
                    .then(function (response) {
                        if (response) {
                            curr.$store.commit('logIn')
                            curr.$store.commit('setUserType', curr.usertype)
                            if (curr.usertype == 'patient') {
                                curr.$router.push({ name: "PDash" });
                            } else if (curr.usertype == 'contact') {
                                curr.$router.push({ name: "Dashboard" });
                            }
                        } else {
                            // give feedback that something was wrong
                            curr.password = "";
                            curr.showAlert = true;
                        }
                    }) ;
            }
        },
        handleDemo() {
            this.username = 'username'
            this.password = 'password'
            this.$nextTick(() => {
                this.handleSubmit()
            })
        }
    }
}
</script>


<style scoped>
.login-spacing {
    max-width: 60%;
    margin-left: 20%;
    margin-right: 10%;
    margin-top: 10%;
}

.button-spacing {
    padding: 2%;
}
</style>
