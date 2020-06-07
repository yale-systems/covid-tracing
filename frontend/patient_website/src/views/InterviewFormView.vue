<template>
    <div>
        <h1 class="ma-4"> Interview Form </h1>
        <!-- <v-btn icon color="blue" class="ma-5" id="call">
            <v-icon x-large>mdi-chat</v-icon>
        </v-btn> -->

        <v-dialog
            v-model="helpOpen"
            width="700"
        >
            <template v-slot:activator="{ on }">
                <v-btn color="primary" outlined class="ma-4" id="phone" width="90px" v-on="on">
                    Help
                </v-btn>
            </template>
            
            <v-card>
                <v-card-title>
                    Need help?
                    <v-spacer></v-spacer>
                    <v-btn icon @click="helpOpen=false">
                        <v-icon> mdi-close </v-icon>
                    </v-btn>
                </v-card-title>
                <v-card-text>
                    If you would like some help navigating the form,
                    feel free to take the tutorial again to familiarize yourself with the content.
                    <br>
                    <v-btn class="ma-2" color="primary" @click="handleTutorial"> Take the Tutorial</v-btn>
                    <br>
                    If you would like to request a call with a volunteer
                    to go through the form together, please request an interview by clicking on the button below.
                    <br>
                    <v-btn class="ma-2" color="primary"> Request an Interview </v-btn>
                </v-card-text>
            </v-card>
        </v-dialog>

        <v-dialog
            v-model="submitLoading"
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
        <div>
            <v-row>
                <v-btn 
                    color="primary" 
                    id="save" 
                    class="ma-4" 
                    width="90px"
                    @click="save = !save"
                    > Save </v-btn>
            </v-row>
            <v-row>
                <v-btn 
                    color="primary" 
                    id="submit" 
                    class="ma-4" 
                    @click="handleSubmit"
                > 
                Submit 
                </v-btn>
            </v-row>
        </div>
        <v-container class="justify-left ml-2" id="form">
            <InterviewForm 
                :submit="submit" 
                :save="save" 
                v-on:submitting="submitLoading = true" 
                v-on:submitted="submitted" 
            />
        </v-container>
    </div>
</template>

<script lang="ts">
import Vue from 'vue'
import InterviewForm from '@/components/InterviewForm.vue'

export default Vue.extend({
    name : "InterviewFormView",
    components : {
        InterviewForm
    },
    data() {
        return {
            helpOpen : false,
            chatOpen : false,
            submitLoading : false,
            submit : false,
            save : false
        }
    },
    mounted() {
        console.log("in view, submit is")
        console.log(this.submit)
    },
    methods : {
        handleTutorial () {
            this.$router.push({ path : "/tutorial"})
        },
        handleSubmit() {
            console.log("handle submit called")
            this.submit = !this.submit
        },
        handleSave() {
            this.save = !this.save
        },
        submitted(){
            setTimeout(() => this.$router.push({path : "/submitted"}).catch(err => {}), 2000)
            this.submit = false
        }
    }
})
</script>

<style scoped>
#phone {
    position : fixed;
    bottom : 110px;
    right: 0;
}

#call {
    position : fixed;
    bottom : 165px;
    right : 0;
}

#save {
    position : fixed;
    bottom : 55px;
    right : 0;
}

#submit {
    position : fixed;
    bottom : 0px;
    right: 0;
}

#form {
    width : 90%;
    left: 0;
}
</style>