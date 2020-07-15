<template>
    <v-dialog
        v-model="value"
        width = "700px"
    >
        <v-card>
            <v-btn icon
                    right
                    top
                    absolute @click="$emit('close')">
                <v-icon> mdi-close </v-icon>
            </v-btn>
            
            <v-row class="pt-8 pb-8 pr-7 pl-7">
                <v-col class="d-flex align-center" cols ="1">
                    <v-icon color="error"
                        large
                        >
                        mdi-alert
                    </v-icon>
                </v-col>
                <v-col class="d-flex align-center pt-8">
                    <p class="large"> There was an error submitting 
                        your data. Please close and try to submit again.  </p>
                </v-col>
            </v-row>
        </v-card>
    </v-dialog>
</template>

<script>
export default {
    name: "ErrorDialog",
    props: {
        value: {
            required: true,
            Boolean
        }
    }
}
</script>

<style scoped>
.large {
    font-size: x-large;
}
</style>