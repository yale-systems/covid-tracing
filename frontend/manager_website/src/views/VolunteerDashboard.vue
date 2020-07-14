<template>
  <div>
    <v-container class="d-flex justify-center align-center my-5">
      <v-sheet elevation="2" class="wide">
        <v-data-table
          :headers="headers"
          :items="volunteers"
          hide-default-footer
          item-key="name"
          class="elevation-1"
        ></v-data-table>
      </v-sheet>
    </v-container>
  </div>
</template>

<script>
export default {
  name: "VolunteerDashboard",
  data: () => {
    return {
      headers: [
        { text: "Name", value: "first_name" },
        { text: "Languages", value: "languages" },
        { text: "Remaining Capacity", value: "remainingCapacity" },
        { text: "Current Cases", value: "current" },
        { text: "Completed Cases", value: "completed" }
      ]
    };
  },
  computed: {
    volunteers() {
      return this.$store.getters.volunteersAsArray;
    }
  },
  mounted() {
    this.$store.dispatch("loadVolunteers");
  }
};
</script>

<style></style>
