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
                console.log(response);
                //for thing in data
                for (var item in response.data) {
                    //console.log(item);
                    res.push({position : {lng: response.data[item].geom.coordinates[0], lat: response.data[item].geom.coordinates[1]}})
                    counter = counter + 1;
                }
                //store time, positition
            })
            .catch(function (error) {
                // handle error
                console.log(error);
            })
        console.log(res);
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
        console.log(formInfo.ll)
        // var d = formInfo.date + "T01:00:00.000Z"
        // console.log(formInfo.date)
        // var d = new Date(formInfo.date)
        // d = d.toISOString()
        // let params = {
        //     longitude : formInfo.ll.lng,
        //     latitude : formInfo.ll.lat,
        //     range : 10000,
        //     start_time : d
        // }
        let params = {
            start_time: "2020-05-03T00:00:00.000Z",
            longitude: 116.7193,
            latitude: 40.13087,
            range : 1
        }

        var exposed=false;
        await axios.get(url, {
            params: params
        })
            .then((response) => {
                console.log("apicalls bananas")
                console.log(response)
                if(response.data.length > 0) {
                    exposed = true;
                }
            })
            .catch((error)=> {
                console.log(error)
            })
        return exposed;
    }
}