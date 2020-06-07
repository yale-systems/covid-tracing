import { validationMixin } from 'vuelidate'

export default {
    mixins: [validationMixin],
    // methods: {
    //     focusFirstStatus(validation) {

    //         // const form = this

    //         // //for each event, let's do this
    //         // form.$children.some((event) => {
    //         //     //if the event has an error, we've found!
    //         //     if (event.status) {
    //         //         scrollToProblem(event)
    //         //     }
    //         // })
    //         // if ( component.status ) { // we found the problem card!

    //         //     var element = component

    //         //     //force user to deal with cranky child
    //         //     var VueScrollTo = require('vue-scrollto')
    //         //     var options = {
    //         //         container: '#scrollme',
    //         //     }
    //         //     VueScrollTo.scrollTo(element, options)
    //         //     console.log(element)
    //         //     element.$el.focus()
    //         //     return //haha not my problem anymore
    //         // }

    //         // component.$children.some((childComponent) => {
    //         //     this.focusFirstStatus(childComponent)
    //         // })
    //     },
    // }
}