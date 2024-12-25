[Level 26. DoubleEntryPoint](https://ethernaut.openzeppelin.com/level/26)

## In A Nutshell

> Understand the vulnerability and how to prevent it.

## Concept

1. Content inside `msg.data`.

## Level Target

1. Write the detection bot to raise an alert at certain conditions.

## Breakdown & Analysis

1. There are four contracts:

   1. `Forta`: Management for detection bots.
   2. `CryptoVault`: A vault holding two ERC20 tokens - `LGT` and `DET`, but can only transfer `LGT` tokens.
   3. `LegacyToken(LGT)`: the `transfer()` function only executes `DET.delegateTransfer()`.
   4. `DoubleEntryPoint(DET)`: `fortaNotify()` calls `notify()` in `Forta`, and we need to finish the logic of function `handleTransaction` inside `notify()`.

2. If someone tries to transfer `LGT` tokens out, it will trigger `DoubleEntryPoint.delegateTransfer(address to, uint256 value, address origSender)` and perform `fortaNotify` modifier, trying to call `handleTransaction()`, which protects the `CryptoVault` from being drained out.
3. To implement the protection of the `CryptoVault` inside `handleTransaction()`, we can raise an alert for any transaction with `origSender` of the contract `CryptoVault`.
4. To get the address of `origSender`, we can parse `msg.data`, which is combined with 4 bytes of function selector and parameters.
5. Lastly, remember to register the bot by calling `setDetectionBot()` using your wallet before submitting the instance.

## Detailed Steps

See [DetectionBot.sol](https://github.com/timou0911/Ethernaut-Writeup/blob/main/26.%20DoubleEntryPoint%20%E2%98%85%E2%98%85%E2%98%86%E2%98%86%E2%98%86/DetectionBot.sol).
