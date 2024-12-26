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
    2. `Wallet`: 
    3. `Coin`: 

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Writeup/blob/main/27.%20Good%20Samaritan%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).
