var burnabletoken = artifacts.require("./BurnableToken.sol");

module.exports = function(deployer) {
  deployer.deploy(burnabletoken);
 };
