// TODO: set baseurl for backend here

import axios from 'axios'
import { baseurl } from '@/constants/baseurl.js'

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
                        links : response.data._links
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
                // console.log("getLocation")
                // console.log(response.data)
                res = response.data
            })
            .catch(function(error) {
                console.log(error)
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
                console.log(error)
            })
        return contacts
    }
};
