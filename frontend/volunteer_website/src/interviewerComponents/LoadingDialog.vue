<template> 
    <v-dialog
            v-model="value"
            width = "700px"
        >
        <v-card>
            <v-card-title text-align="center"> Your data is being submitted... </v-card-title>
            <v-progress-circular
                :size="50"
                color="primary"
                indeterminate
                class="ma-5 justify-center align-center"
            ></v-progress-circular>
        </v-card>
    </v-dialog>
</template>

<script>

export default {
    name: "LoadingDialog",
    props: {
        value: {
            required: true,
            Boolean
        },
    },
    computed: {
        val: {
            get() {
                return this.value
            },
            set(newVal) {
                this.val = newVal
            }
        }
    }
}
</script>