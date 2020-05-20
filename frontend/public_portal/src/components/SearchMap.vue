<template>
    <GoogleMapLoader :mapCenter="mapCenter">
        <template slot-scope="{google, map}">
            <!-- slot-scope enables SearchBar to insert itself on the map  -->
            <SearchBar 
                :google ="google"
                :map ="map"
                v-model="value"
            />
        </template>
    </GoogleMapLoader>
</template>

<script>
import GoogleMapLoader from './GoogleMapLoader'
import SearchBar from './SearchBar'

export default {
    name: 'SearchMap',

    components: {
        GoogleMapLoader,
        SearchBar
    },

    props : {
        mapCenter : {
            type: Object, 
            //TODO: replace this with user location. Currently centers on New Haven.
            //TODO: have a list of lat/lon for major cities and use those variable names
            default: function() { 
                return {lat: 41.309177, lng: -72.928562}
            }
        },
        // value is v-bound to address from parent (InterviewCard)
        // address is of form (location: string, latlon: {lat: lon:})
        value : {
            type: Object,
            required : true
        }
    }
}
</script>

