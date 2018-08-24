var StandardToken = artifacts.require("./StandardToken.sol");
var BurnableToken = artifacts.require("./BurnableToken.sol");
var NewToken = artifacts.require("./NewToken.sol");

module.exports = function(deployer) {

  deployer.deploy(StandardToken);
  deployer.deploy(BurnableToken);
  deployer.link(StandardToken, NewToken);
  deployer.link(BurnableToken, NewToken);
  deployer.deploy(NewToken);

};
