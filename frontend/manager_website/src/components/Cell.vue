<template>
        <td>
            <!-- <v-edit-dialog
            :return-value.sync="value[field]"
            large>
            {{ gettersHelper(value, field) }}
                <template v-slot:input>
                    <v-text-field
                    v-model="value[field]"
                    label="edit"
                    single-line>
                    </v-text-field>
                </template>
            </v-edit-dialog> -->
            <v-text-field v-if="editing"
                v-model="value[field]"
                label="edit"
                single-line
                hide-details
                v-on:blur="editing = false"
                autofocus>
            </v-text-field>
            <p v-else
            class="pt-4"
            @dblclick="handleEditing">
                {{ gettersHelper(value, field)}}
            </p>
        </td>
</template>

<script>
import allGetters from '@/constants/methods.js';
import TextField from '@/components/TextField.vue';

export default {
    name: 'Cell',
    components: {
        TextField
    },
    mixins: [allGetters],
    data: () => {
        return {
            editing: false
        }
    },
    props: {
        value: {
            required: true
        },
        field: {
            type: String,
            required: true
        },
        editable: {
            type: Boolean,
            default: false
        }
    },
    methods: {
        handleEditing() {
            if (this.editable) {
                this.editing = true
            }
        }
    }
}
</script>

<style>

</style>