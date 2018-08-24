pragma solidity ^0.4.24;
import "truffle/Assert.sol"; // this import is automatically injected by Remix.
import "truffle/DeployedAddresses.sol";
import "../contracts/BurnableToken.sol";

contract testBurnableToken {
   function testBalance() public {
       BurnableToken burnable = BurnableToken(DeployedAddresses.BurnableToken());
       uint expected = 10 ** 6 * 10 ** 13;
       Assert.equal(burnable.balanceOf(tx.origin), expected, "should have 10^6 BurnableToken");
   }
}