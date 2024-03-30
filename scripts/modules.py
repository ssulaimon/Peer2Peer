from brownie import accounts, network, config, Peer2Peer
from web3 import Web3

ASSETS = [
    {
        "name": "WETH",
        "contractAddress": "0xC558DBdd856501FCd9aaF1E62eae57A9F0629a3c",
    },
    {
        "name": "USDC",
        "contractAddress": "0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238",
    },
    {
        "name": "USDT",
        "contractAddress": "0xaA8E23Fb1079EA71e0a56F48a2aA51851D8433D0",
    },
]


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


def asset(index: int):
    if index == None or index == 0:
        return ASSETS[0]
    elif index == 1:
        return ASSETS[1]
    else:
        return ASSETS[2]
