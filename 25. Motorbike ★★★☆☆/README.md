[Level 25. Motorbike](https://ethernaut.openzeppelin.com/level/25)

## In A Nutshell

> 

## Concept

1. [EIP-1967](https://eips.ethereum.org/EIPS/eip-1967).
2. UUPS upgradeable patterns.
3. Openzeppelin's Initializable contract.

## Level Target

1. Call `selfdestruct()` on `Engine`(implementation) and make `Motorbike`(Proxy) unusable.

## Breakdown & Analysis

1. 

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Writeup/blob/main/25.%20Motorbike%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).

**This solution no longer works after the Dencun upgrade since `selfdestruct()` won't remove the code. See [EIP-6780](https://eips.ethereum.org/EIPS/eip-6780).**
