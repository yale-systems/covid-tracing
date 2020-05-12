<template>
  <div id="app">
        <b-navbar variant ="primary" type ="dark">
          <b-navbar-brand style="white" > COVID-19 Contact Tracing </b-navbar-brand>
          <b-navbar-nav>
            <b-nav-item to="/map"> Map </b-nav-item>
            <b-nav-item to="/form"> Interview Form </b-nav-item>
            <b-nav-item to="/tool"> Exposure Tool </b-nav-item>
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

</style>

