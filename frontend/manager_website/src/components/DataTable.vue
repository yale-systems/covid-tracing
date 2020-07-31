<template>
    <div>
        <FieldDialog v-model="dialogToggle" />
        <v-row v-if="showSearch" class="mt-2">
            <v-col cols="4">
                <v-text-field
                    class="mt-n5"
                    v-model="searchInput"
                    append-icon="mdi-magnify"
                    label="Search"
                    single-line
                    hide-details
                ></v-text-field>
            </v-col>
            <v-spacer></v-spacer>
            <v-col auto>
                    <v-btn outlined color="primary" @click.stop="dialogToggle=true"> 
                        add fields 
                    </v-btn>
                    <v-btn outlined color="primary" to='add' class="mx-2">
                        Add Cases
                    </v-btn>
                    <v-btn color="primary" to='reassign'>
                        Assign Cases
                    </v-btn>
            </v-col>
        </v-row>
        <v-data-table
            :headers="headers"
            :items="people"
            :show-select="showSelect"
            hide-default-footer
            :search="searchInput"
        >
            <template v-slot:header.data-table-select="{}">
                <v-icon @click="handleHeaderSelect">
                    {{ headerSelectIcon }}
                </v-icon>
            </template>

            <template v-slot:item="{ item }">
                <Row  
                    v-on:input="$emit('input', $event)"
                    v-model="val"
                    :infoType="type" 
                    :person="item" 
                    :cols="headers" 
                    :showSelect="showSelect" 
                />
            </template>
        </v-data-table>
    </div>
</template>

<script>
import Row from '@/components/Row.vue';
import FieldDialog from '@/components/FieldDialog.vue';
export default {
    name: 'DataTable',
    components: {
        Row,
        FieldDialog
    },
    data: () => {
        return {
            searchInput: '',
            dialogToggle: false,
        }
    },
    props: {
        value: {
            Object,
            required: true
        },
        type: String,
        headers: Array,
        people: Array,
        showSelect: {
            Boolean,
            default: false
        },
        showSearch: {
            Boolean, 
            default: false
        }
    },
    computed: {
        val: {
            get() {
                return this.value
            },
            set() {
                
            }
        },
        numberSelected() {
            return this.$store.state.view.selected.length
        },
        headerSelectIcon() {
            // if none selected, should be blank
            if(this.numberSelected == 0) {
                return 'mdi-checkbox-blank-outline'
            } else if (this.numberSelected < this.people.length) {
                return 'mdi-minus-box'
            } else {
                return 'mdi-checkbox-marked'
            }
        }
    },
    methods: {
        handleHeaderSelect() {
            // none selected yet, add all of them
            if (this.numberSelected == 0) {
                for (let person of this.people) {
                    person.check = true
                    this.$store.commit('view/setSelect', person[`${this.type}_id`])
                }
            // some selected, then clear all
            } else {
                for (let person of this.people) {
                    person.check = false
                    this.$store.commit('view/clearSelect')
                }
            // all selected
            }
        }
    },
    // mounted() {
    //     for (let person of this.people) {
    //         person.check = false
    //     }
    // }
}
</script>

<style>
.theme--light.v-icon:focus::after {
    opacity: 0;
}

</style>