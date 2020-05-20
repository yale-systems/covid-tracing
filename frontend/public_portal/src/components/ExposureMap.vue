<template>
  <div class="deck-container">
    <div id="map" ref="map"> </div>
    <canvas id="deck-canvas" ref="canvas"></canvas>
  </div>
</template>

<script>
import mapboxgl from "mapbox-gl"
import { mbToken } from "@/constants/apiKey.js"
import { Deck } from "@deck.gl/core"
import { ScatterplotLayer } from "@deck.gl/layers"

export default {
    name: "ExposureMap",
    props: {
      markers: {
        type: Array,
        default: () => []
      }
    },
    data: function() {
        return {
            viewState: {
              zoom: 9,
              pitch: 0,
              bearing: 0,
              latitude: 41.7658,
              longitude: -72.6734
            },
        }
    },
    created() {
      this.map = null; // map and deck canNOT be reactive!! at ALL!! 
      this.deck = null;
    },
   mounted() {
    // create the map
    this.map = new mapboxgl.Map({
      accessToken: mbToken,
      container : this.$refs.map,
      interactive : false,
      style :
      "mapbox://styles/mapbox/light-v10",
      center: [this.viewState.longitude, this.viewState.latitude],
      zoom : this.viewState.zoom,
      pitch : this.viewState.pitch,
      bearing : this.viewState.bearing
    });
    // create the deck instance
    this.deck = new Deck({
      canvas: this.$refs.canvas,
      width : "100%",
      height : "100%",
      initialViewState : this.viewState,
      controller: true,
      // change map ViewState according to Deck viewstate
      onViewStateChange : ({ viewState }) => {
        this.map.jumpTo({
          center : [viewState.longitude, viewState.latitude],
          zoom : viewState.zoom,
          bearing : viewState.bearing,
          pitch : viewState.pitch
        });
      },
    });
    this.renderLayers(this.getScatterplot);
  },

  computed: {
    getScatterplot() { 
      const scatter = new ScatterplotLayer({
          id: 'scatterplot',
          getFillColor: () => [0, 128, 255],
          getRadius: () => 5,
          getPosition: d => [d.position.lng, d.position.lat],
          opacity: 0.4,
          filled: true,
          pickable: true,
          radiusMinPixels: 15,
          radiusMaxPixels: 30,
          data: this.markers
        });
        return [scatter]
    }
  },

  watch: { 
    markers() {
        this.renderLayers(this.getScatterplot)
    }
  },

  methods : {
    renderLayers(newLayer) {
      console.log("trying to render")
      this.deck.setProps({
        layers: [...newLayer]
      })
      console.log(this.deck)
    }
  }
}
</script>

<style scoped>
.deck-container {
  width : 100%;
  height : 100%;
  position : relative;
}
#map {
  position : absolute;
  top : 0;
  left : 0;
  width : 100%;
  height : 100%;
  background : #e5e9ec;
  overflow : hidden;
}
#deck-canvas {
  position : absolute;
  top : 0;
  left : 0;
  width : 100%;
  height : 100%;
}
</style>
