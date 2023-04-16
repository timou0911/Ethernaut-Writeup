[Level 9. King](https://ethernaut.openzeppelin.com/level/0x3049C00639E6dfC269ED1451764a046f7aE500c6)

## Concepts

1. Three methods to send ether to other contracts. (`transfer()`, `send()`, and `call()`)
2. `receive()` function.

## Level Target

1. Take the kingship and avoid being taken when submitting the instance. (the level will try to reclaim it, and this should be denied)

## Breakdown & Analysis

1. In order to claim the kingship, we will need to call `receive` with ether equal or more than the current prize. 

2. To ensure that the kingship cannot be taken when submitting the instance, we need a contract without implementing `fallback` and `receive`, so all we need is a contract that has a function to call `receive`.

3. It's important to note that neither send nor transfer will work in this scenario, as the operation in receive costs more than the 2300 gas limit imposed on both methods.

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Solution-and-Explanation/blob/main/9.%20King%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).

```js
await contract.prize().then(v => fromWei(v).toString()) // check the prize required to take the kingship
await contract._king() // check if kingship has been taken
```
