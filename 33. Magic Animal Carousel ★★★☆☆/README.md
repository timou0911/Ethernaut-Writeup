[Level 33. Magic Animal Carousel](https://ethernaut.openzeppelin.com/level/33)

## In A Nutshell

> How to deal with low-level data manipulation.

## Concept

1. Bitwise operation.
2. Compacting data in storage slots.

## Level Target

1. We need to break the rule: if someone calls `setAnimalAndSpin(_animal)` and then immediately retrieves `carousel[currentCrateId)]`, it should be the encoding of `_animal`.

## Breakdown & Analysis

1. Each element in mapping `carousel` follows the structure below:
   ``` plaintext
   ----------------------------------------------------------------------------------
   | Animal Name (10 bytes) | Next Crate ID (2 bytes) | Address of Owner (20 bytes) |
   ----------------------------------------------------------------------------------
   ```
   * The element can reference the next animal by storing `nextCrateId` in it.
2. Three functions:
   * `setAnimalAndSpin()`: add an animal to `carousel`. `nextCrateId` and `carousel[nextCrateId]` are computed with the previous `carousel[nextCrateId]`. Also, the lengths of animal names are restricted to at most 10 bytes.
   * `changeAnimal()`: modify the animal only if the owner is `msg.sender`. One thing worth noting is that the lengths of animal names are not restricted to at most 10 bytes.
   * `encodeAnimalName()`: Encodes the given animal name to at most 12 bytes.
3. We can exploit the different length restrictions in `setAnimalAndSpin()` and `changeAnimal()`, modifying the 2-byte Next Crate ID by calling `changeAnimal()` with a specific string.
4. Since `carousel[nextCrateId]` depends on the previous `carousel[nextCrateId]`, we can beat this level if `carousel[nextCrateId]` already has data in it before calling `setAnimalAndSpin()`. We can parse this strategy into three steps:
   1. Call `setAnimalAndSpin()` with an arbitrary string, it will be stored in  `carousel[0]`.
   2. Call `changeAnimal()` with a string to set the 2-byte Next Crate ID to `0xFFFF`.
   3. Call `setAnimalAndSpin()` with another string, it will be stored in `carousel[0]`, then we have achieved the level's goal.

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Writeup/blob/main/33.%20Magic%20Animal%20Carousel%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).
