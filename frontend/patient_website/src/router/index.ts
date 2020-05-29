import Vue from "vue";
import VueRouter, { RouteConfig } from "vue-router";
import LoginPage from "../views/LoginPage.vue";
import Welcome from "../views/Welcome.vue";
import InterviewFormView from "../views/InterviewFormView.vue";
import SubmitPage from "../views/SubmitPage.vue";

Vue.use(VueRouter);

const routes: Array<RouteConfig> = [
    {
        path: "/",
        name: "LoginPage",
        component: LoginPage
    },
    {
        path : "/welcome",
        name: "Welcome",
        component : Welcome
    },
    {
        path : "/form",
        name : "InterviewForm",
        component : InterviewFormView
    },
    {
        path : "/submitted",
        name : "SubmitPage",
        component : SubmitPage
    }
];

const router = new VueRouter({
    mode: "history",
    base: process.env.BASE_URL,
    routes
});

export default router;
