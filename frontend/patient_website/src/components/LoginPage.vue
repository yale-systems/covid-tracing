<template>
    <v-container>
        <v-form
            ref="form"
            v-model="valid"
        >
            <v-text-field
                v-model="username"
                label="Username"
                :rules="requiredRule"
                required
            ></v-text-field>

            <v-text-field
                v-model="password"
                label="Password"
                type="password"
                :rules="requiredRule"
                required
            ></v-text-field>

            <v-btn
                :disabled="!valid"
                class="mr-4"
                @click="validate"
            >
            Submit
            </v-btn>
        </v-form>
    </v-container>
</template>

<script>
export default {
    name : "LoginPage",
    data () {
        return {
            valid : true,
            username : '',
            password : '',
            requiredRule : [
                v => !!v || 'This field is required'
            ]
        }
    }
}
</script>

<style scoped>

</style>