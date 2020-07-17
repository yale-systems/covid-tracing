<template>     
    <v-item-group v-model="patientNum" class="mt-2">
    <v-row class="pb-0">
        <v-item class="ml-7" v-slot:default="{ active, toggle }"> 
            <v-sheet @click="toggle()"
                class="customStepper my-0"
                
                :elevation="active ? 4 : 1"
                :color="active ? '#f0ebf7' : 'white'">  
                    <div class="customStepperText ml-2"> Patient Information </div>
            </v-sheet>
        </v-item>
    </v-row>
    </v-item-group>
</template>

<script>
export default {
    name: "AddPatientSidebar",
    props: {
        value: {
            Number,
            required: true
        }
    },
    computed: {
        patientNum: {
            get() {
                return this.value
            },
            set(newVal) {
                if(newVal != undefined) {
                    this.$emit('input', newVal)
                } else {
                    this.$nextTick(() => { this.$emit('input', this.value) } )
                }
            }
        }
    },
}
</script>

<style>
.customStepperText {
    color: #520078;
    font-weight: 500;
    font-size: large;
}

.customStepper{
    height: 50px;
    width: 100%;
    display: flex;
    justify-content: left;
    align-items: center;
    padding: 10px;
    margin: 5px;
    box-shadow: 0 0 0 .5pt #520078;
    transition-property: background-color;
    transition-duration: .4s;
}
.customStepper:hover{
    cursor: pointer;
}
.separated {
    border-right: 1px solid #E2E2E2;
}
</style>