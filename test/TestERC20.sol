pragma solidity ^0.4.19;

import "/home/sumit101/workspace/solidity/solidity-ci/contracts/MyERC20.sol";
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";

contract TestERC20{

    function testInitialBalanceUsingDeployedContract() public {
    MyERC20 testMyERC = MyERC20(DeployedAddresses.MyERC20());
    uint expected = 1e6 * 1e13;
    Assert.equal(testMyERC.balanceOf(tx.origin), expected, "Owner should have 10000000 Token initially");
    } 
    // function testTotalSupply () public {
    //     myERC20 testMyERC = new myERC20();
    //     uint expected = 10000000;
    //     Assert.equal(testMyERC.balanceOf(tx.origin), expected, "Owner should have 10000000 Token initially");
    // }  
}



