[Level 10. Re-entrancy](https://ethernaut.openzeppelin.com/level/0x2a24869323C0B13Dff24E196Ba072dC790D52479)

## Concept

1. Re-entrancy attack.
2. `receive()` function.

## Level Target

1. Steal all the funds from the contract.

## Breakdown & Analysis

This is a classic example of how re-entrancy can be dangerous.

1. We create a malicious contract and call `withdraw()`. (Be sure to implement `receive()` or `fallback()` in your contract to receive ETH.)
 
2. The key to re-entrancy is creating recursion. Since our `receive()` or `fallback()` will be triggered when we receive ETH, we can call `withdraw()` again in it.

3. Notice that funds are transferred to our contract before the balance is deducted. So the balance has not yet changed when `withdraw()` is called for the second time! This allows us to withdraw more funds than intended.

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Solution-and-Explanation/blob/main/10.%20Re-entrancy%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).

## Two Key in Re-entrancy & How to Avoid it

