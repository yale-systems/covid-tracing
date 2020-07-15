<template>
<div class="centered-flexbox">
    <div class="center">
        <transition name="slide-fade" >
            <ContactCard 
                v-show="formToggle.viewContact"
                v-model="formToggle"
                :household="household"
                :id="openID"
            />
        </transition> 
    </div>

    <div :class="(formToggle.viewContact) ? 'overlay top mr-5 pr-5' : 'top mr-5 pr-5'">
        <!-- household contacts -->
        <v-container fluid class="mx-4 mt-4 px-5 mt-5">
        <h4 class="header"> Household Contacts </h4><br>
        <p>                         
            Please add any household contacts here, including anyone you live with, such as family members or housemates.
            Add people you have come into contact with since <b>{{ $store.getters.readableStartDate }}</b>. Below, you can 
            add people you have come into contact with outside the home. 
        </p>
        <v-container fluid> 
            <v-btn outlined @click="openDialog(-1, true)" class="mb-4">
                <v-icon>
                    mdi-plus
                </v-icon>
                add household contact
            </v-btn>
            
            <table>
                <tr> 
                    <th>Name</th> 
                    <th>Date</th>
                    <th>Phone</th>
                    <th>Email</th>
                </tr>
                <template v-for="contactID in householdContacts">
                    <ContactRow 
                        :key="'house'+contactID"
                        :contactID="contactID" 
                        v-on:open="openDialog($event, true)"
                    />
                </template>
            </table>
        </v-container>
        <p class="mt-3 font-weight-medium">                         
            Please recommend that the case try to reach their household and close contacts (including workplace) 
            to let them know that they may have been exposed. 
        </p>
        </v-container>
        <!-- outside contacts -->
        <v-container fluid class="mx-4 mb-4 px-5 mb-5">
        <hr class="mt-n5" style="border-top: 1px solid rgb(226, 226, 226);"><br>
        <h4 class="header"> Outside Contacts </h4><br> 
        <p>                         
            Please add any outside contacts here, including anyone you have come into contact 
            with not listed above since <b>{{ $store.getters.readableStartDate }}</b>.
        </p>
        <v-container fluid> 
            <v-btn outlined @click="openDialog(-1, false)" class="mb-4">
                <v-icon>
                    mdi-plus
                </v-icon>
                add outside contact
            </v-btn>
            
            <table>
                <tr> 
                    <th>Name</th> 
                    <th>Phone</th>
                    <th>Email</th>
                </tr>
                <template v-for="contactID in outsideContacts">
                    <ContactRow 
                        :key="contactID"
                        :contactID="contactID" 
                        v-on:open="openDialog($event, false)"
                    />
                </template>
            </table>
        </v-container>
        </v-container>
    </div>
</div>
</template>

<script>
import ContactCard from '@/interviewerComponents/ContactCard'
import ContactRow from '@/interviewerComponents/ContactRow'

export default {
    name: "HouseholdContactDiv",
    components: {
        ContactCard,
        ContactRow
    },
    computed: {
        householdContacts() {
            return this.$store.state.householdContactIDArray
        },
        outsideContacts() {
            return this.$store.getters.outsideContacts
        }
    },
    data: () => {
        return {
            formToggle: {
                viewContact: false
            },
            openID: -1,
            household: true
        }
    },
    methods: {
        openDialog(id, house) {
            this.openID = id
            this.household = house
            console.log(this.household)
            this.$nextTick(()=>{this.formToggle.viewContact = true})
        }
    }
}
</script> 

<style>

.overlay{
    -webkit-filter: grayscale(10%) blur(1px);
    -moz-filter: grayscale(10%) blur(1px);
    -o-filter: grayscale(10%) blur(1px);
    -ms-filter: grayscale(10%) blur(1px);
    filter: grayscale(10%) blur(1px);
    opacity: 0.9;
}

.slide-fade-enter-active {
  transition: all .4s ease;
}

.slide-fade-leave-active {
  transition: all .4s ease;
}

.slide-fade-enter, .slide-fade-leave-to {
  transform: translateY(100px);
  opacity: 0;
}

.centered-flexbox{
    display: flex;
    justify-content: center;
}
.center{
    position: absolute;
    margin-top: 5%
}

table {
  border-collapse: collapse;
  width: 100%;
}

th {
    padding: 8px;
    text-align: left;
}

</style>