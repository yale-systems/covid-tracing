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
        if(coordinates.lng == 0, coordinates.lat == 0) {
            return undefined
        }
        return new Promise ((resolve, reject) => {
            geocoder.geocode({'location': coordinates}, function(results, status) {
                if (status === 'OK') {
                    if (results[0]) {
                        streetName = results[0].formatted_address
                        resolve(streetName)
                    } else {
                        // window.alert('No results found');
                        console.error('no results found for ', coordinates)
                        resolve('')
                    }
                } else {
                    // window.alert('Geocoder failed due to: ' + status);
                    console.error(status, "with coordinates ", coordinates)
                    reject(new Error(status))
                }
            });
        });
    }
}