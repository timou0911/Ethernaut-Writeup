[Level 14. Gatekeeper Two](https://ethernaut.openzeppelin.com/level/0x0C791D1923c738AC8c4ACFD0A60382eE5FF08a23)

## In A Nutshell

> 

## Concept

1. 

## Level Target

1. Pass all the modifiers in function `enter()`.

## Breakdown & Analysis

### Modifier `gateOne()`
We've come across a similar concept in [level 4. Telephone](https://github.com/timou0911/Ethernaut_Writeup/blob/main/04.%20Telephone%20%E2%98%85%E2%98%86%E2%98%86%E2%98%86%E2%98%86/README.md).

Simply create a contract to invoke our target, then `tx.origin` and `msg.sender` will be different since `tx.origin` refers to our EOA, while `msg.sender` represents the contract we've deployed.

### Modifier `gateTwo()`


### Modifier `gateThree()`


## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut_Writeup/blob/main/14.%20Gatekeeper%20Two%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).
