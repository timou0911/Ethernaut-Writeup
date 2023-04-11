[Level 9. King](https://ethernaut.openzeppelin.com/level/0x3049C00639E6dfC269ED1451764a046f7aE500c6)

## Concepts



## Level Target

1. Take the kingship and avoid being taken when submitting the instance. (the level will try to reclaim it, and this should be denied)

## Breakdown & Analysis



## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Solution-and-Explanation/blob/main/9.%20King%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).

```js
await contract.prize().then(v => fromWei(v).toString()) // check the prize required to take the kingship
await contract._king() // check if kingship has been taken
```
