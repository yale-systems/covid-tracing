import Vue from "vue";
import Vuetify from "vuetify/lib";
import colors from 'vuetify/lib/util/colors'

Vue.use(Vuetify);

const vuetify = new Vuetify({
  theme: {
    themes: {
      light: {
        primary: '#009688',
        secondary: colors.grey.darken1,
        accent: colors.shades.black,
        error: colors.red.accent3,
      },
      dark: {
        primary: '#009688',
      },
    },
  },
})

export default new Vuetify({
    theme: {
        themes: {
            dark: {
                primary: colors.green,
                anchor: colors.green,
                
            }
        }
    }
});
