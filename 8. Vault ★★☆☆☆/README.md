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

| Type | Size |
| ---- | ---- |
| uint8 | 1 byte |
| uint16 | 2 bytes |
| uint32 | 4 bytes |
| uint64 | 8 bytes |
| uint128 | 16 bytes |
| uint256 | 32 bytes |
| address | 20 bytes |
| bool | 1 bytes |
| bytes1 ~ bytes32 | 1 byte ~ 32 bytes |

### Statically-sized Type

When a state variable is declared, it is assigned to a slot in storage. If the state variable is of a statically-sized type, such as `uint` or `bool`, then it will take up a single slot and use the necessary bytes (data are encoded into hex then saved to slots). However, multiple state variables can be packed into a single storage slot if their total size is less than or equal to 32 bytes. 

For example, consider such code:

```Solidity
contract GetFixedSizeTypeSlot {

    uint256 v1 = 111; // 32 bytes
    uint256 v2 = 222; // 32 bytes
    uint8 v3 = 12; // 1 bytes
    address v4 = 0xd2a5bC10698FD955D1Fe6cb468a17809A08fd005; // 20 bytes
    uint128 v5 = 555; // 16 bytes
    uint64 v6 = 666; // 8 bytes
    uint32 v7 = 777; // 4 bytes
    uint32 v8 = 888; // 4 bytes

    function getValueFromSlot (uint256 i) public view returns (bytes32 data) { 
        assembly {
            data := sload(i) // retrieve data from a slot
        }
    }
}
```

* if we call `getValueFromSlot(0)`, it will return `0x000000000000000000000000000000000000000000000000000000000000006f`, which is 111 in hex.

* Similar to slot 0, slot 1 stores v2 in hex.

* Calling `getValueFromSlot(2)` returns `0x0000000000000000000000d2a5bc10698fd955d1fe6cb468a17809a08fd0050c`, which contains v3(`0x0c`) and an address v4. Since the remaining space can’t fit in v5, it will be stored in the next slot.

* Lastly, `getValueFromSlot(3)` will return `0x0000037800000309000000000000029a0000000000000000000000000000022b`, which consists v5(`0x00000378`), v6(`0x00000309`), v7(`0x000000000000029a`), and v8(`0x0000000000000000000000000000022b`), representing in little endian form(right to left). The four occupy exactly 32 bytes so they are packed into the fourth slot.

### Structs & Static Arrays

Similar to the statically-sized types mentioned previously, a struct will occupy storage slots based on its members. We can optimize storage usage by rearranging the position of the members. For example, instead of declaring members like `S1`, `S2` is a better practice.

Also, if there are any unused bytes in a struct, the subsequent variable will not be stored in the same slot.

```Solidity
S1 {
    uint256 date; // slot 0
    uint128 id; // slot 1
    uint256 grade; // slot 2
    uint128 time; // slot 3
}

S2 {
    uint256 date; // slot 0
    uint256 time; // slot 1
    uint128 grade; // slot 2
    uint128 id; // slot 2
}
```

Static arrays behave similarly to structs in this respect.

### Dynamic Arrays



### Mappings

For mappings, the process of accessing an element is slightly different from that of accessing a dynamic array. Since mappings are dynamic, storing elements in contiguous slots is unrealistic. Instead, there will be a slot reserved for storing the mapping itself(marker slot), while the elements are stored separately in slots determined by their corresponding keys and the slot storing the mapping. 

For instance, suppose that `m[1] = 10`, `m[2] = 20`, `m[3] = 40` are already declared using `addElement`.

```Solidity
contract GetMappingElementSlot {
    uint256 v1 = 111;
    mapping(uint256 => uint256) m; // if we call slot 1, it returns 0x000..., but is still stores the mapping itself

    function addElement (uint256 key, uint256 value) public { // adding mapping element
        m[key] = value;
    }

    function getElementSlot (uint256 key, uint256 mappingSlot) public pure returns (uint256 slot) { // get the element's slot
        // in mappings, the element'slot is determined by the slot storing the mapping itself and the element's key
        slot = uint256(keccak256(abi.encode(key, mappingSlot)));
    }

    function getValueFromSlot (uint256 i) public view returns (uint256 data) {
        assembly {
            data := sload(i)
        }
    }
}
```

* Slot 0 stores v1’s value in hex, and slot 1 stores the mapping m itself.

* The element of a mapping is determined by the hash function, which encodes the key and the mapping's slot together. For instance, to determine which slot stores `m[2]`, 

    * first encode 2 (the index) and 1 (the mapping's slot)
    
    * then convert the encoded number into a hash using `keccak256`
    
    * lastly, we cast the hash result into `uint256`.
    
    In this case, `m[2]` is stored in slot `98521912898304110675870976153671229506380941016514884467413255631823579132687`.

    Although this number may seem extensive, there are `2^256 - 1` slots available for a contract, so the probability of two elements sharing the same slot (hash collision) is minimal.

Similarly, nested mappings are applied with the same method.
