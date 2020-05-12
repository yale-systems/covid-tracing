<template>
    <div> 
        <br>
        <h3 class="title">Timeline</h3>
        <b-container> 
          <vue-slider :adsorb="true" :max="14" 
            :marks="marks" :process="false" :height="8" :tooltip-style="{ backgroundColor: '#007BFE'}" 
            :dot-style="{ backgroundColor: '#007BFE'}" :value = 7 v-model= "value"></vue-slider> 
        </b-container>
        <br>
        <br>
        <b-container fluid>
          <ExposureMap class="exposure-map" :markers="markers" :mapCenter="mapCenter" /> 
        </b-container>
    </div>
</template>

<script> 
import ExposureMap from "./ExposureMap";
import VueSlider from 'vue-slider-component'
import 'vue-slider-component/theme/default.css'
import apiCalls from '@/apiCalls.js'

export default {
  name: 'MapVisualization',
  components: {
    ExposureMap, 
    VueSlider
  }, 
  data() {
    return {
      value: 7,
      marks: { '0': "Two Weeks Ago", '1' : "", '2' : "",
          '3' : "", '4' : "", '5' : "", '6' : "",
          '7': "One Week Ago", '8' : "", '9' : "", '10' : "",
          '11' : "", '12' : "", '13' : "", '14': "Today"
      }, 
      markers: [], 
      mapCenter: {lat: 41.309177, lng: -72.928562}
    }
  }, 

  async mounted() {
      await this.loadData(); 
  },

  watch: {
    value: async function() {
      await this.loadData();
    }
  },

  methods: {
    async loadData () {
      var curr = this;
      apiCalls.getMarkers()
        .then( function (response) {
            curr.$set(curr, "mapCenter", response[0].position);
            curr.$set(curr, "markers", response);
            console.log(response[0]);
        });
    }
  }
}
</script> 

<style lang="scss" scoped>

  .title {
    font-weight: bold;
    padding-left: 30px;

  }
  
  .exposure-map {
    height : 600px;
  }
</style>

