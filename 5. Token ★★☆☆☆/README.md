[Level 5. Token](https://ethernaut.openzeppelin.com/level/0x478f3476358Eb166Cb7adE4666d04fbdDB56C407)

## Concepts

1. Overflow and underflow of integer.

## Level Target

1. Get more tokens than you initially have. Namely, more than 20 tokens.

## Breakdown & Analysis

1. The `transfer` function is the only part of the code that performs token transfers, and it appears to function correctly … if it’s written in `v0.8.0`.

2. Since the code is written in version `0.6.0` of Solidity, it is necessary to manually add overflow and underflow checks to prevent this flaw from being exploited.

3. The range of `uint256` is 0 ~ 2^256-1, to cause underflow, and underflow can occur by subtracting 1 from 0, resulting in a value of 2^256-1. This vulnerability could be exploited to obtain additional tokens from the contract.

## Detailed Steps

```js
// transfer more tokens than we have, then the code does 20 - 21, which causes underflow, now the balance becomes 2^256-1
await contract.transfer('Any other address than yours', 21)
await contract.balanceOf(player).then(v => v.toString()) // check our balance now
```

## How to Prevent Overflow and Underflow?

Prior to `v0.8.0`, the recommended best practice was to use [OpenZeppelin's SafeMath library](https://docs.openzeppelin.com/contracts/2.x/api/math), which includes functions such as `add(num1, num2)` that perform safer arithmetic operations. If the calculation would result in overflow or underflow, the transaction would be reverted.

**Starting from `v0.8.0`, Solidity automatically checks for these issues with a slightly higher gas cost and reverts the transaction if such problems occur.**

**However, if a calculation is guaranteed to be 100% secure from overflow and underflow, you can wrap the code with an `unchecked` block, which instructs Solidity to skip the checks at that point.**
