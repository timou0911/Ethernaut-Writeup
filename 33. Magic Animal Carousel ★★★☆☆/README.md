[Level 33. Magic Animal Carousel](https://ethernaut.openzeppelin.com/level/33)

## In A Nutshell

>

## Concept

1. Bitwise operation.
2. 

## Level Target

1. We need to break the rule: if someone calls `setAnimalAndSpin(_animal)` and then immediately retrieves `carousel[currentCrateId)]`, it should be the encoding of `_animal`.

## Breakdown & Analysis

1. Each element in mapping `carousel` follows the structure below:
   ``` plaintext
   ----------------------------------------------------------------------------------
   | Animal Name (10 bytes) | Next Crate ID (2 bytes) | Address of Owner (20 bytes) |
   ----------------------------------------------------------------------------------
2. Three functions:
   * `setAnimalAndSpin()`: add an animal to `carousel`. `nextCrateId` and `carousel[nextCrateId]` are computed with the current `carousel[nextCrateId]`. Also, the lengths of animal names are restricted to at most 10 bytes.
   * `changeAnimal()`: modify the animal only if the owner is `msg.sender`. One thing worth noting is that the lengths of animal names are not restricted to at most 10 bytes.
   * `encodeAnimalName()`: Encodes the given animal name to at most 12 bytes.
3. We can exploit the different length restrictions in `setAnimalAndSpin()` and `changeAnimal()`.

## Detailed Steps

