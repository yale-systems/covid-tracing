<template>
<v-app id="inspire">
    <v-img
      light
      src="../assets/new-haven-green.jpg"
      gradient="to top, #E0F2F1, rgba(255, 255, 255, .99)">
    <v-row
        align="center"
        justify="center">
        <v-col class="text-center welcome-padding" cols="12">
          <v-card style="margin-bottom:30px;">
            <v-container id="box-top" fluid class="welcome-box" text-align="center" text-justify="center">
                <h1 > Online Resources </h1> 
                <br>
                <p> <b>Thank you for your time and effort in helping us trace COVID-19 in Connecticut.
                    Your actions today may help save a life tomorrow. We know this is a difficult time,
                    so we've put together a list of resources that may be of help to you.</b>
                </p>
                <v-row 
                align="center"
                justify="center"
                class="resource-row">
                    <v-col
                    :cols=5
                    >
                        <v-btn color="teal lighten-5" min-height="60px" class="align-center resource-button" 
                        href="https://www.cdc.gov/coronavirus/2019-ncov/if-you-are-sick/steps-when-sick.html" target="_blank"> CDC Resources </v-btn>
                    </v-col>
                    <v-col>
                        <p>The CDC has put together a central database with information about
                            what to do if you are feeling sick. In addition, they have up-to-date 
                            information on the state of the pandemic in the United States.</p>
                    </v-col>
                </v-row>
                <v-row
                align="center"
                justify="center"
                class="resource-row">
                    <v-col
                    :cols=5
                    >
                        <v-btn color="teal lighten-4" min-height="60px" class="align-center resource-button" 
                        href="https://covid19.newhavenct.gov/" target="_blank"> New Haven Resources </v-btn>
                    </v-col>
                    <v-col>
                        <p>The City of New Haven has created a COVID-19 hub for 
                            information useful for Connecticut residents. 
                            Resources are available in English/español/العربية.</p>
                    </v-col>
                </v-row>
                <v-row
                align="center"
                justify="center"
                class="resource-row">
                    <v-col
                    :cols=5
                    >
                        <v-btn color="teal lighten-3" min-height="60px" class="align-center resource-button" 
                        href="https://portal.ct.gov/Coronavirus/Covid-19-Knowledge-Base/Latest-Guidance" target="_blank"> Connecticut Guidance </v-btn>
                    </v-col>
                    <v-col>
                        <p>The Connecticut state government continually updates this 
                            page with the current state guidance on social distancing and openings. 
                            It also connects to other Connecticut-wide information.</p>
                    </v-col>
                </v-row>
            </v-container>
          </v-card>
          <v-card>
            <v-container fluid class="welcome-box" text-align="center" text-justify="center">
                <h1 > Phone Resources </h1> 
                <br>
                <p> <b>Social distancing has been especially difficult for many of us, particularly those
                    in difficult circumstances. If you want to speak to someone, please reach out at one
                    of the numbers below.</b>
                </p>
                Visit the 24/7 <a href="https://suicidepreventionlifeline.org/">Suicide Prevention Lifeline</a> by calling <b>800-273-8255</b> or texting <b>838255</b>.                
                <br><br>Llama la <a href="https://suicidepreventionlifeline.org/help-yourself/en-espanol/">línea directa de prevención de suicidio</a> para ayuda en español a <b>1-888-628-9454</b>.                    
                <br><br>Visit the 24/7 <a href="https://www.samhsa.gov/find-help/disaster-distress-helpline">Disaster Distress Helpline</a> by calling <b>1-800-985-5990</b> or texting <b>TalkWithUs</b> to <b>66746</b>.
                <br><br>Visit the 24/7 <a href="https://www.thehotline.org/">National Domestic Violence Hotline</a> by calling <b>1-800-799-7233</b> and TTY <b>1-800-787-3224</b>.
                <br><br>Visit the 24/7 <a href="https://www.crisistextline.org/">Crisis Text Line</a> by texting <b>HOME</b> to <b>741741</b>.
                <br><br>Visit the 24/7 <a href="https://www.thetrevorproject.org/get-help-now/">TrevorLifeline</a> for LGBTQ youth by calling <b>1-866-488-7386</b> by texting <b>START</b> to <b>678-678</b>.
               
                <br><br><b>Call 911 if you or the person you are helping is in immediate danger.</b>
            </v-container>
          </v-card>
        </v-col>
    </v-row>
</v-img>
</v-app>
</template>

<script>
export default {

}
</script>

<style scoped>
#box-top {
    padding-top: 3%;
    padding-bottom: 1%;
}
.welcome-padding {
    justify-content: center;
    padding-bottom: 5%;
    padding-right: 15%;
    padding-left: 15%;
    padding-top: 5%;
}

.welcome-box {
    padding: 4%;
}

.resource-button {
    width: 95%;
    height: 100%;
    align-content: center;
    justify-content: center;
    margin-top: -20px;
}

.resource-row {
    margin-top: -5px;
}

.resource-text {
    text-align: center;
}

</style>