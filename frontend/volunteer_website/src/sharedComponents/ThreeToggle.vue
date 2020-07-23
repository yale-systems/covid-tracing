<template>
    <div>
        <v-row>
            <v-btn class="mr-2" color="primary" :depressed="val == 0" :outlined="val != 0" @click="toggle(0)"> {{buttons ? buttons.first : 'Yes'}} </v-btn>
            <v-btn class="mr-2" color="primary" :depressed="val == 1" :outlined="val != 1" @click="toggle(1)"> {{buttons ? buttons.second : 'No'}} </v-btn>
            <v-btn color="primary" :depressed="val == 2" :outlined="val != 2" @click="toggle(2)"> {{buttons ? buttons.third : 'Don\'t have one'}} </v-btn>
        </v-row>
    </div>
</template>

<script>
export default {
    name: 'TFToggle',
    props: {
        value: {
            required: true
        },
        buttons: {
            first: {
                type: String
            },
            second: {
                type: String
            },
            third: {
                type: String
            }
        }
    },
    computed: {
        val: {
            get() {
                return this.value
            },
            set(newVal) {
                this.$emit('input', newVal)
            }
        }
    },
    methods: {
        toggle(newVal) {
            if(this.value == newVal) {
                this.val = undefined
            } else {
                this.val = newVal
            }
        }
    }
}
</script>

<style>

</style>