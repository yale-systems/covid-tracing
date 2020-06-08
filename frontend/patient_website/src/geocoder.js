import GoogleMapsApiLoader from 'google-maps-api-loader'
import { apiKey } from "@/constants/apiKey"
import throttle from 'lodash.throttle'

function getStreetNameHelper(coordinates, geocoder) {
    var streetName = ''
    geocoder.geocode({'location': coordinates}, function(results, status) {
        if (status === 'OK') {
            if (results[0]) {
                streetName = results[0].formatted_address
                console.log(streetName)
            } else {
                window.alert('No results found');
            }
        } else {
            window.alert('Geocoder failed due to: ' + status);
        }
    });
    return streetName;
}

export default {
    // coordinates need to be in form 
    // {lat: -34, lng: 151}
    async getGeocoder() {
        const google = await GoogleMapsApiLoader({
            libraries: ['places'],
            apiKey: apiKey
        })
        const geocoder  = new google.maps.Geocoder
        console.log("this is the geocoder in geocoder.js")
        console.log(geocoder)
        return geocoder
    },
    async getStreetNameHelper(coordinates, geocoder) {
        var streetName = 'dogs'
        await geocoder.geocode({'location': coordinates}, function(results, status) {
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
            console.log(streetName)
            // return streetName;
        });
        // while(streetName == 'dogs') {
        //     console.log("still waiting")
        // }
        // console.log(streetName)
        return streetName;
    },
    async getStreetName(coordinates, geocoder) {
        var streetName = 'cats'
        await this.getStreetNameHelper(coordinates, geocoder)
            .then(function(response) {
                console.log(response)
                streetName = response
            })
            .catch(function(error) {
                console.log(error)
            })
        return streetName
    }
}