<template>
  <DeckMapLoader>
    <template slot-scope="{ deck, map }">
           <ScatterplotController 
                :deck ="deck"
                :map ="map"
                :markers="markers"
              />
    </template>
  </DeckMapLoader>
</template>

<script>
import DeckMapLoader from '@/components/DeckMapLoader.vue'
import ScatterplotController from '@/components/ScatterplotController.vue'

export default {
  name : "ExposureMap",
  components : {
    DeckMapLoader,
    ScatterplotController
  },
  props: {
    markers: {
      type: Array,
      default: () => []
    }
  },
  data() {
    return {
    }
  }
}
</script>

<style scoped>
<style>
