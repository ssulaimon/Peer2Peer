//SPDX-License-Identifier:MIT
pragma solidity >=0.8.0 <0.9.0;

import "../interfaces/ITokenInterface.sol";

contract Peer2Peer{
    address owner;
    constructor (){
        owner = msg.sender;
    }
    event Deposited(address indexed _depositor, uint256 indexed _amount, address indexed _tokenContract);
    event CreatedOffer(address indexed creator, string indexed assetType, uint256 indexed quantity);
    mapping (address=> uint256) _addressToRating;
    uint256 private _tradeId;
    struct Trade{
        uint256 tradeId;
        string  assetType;
        uint256 quantity;
        uint256 price;
        address creator;
        string discriptions;
        address payingWith;
        uint256 walletReputation;
    }

    struct Moderator{
        address moderatorAddress;
        uint256 amountStaked;
        uint256 resolvedDispute;
        uint256 reputation;
    }
    Moderator[] moderators;

    Trade[] _trades;
    //numbers of trades created by an address
    mapping(address=>uint256) numbersOfOpenTrade;
    // check the balance of user balance relative to an asset
    mapping (address=> mapping(address=> uint256))_addressToAssetBalance;

    // check amount of asset deposited to wallet
    function assetBalance(address _assetContractAddress)public view returns(uint256){
        return ITokenInterface(_assetContractAddress).balanceOf(address(this));
    }
// user deposit an asset to the contract
    function assetDeposit (address _depositor, address _assetContractAddress, uint256 _amount)public{
        _addressToAssetBalance[_depositor][_assetContractAddress] = _amount;
       emit Deposited(_depositor, _amount, _assetContractAddress);
    }
// check user balance of asset
    function addressToAssetBalance(address _owner, address _assetContractAddress)public view returns(uint256){
        return _addressToAssetBalance[_owner][_assetContractAddress];
    }
    // active trade list
    function activeTrades()public view returns(Trade[]memory){
        return _trades;
    }

    // check if number of active trade number by user is not more than required by single wallet
    function _isAddressAllowedTrade(address _address)internal view returns(bool){
        if(numbersOfOpenTrade[_address] <=5){
            return true;
        }else{
            return false;
        }
    }
    // check if user have enough asset balance to complete a trade or not
function _isEnoughBalance(address _address, uint256 _amount, address _assets) internal view  returns(bool){
    if(_addressToAssetBalance[_address][_assets] < _amount){
        return false;
    }else{
        return true;
    }
}

// create a market offer for users to browse 
    function createOffer(uint256 _quantity, uint256 _price, string memory _description, address _assets, string memory _assetType)public returns(bool){
        require(_isAddressAllowedTrade(msg.sender), "You have more enough minumum open trade!!!");
        uint256 amountNeeded = _price * _quantity;
        require(_isEnoughBalance(msg.sender, amountNeeded, _assets), "You don't have enough balance required!!!");
        Trade memory trade = Trade({tradeId: _tradeId, assetType: _assetType, quantity:_quantity, price: _price, creator:msg.sender, discriptions:_description, payingWith:_assets, walletReputation:_addressToRating[msg.sender]});
        _trades.push(trade);
        _tradeId +=1;
        numbersOfOpenTrade[msg.sender] +=1;
        _addressToAssetBalance[msg.sender][_assets]-= amountNeeded;
        emit Deposited(msg.sender, amountNeeded, _assets);
        return true;
    }

// transfering the balance of an asset to a wallet address(testing purposes)
    function transerToken (address _assetAddres, address _to, uint256 _value)public{
        require(msg.sender == owner, "Only Owner can call this function !!!");
        ITokenInterface(_assetAddres).transfer(_to, _value);
    }

    function checkOpenTrades(address _address)public view returns(uint256){
        return numbersOfOpenTrade[_address];
    }

 function numbersOfModerators()public view returns(uint256){
    return moderators.length;
 }

}