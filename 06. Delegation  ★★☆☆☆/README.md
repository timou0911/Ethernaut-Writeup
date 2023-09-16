[Level 6. Delegation](https://ethernaut.openzeppelin.com/level/0x73379d8B82Fda494ee59555f333DF7D44483fD58)

## Concepts

1. The understanding of `delegatecall`.

2. The understanding of `fallback` function.

3. How to generate a function signature.

## Level Target

1. Take ownership of Delegation contract.

## Breakdown & Analysis

1. The objective is to take ownership of `Delegation` contract, but the function capable of achieving this objective is located in `Delegate` contract. Fortunately, `Delegation` contract can invoke `Delegate` contract using `delegatecall` method.

2. In order to use `delegatecall`, we will need to call `fallback` function and include the function signature in `msg.data`, specifying the function we want to call (`pwn()` here).

3. Since we’re using `delegatecall`, the `msg.sender` in `Delegate` is our EOA, not `Delegation`.

## Detailed Steps

```js
// call `fallback`and specify the caller as well as the msg.data
// `encodeFunctionSignature` encodes the function name to its ABI signature
await contract.sendTransaction({from: player, data: web3.eth.abi.encodeFunctionSignature('pwn()')})
await contract.owner() === player // check if we're the owner now
```

## `call` v.s. `delegatecall`

`call` and `delegatecall` are two low-level functions that are used to send messages to other contracts and execute functions in those contracts.

**When we use `call` in contract A to invoke a function in contract B, the function uses B’s context and changes the data in B. On the other hand, if we use `delegatecall` in contract A to invoke B’s function, it uses the context of A, modifying A’s data.**

Here’s a plot I made:

<img width="821" alt="call v.s. delegatecall" src="https://user-images.githubusercontent.com/99255480/226260772-4d85d304-3ed6-4d7e-aca0-9f78a7a4bd3d.png">

Usually, `call` is used to send ethers to other contracts, and `delegatecall` is most seen in proxy contracts. **It is important to exercise caution when using `delegatecall`, as its misuse can potentially result in vulnerabilities in our contracts.**
