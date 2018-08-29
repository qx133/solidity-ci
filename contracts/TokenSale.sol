pragma solidity ^0.4.24;

import "./SafeMath.sol";
import "./NewToken.sol";
import "./DefaultToken.sol";

contract TokenSale {
    
    using SafeMath for uint256;

    uint256 public constant ethLimit = 1e18;
    uint256 public constant defLimit = 1000e13;

    uint256 public ethReceived = 0;
    uint256 public defReceived = 0;

    uint256 public startTime;
    uint256 public endTime;

    NewToken public token;
    DefaultToken public defToken;

    bool public endEvent = false;

    mapping(address => bool) public whitelistedAddress;

    address public owner;

    event WhiteList(address whitelistedAddress, bool status);
    event SaleUsingEth(address buyer, uint256 ethValue);
    event SaleUsingDef(address buyer, uint256 defValue);
    
    constructor (address _tokenAddress, address _defAddress) public {
        owner = msg.sender;
        whitelistedAddress[owner] = true;
        token = NewToken(_tokenAddress);
        defToken = DefaultToken(_defAddress);
        startTime = block.timestamp + 0 * 60;
        endTime = block.timestamp + 5 * 60 * 60;
    }

    modifier onlyWhitelisted() {
        require(whitelistedAddress[msg.sender] == true, "Only whitelisted address can join ICO");
        _;
    }

    modifier eventStarted() {
        require(now >= startTime, "Event not yet started");
        _;
    }

    modifier eventNotEnded() {
        require(endEvent == false, "Event has stopped");
        require(now <= endTime, "Event ended");
        _;
    }

    function buyUsingEth() public payable onlyWhitelisted eventStarted eventNotEnded{

        if (ethLimit < ethReceived) {
            token.transfer(msg.sender, msg.value.mul(5000));
        }

        else if (ethLimit >= ethReceived.add(msg.value)) {
            token.transfer(msg.sender, msg.value.mul(10000)); 
        }

        else {
            token.transfer(msg.sender, ethLimit.sub(ethReceived) * 10000);
            token.transfer(msg.sender, msg.value.sub(ethLimit.sub(ethReceived)) * 5000);
        }

        ethReceived = ethReceived.add(msg.value); 
        owner.transfer(msg.value);
        emit SaleUsingEth(msg.sender, msg.value);
    }

    function buyUsingDef(uint256 _defAmount) public payable onlyWhitelisted eventStarted eventNotEnded{
        
        if (defLimit < defReceived) {
            token.transferFrom(owner, msg.sender, _defAmount.mul(500000));
        }

        else if (ethLimit >= (defReceived + _defAmount)) {
            token.transferFrom(owner, msg.sender,  _defAmount.mul(1000000)); 
        }

        else {
            token.transferFrom(owner, msg.sender, defLimit.sub(defReceived) * 1000000);

            token.transferFrom(owner, msg.sender, _defAmount.sub(defLimit.sub(defReceived)) * 500000);
        }

        defReceived = defReceived.add(_defAmount); 
        defToken.transferFrom(msg.sender, owner, _defAmount);
        emit SaleUsingDef(msg.sender, _defAmount);
    }

    function stopEvent() public {
        endEvent = true;
    }

    function addWhitelistedAddress(address _address, bool _status) public {
        whitelistedAddress[_address] = _status;
        emit WhiteList(_address, _status);
    }
}