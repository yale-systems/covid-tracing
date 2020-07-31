<template>
    <div class="ugly"> 
        <v-btn
            v-if="!loginPage() && !drawer" 
            :class="{'mt-4': true, 'mr-4': true, 'ugly-open': !drawer, 'ugly-closed': drawer}" 
            color="primary"
            dark
            @click="drawer = !drawer"
            ><v-icon large>mdi-menu</v-icon>
        </v-btn>

        <v-navigation-drawer
        v-model="drawer"
        right
        absolute
        temporary
        >
        <v-list-item>
            <v-list-item-avatar>
            <v-icon large>mdi-jellyfish</v-icon>
            </v-list-item-avatar>

            <v-list-item-content>
            <v-list-item-title>{{username}}</v-list-item-title>
            <v-list-item-subtitle>Logged In </v-list-item-subtitle>
            </v-list-item-content>
        </v-list-item>

        <v-divider></v-divider>

        <v-list dense>

            <v-list-item
            v-for="item in items"
            :key="item.title"
            link
            @click="selectItemFunction(item.function)"
            >
            <v-list-item-icon>
                <v-icon>{{item.icon}}</v-icon>
            </v-list-item-icon>

            <v-list-item-content>
                <v-list-item-title>{{ item.title }}</v-list-item-title>
            </v-list-item-content>
            </v-list-item>
        </v-list>
        </v-navigation-drawer>
    </div>
</template>

<script>
export default {
    name: "Hamburger",
    data: () => {
    return {
      drawer: null,
      items: [
        { title: 'Notify Contacts', icon: 'mdi-phone', function: 1 },
        // { title: 'Self-Assign Contacts', icon: 'mdi-account-multiple-plus', function: 2 },
        { title: 'Profile', icon: 'mdi-account-circle', function: 3},
        { title: 'Logout', icon: 'mdi-exit-to-app', function: 4},
      ],
    };
  },
  computed: {
      username() {
      return "Username"
    },
 },
  methods: {
      selectItemFunction(i){
      if (i == 1 && this.$router.currentRoute.path != "/dashboard")  { //notify contacts
        this.$router.push({ path: "/dashboard" });
      } else if (i == 2) { //assign more contacts
        alert("sorry fam we haven't supported that yet")
      } else if (i == 3 && this.$router.currentRoute.path != "/profile") { //go to profile
        this.$router.push({ path: "/profile" });
      } else if (i == 4 && this.$router.currentRoute.path != "/login") { //logout
        this.$store.dispatch('logOut')
        this.$router.push({path: "/login"})
      }
      this.drawer = false
    },
    loginPage() {
      if(this.$route.path == "/" || this.$route.path == "/login" ) {
        return true
      } else {
        return false
      }
    }
  }
}
</script>

<style scoped> 
.hamburger-position {
  position: -webkit-sticky; /* Safari */
  position: sticky;
  top: 0%;
  left: 100%;
  
}
.ugly-closed {
    width: 100px;
    float: right;
}
.ugly-open {
    width: 75px;
    right: 0;
    position: absolute;
    z-index: 100
}
</style>

