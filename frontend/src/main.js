import Vue from 'vue'
import App from './App.vue'
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import 'bootstrap-slider/dist/css/bootstrap-slider.css'
import './css/style.css'
import router from './router'
import VueCookies from 'vue-cookies'
import Vuex from 'vuex'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import 'bootstrap-slider/dist/css/bootstrap-slider.css'
import './css/style.css'
import 'mapbox-gl/dist/mapbox-gl.css'

// Install BootstrapVue
Vue.use(BootstrapVue)
Vue.use(VueCookies)
Vue.use(Vuex)

Vue.config.productionTip = false

const store = new Vuex.Store({
  state : {
    username : '',
    loggedIn : false
  },
  mutations : {
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
