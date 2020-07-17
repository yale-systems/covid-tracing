<template>
    <v-select
        :label="label"
        :items="items"
        :item-value="(item) => parseInt(item.key)"
        :item-text="(item) => item.value"
        v-model="val">
    </v-select>
</template>

<script>
import enums from "@/constants/enums"

export default {
    name: "Selector",
    props: {
        field: String,
        value: Number 
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
        items() {
            return enums[this.field].asDict
        },
        label() {
            switch (this.field) {
                case 'contact_type': 
                    return "Type of Contact"
                case 'age_group':
                    return "Age"
                case 'self_isolate':
                    return "Able to self isolate?"
                case 'preexisting_conditions':
                    return "Preexisting conditions"
                case 'employment':
                    return "Employment Status"
                case 'insurance':
                    return "Insurance Status"
                case 'assistance':
                    return 'Assistance Requested'
                case 'reason_flagged':
                    return 'Reason for Prioritizing'
                default:
                    return this.field.charAt(0).toUpperCase() + this.field.slice(1);
            }
        },
    }

}
</script>

<style>

</style>