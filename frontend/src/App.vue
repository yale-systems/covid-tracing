<template>
  <div id="app">
        <b-navbar class="navbar-custom" type ="dark">
          <b-navbar-brand style="white" > COVID-19 Contact Tracing </b-navbar-brand>
          <b-navbar-nav>
            <b-nav-item to="/map"> Map </b-nav-item>
            <b-nav-item to="/form"> Interview Form </b-nav-item>
            <b-nav-item to="/tool"> Exposure Tool </b-nav-item>
            <b-nav-item to="/login"> Login Dev </b-nav-item>
          </b-navbar-nav>
        </b-navbar>
        <router-view></router-view>
  </div>
</template>

<script>

export default {
  name: 'App'
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

