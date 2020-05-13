<template>
  <div class="large-padding bold">
    
     <h3 class="large">Exposure Tool</h3> 
     <div v-if="!flags.submitted"> 
      <div class="form-padding">
        <ExpForm v-model="flags"/>
      </div>
      </div>
      <div v-if="flags.submitted">
        <b-card v-if="flags.exposed" title="You may have been exposed.">
          Please refer to the CDC's guidelines and consider isolating yourself.
        </b-card>
        <b-card v-if="!flags.exposed" title="There were no data points found near your location on the date selected.">
        </b-card>
        <b-button v-on:click="returnSearch">Return to Search</b-button>
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



.form-padding {
    padding: 10px;
}

.bold {
    font-weight : bold;
}
</style>
