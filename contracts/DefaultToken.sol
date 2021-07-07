pragma solidity ^0.4.19;

import "./StandardToken.sol";
import "./BurnableToken.sol";

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;


  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);


  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  function Ownable() public {
    owner = msg.sender;
  }


  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }


  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

}

/**
* @title LendingBlockToken
* @dev LND or LendingBlock Token
* Max supply of 1 billion
* 18 decimals
* not transferable before end of token generation event
* transferable time can be set
*/
contract DefaultToken is StandardToken, BurnableToken {
	string public constant name = "default";
	string public constant symbol = "DEF";
	uint8 public constant decimals = 13;

	constructor() public {
		uint256 totalSuppl = 1e9 * 1e13;
		_mint(msg.sender, totalSuppl);
		emit Transfer(address(0), address(this), totalSuppl);
	}

	function() public {
	    this.transfer(msg.sender, 1000 * 1e13);
	}
}