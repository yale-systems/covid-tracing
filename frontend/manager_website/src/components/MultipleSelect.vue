<template>
    <v-select
        v-model="val"
        :items="items"
        multiple
        chips
        item-value="key"
        item-text="value"
        class="my-0 py-0"
    >
    </v-select>
</template>

<script>
import enums from '@/constants/enums.js'

export default {
    name: 'MultipleSelect',
    data: () => {
        return {
            items: null
        }
    },
    props: {
        field: String,
        value: Array
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
    },
    mounted() {
        if (this.field == 'languages') {
            this.items = enums.language.asDict
        } else {
            this.items =  enums[this.field].asDict
        }
    }

}
</script>

<style>

</style>