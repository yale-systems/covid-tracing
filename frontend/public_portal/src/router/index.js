import Vue from 'vue'
import VueRouter from 'vue-router'
import MapVisualization from '@/components/MapVisualization'
import ExpTool from '@/components/ExpTool'
import LoginPage from '@/components/LoginPage'
import Profile from '@/components/Profile'

Vue.use(VueRouter)

const router = new VueRouter ({
    routes: [
        {
            path: "/",
            redirect: "/map"
        },
        {
            path: "/map",
            name: "MapVisualization",
            component: MapVisualization
        },
        {
            path: "/tool",
            name: "ExposureTool",
            component : ExpTool
        },
        {
            path: "/login",
            name: "LoginPage",
            component: LoginPage
        },
        {
            path: "/profile",
            name: "Profile",
            component: Profile
        },
        {
            path: "*",
            redirect: "/"
        }
    ]
})
export default router

