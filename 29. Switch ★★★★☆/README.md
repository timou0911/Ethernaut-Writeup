[Level 29. Switch](https://ethernaut.openzeppelin.com/level/29)

## In A Nutshell

> Understanding the way calldata is encoded.

## Concept

1. `calldatacopy` opcode.
2. How are function selectors and data encoded in calldata.

## Level Target

1. Flip the switch to `true`.

## Breakdown & Analysis

1. `turnSwitchOn()` is the only function that can set the switch to `true`, but it's modified and can't be accessed.
2. `flipSwitch()` is the only function we can access since it's not modified by `onlyThis` and has a low-level `call` inside it.
3. `flipSwitch()` has a modifier `onlyOff`, and `calldatacopy` copies 4 bytes from offset 68 from calldata to memory, then checks if it equals to `turnSwitchOff()`'s selector.
4. We can pass `onlyOff` by setting byte 68 to byte 71 to `turnSwitchOff()`'s selector(`0x20606e15`).
5. We use low-level `call` to trigger `flipSwitch()` instead of directly calling `flipSwitch()` because it will store data in calldata rather than memory.
6. To trigger `flipSwitch()`, the first four bytes of `data` should be its selector(`0x30c13ade`), followed by the value of 
 parameter `_data`.
7. Let's skip the first four bytes and look at the rest.
     1. Byte 4 to byte 35 of the calldata should be the offset of the actual function we want to call(`turnSwitchOn()`).
     2. Byte 36 to byte 67 are placeholders and can be random values.
     3. Byte 68 to byte 99 should be `turnSwitchOff()`'s function elector(`0x20606e15`) for `onlyOff`'s verification.
     4. The next 32 bytes will be the length information(`0x04`).
     5. The last 32 bytes will be the `turnSwitchOn()`'s function selector(`0x76227e12`).

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Writeup/blob/main/29.%20Switch%20%E2%98%85%E2%98%85%E2%98%85%E2%98%85%E2%98%86/Attack.sol).

## How is Calldata Encoded?

