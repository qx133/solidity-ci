var Migrations = artifacts.require("./Migrations.sol");
var TokenSale = artifacts.require("./TokenSale.sol");
var NewToken = artifacts.require("./NewToken.sol");
var DefaultToken = artifacts.require("./DefaultToken.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(DefaultToken).then(function() {
    return deployer.deploy(TokenSale, DefaultToken.address);
  });
  
};
