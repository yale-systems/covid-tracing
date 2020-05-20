<script>

export default {
    name: "MapMarker", 
    props: {
        google: {
            type: Object, 
            required: true
        }, 
        map: {
            type: Object, 
            required: true
        }, 
        marker: {
            type: Object, 
            required: true
        },
        show : {
            type: Boolean,
            default: true
        }
    },
    data () {
        return {
            mark : null
        }
    },

    mounted() {
        // console.log(this.google)
        this.mark = new this.google.maps.Marker({
            position: this.marker.position,
            marker: this.marker,
            map: this.map,
            icon: this.getIcon()
        });
    }, 

    watch : {
        show : function() {
            console.log("disappear me")
            this.mark.setMap(null)
            this.mark = null
        }
    },

    methods : {
        getIcon() {
            return {
                path: "M 0, 0 m -5, 0 a 5,5 0 1,0 10,0 a 5,5 0 1,0 -10,0",
                fillColor : 'red',
                fillOpacity : .5,
                scale : 3,
                strokeColor : 'white',
                strokeWeight : .5
            }
        }
    },

    render() { return 0 }
    
}
</script>