<template>
  <div class="bold">
     <b-container fluid>
        <br><h3 class="large">Exposure Tool</h3> 
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

.bold {
    font-weight : bold;
}
</style>
