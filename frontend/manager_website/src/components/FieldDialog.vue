<template>
  <v-dialog 
    v-model="value"
    v-on:input="$emit('input', $event)"
    max-width="600px">
      <v-card>
        <v-container fluid>
          <v-card-title class="headline">Add Fields</v-card-title>
        <v-card-text class="px-8">
            <v-switch v-for="(value, index) of selectedFields" 
                v-model="selectedFields[index]" 
                :label="allPatientFields[index].text"
                :value="value"
                :key="allPatientFields[index].value"
                :disabled="allPatientFields[index].text == 'Name'"
                ></v-switch>
        </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
  
            <v-btn
              text
              @click="save"
            >
              Save
            </v-btn>
          </v-card-actions>
        </v-container>
      </v-card>
  </v-dialog>
</template>

<script>
const clone = require('lodash/clone');

export default {
    name: "FieldDialog",
    props: {
        value: {
            Boolean,
            required: true
        }
    },
    data: () => {
        return {
        }
    },
    computed: {
        allPatientFields() {
            return clone(this.$store.state.view.allPatientFields)
        },
        selectedFields() {
            return clone(this.$store.state.view.selectedPatientFields)
        }
    },
    methods: {
        save() {
            this.$store.commit('updatePatientFields', this.selectedFields)
            this.$emit('input', false)
        }
    }
}
</script>

<style scoped>

</style>