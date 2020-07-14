import GoogleMapsApiLoader from 'google-maps-api-loader'
import { apiKey } from "@/constants/apiKey"

export default {
    // coordinates need to be in form 
    // {lat: -34, lng: 151}
    async getGeocoder() {
        const google = await GoogleMapsApiLoader({
            libraries: ['places'],
            apiKey: apiKey
        })
        const geocoder  = new google.maps.Geocoder
        return geocoder
    },

    getStreetName (coordinates, geocoder, callback) {
        var streetName = 'loading...'
        geocoder.geocode({'location': coordinates}, function(results, status) {
            if (status === 'OK') {
                if (results[0]) {
                    streetName = results[0].formatted_address
                    console.log(streetName)
                } else {
                    window.alert('No results found');
                    streetName = ''
                }
            } else {
                window.alert('Geocoder failed due to: ' + status);
                streetName = ''
            }
            callback(streetName);
        });
    }
}