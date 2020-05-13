import Vue from 'vue'
import VueRouter from 'vue-router'
import InterviewForm from '@/components/InterviewForm'
import MapVisualization from '@/components/MapVisualization'
import ExpTool from '@/components/ExpTool'
import LoginPage from '@/components/LoginPage'

Vue.use(VueRouter)

const router = new VueRouter ({
    routes: [
        {
            path: "/",
            redirect: "/map"
        },
        {
            path: "/form",
            name: "InterviewForm",
            component: InterviewForm
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
            component : LoginPage
        },
        {
            path: "*",
            redirect: "/"
        }
    ]
})
export default router

