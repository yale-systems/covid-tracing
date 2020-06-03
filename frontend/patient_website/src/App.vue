<template>
    <v-app>
        <v-app-bar app color="primary" dark>
            <div class="d-flex align-center large-bold ml-1">
                Contact Tracing
            </div>
            <div class="ml-4">
                <v-tabs background-color="primary" v-if="loggedIn">
                    <v-tab
                        to="form">
                        Interview Form
                    </v-tab>
                </v-tabs>
            </div>
        
            <v-spacer></v-spacer>

            <div v-if="loggedIn">
                <span class="mr-2">Welcome, Username</span>
            </div>

            <div class="text-center" v-if="loggedIn">
                <v-menu
                    offset-y
                    open-on-hover
                >
                    <template v-slot:activator="{ on }">
                        <v-btn
                            icon
                            v-on="on"
                        >
                            <v-icon>mdi-account-circle</v-icon>
                        </v-btn>
                    </template>
                    <v-list>
                        <v-list-item
                            @click="$store.commit('logOut')"
                            to="login"
                        >
                            <v-list-item-content>Logout</v-list-item-content>
                        </v-list-item>
                        <v-list-item
                            to="profile"
                        >
                            <v-list-item-content>Profile</v-list-item-content>
                        </v-list-item>
                    </v-list>
                </v-menu>             
            </div>
        </v-app-bar>
        <v-content>
            <router-view />
        </v-content>
    </v-app>
</template>

<script lang="ts">
import Vue from "vue";
import LoginPage from "@/views/LoginPage.vue"
import Welcome from "@/views/Welcome.vue"

export default Vue.extend({
    name: "App",
    components: {
        LoginPage,
        Welcome
    },
    computed: {
        loggedIn() {
            return this.$store.state.loggedIn;
        }
    },

    data: () => ({
    })
});
</script>

<style scoped>

.large-bold {
    font-size: larger;
    font-weight: bold
}

</style>
