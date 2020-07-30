<template>
    <div v-if="label">
        <v-row class="mt-2 pl-10">
            <p class="mt-2 mr-4" style="width:300px;"> {{label}} </p>
            <v-btn class="mr-2" color="primary" :depressed="val" :outlined="val != true" @click="toggle(true)"> Yes </v-btn>
            <v-btn color="primary" :depressed="val == false" :outlined="val != false" @click="toggle(false)"> No </v-btn>
        </v-row>
    </div>
    <div v-else>
        <v-row>
            <v-btn class="mr-2" color="primary" :depressed="val" :outlined="val != true" @click="toggle(true)"> Yes </v-btn>
            <v-btn color="primary" :depressed="val == false" :outlined="val != false" @click="toggle(false)"> No </v-btn>
        </v-row>
    </div>
</template>

<script>
export default {
    name: 'TFToggle',
    props: {
        label: {
            type: String,
            required: false
        },
        value: {
            required: true
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