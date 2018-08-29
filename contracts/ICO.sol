pragma solidity^0.4.24;
import "./ERC20.sol";

contract ICO {
    ERC20 public IcoToken;
    ERC20 public DefToken = ERC20(0x907B98479a589abAFC72926837B726B0D3582C3F);
    uint public discountedEthTokensRemaining = 10000 * 10 ** 13;
    uint public discountedDefTokensRemaining = 10000 * 10 ** 13;
    mapping(address => bool) public whitelist;
    address public owner;
    enum token{ETH, DEF}
    uint public deploymentTime;
    bool public stopped = false;
    event Sale(address buyer, token EthOrDef, uint EthOrDefUnits, uint IcoUnits);
    event StopIco();
    
    constructor(address _IcoTokenAddress, address[] _whitelistedAddresses) public {
        owner = msg.sender;
        owner = IcoToken;
        deploymentTime = now;
        IcoToken = ERC20(_IcoTokenAddress);
        uint len = _whitelistedAddresses.length;
        for(uint i = 0; i  < len; i++) {
            whitelist[_whitelistedAddresses[i]] = true;
        }
    }
    
    modifier isActive() {
        require(now >= deploymentTime + 5 minutes);
        require(now < deploymentTime + 5 hours);
        require(stopped == false);
        _;
    }
    
    modifier isWhitelisted() {
        require(whitelist[msg.sender]);
        _;
    }
    
    function EthCost(uint _numTokens) public view returns(uint) {
        uint cost = 0;
        if (_numTokens > discountedEthTokensRemaining) {
            cost += discountedEthTokensRemaining * 10;
            _numTokens -= discountedEthTokensRemaining;
        } else {
            cost += _numTokens * 10;
            _numTokens = 0;
        }
        cost += _numTokens * 20;
        return cost;
    }
    
    function DefCost(uint _numTokens) public view returns(uint) {
        uint cost = 0;
        if (_numTokens > discountedDefTokensRemaining) {
            cost += discountedDefTokensRemaining/10;
            _numTokens -= discountedDefTokensRemaining;
        } else {
            cost += _numTokens / 10;
            _numTokens = 0;
        }
        cost += _numTokens / 5;
        return cost;
    }
    
    function Stop() public {
        require(msg.sender == owner);
        stopped = true;
        emit StopIco();
    }
    
    function BuyUsingEth(uint _numTokens) public payable isActive() isWhitelisted() {
        uint ethCost = EthCost(_numTokens);
        require(msg.value == ethCost);
        if(_numTokens < discountedEthTokensRemaining) {
            discountedEthTokensRemaining -= _numTokens;
        } else {
            discountedEthTokensRemaining = 0;
        }
        IcoToken.transfer(msg.sender, _numTokens);
        owner.transfer(address(this).balance);
        emit Sale(msg.sender, token.ETH, ethCost, _numTokens);
    }

    function BuyUsingDef(uint _numTokens) public isActive() isWhitelisted() {
        uint defCost = DefCost(_numTokens);
        DefToken.transferFrom(msg.sender, this, defCost);
        if(_numTokens < discountedDefTokensRemaining) {
            discountedDefTokensRemaining -= _numTokens;
        } else {
            discountedDefTokensRemaining = 0;
        }
        IcoToken.transfer(msg.sender, _numTokens);
        DefToken.transfer(owner, DefToken.balanceOf(this));
        owner.transfer(address(this).balance);
        emit Sale(msg.sender, token.DEF, defCost, _numTokens);
    }
    
}
