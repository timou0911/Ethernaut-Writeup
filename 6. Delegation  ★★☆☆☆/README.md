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

3. Since we’re using `delegatecall`, the function operates in the context of `Delegation`, meaning `pwn` changes the `owner` in `Delegation`, not `Delegate`.

## Detailed Steps

```js
// call `fallback`and specify the caller as well as the msg.data
// `encodeFunctionSignature` encodes the function name to its ABI signature
await contract.sendTransaction({from: player, data: web3.eth.abi.encodeFunctionSignature('pwn()')})
await contract.owner() === player // check if we're the owner now
```

## Explanation of `delegatecall`

