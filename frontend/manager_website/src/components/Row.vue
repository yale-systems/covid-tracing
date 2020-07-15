<template>
    <tr :class="watchActive ? 'active hover' : 'hover'" @click="seeRow">
        <!-- checkbox cell, with our own checkbox, likely -->
        <td v-if="showSelect">
            <v-icon @click.stop="select" class="no-bg">
                {{ person.check ? 'mdi-checkbox-marked' : 'mdi-checkbox-blank-outline' }}
            </v-icon>
            <!-- <v-checkbox v-model="person.check" @click.stop="select">
            </v-checkbox> -->
        </td>
        <!-- <td v-for="(field, index) in fields"
            :key="index"
            v-on:dblclick="handleDouble"
        >
            {{ gettersHelper(person, field) }}
        </td> -->
        <Cell v-for="(field, index) in fields"
            :key="index"
            :field="field"
            v-model="person"
        />

    </tr>
</template>

<script>
import allGetters from '@/constants/methods.js';
import Cell from '@/components/Cell.vue';

export default {
    name: 'Row',
    mixins: [allGetters],
    components: {
        Cell
    },
    data: () => {
        return {
            increase: 0
        }
    },
    // each row is passed an item as its value, v-modeled
    props: {
        value: {
            type: Object,
            required: true
        },
        person: {
            type: Object,
            required: true
        },
        // the active fields currently
        // form { text: "", value: ""}
        cols: {
            type: Array, 
            required: true
        },
        infoType: {
            type: String,
            required: true
        },
        showSelect: {
            type: Boolean,
            default: false
        }

    },
    computed: {
        fields() {
            let fields = []
            for (let col of this.cols) {
                fields.push(col.value)
            }
            return fields
        },
        idName() {
            return `${this.infoType}_id`
        },
        watchActive() {
            if(this.value == null) {return false;}
            return (this.value[this.idName] == this.person[this.idName])
        }
    },
    methods: {
        seeRow() {
            this.$emit('input', this.person)
        },
        select() {
            //TODO: add patientID to vuex store array
            this.person.check = !this.person.check
            if( this.person.check ) {
                this.$store.commit('setSelect', this.person[this.idName])
            } else {
                this.$store.commit('removeSelect', this.person[this.idName])
            }
        },
    },
}
</script>

<style scoped>
.active {
    background-color: #f0ebf7 !important;
    cursor: default !important;
}

.hover:hover {
    cursor: pointer;
    background-color: #faf7ff !important;

}

.theme--light.v-icon:focus::after {
    opacity: 0;
}

</style>