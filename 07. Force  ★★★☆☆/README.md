[Level 7. Force](https://ethernaut.openzeppelin.com/level/0xb6c2Ec883DaAac76D8922519E63f875c2ec65575)

## In A Nutshell

> `selfdestruct` can forcibly send ether to any other address.

## Concepts

1. The understanding of `selfdestruct`.

## Level Target

1. Make the balance of the contract greater than zero.

## Breakdown & Analysis

1. In order for a contract to receive ethers, it will need to implement either `receive` or `payable fallback` function. Unfortunately, since there's nothing but a kitten existing in the contract, any `send` and `transfer` will be reverted.

2. However, there’s a way to forcibly transfer ethers to any contract — **due to the mechanism of `selfdestruct`, once it is called in a contract, it can forcibly send its contract balance to any other address, regardless of whether it has `receive` or `payable fallback` function or not.**

3. Therefore, we need to develop a contract that performs `selfdestruct`. Also, it should be able to receive ethers so that it has the balance to send to the target contract.

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernat-Solution-and-Explanation/blob/main/7.%20Force%20%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).

```js
await getBalance(contract.address) // check the contract balance after calling `selfdestruct`.
```

## `selfdestruct` Explanation

`selfdestruct` is an interesting method in Solidity since it can “delete” a contract.

After `selfdestruct` is called, the contract's data is cleared and the space it previously occupied in the current block is freed(more specifically, the current Merkle Patricia tree), making its bytecode inaccessible for future blocks, so that no one can interact with it anymore. **Nonetheless, the contract itself remains on the blockchain, as its bytecode and data are still stored in previous blocks.**

`selfdestruct` is a mechanism that allows the contract to be terminated under certain circumstances. **One common use case is to prevent further damage when the contract has been compromised by an attacker or has encountered a critical error. Also, selfdestruct is useful when updating the contract, developers can easily transfer the fund to the upgraded contract.**

## Things to Evaluate When Auditing a Contract

1. When writing a contract, remember to add conditions to make sure that `selfdestruct` won’t be called by anyone else.

2. **Similarly, when considering an investment opportunity, it's important to thoroughly evaluate whether the project manager or the contract owner has the ability to directly invoke `selfdestruct`. Additionally, it's essential to examine the designated receiver in the `selfdestruct` function. If the receiver is not specified or is an unverified address, it may be risky to invest money in it since investors could be rug pulled.**

3. Never rely on `address(this).balance` since it can be altered easily.

## Negative Gas

Since it is beneficial to clean the code from the blockchain, programmers are encouraged by the Ethereum community to use `selfdestruct`. After calling it, half the total gas used is returned, and this is negative gas.
