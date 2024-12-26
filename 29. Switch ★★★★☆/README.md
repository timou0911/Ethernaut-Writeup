[Level 29. Switch](https://ethernaut.openzeppelin.com/level/29)

## In A Nutshell

> Understanding the way calldata is encoded.

## Concept

1. `calldatacopy` opcode.
2. How are function selectors and data encoded in calldata.

## Level Target

1. Flip the switch to `true`.

## Breakdown & Analysis

1. `flipSwitch()` is the only function we can access since it's not modified by `onlyThis`, and it has a low-level `call` inside it.
2. `flipSwitch()` has a modifier `onlyOff`, and `calldatacopy` copies 4 bytes from offset 68 from calldata to memory, then checks if it equals to `turnSwitchOff()`'s selector.
3. We can pass `onlyOff` by setting byte 68 to byte 71 to `turnSwitchOff()`'s selector(`0x20606e15`).

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Writeup/blob/main/29.%20Switch%20%E2%98%85%E2%98%85%E2%98%85%E2%98%85%E2%98%86/Attack.sol).
