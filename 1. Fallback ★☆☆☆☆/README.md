[Level 1. Fallback](https://ethernaut.openzeppelin.com/level/0x3c34A342b2aF5e885FcaA3800dB5B205fEfa3ffB)

### Concepts

1. The basis of coding logic.
    1. Find which lines of code you can use to crack the level.
    2. In order to access these lines of code, the requirement you’ll need to fulfill.
2. The understanding of `msg.value`.
    1. You can send some eth to the contract when calling a function, and the amount of eth you send can be accessed by `msg.value`.

## Level Target

1. Take ownership of the contract.
2. Withdraw all funds from the contract. (Only `owner` can do so)

## BreakDown & Analysis

1. Two ways to take ownership:
    1. Contribute more eth than `owner` does → unrealistic, you can’t contribute more than 0.001 ether at one transaction, plus the owner already has 1000 ethers of contribution when the contract is built. (unfair, right?)
    2. So the other way to hack the contract is from `receive` function, in order to call `receive`, you’ll need to satisfy two conditions.
        * send some eth when calling receive.
        * already had contributions before.
        
        Once you meet these two conditions and successfully call receive, the first target is fulfilled.
        
2. Only the owner can withdraw the funds:
    1. Since only the owner can withdraw funds, it is required to complete the first target before this step.
    2. Once you become the owner, it is effortless to withdraw all the funds!

## Detailed Steps (work through the console)

```js
await contract.contribute({ value: toWei("0.000001") }) // contribute first, so that you'll be able to call receive
await contract.getContribution().then(fund => fromWei(fund.toString())) // confirm if you have contributed
await sendTransaction({from: player, to: contract.address, value: toWei('0.000001')}) // call receive with some ether sent
await contract.owner() === player // check if you're the owner now
await contract.withdraw() // take all the funds out from the contract!!!
```
