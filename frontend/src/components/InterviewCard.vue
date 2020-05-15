<template>
    <div>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <b-card class="card-margin card-custom">
        <b-form>
            <!-- TITLE FIELD --> 
            <div class="row no-gutters justify-content-start">
                <div :contenteditable="editTitle" :id="titleID" onfocus="document.execCommand('selectAll', false, null);"
                    class="editableTitle title col col-sm-auto" v-text="txt" @blur="onEdit" @keydown.enter="endEdit"></div>
                <div class="space col-sm"><i v-if="cardExpanded" class="material-icons" @click="beginEdit">edit</i></div>
                <div id="lessMargins" class="col-sm-auto"><i class="material-icons md-18" @click="toggleCollapse">expand_less</i></div>
            <!-- <div class="square" @click="toggleCollapse"></div> -->
            </div>
    
            <b-collapse v-model="cardExpanded">
                <!-- NAME FIELD -->
                <b-form-group label="Contact Name:" :label-for="nameID">
                    <b-form-input :id="nameID" :value="v.name.$model" @change.native="v.name.$model = $event.target.value"  type="text" :state="getState(v.name.isName, value.name)"></b-form-input>
                </b-form-group>
                <div class="error" v-if="!v.name.isName">Name must only include alphabetic characters and spaces.</div>

                <!-- EMAIL FIELD -->
                <b-form-group label="Contact Email:" :label-for="emailID">
                    <b-form-input :id="emailID" :value="v.email.$model" @change.native="v.email.$model = $event.target.value" 
                    type="email" :state="getState(v.email.email, value.email)" ></b-form-input>
                </b-form-group>
                <div class="error" v-if="!v.email.email">Please enter a valid email address in the form of <i>name@email.com</i>.</div>

                <!-- PHONE FIELD -->
                <b-form-group label="Contact Phone:" :label-for="phoneID">
                    <b-form-input :id="phoneID" :value="v.phone.$model" @change.native="v.phone.$model = $event.target.value"  type="tel" :state="getState(v.phone.numeric, value.phone)"></b-form-input>
                </b-form-group>
                <div class="error" v-if="!v.phone.numeric">Please only enter numbers.</div>

                <!-- LOCATION FIELD -->
                    <b-form-group label="Location:" :label-for="locationID">
                        <b-input-group>
                            
                            <b-input-group-prepend>
                                    <b-button class="navbar-custom" v-on:click="showMap"> Map </b-button>
                            </b-input-group-prepend>
                            

                            <b-form-input :id="locationID" v-model.trim="value.location" type="text" disabled 
                            :state="getState(true, value.location)" placeholder="Use the map to select a location"></b-form-input>
                            <div v-if="clearMapOpt">
                                <b-input-group-append>
                                    <!-- the below is a nicer x button but uh is kinda ugly altogether... -->
                                    <!-- <i class="material-icons" @click="clearLocationInfo">clear</i> -->
                                    <b-button v-on:click="clearLocationInfo"> Clear </b-button>
                                </b-input-group-append>
                            </div>
                        </b-input-group>
                    </b-form-group>
                    <div class="trash col-md-auto"><i class="material-icons md-18" @click="$emit('delete', (defaultEventNum-1))">delete</i></div> 
                </b-collapse> 
            </b-form>  
        </b-card>
        <!-- Modal to show map for location -->
        <b-modal :id="modalID" :hide-header="true" size="lg" hide-backdrop content-class="shadow" @ok="handleOk">
            <SearchMap class="search-map" v-model="this.addressInfo"/>
        </b-modal>
    </div>  
</template>

<script>
import SearchMap from './SearchMap'
import formMixin from '@/mixins/formMixin'

export default {
    name: 'InterviewCard', 
    components : {
        SearchMap
    },
    mixins: [formMixin],
    props: {
        // TODO: attempt to merge, as v currently models all other data in InterviewForm
        value: {
            type: Object,
            required: true
        },
        v: {
            type: Object,
            required: true
        },
        // gives default ID for event
        defaultEventNum: Number,
    },

    data: function() {
        return {
            txt: "Event ",
            defaultText: "Event ",
            nameID: "name-",
            emailID: "email-", 
            phoneID: "phone-",
            locationID: "location-",
            modalID: "modal-",
            titleID: "title-",
            addressInfo : {
                adr: '',
                ll: null
            },
            editTitle: false,
            cardExpanded: true,
            clearMapOpt: false
        }
    },

    computed: {
        //base case for recursive find error function, using anyError
        status: function() {
            return this.v.$anyError 
        }
    },

    mounted() {
        // sets unique IDs for each field
        this.txt = this.txt + this.defaultEventNum
        this.defaultText = this.txt
        this.nameID = this.nameID + this._uid
        this.emailID = this.emailID + this._uid
        this.phoneID = this.phoneID + this._uid
        this.locationID = this.locationID + this._uid
        this.modalID = this.modalID + this._uid
        this.titleID = this.titleID + this._uid
    },

    methods: {
        //these handle the title of each event
        beginEdit(){
            var element = document.getElementById(this.titleID);
            this.editTitle = true;
            this.$nextTick(() => {
                element.focus();
            }) 
        },
        onEdit(title) {
            if (title.target.innerText.length > 0) {
                this.txt = title.target.innerText
            } else {
                title.target.innerText = this.defaultText
                this.txt = this.defaultText
            }
            this.editTitle = false;
        },
        // blur the title field when enter is pressed
        endEdit() {
            this.$el.querySelector('.editableTitle').blur()
            this.editTitle = false;
        },
        // show map 
        showMap() {
            this.$bvModal.show(this.modalID)
        },
        // autofills location field and lat lon in data
        handleOk() {
            this.value.location = this.addressInfo.adr
            this.value.latlon = this.addressInfo.ll
            this.clearMapOpt = true
        },
        toggleCollapse(element){
            element.target.innerText = (element.target.innerText == "expand_less") ? "expand_more" : "expand_less";
            this.cardExpanded = !this.cardExpanded;
        },
        clearLocationInfo() {
            this.value.location = ""
            this.value.latlon.lat = null
            this.value.latlon.lng = null
            this.clearMapOpt = false
        }
        
    }
}
</script>

<style scoped>

[contenteditable] {
    outline: 0px solid transparent;
}

.material-icons:hover{
    color : black;
    cursor : pointer;
}

.material-icons {
    color : gray;
    line-height: 10px;
    margin-top: 10px;
}

.material-icons.md-18 { 
    font-size: 30px;
    color: gray;
}

/* .square {
  position: absolute;
  height: 50px;
  width: 75%;
  background-color: rgb(211, 221, 238, 0);
  color: rgb(211, 221, 238, 0);
  z-index: 1;
  margin-left: 15%;
} */

</style>
