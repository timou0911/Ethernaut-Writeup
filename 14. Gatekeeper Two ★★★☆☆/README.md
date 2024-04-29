[Level 14. Gatekeeper Two](https://ethernaut.openzeppelin.com/level/0x0C791D1923c738AC8c4ACFD0A60382eE5FF08a23)

## In A Nutshell

> Some advanced concepts such as inline assembly and bitwise operations.

## Concept

1. Inline assembly.
2. Bitwise operations.

## Level Target

1. Pass all the modifiers in function `enter()`.

## Breakdown & Analysis

### Modifier `gateOne()`
The first gate is same as [level 13. Gatekeeper One](https://github.com/timou0911/Ethernaut_Writeup/blob/main/13.%20Gatekeeper%20One%20%E2%98%85%E2%98%85%E2%98%85%E2%98%85%E2%98%86/README.md).

### Modifier `gateTwo()`
`extcodesize()` is an assembly-level method allowing us to get the size of a contract's code at a given address.

Inside `extcodesize()`, we encounter another method `caller()`, which returns the call sender. However, it excludes `delegatecall()`, which returns `0x00...` when `delegatecall()` is applied.

### Modifier `gateThree()`


## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut_Writeup/blob/main/14.%20Gatekeeper%20Two%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).

## Inline Assembly & Yul in Solidity



## Bitwise Operations

