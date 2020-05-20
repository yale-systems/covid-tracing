<template>
    <div class="bold">
        <b-container fluid>
        <!-- TODO: SOMEWHERE in here, add a "register" button. v-if register, have a field (optional) for an email address.
        A "what's this" button, if hovered over, pops up a tooltip and explains that this is the way we'll contact you, if your risk
        status changes. This tooltip also says that you can disable or enable email notifications anytime you'd like, in your profile (which we need to add -- can be as simple
        as, when the person clicks on their name, putting down their username, password, and email address, 
        and a button saying "delete my account". They should be able to edit any of those fields. We will
        autopopulate whatever form fields you create with their username, password, etc, and handle what happens with
        the backend when they say "delete me" or "update me" -- your challenge is just to design
        the front end in HTML and CSS! -->
        <div v-if="!loggedIn">
            <br><h3 class="large">Please Log In</h3>
            <hr class="line">
                <b-card class="login-margins">
                    <b-form>
                        <b-form-group label="Username" label-for="username">
                            <b-form-input 
                                v-model="$v.loginInfo.username.$model" 
                                id="username"
                                :state="getState(!$v.loginInfo.username.$error, loginInfo.username)"
                            > </b-form-input>
                        </b-form-group>
                        <div class="error errorMargin" v-if="$v.loginInfo.username.$error"> A username is required </div>
                        <b-form-group label="Password" label-for="password">
                            <b-form-input 
                                v-model="$v.loginInfo.password.$model" 
                                id="password" 
                                type="password"
                                :state="getState(!$v.loginInfo.password.$error, loginInfo.password)"
                            > </b-form-input>
                        </b-form-group>
                        <div class="error errorMargin" v-if="$v.loginInfo.password.$error"> A password is required </div>
                        
                        <b-button class="navbar-custom largerMargin" @click="handleSubmit">Login</b-button>
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

</style>