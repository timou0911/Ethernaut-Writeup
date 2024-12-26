[Level 28. Gatekeeper Three](https://ethernaut.openzeppelin.com/level/28)

## In A Nutshell

> Several concepts in prior Ethernaut levels combined.

## Concept

1. How to retrieve storage variables.

## Level Target

1. Pass all the modifiers in function `enter()`.

## Breakdown & Analysis

### Modifier `gateOne()`
It requires `msg.sender` to be the `owner` and `tx.origin` can't be the `owner`, which can be simply done by calling `construct0r()` with our malicious contract.

This is similar to the combination of [level 2. Fallout](https://github.com/timou0911/Ethernaut-Writeup/tree/main/02.%20Fallout%20%E2%98%85%E2%98%86%E2%98%86%E2%98%86%E2%98%86) and [level 4. Telephone](https://github.com/timou0911/Ethernaut-Writeup/tree/main/04.%20Telephone%20%E2%98%85%E2%98%86%E2%98%86%E2%98%86%E2%98%86).

### Modifier `gateTwo()`
To pass `gateTwo`, we have two methods

1. Make the `createTrick()` call and `getAllowance()` call in the same transaction, making `block.timestamp` consistent.
2. Using `await web3.eth.getStorageAt("SimpleTrick Contract Address", 2);` to retrieve the value of slot 2. (Same as [level 12. Privacy](https://github.com/timou0911/Ethernaut-Writeup/tree/main/12.%20Privacy%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86))

### Modifier `gateThree()`
We will need to transfer more than 0.001 ether to the target contract and not implement `receive()` functions in our malicious contract.

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Writeup/blob/main/28.%20Gatekeeper%20Three%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).
