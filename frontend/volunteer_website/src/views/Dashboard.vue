<template>
  <div>
    <Hamburger /> 
    <v-container fluid class="pb-0 pt-0">
      <v-row >
        <!-- for the menu -->
        <v-col class="mt-0 pa-0 overflow-y-auto full fill-height" cols="3">
          <v-container class="pa-0 mb-0 full-height">
            <v-toolbar color="secondary" class="pt-0 mt-0 sticky" flat dark>
              <v-toolbar-title v-if="!showSearch"> Patients </v-toolbar-title>
              <v-spacer v-if="!showSearch"></v-spacer>

              <v-text-field
                placeholder="search patients"
                v-show="showSearch"
                @blur="hideSearch"
                v-model="searchText"
                ref="search"
                class="mt-4"
              >
              </v-text-field>
              <v-btn icon @click="handleSearch">
                <v-icon>mdi-magnify</v-icon>
              </v-btn>

              <v-btn icon @click="filter = (filter + 1) % 2">
                <v-icon> {{sortIcon}} </v-icon>
              </v-btn>
            </v-toolbar>
            <v-list two-line class="pt-0 pb-0 mb-0 full-height">
              <v-list-item-group v-model="selectedIndex" class="full">
                <template class="full" v-for="(item, index) in showItems">
                  <v-list-item class="size-medium" :key="item.contactID">
                    <!-- name and subtitle -->
                      <v-list-item-content>
                        <v-list-item-title v-text="gettersHelper(item, 'name')"></v-list-item-title>
                        <v-list-item-subtitle
                          class="text--primary"
                          v-text="gettersHelper(item, 'phone')"
                        ></v-list-item-subtitle>
                      </v-list-item-content>
                      <!-- last active date and flag -->
                      <v-list-item-action>
                        <v-list-item-action-text
                          v-text="item.contact_date.format('M/D/YYYY')"
                        ></v-list-item-action-text>
                        <v-progress-circular 
                          rotate="-90"
                          class="mb-2 mr-1"
                          :value="gettersHelper(item, 'progress')"
                          size=20
                          color="green"
                        ></v-progress-circular>
                      </v-list-item-action>
                  </v-list-item>

                  <v-divider
                    :key="'divider-' + index"
                  ></v-divider>
                </template>
              </v-list-item-group>
            </v-list>
            <v-divider vertical> </v-divider>
          </v-container>
        </v-col>
        <!-- for the card itself -->
        <v-col class="pl-8 pr-8 pb-8 overflow-y-auto full">
          <!-- todo: set max height for the entire thing just equal to the page on load for contact tracers -- they should be scrolling
          within divs, I think. Get rid of the lil scroll bars, (at least when no scrolling is happening) -->
          <ContactScript
            v-if="selectedIndex != undefined && items[selectedIndex] != undefined" 
            v-model="items[selectedIndex]"
            v-on:reload="reload"></ContactScript>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import ContactScript from '@/notifierComponents/ContactScript.vue'
import Hamburger from "@/sharedComponents/Hamburger.vue"
import apiCalls from "@/apiCalls";
import getters from "@/methods.js";
import constants from '@/constants'
import cloner from 'lodash'

export default {
  name: "Dashboard",
  components: {
    ContactScript,
    Hamburger
  },
  mixins: [ getters ],
  data: () => {
    return {
      //might be possible for selected Index to become undefined; check this. 
      selectedIndex: 0,
      showItems: [],
      searchText: undefined,
      showSearch: false,
      filter: 0, //0 = filter off, 1 = sort ascending, 2 = sort descending
      callStatuses: constants.callStatuses
    };
  },
  computed: {
    sortIcon() {
      if (this.filter == 0) {
        return "mdi-sort"
      } else if (this.filter == 1) {
        return "mdi-sort-ascending"
      } else {
        return "mdi-sort-descending"
      }
    },
    items() {
      return this.$store.getters['contacts/contacts']
    }
  },
  watch: {
    selectedIndex(newVal, oldVal) {
      console.log(this.selectedIndex)
      if(newVal === undefined) {
        this.$nextTick(() => {
          this.selectedIndex = oldVal
        })
      }
    },
    searchText() {
      this.showItems = cloner.cloneDeep(this.items)
      this.$nextTick(() => {
        var search = cloner.cloneDeep(this.items)
        //we want to search, regardless of if "filter" is on or not
        if (this.searchText != undefined && this.searchText != '') {
          search = search.filter(this.bySearchText)
          this.selectedIndex = 0
          //remap this.items so the search ones appear in order first 
          var temp = cloner.cloneDeep(search)
          for(var contact in this.items) {
            var found = false
            for(var i in search) {
              if(search[i].contactID == this.items[contact].contactID) {
                found = true
                break
              }
            }
            if(!found) {
              temp.push(cloner.cloneDeep(this.items[contact]))
            }
          }
          this.items = Object.assign([], temp)
          console.log(this.items)
        }
        this.showItems = search
      })
    },
    filter(newVal, oldVal) {
      this.showItems = this.showItems.sort(this.compareDates)
    }
  },
  methods: {
    //TODO: use reference copies for showItems... instead of deep copies (I think that should work)
    reload() {
      var tempShow = []
      for(var contact in this.showItems) {
        for(var i in this.items) {
          if(this.showItems[contact].contactID == this.items[i].contactID) {
            tempShow.push(cloner.cloneDeep(this.items[i]))
            break;
          }
        }
      }
      this.showItems = tempShow
    },
    bySearchText(item) {
      var text = this.gettersHelper(item, 'name') + this.gettersHelper(item, 'contact_call_status') +
        this.gettersHelper(item, 'contact_date').format("M/D/YYYY") + this.gettersHelper(item, 'contact_date').format("MMMM")
      let lowerSearch = this.searchText.toLowerCase()
      text = text.toLowerCase()
      return text.search(lowerSearch) > -1
    },
    compareDates(item1, item2) {
      let date1 = item1.contactDate
      let date2 = item2.contactDate
      if(this.filter == 0) {
        if(date1.isAfter(date2)) {
          return 1
        } else if (date1.isSame(date2)){
          return 0
        } else {
          return -1
        }
      } else {
        if(date1.isAfter(date2)) {
          return -1
        } else if (date1.isSame(date2)){
          return 0
        } else {
          return 1
        }
      }
    },
    handleSearch() {
      if (!this.showSearch) {
        this.showSearch = true;
        this.$nextTick(() => {this.$refs.search.focus()})
      } 
    },
    hideSearch() {
      if (this.searchText.length < 1) {
        this.showSearch = false;
      }
    },
  },
  mounted() {
    this.showItems = cloner.cloneDeep(this.items)
  }
};
</script>

<style>
::-webkit-scrollbar { 
  display: none; 
}

.full {
  height: 100vh;
}

.sticky {
  position: -webkit-sticky; /* Safari */
  position: sticky;
  top: 0;
  z-index: 1
}

.size-medium{
  height: 80px
}

.mostly-full {
  height: 90vh;
}

</style>
