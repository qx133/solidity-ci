pragma solidity ^0.4.24;

import "./StandardToken.sol";
import "./BurnableToken.sol";


contract NewToken is StandardToken, BurnableToken {
    string public constant name = "Token Name";
    string public constant symbol = "SYM";
    uint8 public constant decimals = 13;

    constructor() public {
        _mint(tx.origin, 1000000 * 10**uint(decimals));
    }
}