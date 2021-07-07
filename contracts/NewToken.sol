pragma solidity ^0.4.24;

import "./StandardToken.sol";
import "./BurnableToken.sol";


contract NewToken is StandardToken, BurnableToken {
    string public constant name = "MyICO";
    string public constant symbol = "ICO";
    uint8 public constant decimals = 18;

    address public owner;

    constructor() public {
        owner = msg.sender;
        _mint(msg.sender, 100000 * 10 ** 18);
    }
}