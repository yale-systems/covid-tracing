import Vue from "vue";
import VueRouter from "vue-router";
import LoginPage from "@/views/LoginPage.vue";
import Dashboard from "@/views/Dashboard.vue";
import Profile from "@/views/Profile.vue";
import PatientDash from "@/views/PatientDash.vue"
import InterviewFormView from "@/views/InterviewFormView"

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    component: LoginPage
  },
  {
    path: "/login",
    name: "Login",
    component: LoginPage
  },
  {
    path: "/dashboard",
    name: "Dashboard",
    component: Dashboard
  },
  {
    path: "/profile",
    name: "Profile",
    component: Profile
  },
  {
    path: "/pdash",
    name: "PDash",
    component: PatientDash
  },
  {
    path: "/form/:id",
    name: "Form",
    component: InterviewFormView
  }
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes
});

export default router;
