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

In Solidity, state variables are stored in storage, which is divided into fixed-size slots of 32 bytes each. Each slot has a unique key starting from 0, and subsequent slots are numbered sequentially from 1, 2, 3, and so on.

When a state variable is declared, it is assigned to a slot in storage. If the state variable is of a fixed-size type, such as `uint` or `bool`, then it will take up a single slot and use the necessary bytes (data are encoded into hex then saved to slots). However, it is possible for multiple state variables to be packed into a single storage slot if their total size is less than or equal to 32 bytes. 

For example, consider such code:

```Solidity
contract GetSlotValue {

    uint256 v1 = 111;
    uint256 v2 = 222;
    uint8 v3 = 12;
    address v4 = 0xd2a5bC10698FD955D1Fe6cb468a17809A08fd005;
    uint128 v5 = 555;
    uint64 v6 = 666;
    uint32 v7 = 777;
    uint32 v8 = 888;

    function getValueFromSlot (uint256 i) public view returns (bytes32 data) { 
        assembly {
            data := sload(i)
        }
    }
}
```

* if I call `getValueFromSlot(0)`, it will return `0x000000000000000000000000000000000000000000000000000000000000006f`, which is 111 in hex.
* 
* Calling `getValueFromSlot(2)` returns `0x0000000000000000000000d2a5bc10698fd955d1fe6cb468a17809a08fd0050c`, which contains v3(`0c`) and an address v4. Since the remaining space can’t fit in v5, it will be stored in the next slot.

* Lastly, `getValueFromSlot(3)` will return `0x0000037800000309000000000000029a0000000000000000000000000000022b`, which consists v5(`0x00000378`), v6(`0x00000309`), v7(`0x000000000000029a`), and v8(`0x0000000000000000000000000000022b`), representing in little endian form(right to left). The four occupy exactly 32 bytes so they are packed into the fourth slot.
