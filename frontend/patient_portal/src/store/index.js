import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

/*
Creating a Vuex Store. 
State: holds username and whether or not you're logged in. 
Mutations: methods that modify state
*/
const store = new Vuex.Store({
  //state is the key, {username, loggedIn} is the value
  state: {
    username: '', //username is the key, '' is the value
    loggedIn: false
  },
  mutations: {
    setUser(state, name) {
      state.username = name
      state.loggedIn = true
    },
    logout(state) {
      state.username = ""
      state.loggedIn = false
    }
  }
})

export default store