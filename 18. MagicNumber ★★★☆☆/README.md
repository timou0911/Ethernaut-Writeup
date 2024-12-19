[Level 18. MagicNumber](https://ethernaut.openzeppelin.com/level/0x2132C7bc11De7A90B87375f282d36100a29f97a9)

## In A Nutshell

> Deconstructing contracts from EVM level.

## Concept

1. EVM opcode and understanding of stack.
2. Contract bytecode comprises two parts: initialization bytecode and runtime bytecode.

## Level Target

1. Create a contract `Solver` with a size of no more than 10 bytes (10 opcodes).

## Breakdown & Analysis

1. Writing Solidity to break this level is impossible due to the size limit, so we need to write opcode instead.
2. We need to divide our contract into initialization bytecode and runtime bytecode, and then address them separately.
3. Initialization bytecode should copy the runtime bytecode and then return it; runtime bytecode should return 42 in this case.

## Detailed Steps

`Full bytecode = initialization bytecode + runtime bytecode`

One thing to note is that we must push the opcode's parameters in the stack before using them, and stack is LIFO (Last In First Out).

### Runtime Bytecode

Runtime bytecode is the actual code deployed on chain, so we should limit its size to no more than 10 bytes.

1. To return 42(`0x2a`), the opcode used is `RETURN`(`0xf3`). It takes two parameters: offset(the memory location of `0x2a`) and its size.
2. To store `0x2a` in memory, the opcode used is `MSTORE`(`0x52`) It takes two parameters: offset(the memory location where `0x2a` will be stored) and the value to store(`0x2a`).
3. All parameters must be stored in the stack before use, so we need to call `PUSH1`(`0x60`) for each parameter.

---

1. Push `0x2a` in stack as the value for `MSTORE` -> `PUSH1 0x2a` -> `602a`.
2. Push `0x70` in stack as the offset for `MSTORE` -> `PSH1 0x50` -> `6070`.
3. Store `0x2a` in memory location `0x70` -> `MSTORE 0x70, 0x2a` -> `52`.
4. Push `0x20` in stack as the offset for `RETURN -> `PUSH1 0x20` -> `6020`.

### Initialization Bytecode

