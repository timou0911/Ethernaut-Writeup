[Level 27. Good Samaritan](https://ethernaut.openzeppelin.com/level/27)

## In A Nutshell

> Never assume the error originated from the immediate target of the contract call; any contract in the downstream call chain can also trigger the same error.

## Concept

1. Custom errors.
2. Leaving interface implementation to users.

## Level Target

1. Drain all the balance from the `Wallet` contract.

## Breakdown & Analysis

1. Three contracts:

    1. `GoodSamaritan`: deploy instances of `Wallet` and `Coin`. The `requestDonation` function processes the donation by transferring either 10 coins or the remaining available coins, depending on the error check.
    2. `Wallet`: has two donate functions - `donate10()` which reverts `NotEnoughBalance` when balance < 10,  and `transferRemainder()` which transfers all the `Wallet`'s coins. 
    3. `Coin`: executes the actual coin transfer and notify the destination if it's a contract.

2. If we can make our `donate10()` revert `NotEnoughBalance`, it will execute `transferRemainder()` so that we can drain out all the coins.
3. In `donate10()`, it calls `coin.transfer()`. Inside `transfer()` it calls `notify()` in our contract. We can revert `NotEnoughBalance` in our own `notify()` implementation.
4. One thing worth noting is that we can't just revert every time since we still need to receive the coins, so we should add a check to revert only if `amount` <= 10.

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Writeup/blob/main/27.%20Good%20Samaritan%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).

## Custom Errors

Since `0.8.4`, Solidity provides a gas-efficient and readable way to handle errors. Programmers can record error messages just by defining the name and passing parameters to it.
