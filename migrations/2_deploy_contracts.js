var burnableToken = artifacts.require("./BurnableToken.sol");
var ico = artifacts.require("./ICO.sol");

module.exports = function(deployer) {
  deployer.deploy(burnableToken).then(function() {
    return deployer.deploy(ico, burnableToken.address, [0xDc477f985E01182Ec5C284209630b4ecca5D24c7]);
  });
 };
