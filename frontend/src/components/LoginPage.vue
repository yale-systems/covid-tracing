<template>
    <div>
      <b-container fluid>
        <br><h3 class="large">Please Log In</h3>
        <b-card class="login-margins">
            <b-form>
                <b-form-group label="Username" :label-for="username">
                    <b-form-input v-model="$v.loginInfo.username.$model" id="username"> </b-form-input>
                </b-form-group>

                <b-form-group label="Password" :label-for="password">
                    <b-form-input v-model="$v.loginInfo.password.$model" id="password" type="password"> </b-form-input>
                </b-form-group>

                <b-button class="navbar-custom" @click="storeCookie">Login</b-button>
            </b-form>
        </b-card>
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
            }
        }
    },
    methods : {
        storeCookie() {
            
            console.log("user tried to log in")
        }
    }
}
</script>

<style scoped>

</style>