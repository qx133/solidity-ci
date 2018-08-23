var helloworld = artifacts.require("./helloworld.sol");

module.exports = function(deployer) {
  deployer.deploy(helloworld);
};
