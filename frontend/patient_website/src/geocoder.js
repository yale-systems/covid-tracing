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

    async getStreetName (coordinates, geocoder) {
        var streetName = 'loading...'
        if(coordinates[0] == 0, coordinates[1] == 0) {
            return 'undefined location'
        }
        return new Promise ((resolve, reject) => {
            geocoder.geocode({'location': coordinates}, function(results, status) {
                if (status === 'OK') {
                    if (results[0]) {
                        streetName = results[0].formatted_address
                        resolve(streetName)
                    } else {
                        // window.alert('No results found');
                        resolve('')
                    }
                } else {
                    // window.alert('Geocoder failed due to: ' + status);
                    reject(new Error(status))
                }
            });
        });
    }
}