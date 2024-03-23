from brownie import accounts, network, config, Peer2Peer
from web3 import Web3


def walletAccount() -> str:
    if network.show_active() == "development":
        return accounts[0]
    else:
        return accounts.add(
            config["networks"][network.show_active()]["wallets"]["account-one"]
        )


def convertToWei(amount: int):
    return Web3.to_wei(amount, "ether")


def recentDeployedContract() -> str:
    return Peer2Peer[-1].address
