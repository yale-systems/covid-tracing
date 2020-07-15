<template>
    <v-text-field
        v-model="val"
        single-line
        autofocus
        
        :rules="rules"
    >
    </v-text-field>
</template>

<script>
import allRules from '@/constants/rules.js'

export default {
    name: 'TextField',
    data: () => {
        return {
                nameRules: [
                    v => !!v || 'Name is required',
                    v => (v && v.length <= 10) || 'Name must be less than 10 characters',
                ],
        }
    },
    props: {
        field: String,
        value: String
    },
    computed: {
        val: {
            get() {
                return this.value
            },
            set(newVal) {
                this.$emit('input', newVal)
            }
        },
        rules() {
            console.log(this.field)
            switch (this.field) {
                case 'first_name':
                    return [ allRules.required, allRules.nameChars, allRules.makeLength(50)]
                case 'last_name': 
                    return [allRules.required, allRules.nameChars, allRules.makeLength(50)]
                case 'shelter':
                    return [allRules.textarea, allRules.makeLength(50)]
                case 'notes':
                    return [allRules.textarea, allRules.makeLength(500)]
            }
        },
        otherRules() {
            return allRules
        }
    }
}
</script>

<style>

</style>