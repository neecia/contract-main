const Migrations = artifacts.require("Bank")

module.exports = function(deployer) {
    deployer.deploy(Migrations);
}