import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import BootstrapVue from "bootstrap-vue";
import VueCookies from "vue-cookies";
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap-vue/dist/bootstrap-vue.css";
import "bootstrap-slider/dist/css/bootstrap-slider.css";
import "./css/style.css";

Vue.config.productionTip = false;

Vue.use(BootstrapVue)
Vue.use(VueCookies)

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount("#app");


