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

### Initialization Bytecode



### Runtime Bytecode

