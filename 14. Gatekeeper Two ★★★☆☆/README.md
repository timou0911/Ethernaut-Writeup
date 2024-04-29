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
The first gate is same as [level 13. Gatekeeper One](https://github.com/timou0911/Ethernaut_Writeup/blob/main/13.%20Gatekeeper%20One%20%E2%98%85%E2%98%85%E2%98%85%E2%98%85%E2%98%86/README.md#modifier-gateone).

### Modifier `gateTwo()`
`extcodesize()` is an assembly-level method that enables us to determine the size of a contract's code at a specified address.

Within `extcodesize()`, we encounter the Yul method `caller()`, which retrieves the call sender. However, it does not account for `delegatecall()`, which returns `0x00...000` when applied, behaving similarly to `msg.sender` in the absence of `delegatecall()`.

This modifier required x(the code size of our contract) to be zero, which can be accomplished by using `delegatecall()` as described above.

### Modifier `gateThree()`


## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut_Writeup/blob/main/14.%20Gatekeeper%20Two%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).

## Inline Assembly & Yul in Solidity



## Bitwise Operations

