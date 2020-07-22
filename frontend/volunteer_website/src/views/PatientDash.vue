<template>
    <div>
        <v-app-bar flat color="#e8f5ff" class="sticky shadow">
            <v-row class="d-flex" align="center">
                <v-col cols="4"> 
                    <b class="large">Oasis Interviewer Portal</b>
                </v-col>
                <v-spacer></v-spacer>
                <v-btn text @click="logout">Log Out</v-btn>
            </v-row>
        </v-app-bar>
        <v-container>
        <v-row class="mt-5">
            <h1> Patients to Contact</h1>
        </v-row>
        <v-row class="mb-5">
            <v-spacer></v-spacer>
            <v-btn color="primary" outlined>
                get more patients
            </v-btn>
        </v-row>
        <v-row>
            <PatientTable />
        </v-row>
        </v-container>
    </div>
</template>

<script>
import PatientTable from '@/interviewerComponents/PatientTable';

export default {
    name: 'PatientDash',
    components: {
        PatientTable
    },
    methods: {
        logout() {
            this.$store.commit('logOut')
            this.$router.push({name: 'Login'})
        }
    }

}
</script>

<style scoped>
.large{
    font-size: 25px;
}

.shadow {
    box-shadow: 0px 0px 8px rgba(0, 0, 0, .5);
    z-index: 10;
}
</style>