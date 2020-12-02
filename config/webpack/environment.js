const { environment } = require("@rails/webpacker");

//github.com/rails/webpacker/issues/2131
environment.loaders.delete("nodeModules");

module.exports = environment;
