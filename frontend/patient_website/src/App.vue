<template>
    <v-app>
        <v-app-bar app color="primary" dark>
            <div class="d-flex align-center large-bold ml-1 pointerOnHover"
                @click="goHome">
                Oasis Contact Tracing
            </div>
            <div class="ml-4">

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
                            @click="$store.dispatch('logOut')"
                            to="login"
                        >
                            <v-list-item-content>Logout</v-list-item-content>
                        </v-list-item>
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

export default {
    name: "App",
    computed: {
        loggedIn() {
            return this.$store.state.loggedIn;
        },
        name() {
            return this.$store.getters['patients/activePatient'].first_name
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
