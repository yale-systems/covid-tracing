<template>
  <div>
    <div class="google-map" ref="googleMap"></div>
    <template v-if="Boolean(this.google) && Boolean(this.map)">
        <slot
            :google="google"
            :map="map"
            :geocoder="geocoder"
        />
    </template>
  </div>
</template>

<script>
//loads api
import GoogleMapsApiLoader from 'google-maps-api-loader'
import { mapSettings } from "./mapSettings"
import { apiKey } from "@/constants/apiKey"
export default {
    name: "GoogleMapLoader",
    props: { // parent provides these to initializer
        mapCenter: Object,
    }, 
    data() {
        return {
            google: null,
            map: null,
            geocoder: null
        }
    },
    computed: {
        mapConfig () {
            return {
                ...mapSettings,
                center: this.mapCenter
            }
        }
    }, 
    watch: {
        mapCenter: function() {
            // do something, do in fact want to change center
            this.map.setCenter(this.mapCenter);
        }
    },
    async mounted() {
        const googleMapApi = await GoogleMapsApiLoader({
            libraries: ['places'],
            apiKey: apiKey
        })
        this.google = googleMapApi
        this.initializeMap()
        this.initializeGeocoder()
    },
    methods: {
        initializeMap() {
            const mapContainer = this.$refs.googleMap
            this.map = new this.google.maps.Map(mapContainer, this.mapConfig)
        },
        initializeGeocoder() {
            this.geocoder  = new this.google.maps.Geocoder
        }
    }
}
</script>

<style scoped>
.google-map {
    width: 100%,;
    min-height: 100%;
}
</style>