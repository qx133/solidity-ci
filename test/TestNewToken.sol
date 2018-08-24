pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/NewToken.sol";

contract TestNewToken {

    function testCheckOwnerBalance() public {
        NewToken token = NewToken(DeployedAddresses.NewToken());

        uint expected = 1000000 * 10 ** 13; 

        Assert.equal(token.balanceOf(tx.origin), expected, "Owner should have 1000000 tokens initially");
    }
}