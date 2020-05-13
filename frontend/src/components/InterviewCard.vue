<template>
    <div>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <b-card class="card-margin card-custom">
        <b-form>
            <!-- TITLE FIELD --> 
            <div class="row no-gutters justify-content-start">
                <div contenteditable class="editableTitle title col col-md-auto" v-text="txt" @blur="onEdit" @keydown.enter="endEdit"></div>
                <div class="space col-md-auto"><i class="material-icons">edit</i></div>
            </div>
        
            <!-- NAME FIELD -->
            <b-form-group label="Name:" :label-for="nameID">
                <b-form-input :id="nameID" :value="v.name.$model" @change.native="v.name.$model = $event.target.value"  type="text" :state="getState(v.name.isName, value.name)"></b-form-input>
            </b-form-group>
            <div class="error" v-if="!v.name.isName">Name must only include alphabetic characters and spaces.</div>

            <!-- EMAIL FIELD -->
            <b-form-group label="Email:" :label-for="emailID">
                <b-form-input :id="emailID" :value="v.email.$model" @change.native="v.email.$model = $event.target.value" 
                 type="email" :state="getState(v.email.email, value.email)" ></b-form-input>
            </b-form-group>
            <div class="error" v-if="!v.email.email">Please enter a valid email address in the form of <i>name@email.com</i>.</div>

            <!-- PHONE FIELD -->
            <b-form-group label="Phone:" :label-for="phoneID">
                <b-form-input :id="phoneID" :value="v.phone.$model" @change.native="v.phone.$model = $event.target.value"  type="tel" :state="getState(v.phone.numeric, value.phone)"></b-form-input>
            </b-form-group>
            <div class="error" v-if="!v.phone.numeric">Please only enter numbers.</div>

            <!-- LOCATION FIELD -->
                <b-form-group label="Location:" :label-for="locationID">
                    <b-input-group>
                        <b-form-input :id="locationID" v-model.trim="value.location" type="text" disabled :state="getState(true, value.location)"></b-form-input>
                            <b-input-group-append>
                                <b-button class="navbar-custom" v-on:click="showMap"> Map </b-button>
                            </b-input-group-append>
                    </b-input-group>
                </b-form-group>
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
        defaultEventNum: Number
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
            addressInfo : {
                adr: '',
                ll: null
            }
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
    },

    methods: {
        //these handle the title of each event
        onEdit(title) {
            if (title.target.innerText.length > 0) {
                this.txt = title.target.innerText
            } else {
                title.target.innerText = this.defaultText
                this.txt = this.defaultText
            }
        },
        // blur the title field when enter is pressed
        endEdit() {
            this.$el.querySelector('.editableTitle').blur()
        },
        // show map 
        showMap() {
            this.$bvModal.show(this.modalID)
        },
        // autofills location field and lat lon in data
        handleOk() {
            this.value.location = this.addressInfo.adr
            this.value.latlon = this.addressInfo.ll
        }
    }
}
</script>

<style scoped>

.card-margin {
  align-content: center;
  margin-left: 10%;
  margin-right: 10%;
  z-index: 0;
}

.no-gutters {
  margin-right: 0px;
  margin-left: 0px;
}

[contenteditable] {
    outline: 0px solid transparent;
}

.space {
  margin-left: 10px;
}

.search-map {
        height : 400px
    }

.title {
        font-weight : bold;
        font-size : larger
}

.material-icons:hover{
    color : darkgray;
    cursor : pointer
}

.material-icons {
    color : black;
}

.error {
        color : firebrick;
        font-size : smaller;
        line-height : 50%;
        padding-bottom: 10px;
}    

.card-custom { 
    background-color: rgba(27, 59, 113, 0); 
    border: rgba(27, 59, 113, 0);
} 

</style>
