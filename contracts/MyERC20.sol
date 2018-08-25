pragma solidity ^0.4.19;

import "./BurnableToken.sol";
import "./StandardToken.sol";

contract MyERC20 is StandardToken, BurnableToken{
    string public constant name = "myERC20";
	string public constant symbol = "MRC";
	uint8 public constant decimals = 13;
    address public owner;    

    constructor() public {
		owner = msg.sender;
		_mint(msg.sender, 1e6*10**13);
// 		totalSupply = 1e6 * 1e13;
// 		balances[msg.sender] = totalSupply;
// 		Transfer(address(0), msg.sender, totalSupply);
	}
}
