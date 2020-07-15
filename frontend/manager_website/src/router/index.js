import Vue from "vue";
import VueRouter from "vue-router";
import LoginPage from "../views/LoginPage.vue";
import PatientDashboard from "../views/PatientDashboard.vue";
import ContactDashboard from "../views/ContactDashboard.vue";
import VolunteerDashboard from "../views/VolunteerDashboard.vue";
import Reassign from "../views/Reassign.vue";
import AddCases from "../views/AddCases.vue"
import Test from "../views/tester.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Login",
    component: LoginPage
  },
  {
    path: "/pdash",
    name: "PDash",
    component: PatientDashboard
  },
  {
    path: "/cdash",
    name: "CDash",
    component: ContactDashboard
  },
  {
    path: "/vdash",
    name: "VDash",
    component: VolunteerDashboard
  },
  {
    path: "/reassign",
    name: "reassign",
    component: Reassign
  },
  {
    path: "/add",
    name: "add",
    component: AddCases
  },
  {
    path: "/tester",
    name: "test",
    component: Test
  },
  {
    path: "*",
    component: LoginPage
  }
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes
});

export default router;
