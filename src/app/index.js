var appPath = process.env["APPLICATION_COVERAGE"] ? "../app-cov/" : "./";

module.exports = require(appPath + "application");