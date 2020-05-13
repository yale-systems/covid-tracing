<template>
    <div>
        <b-container fluid>
        <div v-if="!loggedIn">
            <br><h3 class="large">Please Log In</h3>
                <b-card class="login-margins">
                    <b-form>
                        <b-form-group label="Username" label-for="username">
                            <b-form-input 
                                v-model="$v.loginInfo.username.$model" 
                                id="username"
                                :state="getState(!$v.loginInfo.username.$error, loginInfo.username)"
                            > </b-form-input>
                        </b-form-group>
                        <div class="error" v-if="$v.loginInfo.username.$error"> A username is required </div>
                        <b-form-group label="Password" label-for="password">
                            <b-form-input 
                                v-model="$v.loginInfo.password.$model" 
                                id="password" 
                                type="password"
                                :state="getState(!$v.loginInfo.password.$error, loginInfo.password)"
                            > </b-form-input>
                        </b-form-group>
                        <p class="error" v-if="$v.loginInfo.password.$error"> A password is required </p>

                        <b-button class="navbar-custom" @click="handleSubmit">Login</b-button>
                    </b-form>
                </b-card>
        </div>
        <div v-if="loggedIn">
            <b-card class="centered">
                Success! Redirecting...
            </b-card>
        </div>
        </b-container>
    </div>
</template>

<script>
import formMixin from '@/mixins/formMixin'
import { required } from 'vuelidate/lib/validators'

export default {
    mixins: [formMixin],

    validations: {
        loginInfo: {
            username: {required},
            password: {required}
        }
    },

    data() {
        return {
            loginInfo : {
                username : '',
                password : ''
            },
            loggedIn : false,
            submitTriggered : false
        }
    },
    methods : {
        handleSubmit() {
            this.$v.$touch()
            if (!this.$v.$invalid) {
                this.storeCookie()
            }
        },
        storeCookie() {
            this.$cookies.set('user', this.loginInfo.username)
            this.$store.commit('setUser', this.loginInfo.username)
            this.loggedIn = true
            var fromPage = 'MapVisualization'
            if(this.$cookies.isKey('from')) {
                fromPage = this.$cookies.get('from')
                this.$cookies.remove('from')
            }
            this.$router.push({ name: fromPage })
            //setTimeout(() => { this.$router.push({ name: fromPage })}, 1000)
        }
    }
}
</script>

<style scoped>
.centered {
    justify-content: center;
    display: flex;
    align-items:center;
    padding-bottom: 10px;
    padding-top: 8px;
}
.error {
  color : firebrick;
  font-size : smaller;
  line-height : 50%;
  padding-top : 15px;
} 
</style>