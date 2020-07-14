<template>
    <div id="app">
  <v-app id="inspire">
    <v-img
      dark
      src="../assets/new-haven-green.jpg"
      gradient="to top, #E0F2F1, rgba(224, 242, 241, .99)">
      <v-row
         justify="center"
         class="welcome-style"
         style="font-size:60px; font-weight:bold;">
         Welcome to Oasis Contact Tracing
      </v-row>
      <v-row
        align="center"
        justify="center">
        <v-col class="text-center login-padding" cols="12">
          <v-card light class="form-padding">
              <h2>Please log in here for the Patient Portal</h2>
              <br>
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
                    x-large
                    block
                    color="primary" dark
                    :disabled="!valid"
                    class="mr-4 button-size"
                    @click="handleSubmit"
                >
                Submit
                </v-btn>
            </v-form>
        </v-card>
        </v-col>
      </v-row>
      <v-row
         justify="center"
         class="info-style"
         style="font-size:20px;">
         To learn more about the Oasis contact tracing project, please visit oasis.yale.edu.
      </v-row>
    </v-img>
  </v-app>
</div>
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
.text-style {
    text-shadow: 5px 5px #000000da
}
.welcome-style {
    color: black;
    font-size: 35px;
    margin-top: 5%;
    margin-bottom: 4%;
}
.info-style {
    color: black;
    margin-top: 4%;
}
.login-style {
    background-color: white;
}
.login-padding {
    max-width: 80%;
    justify-content: center;
    padding-right: 20%;
    padding-left: 20%;
}
.form-padding {
    padding-left: 8%;
    padding-right: 8%;
    padding-top:6%;
    padding-bottom: 6%;
}
.button-size {
    margin-top: 4%;
}
</style>