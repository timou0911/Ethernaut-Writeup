[Level 16. Preservation](https://ethernaut.openzeppelin.com/level/0x7ae0655F0Ee1e7752D7C62493CEa1E69A810e2ed)

## In A Nutshell

> `delegatecall` on libraries could be risky, especially for contract libraries that have their state.

## Concept

1. The understanding of `delegatecall`.
2. The concept of slots.

## Level Target

1. Take ownership of `Preservation` contract.

## Breakdown & Analysis

1. The only code that directly accesses `owner` is in the `constructor` so we cannot change it directly. However, the storage layouts of `Preservation` and `LibraryContract` are not aligned, which poses a risk when using `delegatecall`.
2. Since the variable `storedTime` in `LibraryContract` is aligned with `timeZone1Library` in `Preservation, when we call `setFirstTime()`, it `delegatecall` the function `setTime()` in `LibraryContract`, but changes `timeZone1Library`'s value.
3. We first call `setFirstTime()` with the address of our malicious contract, making the next `setFirstTime()` call to be directed to our contract.
4. The second `setFirstTime()` call will take place inside our own `setTime()`, we will need the same storage layout to be able to change `owner` in `Preservation`.

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Writeup/blob/main/16.%20Preservation%20%E2%98%85%E2%98%85%E2%98%85%E2%98%85%E2%98%86/Attack.sol).

## Mitigations

1. Libraries shouldn't store any state variables.
2. Use the keyword `library` on `LibraryContract` rather than the keyword `contract`.
