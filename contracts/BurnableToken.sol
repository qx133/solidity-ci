pragma solidity ^0.4.24;

import "./StandardToken.sol";


/**
 * @title Burnable Token
 * @dev Token that can be irreversibly burned (destroyed).
 */
contract BurnableToken is StandardToken {

  event Burn(address indexed burner, uint256 value);
  address creator;
  uint constant decimals = 13;

  modifier isCreator() {
      require(msg.sender == creator);
      _;
  }
  
  constructor() public {
      creator = msg.sender;
      //Assign creator 10^6 tokens
      mint(10 ** 6);
  }
  
  function mint(uint _value) isCreator() public {
      _mint(msg.sender, _value * 10 ** decimals);
  }
  
  /**
   * @dev Burns a specific amount of tokens.
   * @param _value The amount of token to be burned.
   */
  function burn(uint256 _value) public {
    _burn(msg.sender, _value);
  }

  /**
   * @dev Burns a specific amount of tokens from the target address and decrements allowance
   * @param _from address The address which you want to send tokens from
   * @param _value uint256 The amount of token to be burned
   */
  function burnFrom(address _from, uint256 _value) public {
    _burnFrom(_from, _value);
  }

  /**
   * @dev Overrides StandardToken._burn in order for burn and burnFrom to emit
   * an additional Burn event.
   */
  function _burn(address _who, uint256 _value) internal {
    super._burn(_who, _value);
    emit Burn(_who, _value);
  }
}
