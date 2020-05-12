<template>
  <div>
    <b-card>
      <b-card>
        <ExpForm :queryResults="foundResults" :submitted="resultsReturned"/>
      </b-card>
      <component v-bind:is="cardName"> </component>
      <div v-if="resultsReturned">
      <b-card v-if="foundResults" title="You may have been exposed.">
        Please refer to the CDC's guidelines and consider isolating yourself.
      </b-card>
      <b-card v-if="!foundResults" title="There were no data points found near your location.">
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
      foundResults : false,
      resultsReturned : false
    }
  },
  methods : {
  }
}

</script>

<style scoped>
</style>
