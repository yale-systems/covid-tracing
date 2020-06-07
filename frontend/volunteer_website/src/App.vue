<template>
  <v-app>
    <v-app-bar
      app
      color="primary"
      dark
    >
      <div class="d-flex align-center large-bold ml-1">
        Contact Tracing Volunteer Portal
      </div>
      <div>
        <v-tabs v-if="loggedIn" class="ml-2" background-color="primary">
          <v-tab>
            Patients
          </v-tab>
          <v-tab>
            Contacts
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
                            <v-list-item-content
                            @click="goProfile"
                            >
                            Profile
                            </v-list-item-content>
                        </v-list-item>
                    </v-list>
                </v-menu>             
            </div>
    </v-app-bar>

    <v-content>
      <router-view>
      </router-view>
    </v-content>
  </v-app>
</template>

<script>

export default {
  name: 'App',
  computed: {
    loggedIn() {
        return this.$store.state.loggedIn;
    }
  },
  methods : {
    goProfile() {
      this.$router.push({ path: '/profile'})
    }
  },
  data: () => ({
    //
  }),
};
</script>
