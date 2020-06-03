// TODO: set baseurl for backend here

// import axios from 'axios'
// import { baseurl } from '@/constants/baseurl.ts'

export default {
    async checkLogin(credentials) {
        if (credentials.username == "username" && credentials.password == "password") {
            return true
        } else {
            return false
        }
    }
}
