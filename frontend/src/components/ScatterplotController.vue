<template>
  <div> </div>
</template>

<script>
import { ScatterplotLayer } from "@deck.gl/layers"

export default {
  name: "ScatterplotController",
  props : {
    deck : {
      type : Object
    },
    map : {
      type : Object
    },
    markers: {
      type: Array, 
      default: () => []
    }
  },
  created() {
    console.log("creating")
  },
  mounted() {
    console.log("scatterplot layer has been mounted")
  },
  computed: {
    //create the scatterplot layer whenever the markers change...
    getScatterLayer() {
      const points = new ScatterplotLayer({
        id: 'scatterplot',
        getPosition: marker => [marker.position.lat, marker.position.lng],
        getFillColor: () => [0, 128, 255],
        getRadius: () => 5,
        opacity: 0.5,
        filled: true,
        pickable: true,
        radiusMinPixels: 30,
        radiusMaxPixels: 50,
        data: this.markers
      });
      console.log("The points are: ")
      console.log(points);

      return [points];
  
    }
  },
  methods: {
    renderScatter(pointLayer) {
      this.deck.setProps({ //note: what if you want to set multiple layers? can each layer call this.deck.setProps? Or do we need to do ... pointLayer? 
        layers: [...pointLayer]
      });
      console.log("the deck is now: ")
      console.log(this.deck);
    }
  },
  watch: {
    getScatterLayer(pointLayer) {
      this.renderScatter(pointLayer);
      console.log("trying to render point Layer")
      console.log(pointLayer)
    }
  }
}
</script>

<style scoped>
<style>
