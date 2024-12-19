[Level 15. Naught Coin](https://ethernaut.openzeppelin.com/level/15)

## In A Nutshell

> Make sure to understand the ERC20 spec when inheriting it.

## Concept

1. `approve()` function.
2. `transfer()` and `transferFrom()` functions.

## Level Target

1. Make your token balance to 0.

## Breakdown & Analysis

1. In the contract, the function `transfer()` is overridden and restricted by a ten-year lock `modifier`.
2. In the ERC20 standard, there are two methods to transfer tokens out: `transfer()` and `transferFrom()`. In this case, we can utilize `transferFrom()`.
3. Since `transferFrom()` requires prior approval to transfer our tokens, we need to call `approve()` first.
4. After approval, call `transferFrom()` to avoid the time lock and transfer all the tokens out.

## Detailed Steps (work through the console)

```js
await contract.approve(player, toWei("1000000")); // approve ourselves
await contract.transferFrom(player, "0xd500f37734A4DC70434Be052187161b63763d9d7", toWei("1000000")); // The second parameter can be any account besides the player.
await contract.balanceOf(player).then(v=>v.toString()); // check if player's balance is 0 now.
```

## ERC20 Standard

See [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol).
