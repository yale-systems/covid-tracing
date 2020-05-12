import axios from "axios"
import { baseurl } from '@/constants/baseurl.js'

export default {
    async getMarkers() { //for now, this takes no arguments, should take date, center
        // res = await axios.get(callHere);
        var counter = 0;
        var res = Array(0)
        let url = baseurl + 'getrange'

        await axios.get(url, {
            params : {
                range : 10
            }
        })
            .then(function (response) {
                //console.log(response);
                //for thing in data
                for (var item in response.data) {
                    //console.log(item);
                    res.push({position : {lng: response.data[item].latitude, lat: response.data[item].longitude}})
                    counter = counter + 1;
                }
                //store time, positition
            })
            .catch(function (error) {
                // handle error
                console.log(error);
            })
        console.log(res.length);
        return res;
    },

    async insertMarker(jsonReadyObject) {
        let url = baseurl + 'insert'
        await axios.post(url, jsonReadyObject)
            .then( (response) => {
                console.log(response)
            })
            .catch( (error) => {
                console.log(error)
            })
    },

    async expQuery(formInfo) {
        let url = baseurl + 'withinrange'
        var d = new Date(formInfo.date)
        d = encodeURIComponent(d.toISOString())
        let params = {
            longitude : formInfo.ll.lon,
            latitude : formInfo.ll.lat,
            range : 1000,
            start_time : d
        }
        await axios.get(url, {
            params: params
        })
            .then((response) => {
                console.log("apicalls bananas")
                console.log(response)
            })
            .catch((error)=> {
                console.log(error)
            })
    }
}