[Level 13. Gatekeeper One](https://ethernaut.openzeppelin.com/level/13)

## In A Nutshell

> Type casting in Solidity and how to designate gas amount.

## Concept

1. Difference between `msg.sender` and `tx.origin`.
2. `gasleft()` function.
3. Type casting/conversion in Solidity.

## Level Target

1. Pass all the modifiers in function `enter()`.

## Breakdown & Analysis

### Modifier `gateOne()`
We've come across a similar concept in [level 4. Telephone](https://github.com/timou0911/Ethernaut_Writeup/blob/main/04.%20Telephone%20%E2%98%85%E2%98%86%E2%98%86%E2%98%86%E2%98%86/README.md).

Simply create a contract to invoke our target, then `tx.origin` and `msg.sender` will be different since `tx.origin` refers to our EOA, while `msg.sender` represents the contract we've deployed.

### Modifier `gateTwo()`
`gasleft()` is a built-in global function used to check the remaining gas in a function call.

In our scenario, we aim to make the remaining gas a multiple of 8191. This requires adjusting the gas sent to the call, which can be achieved using the `call{gas: gasSent}(signature)`. However, determining the exact gas cost for our call poses a challenge.

One approach is to navigate the debugger in Remix, although this requires knowledge of EVM opcodes. Alternatively, we can iterate through an additional gas amounts from 0 to 8191-1, testing each possibility until we find the desired gas remainder. Since the minimum gas amount for an external call is 21000, we need to establish a threshold for our calculations.

Another advantage of using `call()` instead of directly calling a contract is that `call()` does not revert if it fails to pass a modifier. In contrast, directly calling the contract will trigger a revert if the modifier check fails.

### Modifier `gateThree()`
We start by showcasing `bytes8 _gateKey` with the value `0x b0 b1 b2 b3 b4 b5 b6 b7`, where each `b_i` represents one byte. Then, we dissect each require() statement to determine the mask.

* `uint32(uint64(_gateKey)) == uint16(uint64(_gateKey))`:

>`uint32(uint64(_gateKey))` equals to `b4 b5 b6 b7`; `uint16(uint64(_gateKey))` equals to `b6 b7`, which means if `0x b4 b5 b6 b7 == 0x b6 b7`, then `b4 b5` must be zero.

* `uint32(uint64(_gateKey)) != uint64(_gateKey)`:

>`uint32(uint64(_gateKey))` equals to `b4 b5 b6 b7`; `uint64(_gateKey)` equals to `b0 b1 b2 b3 b4 b5 b6 b7`, which means if `b4 b5 b6 b7 != b0 b1 b2 b3 b4 b5 b6 b7`, then `b0 b1 b2 b3` must not be zero.

* `uint32(uint64(_gateKey)) == uint16(uint160(tx.origin))`:

>`uint32(uint64(_gateKey))` equals to `b4 b5 b6 b7`; `uint16(uint160(tx.origin))` equals the first two bytes of `tx.origin`, which means `b6 b7` should be first two bytes of `tx.origin`.

We can deduce that `b0 b1 b2 b3` must not be zero, `b4 b5` should be zero, and `b6 b7` should match the last two bytes of `tx.origin`. We then apply the mask `0xFFFFFFFF0000FFFF` to `tx.origin` with bitwise `AND` operation to derive the desired key. (`0xFF` = 11111111; `0x00` = 00000000; `i & 1 = i`; `i & 0 = 0`)

_Two hexadecimals = 1 byte._

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut_Writeup/blob/main/13.%20Gatekeeper%20One%20%E2%98%85%E2%98%85%E2%98%85%E2%98%85%E2%98%86/Attack.sol).

## `gasleft()` function

> `gasleft() returns (uint256)`: remaining gas.

`gasleft()` estimates gas cost and protects against re-entrancy attacks.

_Before version 0.5, `gasleft()` was named `msg.gas()`._

## Type Conversion in Solidity

* Casting from small-sized `uint`/`int` to large-sized `uint`/`int`: value doesn't change, padding bits are added to the left.

     ```Solidity
     uint8 a = 0x12;
     uint16 b = uint16(a); // b = 0x0012, padding bits are added to the left (explicit conversion)
     uint16 c = b; // This also works since no bit is lost (implicit conversion)
     ```
      
* Casting from large-sized `uint`/`int` to small-sized `uint`/`int`: value may change since higher bits are cut.

     ```Solidity
     uint16 a = 0x1234;
     uint8 b = uint8(a); // b = 0x34, since higher bits(0x12) are cut (explicit conversion is required since some bits are lost)
     ```
* Casting from `int` to `uint` would yield interesting results.

    ```Solidity
    int8 a = -1; // a is represented as 11111111 in binary (with two's complement).
    uint8 b = uint8(a); // b = 255, which is 11111111 in binary, too.
    // int8 has a range from -2^4 to 2^4 - 1, so 11111111 can only represent -1, not 255
    // uint8 has a range from 0 to 2^8 - 1, so 11111111 can only represent 255, not -1
    ```
  
* Casting from small-sized `bytes` to large-sized `bytes`: value doesn't change, padding bits are added to the right.

     ```Solidity
     bytes2 a = 0x1234;
     bytes4 b = bytes4(a); // b = 0x12340000 (explicit conversion)
     bytes4 c = a; // implicit conversion
     ```

* Casting from large-sized `bytes` to small-sized `bytes`: value may change since higher bits are cut.
  
    ```Solidity
    bytes4 a = 0x1234;
    bytes2 b = bytes2(a); // b = 0x12 (explicit conversion is required since some bits are lost)
    ```

* Casting between `uint` and fix-sized bytes is feasible if they have the same size.

    ```Solidity
    bytes4 a = 0x12345678;
    uint32 b = uint32(a);
    ```

* Casting from `address` to `uint` requires a conversion to `uint160` first. (same for `bytes`)

    ```Solidity
    address a = 0x12....;
    uint256 b = uint256(uint160(a)); // address is 256 160 bits long
    bytes24 c = bytes24(bytes20(a)); // address is 20 bytes long
    ```
