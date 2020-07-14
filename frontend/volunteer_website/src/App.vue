<template>
  <v-app>
    <v-app-bar v-if="loginPage()" app color="primary" dark>
      <div class="d-flex align-center large-bold ml-1">
        Contact Tracing Volunteer Portal
      </div>

    </v-app-bar>
    
    <v-content>
      <router-view class="pt-0"> </router-view>
    </v-content>
  </v-app>
</template>

<script>
export default {
  name: "App",
  computed: {
    loggedIn() {
      return this.$store.state.loggedIn;
    },
    usertype() {
      return this.$store.state.userType
    },
  },



  methods: {
    loginPage() {
      if(this.$route.path == "/" || this.$route.path == "/login" ) {
        return true
      } else {
        return false
      }
    }
  }
};
</script>

<style>

</style>
