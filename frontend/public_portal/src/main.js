import Vue from 'vue'
import App from './App.vue'
import BootstrapVue from 'bootstrap-vue'
import router from './router'
import VueCookies from 'vue-cookies'
import Vuex from 'vuex'
import 'mapbox-gl/dist/mapbox-gl.css'

// Install BootstrapVue
Vue.use(BootstrapVue)
Vue.use(VueCookies)
Vue.use(Vuex)

Vue.config.productionTip = false
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

new Vue({
  el: '#app',
  router, 
  store: store,
  components: {App},
  render: h => h(App),
}).$mount('#app')
