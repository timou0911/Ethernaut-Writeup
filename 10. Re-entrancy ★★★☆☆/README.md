[Level 10. Re-entrancy](https://ethernaut.openzeppelin.com/level/0x2a24869323C0B13Dff24E196Ba072dC790D52479)

## Concept

1. Re-entrancy attack.
2. `receive()` & `fallback()` function.

## Level Target

1. Steal all the funds from the contract.

## Breakdown & Analysis

This is a classic example of how re-entrancy can be dangerous.

1. We create a malicious contract and call `withdraw()`. (Be sure to implement `receive()` or `fallback()` in your contract to receive ETH.)
 
2. The key to re-entrancy is calling the function again before the previous call has completed. Since our `receive()` will be triggered when we receive ETH, we can call `withdraw()` again in it. 
    * Unlike recursion, where the new invocation can only be caused by internal call, re-entrancy can be caused by an internal or external action.

4. Notice that funds are transferred to our contract before the balance is deducted. So the balance has not yet changed when `withdraw()` is called for the second time! This allows us to withdraw more funds than intended.

5. Finally, we need to set a termination condition in our `receive()` to check if the contract balance is 0. (Having a termination condition is important since each call costs gas, and we don't want to run out of the gas and cause the transaction to be reverted.)

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Solution-and-Explanation/blob/main/10.%20Re-entrancy%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).

## Two Keys in Re-entrancy

1. External call (e.g. `fallback` & `receive`)

2. Shared States (Shared before and after calling)

## Mitigation

1. [Rentrancy Gaurd](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/ReentrancyGuard.sol)

2. Check-Effect-Interaction (CEI)

   Check requirements -> Modify state within the contract -> Interact with other contracts.

3. [Pull Payment Strategy](https://docs.openzeppelin.com/contracts/2.x/api/payment#PullPayment)
