## Target

1. Take ownership of the contract

## Break Down & Analyze

The `constructor` has a typo: `Fal”1”out`. Since the wrong spelling, it is served as a function rather than a `constructor`, so everyone can call it and take ownership.<br>
Also, prior to version 0.4.22, a `constructor` is defined as a function with the same name as the contract, however, it was deprecated in version 0.5.0, so it is not allowed to use it as a `constructor` in 0.6.0.

## Detailed Steps (work through the console)

```js
await contract.Fal1out() // call the wrong-spelled function to take ownership
await contract.owner() === player // check if you're the owner now
```
