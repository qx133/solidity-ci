pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/TokenSale.sol";
//import "../contracts/NewToken.sol";

contract ATokenSale {

    uint public initialBalance = 10 ether;

    address public owner;
    NewToken public token;
    TokenSale public tokenSale;

    constructor() public {
        owner = msg.sender;
        tokenSale = TokenSale(DeployedAddresses.TokenSale());
        token = NewToken(tokenSale.token());
    }

    function testTotalSupply() public {

        uint expected = 100000 * 10 ** 18; 
        Assert.equal(token.totalSupply(), expected, "TotalSupply should have 100000 tokens");
    }

    function testWhitelistedAddress() public {

        tokenSale.addWhitelistedAddress(this, true);
        Assert.equal(tokenSale.whitelistedAddress(this), true, "Address should be whitelisted");
    }

    function testSaleUsingEther() public {
        tokenSale.buyUsingEth.value(1.5 ether)();
        uint expected = 12500 * 10 ** 18;
        Assert.equal(token.balanceOf(this), expected, "Balance should have 12500 tokens");
    }
}