var MyERC20 = artifacts.require("./MyERC20.sol");

module.exports = function(deployer) {
  deployer.deploy(MyERC20);
};
