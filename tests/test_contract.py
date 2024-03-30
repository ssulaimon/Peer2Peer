from brownie import Peer2Peer, interface
from scripts.modules import (
    recentDeployedContract,
    convertToWei,
    walletAccount,
    asset,
    convertToWei,
)


def test_contractBalance():
    token = asset(index=0)
    contract = Peer2Peer[-1]
    balanceWrappedEth = contract.assetBalance(token["contractAddress"])
    expectedAmount = convertToWei(amount=0.001)
    assert balanceWrappedEth >= expectedAmount


def test_walletBalance():
    address = walletAccount()
    token = asset(index=0)
    contract = Peer2Peer[-1]
    userBalance = contract.addressToAssetBalance(address, token["contractAddress"])
    expectedAmount = 0
    assert userBalance >= expectedAmount


def test_numberOfTrade():
    contract = Peer2Peer[-1]
    address = walletAccount()
    openTradeNumber = contract.checkOpenTrades(address)
    assert openTradeNumber == 1


def test_numbersOfModerators():
    contract = Peer2Peer[-1]
    moderators = contract.numbersOfModerators()
    assert moderators == 0
