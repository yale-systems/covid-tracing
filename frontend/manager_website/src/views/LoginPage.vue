<template>
  <!-- controlling the size of the container will control the size of the stepper -->
  <v-container fluid class="px-9 login-spacing">
    <v-card>
      <v-container fluid class="pa-5 pt-2">
        <v-card-title>
          Welcome
        </v-card-title>
        <v-card-subtitle>
          Please login
        </v-card-subtitle>
        <v-form ref="form" class="mx-4">
          <v-text-field
            v-model="username"
            label="Username"
            :rules="usernameRules"
            required
          ></v-text-field>

          <v-text-field
            v-model="password"
            label="Password"
            :rules="passwordRules"
            required
            password
          ></v-text-field>

          <v-alert type="error" dense outlined v-if="showAlert">
            The username or password may be incorrect. Please try again.
          </v-alert>
        </v-form>

        <v-card-actions>
          <v-btn :disabled="!valid" color="primary" @click="handleSubmit">
            Submit
          </v-btn>
          <v-btn @click="handleDemo">
            demo login
          </v-btn>
        </v-card-actions>
      </v-container>
    </v-card>
  </v-container>
</template>

<script>

export default {
  name: "LoginPage",
  data() {
    return {
      valid: true,
      username: "",
      password: "",
      usernameRules: [
        v => !/\s/.test(v) || "Username cannot include spaces",
        v => !!v || "Username is required"
      ],
      passwordRules: [v => !!v || "Password is required"],
      showPassword: false,
      showAlert: false,
      usertype: ""
    };
  },
  methods: {
    async handleSubmit() {
      // if the input is valid
      let validate = this.$refs.form.validate();
      if (validate) {
        // make call to API , and if that checks out, send to other page
        let credentials = {
          username: this.username,
          password: this.password
        };
        let curr = this;
        // if it passes, send to welcome screen
        let response = await this.$store.dispatch('managerLogin', credentials)
        if (response) {
          curr.$store.commit("logIn");
          curr.$router.push({ name: "PDash" });
        } else {
          // give feedback that something was wrong
          curr.password = "";
          curr.showAlert = true;
        }
      }
    },
    handleDemo() {
      this.username = "username1";
      this.password = "password";
      this.$nextTick(() => {
        this.handleSubmit();
      });
    }
  }
};
</script>

<style scoped>
.login-spacing {
  max-width: 60%;
  margin-left: 20%;
  margin-right: 10%;
  margin-top: 10%;
}

.button-spacing {
  padding: 2%;
}
</style>
