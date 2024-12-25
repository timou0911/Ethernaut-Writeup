[Level 26. DoubleEntryPoint](https://ethernaut.openzeppelin.com/level/26)

## In A Nutshell

> Know the vulnerability and how to prevent it.

## Concept

1. 

## Level Target

1. Write the detection bot to raise an alert at certain conditions.

## Breakdown & Analysis

1. There are four contracts:

   1. `Forta`: Management for detection bots.
   2. `CryptoVault`: A vault holding two ERC20 tokens - `LGT` and `DET`.
   3. `LegacyToken(LGT)`: the `transfer()` function only executes `DET.delegateTransfer()`.
   4. `DoubleEntryPoint(DET)`: `fortaNotify()` calls `notify()` in `Forta`, and we need to finish the logic of function `handleTransaction` inside `notify()`.

## Detailed Steps

See [DetectionBot.sol](https://github.com/timou0911/Ethernaut-Writeup/blob/main/26.%20DoubleEntryPoint%20%E2%98%85%E2%98%85%E2%98%86%E2%98%86%E2%98%86/DetectionBot.sol).
