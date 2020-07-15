<template>
    <v-app>
        <v-app-bar app color="primary" dark>
            <div class="d-flex align-center large-bold ml-1 pointerOnHover"
                @click="goHome">
                Oasis Contact Tracing
            </div>
            <div class="ml-4">
                <!-- <v-tabs background-color="teal lighten-2" v-if="loggedIn && showMe">
                    <v-tab
                        to="form">
                        Interview Form
                    </v-tab>
                </v-tabs> -->
            </div>
        
            <v-spacer></v-spacer>

            <div v-if="loggedIn">
                <span class="mr-2">Welcome, {{name}} </span>
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
                        <!-- <v-list-item
                            to="profile"
                        >
                            <v-list-item-content>Profile</v-list-item-content>
                        </v-list-item> -->
                    </v-list>
                </v-menu>             
            </div>
        </v-app-bar>
        <v-main>
            <router-view />
        </v-main>
    </v-app>
</template>

<script>
import Vue from "vue";
import LoginPage from "@/views/LoginPage.vue"
import Welcome from "@/views/Welcome.vue"

export default {
    name: "App",
    components: {
        LoginPage,
        Welcome
    },
    computed: {
        loggedIn() {
            return this.$store.state.loggedIn;
        },
        name() {
            return this.$store.state.patientInfo.name
        },
        showMe() {
            return this.$store.state.showNavBar
        }
    },
    methods: {
        goHome() {
            if(this.loggedIn) {
                this.$router.push({name: "welcome"})
            } else {
                this.$router.push({name: "login"})
            }
            
        }
    }
};
</script>

<style scoped>

.large-bold {
    font-size: larger;
    font-weight: bold
}

.pointerOnHover {
    cursor: pointer;
}

</style>
