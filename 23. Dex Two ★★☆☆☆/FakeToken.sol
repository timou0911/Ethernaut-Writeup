// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// 0x0Ec24374999dad931E4477aFF98bc5f563bE5005

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FakeToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("FakeToken", "FAKE") {
        _mint(msg.sender, initialSupply); // provide at least 400 tokens
    }
}
