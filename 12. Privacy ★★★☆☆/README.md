[Level 12. Privacy](https://ethernaut.openzeppelin.com/level/12)

## In A Nutshell

> Although can't be accessed by other contracts, a `private` state variable is visible on chain by reading its slot. (similar concept to [level 8. Vault](https://github.com/timou0911/Ethernaut_Writeup/blob/main/08.%20Vault%20%E2%98%85%E2%98%85%E2%98%86%E2%98%86%E2%98%86/README.md))

## Concept

1. Understanding the real purpose of modifier private.
2. Storage slots in a smart contract.
3. Slot counting and getting designated data by accessing a certain slot.

## Level Target

1. Get `data[2]` to make `locked` false.

## Breakdown & Analysis

1. Since `bytes32[3] data` is set to `private`, no getter function is available, and other contracts, even those that inherit from it, cannot access it.

2. We can adapt the same strategy in level 8, but the slot counting in this problem is slightly more complicated.
   
    1. Slot 0: `bool public locked` (1 byte).
    2. Slot 1: `uint256 public ID` (32 bytes). (it's stored in slot 1 since slot 0 only has 31 bytes left).
    3. Slot 2: `uint8 private flattening` (8 bytes), `uint8 private denomination` (8 bytes), and `uint16 private awkwardness` (16 bytes). (These three variables are stored in the same slot since the total sum is <= 32 bytes)
    4. Slot 3: `bytes32 private data[0]` (32 bytes).
    5. Slot 4: `bytes32 private data[1]` (32 bytes).
    6. Slot 5: `bytes32 private data[2]` (32 bytes). (That's what we're looking for!)
   
3. Retrieve slot 5 using web3.js, then pass the first 16 bytes of the returned value to function `unlock()`.


## Detailed Steps

```js
data_2 = await web3.eth.getStorageAt(contract.address, 5) // get data[2] by accessing the slot
key = data_2.slice(0, 34) // retrieve the first 16 bytes (0x prefix + first 16 bytes, so the ending index is 34)
await contract.unlock(key)
await contract.locked() === false // check if the lock is open now
```
