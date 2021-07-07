var tokenSale = artifacts.require("./TokenSale.sol");
var token = artifacts.require("./NewToken.sol");
var defToken = artifacts.require("./DefaultToken.sol");

contract('tokenSale', function(accounts) {
  it("totalSupply should  be 1e22 ", async () =>  {
    let defTokenInst = await defToken.deployed();
    
    let totalSupply = await defTokenInst.totalSupply();
    assert.equal(totalSupply.minus('1e+22').toString(), 0);
  });

  it("allowance should  be 1e22 ", async () =>  {
    let defTokenInst = await defToken.deployed();
    let tokenSaleInst = await tokenSale.deployed();
    let balance = await defTokenInst.balanceOf(accounts[0]);
    console.log(tokenSaleInst.defToken());
    assert.equal(balance.minus('1e+22').toString(), 0);
  });

})