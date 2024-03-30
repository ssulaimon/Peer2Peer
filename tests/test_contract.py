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
    expectedAmount = convertToWei(amount=0.001)
    assert userBalance >= expectedAmount
