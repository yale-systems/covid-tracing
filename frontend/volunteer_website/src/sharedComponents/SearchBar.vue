<template>
  <input
    id="searchInput"
    ref="searchInput"
    placeholder="Click here to choose a location"
  />
</template>

<script>
export default {
  name: "SearchBar",
  data() {
    return {
      //google map objects initialized & mounted by SearchBar using props
      marker: null,
      autocomplete: null,
      geocoder: null
    };
  },
  props: {
    google: {
      type: Object,
      required: true
    },
    map: {
      type: Object,
      required: true
    },
    // location string and latlon passed in from InterviewCard -> SearchMap,
    // double-bound using v-model, used to autofill location on the form
    value: {
      type: Object,
      required: true
    }
  },
  mounted() {
    // initialize autocomplete object on input HTML element
    this.autocomplete = new this.google.maps.places.Autocomplete(
      this.$refs.searchInput
    );
    // puts HTML input at the top center of the map
    this.map.controls[this.google.maps.ControlPosition.TOP_CENTER].push(
      this.$refs.searchInput
    );
    // bias autocomplete towards current bounds (will update on bound change)
    this.autocomplete.bindTo("bounds", this.map);
    // set the data fields to return when the user selects a place
    this.autocomplete.setFields(["address_components", "geometry"]); //geometry: lat/lon; address: string

    var curr = this;
    // every time enter is pressed / we select a place, show place with marker
    this.autocomplete.addListener("place_changed", function() {
      curr.searchToMarker();
    });
    // every time we click the map, make a marker and fill input HTML with reverse geocoding
    this.map.addListener("click", function(event) {
      console.log("the map got clicked");
      curr.markerToSearch(event);
    });
    //initializing marker & geocoder
    this.marker = new this.google.maps.Marker({
      map: this.map
    });
    this.geocoder = new this.google.maps.Geocoder();
  },
  methods: {
    // places a marker & adjusts map center based on autocomplete result
    searchToMarker() {
      var place = this.autocomplete.getPlace();
      if (!place.geometry) {
        console.log("Place could not be found");
        return;
      }

      // viewport is Google's zoom / centering for any given location
      if (place.geometry.viewport) {
        this.map.fitBounds(place.geometry.viewport);
      } else {
        this.map.setCenter(place.geometry.location);
        // to quote the documentation page, "why? Because it looks good."
        this.map.setZoom(17);
      }
      this.marker.setPosition(place.geometry.location);
      this.marker.setVisible(true);

      //updates address and lat/lon (this also incidentally updates the form!)
      this.value.adr = this.$refs.searchInput.value;
      this.value.ll = place.geometry.location.toJSON();
    },
    // event is the clicked location. Places marker there & reverse geocodes to find address
    markerToSearch(event) {
      console.log(event.latLng.toJSON());
      this.value.ll = event.latLng.toJSON();
      this.marker.setPosition(event.latLng);
      this.marker.setVisible(true);
      var curr = this;
      this.geocoder.geocode({ location: event.latLng }, function(
        results,
        status
      ) {
        if (status === "OK") {
          if (results[0]) {
            curr.$refs.searchInput.value = results[0].formatted_address;
            curr.value.adr = results[0].formatted_address;
          } else {
            window.alert("No results found");
            curr.value.adr = "";
          }
        } else {
          window.alert("Geocoder failed due to: " + status);
          curr.value.adr = "";
        }
      });
    }
  }
};
</script>

Dangerous! Not scoped!
<style>
#searchInput {
  box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.16), 0 0 0 1px rgba(0, 0, 0, 0.08);
  font-size: 15px;
  border-radius: 3px;
  border: 0;
  margin-top: 10px;
  width: 270px;
  height: 40px;
  text-overflow: ellipsis;
  padding: 0 1em;
  background-color: white;
}
/* otherwise autocomplete search is BEHIND modal, which is... unideal */
.pac-container {
  z-index: 1055 !important;
}
</style>
