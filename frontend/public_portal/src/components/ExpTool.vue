<template>
  <div> 
    <div v-if="!loggedIn"> 
      <p> You must login or register for an account in order to use this tool. 
      Push the lil Login button to do so. Make this text nice. Maybe even put
      this lil dude in a card. or somethin </p> 
    </div> 
    <div class="bold" v-if="loggedIn">
      <b-container fluid>
          <br><h3 class="large">Exposure Tool</h3> 
          <hr class="line">
          <div v-if="!flags.submitted"> 
            <div>
              <ExpForm v-model="flags"/>
            </div>
          </div>
          <div class="login-margins" v-if="flags.submitted">
            <b-card v-if="flags.exposed" title="You may have been exposed.">
              Please refer to <a href="https://www.cdc.gov/coronavirus/2019-ncov/if-you-are-sick/steps-when-sick.html">the CDC's guidelines</a> and consider isolating yourself.
            </b-card>
            <b-card v-if="!flags.exposed">There were no data points found near your location on the date selected.
            </b-card>
            <br><b-button class="navbar-custom" v-on:click="returnSearch">Return to Search</b-button>
          </div>
      </b-container>
     </div>
  </div>
</template>

<script>
import ExpForm from './ExpForm'

export default {
  name: 'ExpTool',
  components: {
    ExpForm
  },

  data () {
    return {
      flags: {
        exposed : false,
        submitted : false
      }
    }
  },
  computed: {
    loggedIn : function () {
      return this.$store.state.loggedIn
    }
  },

  watch: {
    submitted() {
      console.log("form was submitted")
    }
  },
  methods : {
    returnSearch() {
      this.flags.submitted = false;
    }
  }
}

</script>

<style scoped>

</style>
