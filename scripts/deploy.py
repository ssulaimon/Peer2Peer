from brownie import Peer2Peer, interface, exceptions
from scripts.modules import walletAccount, recentDeployedContract, convertToWei, asset

from web3 import Web3


def deployContract():
    contract = Peer2Peer.deploy({"from": walletAccount()})
    print(contract.address)


def contractBalance():
    contract = Peer2Peer[-1]
    token = asset(index=0)
    balance = contract.assetBalance(token["contractAddress"])
    print(f"The contract balance for {token['name']} is {balance}")


def depositAsset():
    token_contract = asset(index=0)
    token = interface.ITokenInterface(token_contract["contractAddress"])
    dappAddress = recentDeployedContract()
    amount = convertToWei(amount=0.001)
    address = walletAccount()
    print("approving token....")
    approve = token.approve(
        dappAddress,
        amount,
        {
            "from": address,
        },
    )
    allowance = token.allowance(address, dappAddress)
    print(f"transfering {allowance}")
    deposit = token.transferFrom(
        address,
        dappAddress,
        amount,
        {
            "from": address,
        },
    )

    contract = Peer2Peer[-1]
    deposit = contract.assetDeposit(
        address,
        token_contract["contractAddress"],
        amount,
        {
            "from": address,
        },
    )
    print("deposited.....")


def transfer():
    contract = Peer2Peer[-1]
    address = walletAccount()
    token_contract = asset(index=0)
    amount = convertToWei(amount=0.001)
    transferToken = contract.transerToken(
        token_contract["contractAddress"],
        address,
        amount,
        {
            "from": address,
        },
    )
    transferToken.wait(1)
    print("transfered")


## createOffer(uint256 _quantity, uint256 _price, string memory _description, address _assets, string memory _assetType)
def createOrder():
    contract = Peer2Peer[-1]
    amount = convertToWei(amount=0.001)
    token_contract = asset(index=0)
    address = walletAccount()
    try:
        createOffer = contract.createOffer(
            1,
            amount,
            "Buying MTN rechard card",
            token_contract["contractAddress"],
            "None Reload able card",
            {
                "from": address,
            },
        )
    except exceptions.VirtualMachineError as error:
        if error == "You don't have enough balance required!!!":
            value = Web3.from_wei(amount)
            print(f"You need {value} Eth!!!")
        else:
            print(error)
    except ValueError as error:
        print(error)


def openTrades():
    contract = Peer2Peer[-1]
    offers = contract.trades()
    print(offers[0][1])


def main():
    createOrder()
