[Level 17. Recovery](https://ethernaut.openzeppelin.com/level/17)

## In A Nutshell

> How to obtain the address of a newly deployed contract.

## Concept

1. One can determine the address of a specific contract by reviewing the transaction details on [Etherscan](https://etherscan.io/).
2. Alternatively, the address of a contract can be calculated.

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

## A Secretive Way to Store Ethers

A contract address can be calculated in Python using `sha3(rlp.encode([normalize_address(sender), nonce]))[12:]`. Since the calculation is deterministic, the address for a future nonce can be pre-computed, allowing ethers to be sent to it in advance. Those ethers can't barely be accessed before reaching that nonce. However, one won't be able to restore them back the nonce is missed.
