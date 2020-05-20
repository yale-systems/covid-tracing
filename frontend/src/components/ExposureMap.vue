<template>
  <div class="deck-container">
    <div id="map" ref="map"> </div>
    <canvas id="deck-canvas" ref="canvas"></canvas>
    <div id="tooltip" ref="tooltip"></div>
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
      },
      selectedDay : {
        type : Number,
        default : -1
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
            dayLayers : []
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
    // console.log("render in mounted")
    this.renderLayers(this.getScatterplot());
  },

  computed: {
  },

  watch: { 
    selectedDay() {
        // console.log("render on watch")
        this.renderLayers(this.dayLayers[this.selectedDay])
    },
    markers() {
      this.makeLayers()
      this.renderLayers(this.dayLayers[this.selectedDay])
      //this.renderLayers(this.getScatterplot())
    }
  },

  methods : {
    renderLayers(newLayer) {
      // console.log("trying to render")
      this.deck.setProps({
        layers: [...newLayer]
      })
      // console.log(this.deck)
    },
    updateToolTip(message, x, y) {
      const el = this.$refs.tooltip
      el.innerText = message;
      el.style.display = 'block';
      el.style.left = x + 30 + 'px';
      el.style.top = y + 30 + 'px';
    },
    makeLayers() {
      var i;
      for (i = 0; i < 7; i++) {
        let layer = this.getScatterplot(i + 2)
        this.dayLayers.push(layer)
      }
    },
    getScatterplot(selectedDay) { 
      let filterData = null
      if (selectedDay < 0) {
        filterData = this.markers
      } else {
        filterData = this.markers.filter(d => d.time.day == selectedDay)
      }
      console.log("this is filtered for day")
      console.log(this.selectedDay + 2)
      console.log(filterData)

      const scatter = new ScatterplotLayer({
          id: 'scatterplot',
          getFillColor: () => [0, 128, 255],
          getRadius: () => 5,
          getPosition: d => [d.position.lng, d.position.lat],
          opacity: 0.2,
          filled: true,
          pickable: true,
          radiusMinPixels: 5,
          radiusMaxPixels: 30,
          data: filterData,
          onHover : ({object, x, y}) => {
            if (object) {
              const tooltip = `${object.time.date}\n${object.time.start_time} - ${object.time.end_time}`
              this.updateToolTip(tooltip, x, y)
            } else {
              this.$refs.tooltip.style.display = 'none'
            }
          }
        });
        return [scatter]
    },
    isSameDay(value) {
      return value.time.day == this.selectedDay + 2
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

#tooltip {
  background: black;
  position: absolute; 
  z-index: 1; 
  pointer-events: none;
  padding : 5px;
  color : white;
}
</style>
