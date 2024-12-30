[Level 31. Stake](https://ethernaut.openzeppelin.com/level/31)

## In A Nutshell

> When performing low-level calls to external contracts, it is important to check the return value properly.

## Concept

1. ERC20 spec.
2. Low-level call.

## Level Target

1. The `Stake` contract's ETH balance has to be greater than 0.
2. `totalStaked` must be greater than the `Stake` contract's ETH balance.
3. You must be a staker.
4. Your staked balance must be 0.

## Breakdown & Analysis

1. From `Unstake()` function we can see that there's no code to cancel one's stakership, which means once we staked some ETH, we are a staker forever.
2. After knowing this, we can call `StakeETH()` with `msg.value` greater than 0.001 ETH and `Unstake()` them all to accomplish requirements 3. and 4.
3. Since `totalStaked` must be greater than the `Stake` contract's ETH balance, we'll have to stake some WETH.
4. In function `StakeWETH()`, there's no check on whether a low-level call is successful, which means the `totalStaked` will increase anyway. All we have to do is pass the allowance requirement.
5. In ERC20 spec, we don't necessarily need to hold a balance to allow others to spend, thus we can approve an allowance greater than 0.001 ETH to the contract. In the later actual transfer, the call would fail but the function will proceed normally. Here we accomplish requirement 2.
6. To finish requirement 1, we can simply `selfdestruct()` our malicious contract and send 1 wei to the target contract.

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Writeup/blob/main/31.%20Stake%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).

After performing `attack()` in  Attack.sol:

```js
await contract.StakeETH({value: toWei("1")}); // stake to make ourselves a staker
await contract.Unstake(toWei("1")); // unstake to make ourselves's staked balance be 0
```
