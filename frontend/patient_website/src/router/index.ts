import Vue from "vue";
import VueRouter, { RouteConfig } from "vue-router";
import LoginPage from "../views/LoginPage.vue";
import Welcome from "../views/Welcome.vue";
import InterviewFormView from "../views/InterviewFormView.vue";
import SubmitPage from "../views/SubmitPage.vue";
import PreForm from "../views/PreForm.vue";

Vue.use(VueRouter);

const routes: Array<RouteConfig> = [
    {
        path: "/",
        component: LoginPage
    },
    {
        path: "/login",
        name: "login",
        component: LoginPage
    },
    {
        path : "/welcome",
        name: "welcome",
        component : Welcome
    },
    {
        path : "/form",
        name : "form",
        component : InterviewFormView
    },
    {
        path : "/setup",
        name : "setup",
        component : PreForm
    },
    {
        path : "/submitted",
        name : "submitted",
        component : SubmitPage
    }
];

const router = new VueRouter({
    mode: "history",
    base: process.env.BASE_URL,
    routes
});

export default router;
