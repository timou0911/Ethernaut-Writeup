[Level 14. Gatekeeper Two](https://ethernaut.openzeppelin.com/level/0x0C791D1923c738AC8c4ACFD0A60382eE5FF08a23)

## In A Nutshell

> Some advanced concepts such as inline assembly and bitwise operations.

## Concept

1. Inline assembly and Yul.
2. Bitwise operations.
3. `delegatecall()`

## Level Target

1. Pass all the modifiers in function `enter()`.

## Breakdown & Analysis

### Modifier `gateOne()`
The first gate is same as [level 13. Gatekeeper One](https://github.com/timou0911/Ethernaut_Writeup/blob/main/13.%20Gatekeeper%20One%20%E2%98%85%E2%98%85%E2%98%85%E2%98%85%E2%98%86/README.md#modifier-gateone).

### Modifier `gateTwo()`
`extcodesize()` is an assembly-level method that enables us to determine the size of a contract's code at a specified address.

Within `extcodesize()`, the Yul method `caller()` retrieves the call sender. However, it does not consider `delegatecall()`, which returns `0x00...000` when used, functioning akin to `msg.sender` in the absence of `delegatecall()`.

This modifier required x(the code size of our contract) to be zero, which can be accomplished by using `delegatecall()` as described above.

--

Another method is calling the target contract in our attack contract's `constructor`.

### Modifier `gateThree()`
Our objective is to equate the left to the right side, which represents the maximum value of `uint64`. In binary, this value is `111...111` with a length of 64 bits.

| p | q | p ^ q |
| ---- | ---- | ---- |
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

On the left side of the `==`, there's a bitwise operation called exclusive or, or XOR (`^`). It compares two binary values, returning 1 for bits that are different and 0 for bits that are the same. One operand is the `uint64` representation of `msg.sender`, while the other is `_gateKey`.

To achieve a result with all bits set to 1, each bit of `_gateKey` should be the complement of the corresponding bit in the `uint64` representation of `msg.sender`. This can be accomplished by using another bitwise operation, NOT (`~`), which negates each bit of the operand.

| p | ~p |
| - | - |
| 0 | 1 |
| 1 | 0 |

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut_Writeup/blob/main/14.%20Gatekeeper%20Two%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).

## Inline Assembly & Yul in Solidity



## Bitwise Operations

