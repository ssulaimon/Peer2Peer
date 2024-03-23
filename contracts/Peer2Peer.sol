//SPDX-License-Identifier:MIT

pragma solidity >=0.8.0 <0.9.0;
import "../interfaces/ITokenInterface.sol";

contract Peer2Peer{

    constructor(){
        exchageAssets.push(ExchangeAssets({name: "USDT", assetContract: 0xe69D0Aa17482DefcEfbA92298d47fAe73615fcB0}));
        exchageAssets.push(ExchangeAssets({name: "USDC", assetContract: 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238}));
        exchageAssets.push(ExchangeAssets({name: "EURC", assetContract: 0x08210F9170F89Ab7658F0B5E3fF39b0E03C594D4}));
         exchageAssets.push(ExchangeAssets({name: "WrappedETH", assetContract: 0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9}));
         
        
    }

    enum Assets{
        USDT,
        USDC,
        TT,
        WETH
    }

    //model for each asset accepted on the contract
    struct ExchangeAssets{
        string name;
        address assetContract;
    }

    // model for market orders that can be created
    struct MarketOrder{
        string orderName;
        uint256 amount;
        address seller;
        address buyer;
        uint256 rating;
        address exchangeAsset;
    }
    // model for each moderators that would be on the platform
    struct Moderator{
        address moderatorAddress;
        uint256 disputeResolved;

    }

// mapping an address to the number of dispute they resolved previously
    mapping(address=>uint256) addressToDisputeResolved;
// mapping ofaddress to their rating already earned on the system
    mapping (address=>uint256) addressTorating;
// address to the all time amount already deposited to the platform
    mapping(address=> uint256) addressToAmountDeposited;
// amount of token deposited by a moderator 
    mapping(address=>uint256) moderatorDeposit;

// list of assets accepted for exchange availabale
    ExchangeAssets[] exchageAssets;
// list of oders needed by a peer in the system
    MarketOrder[] marketOrders;
//moderators list in the system. 
    Moderator[]moderators;

//view assets list accepted for exchange
    function exchangeAssetsList()public view returns(ExchangeAssets[] memory){
        return exchageAssets;
    }
 // adding an exchange assets function. Only caled by admin

    function addAssets(string memory _name, address _assetContract) public{
        ExchangeAssets memory asset = ExchangeAssets({name: _name, assetContract: _assetContract});
        exchageAssets.push(asset);
    }

    // check the balance of particular asset locked on the contract 

    function assetBalanceInContract(address _address)public view returns(uint256){
        return ITokenInterface(_address).balanceOf(address(this));
    }

// view list of market orders waiting to be filled by peers in the system
    function marketOrdersList()public view returns(MarketOrder[]memory){
        return marketOrders;
    }

// view the amount of token staked by a particular moderator

    function checkModeratorDeposit(address _address)public view returns(uint256){
        return moderatorDeposit[_address];
    }

//  view the ratings of a particular address
    function viewAddressRating(address _address)public view returns(uint256){
        return addressTorating[_address];
    }

// view the number of dispute been resolved by a moderator
    function viewModeratorDisputeResulved(address _address)public view returns(uint256){
        return addressToDisputeResolved[_address];
    }

//  struct MarketOrder{
//         string orderName;
//         uint256 amount;
//         address seller;
//         address buyer;
//         uint256 rating;
//     }
    function createMarketOrder(address  _asset, string memory _name, uint256 _amount)public returns(bool){
        address _buyer;
        uint256 _rating = addressTorating[msg.sender];
        MarketOrder memory marketOrder = MarketOrder({orderName: _name, amount:_amount, seller:msg.sender, buyer:_buyer, rating: _rating, exchangeAsset: _asset});
        marketOrders.push(marketOrder);
        return true;
    }
    // approve a token 
    function approveToken(address _token, uint256 _value)external returns(bool){
        bool isApproved = ITokenInterface(_token).approve( address(this), _value);
        return isApproved;

    }
// check amount allowed to spend
    function checkAllowance(address _tokenAddress)external view returns(uint256){
        return ITokenInterface(_tokenAddress).allowance(msg.sender, address(this));
    }


}