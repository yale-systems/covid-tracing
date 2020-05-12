module.exports = {
    devServer : {
        host : '0.0.0.0',
        disableHostCheck: true,
        proxy : "http://10.0.0.83:8080/"
    }
}