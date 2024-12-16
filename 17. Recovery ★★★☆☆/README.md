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
3. We can obtain `SimpleToken`'s address by reviewing our address's transaction on [Etherscan](https://etherscan.io/), and then search for the destination where our 0.001 ether is ultimately transferred.
4. Paste the address of the destination contract on Remix using `At Address`, and then call destroy()` to send our ether back.

## Detailed Steps



