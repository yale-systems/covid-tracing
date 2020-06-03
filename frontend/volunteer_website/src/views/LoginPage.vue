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

<script lang="ts">
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
                (v : any) => !/\s/.test(v) || 'Username cannot include spaces',
                (v : any) => !!v || 'Username is required'
            ],
            passwordRules : [
                (v : any) => !!v || 'Password is required'
            ] as Array<any>,
            showPassword : false,
            showAlert : false
        }
    },
    methods : {
        async handleSubmit () {
            console.log("clicked")
            // if the input is valid
            if (this.$refs.form.validate()) {
                console.log("valid input")
                // make call to API , and if that checks out, send to other page
                let credentials : any = {
                    username : this.username,
                    password  : this.password
                }
                let curr : any = this;
                // if it passes, send to welcome screen
                apiCalls.checkLogin(credentials)
                    .then(function (response : boolean) {
                        if (response) {
                            curr.$store.commit('logIn')
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