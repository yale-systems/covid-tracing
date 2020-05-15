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
    name: "DeckMapLoader",

    data: function() {
        return {
          map : null,
          deck : null,
            viewState: {
              zoom: 5,
              pitch: 0,
              bearing: 0,
              latitude: 41.309177,
              longitude: -72.928562
            },
          markers : [
            [-72.844716,41.681735],[-72.84622600000002,41.691475000000004],[-72.83480600000001,41.708285000000004],[-72.82274600000001,41.714785],[-72.81858600000001,41.723895],[-72.80810600000001,41.724265]
          ]
        }
    },
  created() {
    this.map = null;
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
      layers: [ new ScatterplotLayer({
        id: 'scatterplot',
        getFillColor: () => [0, 128, 255],
        getRadius: () => 5,
        getPosition: d => d,
        opacity: 1,
        filled: true,
        pickable: true,
        radiusMinPixels: 30,
        radiusMaxPixels: 50,
        data: this.markers
      }) ]
    });
  },
  // computed : {
  //   getLayers() {
  //     const scatter = new ScatterplotLayer({
  //       id: 'scatterplot',
  //       getFillColor: [0, 128, 255],
  //       getRadius: 5,
  //       opacity: 1,
  //       filled: true,
  //       pickable: true,
  //       radiusMinPixels: 30,
  //       radiusMaxPixels: 50,
  //       data: this.markers
  //     });
  //     console.log("making new layer")
  //     console.log(scatter)
  //     return [scatter];
  //   }
  // },
  // methods : {
  //   renderLayers(layers) {
  //     this.deck.setProps({
  //       layers: []
  //     })
  //   }
  // },
  // watch : {
  //   getLayers(scatter) {
  //     console.log("adding layer")
  //     this.renderLayers(scatter);
  //   }
  // }
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
