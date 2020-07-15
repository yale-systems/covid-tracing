module.exports = {
    lintOnSave: false,
    transpileDependencies: ["vuetify"],
    devServer: {
        compress: true,
        public: 'oasis-patient.cs.yale.edu',
        allowedHosts: [
          '.cs.yale.edu'
        ]
      }
};
