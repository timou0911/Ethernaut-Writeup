[Level 8. Vault](https://ethernaut.openzeppelin.com/level/0xB7257D8Ba61BD1b3Fb7249DCd9330a023a5F3670)

## Concepts

1. Understanding the real purpose of modifier `private`.

2. Storage slots in a smart contract and how to get designated data by accessing a certain slot.

## Level Target

1. Unlock the vault(make unlocked variable false).

## Breakdown & Analysis

1. The vault can only be unlocked by determining the correct value of `password`.

2. Since `password` is set to `private`, there is no getter function available, and other contracts, even those that inherit from it, cannot access its data.

3. However, **the primary purpose of visibility modifiers (`public`, `external`, `internal`, `private`) is to restrict access for other contracts and functions, but the data can still be viewed on the chain.** It's also worth noting that `external` cannot be applied to state variables.

4. **To retrieve a state variable's value on the chain, we must identify its storage slot.** As `password` is the second variable declared, it occupies storage slot 1. To access its value, we can utilize the web3.js method: `web3.eth.getStorageAt(address, position)`.

## Detailed Steps

```js
password = await web3.eth.getStorageAt(contract.address, 1) // get password by accessing the slot
await contract.unlock(password) 
await contract.locked() === false // check if the vault is open now
```

## Slot Explanation

