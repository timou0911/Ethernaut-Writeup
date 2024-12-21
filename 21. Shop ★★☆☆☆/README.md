[Level 21. Shop](https://ethernaut.openzeppelin.com/level/21)

## In A Nutshell

> It's dangerous to change the state based on untrusted contracts.

## Concept

1. Never leave an interface unimplemented or leave interface implementation to unknown contracts.
2. `pure` and `view` functions can still be manipulated even though they can't modify states.

## Level Target

1. Get the item from the shop for less than the designated price.

## Breakdown & Analysis

1. Similar to [level 11. Elevator](https://github.com/timou0911/Ethernaut-Writeup/tree/main/11.%20Elevator%20%E2%98%85%E2%98%85%E2%98%86%E2%98%86%E2%98%86), we have to return different value based on a state.
2. But unlike level 11., the function in this level's interface is restricted as `view`, which means we need another variable to determine the return value - `isSold`.

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Writeup/blob/main/21.%20Shop%20%E2%98%85%E2%98%85%E2%98%86%E2%98%86%E2%98%86/Attack.sol).
