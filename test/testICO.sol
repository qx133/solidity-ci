pragma solidity ^0.4.24;
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/ICO.sol";
import "../contracts/BurnableToken.sol";

contract testICO {
   function testStop() public {
       ICO ico = ICO(DeployedAddresses.ICO());
       Assert.equal(ico.stopped(), false, "ICO should be active");
   }
   
   function testCosts() public {
       ICO ico = ICO(DeployedAddresses.ICO());
       Assert.equal(ico.EthCost(5000 * (10 ** 13)), 0.5 ether, "5000 tokens should cost 0.5ETH initially");
       Assert.equal(ico.EthCost(15000 * (10 ** 13)), 2 ether, "15000 tokens should cost 2ETH initially");
       Assert.equal(ico.DefCost(5000 * (10 ** 13)), 500 * (10 ** 13), "5000 tokens should cost 500DEF initially");
       Assert.equal(ico.DefCost(15000 * (10 ** 13)), 2000 * (10 ** 13), "15000 tokens should cost 2000DEF initially");
   }
}