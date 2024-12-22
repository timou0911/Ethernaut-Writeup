[Level 22. Dex](https://ethernaut.openzeppelin.com/level/22)

## In A Nutshell

> In Solidity, division rounds to the floor.

## Concept

1. There's no floating point in Solidity.
2. Division should be cautiously approached, as precision loss can result in serious consequences.

## Level Target

1. Drain all of at least 1 of the 2 tokens from the contract, and allow the contract to report a "bad" price of the assets.

## Breakdown & Analysis

1. The formula in the function `getSwapPrice()` contains a flaw. The division will result in having more balance before each swap.

|              | DEX - Token1 | DEX - Token2 | Player - Token1 | Player - Token2 |
| ------------ |--------------|--------------|-----------------|-----------------|
| Before Swap  |      100     |      100     |        10       |        10       |
| After Swap 1 |      110     |      90      |        0        |        20       |
| After Swap 2 |      86      |      110     |        24       |        0        |
| After Swap 3 |      110     |      80      |        0        |        30       |
| After Swap 4 |      69      |      110     |        41       |        0        |
| After Swap 5 |      110     |      45      |        0        |        65       |
| After Swap 6 |      0       |      90      |       110       |        20       |

## Detailed Steps

