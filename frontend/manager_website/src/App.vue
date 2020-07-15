<template>
  	<v-app>
		<v-app-bar app color="primary" dark class="pa-0">
			<v-toolbar-title>
				Organization Name
			</v-toolbar-title>
			<v-spacer></v-spacer>
			<v-toolbar-items v-if="loggedIn">
				<v-tabs class="d-flex align-center" background-color="primary">
					<v-tab to="/pdash"> Cases </v-tab>
					<v-tab to="/cdash"> Contacts </v-tab>
					<v-tab to="/vdash"> Volunteers </v-tab>
				</v-tabs>
				<v-btn icon>
					<v-icon @click="logout"> mdi-logout </v-icon>
				</v-btn>
			</v-toolbar-items>
		</v-app-bar>

		<v-main>
			<router-view class="pt-0"></router-view>
		</v-main>
  	</v-app>
</template>

<script>
export default {
	name: "App",
	computed: {
		loggedIn() {
			return this.$store.state.loggedIn;
		}
		// org() {
		//   return this.$store.state.org;
		// }
	},
	methods: {
		loginPage() {
			if (this.$route.path == "/" || this.$route.path == "/login") {
				return true;
			} else {
				return false;
			}
		},
		logout() {
			this.$store.commit('logOut');
			this.$router.push({name: 'Login' })
		}
	}
};
</script>
