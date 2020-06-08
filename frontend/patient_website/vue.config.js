module.exports = {
    lintOnSave: false,
    transpileDependencies: ["vuetify"],
    devServer: {
        host : '0.0.0.0',
        disableHostCheck: true,
        proxy : "http://localhost:8080/"
    }
};
