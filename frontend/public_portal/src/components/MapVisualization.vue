<template>
    <div> 
        <b-container fluid> 
          <br>
          <h3 class="large">Map and Timeline</h3>
          <hr class="line">
          <br>
        </b-container>
        <b-container class="slide">
          <vue-slider :adsorb="true" :max="6" 
                :marks="marks" :process="false" :height="8" :tooltip-style="{ backgroundColor: '#1B3A71'}" 
                :dot-style="{ backgroundColor: '#1B3A71'}" v-model="value"></vue-slider> 
          <br>
          <ExposureMap class="exposure-map large-padding" :markers="markers" :mapCenter="mapCenter" :selectedDay="value"/> 
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
      value: 4,
      // marks: { '0': "Two Weeks Ago", '1' : "", '2' : "",
      //     '3' : "", '4' : "", '5' : "", '6' : "",
      //     '7': "One Week Ago", '8' : "", '9' : "", '10' : "",
      //     '11' : "", '12' : "", '13' : "", '14': "Today"
      // }, 
      marks : { '0' : 'Sat Feb 02', 
                '1' : 'Sun Feb 03', 
                '2' : 'Mon Feb 04', 
                '3' : 'Tue Feb 05', 
                '4' : 'Wed Feb 06', 
                '5' : 'Thu Feb 07', 
                '6' : 'Fri Feb 08' },
      markers: [], 
      mapCenter: {lat: 41.309177, lng: -72.928562}
    }
  }, 
  async mounted() {
      await this.loadData(); 
  },
  watch: {
    value: async function() {
      // await this.loadData();
    }
  },
  methods: {
    async loadData () {
      var curr = this;
      apiCalls.getMarkers()
        .then( function (response) {
            curr.$set(curr, "mapCenter", response[0].position);
            for (var e in response) {
              // make the start and time more human readable
              var readable = new Date(response[e].time.start_time)
              readable = readable.toString()
              response[e].time.date = readable.substring(0, 15)
              response[e].time.start_time = response[e].time.start_time.substring(11, 19)
              response[e].time.end_time = response[e].time.end_time.substring(11, 19)
              response[e].time.day = parseInt(readable.substring(9, 10))
            }
            console.log(response[0])
            curr.$set(curr, "markers", response);
        });
    }
  }
}
</script> 

<style lang="scss" scoped>
  .slide {
    padding-right: 5%;
    padding-left: 5%;
  }
  .title {
    padding-left: 30px;
  }
  .exposure-map {
    height : 600px;
    padding-top : 10px;
  }
</style>