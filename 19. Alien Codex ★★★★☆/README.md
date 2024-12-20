[Level 19. Alien Codex](https://ethernaut.openzeppelin.com/level/19)

## In A Nutshell

> How array storage works and the risk of array length underflow.

## Concept

1. Dynamic array in perspective of the slots.
2. The underflow of a dynamic array length.

## Level Target

1. Claim ownership of this contract.

## Breakdown & Analysis

1. We first need to call `makeContact()` to make the modifier `contacted` pass.
2. We can make the array's length underflow by calling `retract()`, allowing it to access all the storage slots.
3. The `codex`'s length is stored at slot 1, and `codex[0]` is at slot `keccak256(1) + 0`.
4. To make `codex` access slot 0, the index will be `codex[2^256 - keccak256(1)]`.

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Writeup/tree/main/19.%20Alien%20Codex%20%E2%98%85%E2%98%85%E2%98%85%E2%98%85%E2%98%86).

## Exploitation

Before Solidity `0.8`, EVM doesn't check array length operations' overflow and underflow. When a dynamic array's length underflow occurs, it allows manipulation of all storage slots. 
