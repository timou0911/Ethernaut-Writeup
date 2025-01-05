[Level 32. Impersonator](https://ethernaut.openzeppelin.com/level/32)

## In A Nutshell

> The understanding of ECDSA.

## Concept

1. ECDSA signature.
2. Inline assembly.
3. Inspecting Etherscan.

## Level Target

1. Compromise the system so that anyone can open the door.

## Breakdown & Analysis

1. First we need to get the address of `ECLocker` by inspecting Etherscan.
2. To make anyone able to call `open()`, `_isValidSignature()` should pass every time, which means we need to deal with the two `require`.
3. In the first `require`, the return address of `ecrecover()` should be equal to the `controller`. `ecrecover()` returns `address(0)` if the signature is invalid. We can change the `controller` address to it by calling `changeController()`, but we still need to handle `_isValidSignature()` before making the `controller` as `address(0)`.
4. Here comes the signature malleability. One message for a private key can generate two valid signatures in ECDSA, with one located on the positive y-axis and the other on the negative y-axis. If we know the signature used when creating `ECLocker,` we can use this knowledge to compute the other signature. (We can't use the same signature twice since the contract records used signature)
5. We can obtain the signature from the event log on Etehrscan and get:
   * `v = 000000000000000000000000000000000000000000000000000000000000001b = 27` (one side of the elliptic curve)
   * `r = 0x1932cb842d3e27f54f79f7be0289437381ba2410fdefbae36850bee9c41e3b91`
   * `s = 0x78489c64a0db16c40ef986beccc8f069ad5041e5b992d76fe76bba057d9abff2`.
6. We then compute the other valid signature by toggling `v` and `s' = secp256k1n(generator point) - s`:
   * `v' = 28 = 000000000000000000000000000000000000000000000000000000000000001c` (the other side of the elliptic curve)
   * `r = 0x1932cb842d3e27f54f79f7be0289437381ba2410fdefbae36850bee9c41e3b91`
   * `s' = bytes32(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141 - uint256(s)) = 0x87b7639b5f24e93bf106794133370f950d5e9b00f5b5c8cbd866a487529b814f`
7. Now we can call `changeController()` and set `controller` to `address(0)` successfully. The second `require` in `open()` can be passed easily with arbitrary `v`, `r`, and `s`.

## Detailed Steps

```Solidity
    function getSPrime(bytes32 s) public pure returns (bytes32) {
        return bytes32(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141 - uint256(s));
    }
```
