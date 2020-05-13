<template>
  <div>
  <b-card class="login-margins">
    <b-form>           
    <label for="datepicker-buttons"> Date: </label>
    <b-form-datepicker
      id="datepicker-buttons"
      reset-button
      locale="en"
      placeholder="Please select a date"
      v-model="$v.formInfo.date.$model"
      :state="getState(!$v.formInfo.date.$error, formInfo.date)"
    ></b-form-datepicker>
    <div class="error" v-if="$v.formInfo.date.$error"> This field is required. </div>

    <br>
    <b-form-group label="Location:" label-for="expLocation">
      <b-input-group>
        <b-input-group-prepend>
          <b-button class="navbar-custom" v-on:click="showMap"> Map </b-button>
        </b-input-group-prepend> 
          <b-form-input 
            v-model="$v.formInfo.adr.$model" 
            id="expLocation" 
            type="text" 
            disabled 
            placeholder="Use the map to select a location"
            :state="getState(!$v.formInfo.adr.$error, formInfo.adr)"
          ></b-form-input>
      </b-input-group>
    </b-form-group>
    <b-button class="fsb navbar-custom" @click="submit"> Submit </b-button>
  </b-form>
  <b-modal id="expModal" :hide-header="true" size="lg" hide-backdrop content-class="shadow">
      <SearchMap class="search-map" v-model="this.formInfo"/>
  </b-modal>
  </b-card>
 </div>
</template>

<script>
import SearchMap from './SearchMap'
import formMixin from '@/mixins/formMixin'
import { required } from 'vuelidate/lib/validators'
import apiCalls from '@/apiCalls.js'

export default {
  name: 'ExpForm',
  components : { 
    SearchMap
  },
  props : {
    value : Object
  },

  mixins: [formMixin],

  validations: {
    formInfo: {
      adr: {required},
      ll: {},
      date: {required}
    }
  },
  
  data () {
    return {
      formInfo : {
        adr: '',
        ll: null,
        date : ''
      },
    }
  },
  methods: {// show map 
    showMap() {
      this.$bvModal.show('expModal')
    },
    async submit(event) {
      event.preventDefault()
      if (!this.$v.$invalid) {
        await this.makeQuery()
      }
    },
    async makeQuery() {
      let res = await apiCalls.expQuery(this.formInfo)
      // if there are positive results
      if (res) {
        this.value.exposed = true
      }
      this.value.submitted = true;
     // this.value.submitted = true;
      //this.value.exposed = true;
    }
  }
}
</script>

<style scoped>

.search-map {
  height : 400px;
}
.fsb {
  float: right
}
.error {
  color : firebrick;
  font-size : smaller;
  line-height : 50%;
  padding-top : 15px;
} 
</style>
