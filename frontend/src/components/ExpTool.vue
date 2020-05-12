<template>
  <div>
    <b-card>
      <b-card>
        <ExpForm v-model="flags"/>
      </b-card>
      <div v-if="flags.submitted">
      <b-card v-if="flags.exposed" title="You may have been exposed.">
        Please refer to the CDC's guidelines and consider isolating yourself.
      </b-card>
      <b-card v-if="!flags.exposed" title="There were no data points found near your location.">
      </b-card>
      </div>
    </b-card>  
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
  }
}

</script>

<style scoped>
</style>
