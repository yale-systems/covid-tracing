<template>
    <div>
        <MultipleSelect
        v-model="preexisting_conditions"
        field="preexisting_conditions"
        />
    </div>
</template>

<script>
import allGetters from '@/constants/methods.js'
import MultipleSelect from '@/components/MultipleSelect.vue';

export default {
    name: "Test",
    mixins: [allGetters],
    components: {
        MultipleSelect
    },
    data: () => {
        return {
            preexisting_conditions: ["0"]
        }
    }
}
</script>

<style>

</style>