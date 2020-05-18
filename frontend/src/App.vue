<template>
  <div id="app">
        <b-navbar class="navbar-custom" type ="dark">
          <b-navbar-brand style="white" to="/map"> COVID-19 Contact Tracing </b-navbar-brand>
          <b-navbar-nav>
            <b-nav-item to="/map"> Map </b-nav-item>
            <b-nav-item to="/form" v-if="loggedIn"> Interview Form </b-nav-item>
            <b-nav-item to="/tool"> Exposure Tool </b-nav-item>
          </b-navbar-nav>
          <b-navbar-nav class="ml-auto">
            <b-nav-item to="/login" v-if="!loggedIn"> Login </b-nav-item>
            <b-nav-text v-if="loggedIn"> {{"Welcome, " + username}} </b-nav-text>
            <b-nav-item @click="logout" v-if="loggedIn"> Logout </b-nav-item>
          </b-navbar-nav>
        </b-navbar>
        <router-view></router-view>
  </div>
</template>

<script>

export default {
  name: 'App',
  /*
    username and loggedIn are shorthand aliases for this.$store. values of username
    and loggedIn
  */ 
  computed : {
    username : function() {
      //this refers to the component named "App" aka the component we're currently in
      //$store is our vuex store
      return this.$store.state.username
    },
      //loggedIn is a shorthand allias for this.$store.state.loggedIn
    loggedIn : function () {
      return this.$store.state.loggedIn
    }
  },
  created () {
    if (this.$cookies.isKey('user')) {
      this.$store.commit('setUser', this.$cookies.get('user'))
    }
  },
 
 methods : {
    //if "logout" is pressed, username is removed 
    //(both from cookie, and from global store)
    //page is redirected to MapVisualization
    logout() {
      if(this.$cookies.isKey('user')) {
        this.$cookies.remove('user')
      }
      this.$router.push({ name : 'MapVisualization'})
      this.$store.commit("logout")
    }
  }
}
</script>

<style scoped>

/*
.navbar-dark .navbar-nav  {
  background-color :#1B3A71;
}


.custom-class {
  color: var(#1B3A71);
  background-color: var(#1B3A71);
}
*/

</style>

