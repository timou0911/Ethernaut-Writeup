# Ethernat-Solution-and-Explanation
## 1. Fallback ★☆☆☆☆
### Level Target

1. Take ownership of the contract.
2. Withdraw all funds from the contract. (Only the owner can do so)

### Break Down & Analyze

1. Two ways to take ownership:
    1. Contribute more eth than the owner does → unrealistic, you can’t contribute more than 0.001 ether at one transaction, and the owner already has 1000 ether of contribution when the contract is built. (unfair, right?)
    2. So the other way to hack the contract is from receive function, in order to call receive, you’ll need to satisfy two conditions.
        * send some eth when calling receive.
        * already had contributions before.
        
        Once you meet these two conditions and successfully call receive, the first target is fulfilled.
        
2. Only the owner can withdraw the funds:
    1. Since only the owner can withdraw funds, it is required to complete the first target before this step.
    2. Once you become the owner, it is effortless to withdraw all the funds!

### Detailed Steps (work through the console)

```js
await contract.contribute({ value: toWei("0.000001") }) // contribute first, so that you'll be able to call receive
await contract.getContribution().then(fund => fromWei(fund.toString())) // confirm if you have contributed
await sendTransaction({from: player, to: contract.address, value: toWei('0.000001')}) // call receive with some ether sent
await contract.owner() === player // check if you're the owner now
await contract.withdraw() // take all the funds out from the contract!!!
```

## 2. Fallout ★☆☆☆☆

### ### Target

1. Take ownership of the contract

### Break Down & Analyze

The constructor has typo: Fal”1”out. Since the wrong spelling, it is served as a function rather than a constructor, so everyone can call it and take the ownership.

### Detailed Steps (work through the console)

```js
await contract.Fal1out() // call the wrong-spelled function to take ownership
await contract.owner() === player // check if you're the owner now
```

## 3. Coin Flip ★★☆☆☆
