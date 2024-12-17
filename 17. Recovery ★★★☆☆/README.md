[Level 17. Recovery](https://ethernaut.openzeppelin.com/level/0xAF98ab8F2e2B24F42C661ed023237f5B7acAB048)

## In A Nutshell

> How to get a specific contract's address.

## Concept

1. One can determine the address of a specific contract by reviewing the transaction details on [Etherscan](https://etherscan.io/).
2. Alternatively, the address of a contract can be calculated by `keccak256(address, nonce)`.

## Level Target

1. Recover (or remove) the 0.001 ether from the lost contract address.

## Breakdown & Analysis

1. When we get a new instance of contract `Recovery`, it deploys a new `SimpleToken` contract and sends our 0.001 ether to it.
2. From the `SimpleToken` contract we can see that function `destroy()` can send tokens(the balance of `SimpleToken`) back to us, but only if we know its address.
3. We can obtain the address on [Etherscan](https://etherscan.io/) or calculate on our own.

## Detailed Steps

1. After we get the new instance, we obtain `SimpleToken`'s address by reviewing our address's transaction on [Etherscan](https://etherscan.io/).
2. Search for the destination(`SimpleToken`) where our 0.001 ether is ultimately transferred.
3. Paste `SimpleToken`'s code and its address on Remix using `At Address`, then call `destroy()` to send our ether back.

## 

