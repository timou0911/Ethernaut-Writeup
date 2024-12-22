[Level 23. Dex Two](https://ethernaut.openzeppelin.com/level/23)

## In A Nutshell

> Before swapping, checking `from` and `to` addresses is necessary.

## Concept

1. ERC20 Token Standard.
2. The necessary check for swap tokens.

## Level Target

1. Drain all balances of token1 and token2 from the `DexTwo` contract.

## Breakdown & Analysis

1. Different from [level 22. Dex](https://github.com/timou0911/Ethernaut-Writeup/tree/main/22.%20Dex%20%E2%98%85%E2%98%85%E2%98%86%E2%98%86%E2%98%86), the function `swap()` lacks the check of `from` and `to` addresses, which means we can swap token1 and token2 out with other tokens.
2. We create our own fake ERC20 token and swap them for token1 and token2. 

## Detailed Steps

