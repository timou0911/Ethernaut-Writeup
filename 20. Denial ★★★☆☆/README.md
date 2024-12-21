[Level 20. Denial](https://ethernaut.openzeppelin.com/level/20)

## In A Nutshell

> No fixed amount specified in an external call could cause a denial of service attack vector.

## Concept

1. A fixed amount should be set in an external call.
2. `fallback()` and `receive()` ahs 2300 gas limit.

## Level Target

1. Deny the owner from withdrawing funds when he calls `withdraw()`.

## Breakdown & Analysis

1. 

## Detailed Steps

