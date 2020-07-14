<template>
  <div>
    <v-container class="d-flex justify-center align-center my-5">
      <v-sheet elevation="2" class="wide">
        <v-data-table
          :headers="headers"
          :items="contacts"
          hide-default-footer
          item-key="name"
          class="elevation-1"
        ></v-data-table>
        <v-card>hello there</v-card>
      </v-sheet>
    </v-container>
  </div>
</template>

<script>
export default {
  name: "ContactDashboard",
  data: () => {
    return {
      headers: [
        { text: "Name", value: "first_name" },
        { text: "Language", value: "language" },
        { text: "Call Status", value: "callStatus" },
        { text: "Age", value: "age" },
        { text: "Symptomatic", value: "symptomatic" },
        { text: "Assistance", value: "assistance" },
        { text: "Assigned to?", value: "assignedTo" }
      ]
    };
  },
  computed: {
    contacts() {
      return this.$store.getters.contactsAsArray;
    }
  },
  mounted() {
    this.$store.dispatch("loadContacts");
  }
};
</script>

<style></style>
