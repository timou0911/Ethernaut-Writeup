[Level 24. Puzzle Wallet](https://ethernaut.openzeppelin.com/level/24)

## In A Nutshell

> Slot collision and context-preserving when using `delegatecall`.

## Concept

1. Function selector.
2. Slot arrangement.
3. Context-preserving in multiple `delegatecall`.

## Level Target

1. Become the admin of `PuzzleProxy`.

## Breakdown & Analysis

1. The goal is to become the admin of `PuzzleProxy`, so we can overwrite either `admin` in `PuzzleProxy` or `maxBalance` in `PuzzleWallet` since they are both in slot 1.
2. The two functions that can modify `maxBalance` are `init()` and `setMaxBalance()`. The former has a check of whether `maxBalance` is 0, which we can't pass, so we focus on cracking `setMaxBalance()`.
3. `setMaxBalance()` has a modifier `onlyWhitelisted`, which we need to pass by making our address whitelisted. However, only the `owner` in `PuzzleWallet` can add addresses.
4. To become the `owner`, we should overwrite either `owner` or `pendingAdmin`(both are in slot 0). The latter can be easily set by calling `proposeNewAdmin()`. So now we become the `owner` and can make our address whitelisted.
5. Now `onlyWhitelisted` is passed, the last thing to do is pass the requirement `address(this).balance == 0`. `execute()` is the only function that can reduce the balance of `PuzzleWallet`. (current contract balance is 0.001 ether)
6. However, we can only reduce the amount of our balance. We need a way to make the `balances` record go wrong. The solution is to call `deposit()` twice within a transaction with `msg.value` of 0.001 ether. This will make `balances[msg.sender]` record 0.002 ether, but the actual contract balance will be 0.001(before hacking) + 0.001(from `msg.value`) = 0.002 ether. Then we can take out all the contract balance.
7. But there's a flag `depositCalled` restricting only one `deposit()` within a `multicall()`. In our second `deposit()`, we shouldn't directly call it, instead, we call another `multicall()` to call `deposit()` since `depositCalled` will be set to `false` again.

``` plaintext
               | --------- deposit --------- balances[msg.sender] += 0.001 ether
multicall ---- |
               | --------- multicall --------- deposit --------- balances[msg.sender] += 0.001 ether
```

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Writeup/blob/main/24.%20Puzzle%20Wallet%20%E2%98%85%E2%98%85%E2%98%85%E2%98%85%E2%98%86/Attack.sol).

