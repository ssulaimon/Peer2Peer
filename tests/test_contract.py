from brownie import Peer2Peer, interface
from scripts.modules import recentDeployedContract, convertToWei, walletAccount


def test_approval():
    tokenInterface = interface.ITokenInterface(
        "0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238"
    )
    contractAddress = recentDeployedContract()
    value = convertToWei(amount=3)
    address = walletAccount()
    approveValue = tokenInterface.approve(contractAddress, value, {"from": address})
    # address _owner, address _spender
    allowance = tokenInterface.allowance(address, contractAddress)
    assert allowance == value


def test_depositedTokenBalance():
    contract = Peer2Peer[-1]
    checker = contract.assetBalanceInContract(
        "0x17396d7e7Ed759E772dB33c83C2F75fdB8d2c1d2"
    )
    value = convertToWei(amount=3)
    assert checker == value
