[Level 20. Denial](https://ethernaut.openzeppelin.com/level/20)

## In A Nutshell

> No fixed amount specified in an external call could cause a denial of service attack vector.

## Concept

1. A fixed amount should be set in an external call.
2. `fallback()` and `receive()` has a 2300 gas limit.

## Level Target

1. Deny the owner from withdrawing funds when he calls `withdraw()`.

## Breakdown & Analysis

1. In the function `withdraw()` it transfers 1% of the funds to both `owner` and `partner`(ourselves).
2. Since there's no check on the result of `call()`, whether we revert the `call()` or not, `owner` can still receive the funds.
3. However, since there's no gas limit specified in `call()`, all the gas will be forwarded to the callback function. We can then make `withdraw()` fail` by draining all the gas inside `receive()` or `fallback()`.

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Writeup/blob/main/20.%20Denial%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).

## 
