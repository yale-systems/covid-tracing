import { validationMixin } from 'vuelidate'

export default {
    mixins: [validationMixin],
    methods: {
        /* Note: this entire function is very specific to
            our particular form, which is...rather negative. But, y'know...
            win some lose some? 
        */
        focusFirstStatus(component = this) {
            if ( component.status ) { // we found the problem card!

                var element = component

                //figure out which child is cranky
                if (component.v.name.$error) {
                    element = component.$children[0].$children[0]
                } else if (component.v.email.$error) {
                    element = component.$children[1].$children[0]
                } else if (component.v.phone.$error) {
                    element = component.$children[2].$children[0]
                } else {
                    element = component.$children[3].$children[0]
                }

                //force user to deal with cranky child
                var VueScrollTo = require('vue-scrollto')
                var options = {
                    container: '#scrollme',
                }
                VueScrollTo.scrollTo(element, options)
                console.log(element)
                element.$el.focus()
                return //haha not my problem anymore
            }

            component.$children.some((childComponent) => {
                this.focusFirstStatus(childComponent)
            })
        },
        // wrapper function for validation and feedback in input (makes field red or green)
        // TODO: handle in CSS
        getState(flag, type){
            if (flag) {
                if (type != "") return true
                return null
            } 
            return false
        },
    }
}