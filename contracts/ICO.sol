pragma solidity ^0.4.19;

import "./BurnableToken.sol";
import "./StandardToken.sol";
import "./MyERC20.sol";
import "./SafeMath.sol";




contract ICO{
    using SafeMath for uint256;
    MyERC20 public token;
    MyERC20 public dToken;
    address public wallet;
    uint public _totalSupply;
    uint public startTimePre;
    uint public endTimePre;

    uint public ethLimit = 10**13;
    uint public defLimit = 1000;

	uint256 public rateMain;
    bool public icoStop=false;
    bool public eventEnded;
	mapping(address => bool) public whitelistedAddressPre;
	mapping(address => bool) public whitelistedAddressMain;
	mapping(address => uint256) public contributedValue;
	mapping(address => uint) balances;

	event TokenPre(address indexed participant, uint256 value, uint256 tokens);
// 	event TokenMain(address indexed participant, uint256 value, uint256 tokens);
// 	event WhitelistPre(address indexed whitelistedAddress, bool whitelistedStatus);
// 	event WhitelistMain(address indexed whitelistedAddress, bool whitelistedStatus);

	/**
	* @dev all functions can only be called before event has ended
	*/
	modifier eventNotEnded() {
		require(eventEnded == false);
		_;
	}
	
	constructor() public{
	    wallet = msg.sender;
	    startTimePre = now;
        endTimePre = now + 5 hours;
	}

    function MyERC20TokenEvent(address _contractAddress) public {
		token = MyERC20(_contractAddress);

	}
	
	function createDEF (address _tokenAddress) public{
	    dToken = MyERC20(_tokenAddress);
	}


    uint private _value = 1*10**13;
    
    function() public payable eventNotEnded{
        require(now >= startTimePre && now <= endTimePre);
        uint tokens;
        if (msg.value <= _value && _totalSupply <= _value) {
            tokens = msg.value.mul(10);
        } else {
            if (_totalSupply < _value && msg.value >= _value){
                tokens = _value.sub(_totalSupply) .mul(10);
                tokens += msg.value.sub(_value).mul(5);
            }
            else{
                tokens = msg.value.mul(5);
            }
            
        }
        
        _totalSupply = _totalSupply.add(tokens);
        token.transfer(msg.sender,tokens);
        TokenPre(msg.sender, _totalSupply, tokens);//record contribution in logs
        forwardFunds();//send eth for safekeeping
    }
    
    function BuyUsingDEF(uint defToken) public eventNotEnded {
        require(now >= startTimePre && now <= endTimePre);
        
        uint tokens;
        if (defToken <= defLimit) {
            tokens = 10;
        } else {
            if (_totalSupply < _value && defToken >= defLimit){

                tokens = 10 + defToken.sub(1000)*5;
            }
            else{
                tokens = defToken * 5;
            }
            
        }
        
        _totalSupply = _totalSupply.add(tokens);
        //token.transfer(msg.sender,tokens); //send bought tokens to his account
        dToken.transferFrom(msg.sender,wallet,defToken); //transfer def tokens to owner
        TokenPre(msg.sender, _totalSupply, tokens);//record contribution in logs

    }

    function forwardFunds() internal {
		wallet.transfer(msg.value);
	}
	
	function stopIco() public{
	    eventEnded= true;
	}
	
	



    
}
