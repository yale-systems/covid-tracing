<template>
    <v-container>
        <v-form
            ref="form"
        >
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
            <v-btn
                :disabled="!valid"
                class="mr-4"
                @click="handleSubmit"
            >
            Submit
            </v-btn>
        </v-form>
    </v-container>
</template>

<script>
import Vue from 'vue'
import apiCalls from '@/apiCalls'

export default Vue.extend({
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
            showAlert : false
        }
    },
    methods : {
        async handleSubmit () {
            // console.log("clicked")
            // if the input is valid
            if (this.$refs.form.validate()) {
                // console.log("valid input")
                // make call to API , and if that checks out, send to other page
                let credentials = {
                    username : this.username,
                    password  : this.password
                }
                let curr = this;
                // if it passes, send to welcome screen
                apiCalls.checkLogin(credentials)
                    .then(function (response) {
                        console.log(response)
                        if (response.login == true) {
                            curr.$store.commit('logIn')
                            curr.$store.commit('instantiatePatient', response)
                            curr.$router.push({ name : "welcome" });
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
})
</script>

<style scoped>

</style>