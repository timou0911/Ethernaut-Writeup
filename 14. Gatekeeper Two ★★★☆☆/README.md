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

Within `extcodesize()`, the Yul method `caller()` retrieves the call sender. There are two scenarios causing `extcodesize()` to return 0:

1. The caller is an EOA.
2. The caller is a CA, but is calling inside `constructor` (i.e., during the contract initialization phase).

The second scenario meets our requirement since using an EOA will not satisfy the first gate's criteria.

### Modifier `gateThree()`
On the left side of the `==`, there's a bitwise operation called exclusive or, or XOR (`^`). It compares two binary values, returning 1 for bits that are different and 0 for bits that are the same. Also, `p ^ q = r` means `r ^ q = p`.

| p | q | r |
| - | - | - |
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

Here we need to make `uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max`. We can simply get `_gateKey` by computing `uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ type(uint64).max` ,and pass `_gateKey` to the function `enter()`.


## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut_Writeup/blob/main/14.%20Gatekeeper%20Two%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).

## Inline Assembly & Yul in Solidity



## Bitwise Operations

Bitwise operations can directly manipulate the individual bits of binary numbers. These operations work at the bit level and include:

* AND (`&`): Results in 1 only if both bits are 1.
* OR (`|`): Results in 1 if at least one of the bits is 1.
* XOR (`^`): Results in 1 if the bits are different.
* NOT (`~`): Inverts the bits, turning 0s into 1s and 1s into 0s.
