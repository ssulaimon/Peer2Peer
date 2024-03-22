//SPDX-License-Identifier:MIT

pragma solidity >=0.8.0 <0.9.0;
import "../interfaces/ITokenInterface.sol";

contract Peer2Peer{
    struct ExchangeAssets{
        string name;
        address assetContract;
    }
    struct MarketOrder{
        string orderName;
        uint256 amount;
        address seller;
        address buyer;
        uint256 rating;
    }

    struct Moderator{
        address moderatorAddress;
        uint256 disputeResolved;

    }
    mapping(address=>uint256) addressToDisputeResolved;
    mapping (address=>uint256) AddressTorating;
    mapping(address=> uint256) addressToAmountDeposited;
    mapping(address=>uint256) moderatorDeposit;

    ExchangeAssets[] exchageAssets;
    MarketOrder[] marketOrders;
    Moderator[]moderators;
    function exchangeAssetsList()public view returns(ExchangeAssets[] memory){
        return exchageAssets;
    }

    function addAssets(string memory _name, address _assetContract) public{
        ExchangeAssets memory asset = ExchangeAssets({name: _name, assetContract: _assetContract});
        exchageAssets.push(asset);
    }

    function assetBalanceInContract(address _address)public view returns(uint256){
        return ITokenInterface(_address).balanceOf(address(this));
    }

    function marketOrdersList()public view returns(MarketOrder[]memory){
        return marketOrders;
    }

    function checkModeratorDeposit(address _address)public view returns(uint256){
        return moderatorDeposit[_address];
    }

    function viewAddressRating(address _address)public view returns(uint256){
        return AddressTorating[_address];
    }

    function viewModeratorDisputeResulved(address _address)public view returns(uint256){
        return addressToDisputeResolved[_address];
    }


}