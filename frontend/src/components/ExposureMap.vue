<template>
    <GoogleMapLoader v-bind:mapCenter = "mapCenter" :clickEnabled = "clickEnabled">

    <template slot-scope = "{google, map}">
        <MapMarker
            v-for="marker in oldMarkers"
            :key ="marker.position.lat"
            :marker ="marker"
            :google ="google"
            :map ="map"
            :show="keepMarkers"
        />
    </template> 

    </GoogleMapLoader>
</template>

<script>
import GoogleMapLoader from "./GoogleMapLoader"
import MapMarker from "./MapMarker"

export default {
    name: "ExposureMap",
    components : {
        GoogleMapLoader, 
        MapMarker
    }, 

    props : {
        markers: {
            type: Array,
            default: function (){
                return []
            }
        },
        mapCenter: {
            type: Object, 
            default: function() {
                return {lat: 41.309177, lng: -72.928562}
            }
        }, 
        clickEnabled:  {
            type: Boolean,
            default: false
        }
    }, 

    data: function() {
        return {
            keepMarkers : true,
            oldMarkers: []
        }
    },

    watch : {
        markers : function() {
            console.log("setting this to false")
            // first we want to delete all prev markers 
            this.keepMarkers = false
            setTimeout(() => {this.keepMarkers = true; this.oldMarkers = this.markers; console.log("changing new markers")}, 1 )
        }
    }
}
</script>