// TODO: set baseurl for backend here

import axios from 'axios'
import { baseurl } from '@/constants/baseurl.js'
import moment from 'moment';

export default {
    async checkLogin(credentials) {
        const userRegex = /^username[1-3]?[0-9]$/;
        const passwordRegex = /^password$/;
        if (
            credentials.username.match(userRegex) &&
            credentials.password.match(passwordRegex)
        ) {
            const numberRegex = /[1-3]?[0-9]/
            const ID = credentials.username.match(numberRegex);
            console.log(ID);
            const url = baseurl + 'patient/getbypatientid/' + ID[0]
            var res = {};
            await axios.get(url)
                .then(function (response) {
                    console.log(response)
                    res = {
                        login: true,
                        name : response.data.name,
                        links : response.data._links,
                        patient_id: response.data.patient_id
                    }
                })
                .catch(function(error) {
                    console.log(error)
                })
            return res;
        } else {
            return {
                login: false
            };
        }
    },
    async getLocations(url) {
        var res = [];
        await axios.get(url)
            .then(function (response) {
                res = response.data
            })
            .catch(function(error) {
                console.error(error)
            })
        return res
    },

    async deleteLocation(url, id) {
        var res = "";
        var link = url + id.toString()
        await axios.delete(link)
            .then(function(response) {
                if (response.data === id) {
                    res = true
                }
            })
            .catch(function(error) {
                console.error(error)
                res = false
            })
        return res
    },

    async getContacts(url) {
        var contacts = []
        await axios.get(url)
            .then(function(response) {
                contacts = response.data
            })
            .catch(function(error) {
                console.error(error)
            })
        return contacts
    },

    async addLocation(url, event, p_id) {
        let json = {
            "start_time":moment(event.date).toISOString(),
            "end_time":moment(event.date).add(11,'hour').toISOString(),
            "confirmed": false,
            "patient_id": p_id,
        }
        if (Object.keys(event.location.coordinates).length > 0) {
            let ll = [event.location.coordinates.lng, event.location.coordinates.lat]
            json["geom"] = {"type":"Point", "coordinates": ll}
        }

        var res = null
        console.log(json)
        console.log("in apiCalls, making call now")
        await axios.post(url, json)
            .then(function(response) {
                if (response.status === 200) {
                    res = true
                } else {
                    res = false
                }
            })
            .catch(function(error) {
                console.error(error)
                res = false
            })
        return res
    }
};
