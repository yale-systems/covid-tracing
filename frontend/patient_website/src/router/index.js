import Vue from "vue";
import VueRouter, { RouteConfig } from "vue-router";
import LoginPage from "@/views/LoginPage.vue";
import Welcome from "@/views/Welcome.vue";
import SubmitPage from "@/views/SubmitPage.vue";
import CompleteForm from "@/views/CompleteForm.vue";
import Resources from "@/views/Resources.vue";

Vue.use(VueRouter);

const routes = [
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
        path : "/submitted",
        name : "submitted",
        component : SubmitPage
    },
    {
        path: "/completeform",
        name: "completeForm",
        component: CompleteForm
    },
    {
        path: "/completeform/:step",
        name: "completeFormParams",
        component: CompleteForm
    },
    {
        path: "/resources",
        name: "resources",
        component: Resources
    }
];

const router = new VueRouter({
    mode: "history",
    base: process.env.BASE_URL,
    routes
});

export default router;
