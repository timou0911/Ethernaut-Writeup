[Level 3. Coin Flip](https://ethernaut.openzeppelin.com/level/0xA62fE5344FE62AdC1F356447B669E9E6D10abaaF)

## Concepts

1. How to call other contracts’ functions.

    1. Use `interface` and then pass in the contract address when calling specific functions.
    
    2. Create a contract variable, and pass in the contract address to call a specific function.

2. Generating random numbers in Solidity.

3. The understanding of blocks as well as global variables like `blockhash` and `block.number`.

    1. `blockhash(uint256 blockNumber) returns (bytes32)`: hash of the given block when `blocknumber` is one of the 256 most recent blocks; otherwise returns zero.
    
    2. `block.number()`: current block number.
    
    3. Other global variables can be found in [Solidity Docs](https://docs.soliditylang.org/en/v0.8.19/units-and-global-variables.html).

## Target

1. Guess the correct outcome of a coin flip game 10 times in a row.

## Breakdown & Analysis

1. The factors that determine the side of a coin flip.

    1. The code utilizes the block hash of the previous block and a large number to determine the outcome of a coin flip.
    
    2. Since the large number won’t change, the only factor we should concern about is the block number.
    
2. The method to retrieve block number.

    1. In fact, it is not necessary to determine the block number of our transaction. Rather, we simply need to place the transaction of our malicious contract and the transaction calling the flip function in the same block.
    
    2. In order to perform this trick, we can create a function(`attack`) in our malicious contract that calls the `flip` function in the target contract, so both the `attack` function we call and the `flip` function that the `attack` calls will be packed into the same block!

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernat-Solution-and-Explanation/blob/main/3.%20Coin%20Flip%20%E2%98%85%E2%98%85%E2%98%86%E2%98%86%E2%98%86/Attack.sol).

## How to Safely Generate Random Numbers in Solidity?

Due to the determinacy of blockchain, it’s difficult to generate random numbers in Solidity.

A trivial way to generate random numbers is by doing calculations on global variables about blocks, such as `blockhash` or `block.timestamp`. Nonetheless, these variables can be manipulated by miners to some degree, so it’s definitely not a safe way to generate randomness.

A proper method to add randomness to our smart contracts is by collecting data outside the chain. Namely, use <b>oracles</b> to obtain real-world information. [Chainlink VRF](https://docs.chain.link/vrf/v2/subscription/examples/get-a-random-number) is the most popular way to achieve it. We can add it to our code to gain powerful randomness.

