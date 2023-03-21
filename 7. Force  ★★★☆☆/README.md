[Level 7. Force](https://ethernaut.openzeppelin.com/level/0xb6c2Ec883DaAac76D8922519E63f875c2ec65575)

## Concepts

1. The understanding of `selfdestruct`.

## Level Target

1. Make the balance of the contract greater than zero.

## Breakdown & Analysis

1. In order for a contract to receive ethers, it will need to implement either `receive` or `payable fallback` function. Unfortunately, since the contract is empty, any `send` and `transfer` will be reverted.

2. However, there’s a way to forcibly transfer ethers to any contract — **due to the mechanism of `selfdestruct`, once it is called in a contract, it can forcibly send its contract balance to any other address, regardless of whether it has `receive` or `payable fallback` function or not.**

3. Therefore, we need to develop a contract that performs `selfdestruct`. Also, it should be able to receive ethers so that it has the balance to send to the target contract.

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernat-Solution-and-Explanation/blob/main/7.%20Force%20%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).

