<template>
    <div :style="cssProps" class="circle"><slot></slot></div>
</template>


<script>
export default {
    name: "circleicon",
    props: {
        text: {
            String,
            default: ''
        },
        color: {
            String, 
            default: 'black'
        },
        textColor: {
            String, 
            default: 'white'
        }
    },
    computed: {
        cssProps() {
            return {
                '--background-color': this.color,
                '--text-color': this.textColor,
            }
        }
    },
    mounted() {
        console.log("hello i am a circle")
    }
}

</script> 

<style scoped> 

.circle {
    width: 25px;
    height: 25px;
    border-radius: 50%;
    background: var(--background-color);
    color: var(--text-color);
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 10px
}

</style> 