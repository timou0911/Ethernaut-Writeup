[Level 13. Gatekeeper One](https://ethernaut.openzeppelin.com/level/0xb5858B8EDE0030e46C0Ac1aaAedea8Fb71EF423C)

## In A Nutshell

> Type casting in Solidity and how to designate gas amount.

## Concept

1. Difference between `msg.sender` and `tx.origin`.
2. `gasleft()` function.
3. Type casting/conversion in Solidity.

## Level Target

1. Pass all the modifiers in function `enter()`.

## Breakdown & Analysis

### Modifier `gateOne()`
We've come across a similar concept in [level 4. Telephone](https://github.com/timou0911/Ethernaut_Writeup/blob/main/04.%20Telephone%20%E2%98%85%E2%98%86%E2%98%86%E2%98%86%E2%98%86/README.md).
Simply create a contract to invoke our target, then `tx.origin` and `msg.sender` will be different since `tx.origin` refers to our EOA, while `msg.sender` represents the contract we've deployed.

### Modifier `gateTwo()`


## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut_Writeup/blob/main/13.%20Gatekeeper%20One%20%E2%98%85%E2%98%85%E2%98%85%E2%98%85%E2%98%86/Attack.sol).

## 
