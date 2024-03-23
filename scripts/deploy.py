from brownie import Peer2Peer, interface
from scripts.modules import walletAccount, recentDeployedContract, convertToWei


def deployApp():
    print(recentDeployedContract())


def transferTokenToContract():
    contract = Peer2Peer[-1].address
    tokenInterface = interface.ITokenInterface(
        "0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238"
    )
    address = walletAccount()
    value = convertToWei(amount=1)
    # address _from, address _to, uint256 _value
    transfer = tokenInterface.transferFrom(
        address, contract, 1000000, {"from": address}
    )


def main():
    transferTokenToContract()
