// SPDX-License-Identifier: MIM

pragma solidity ^0.8.0;

interface IDetectionBot {
    function handleTransaction(address user, bytes calldata msgData) external;
}

interface IDoubleEntryPoint {
    function cryptoVault() external returns(address);
    function player() external returns(address);
    function delegatedFrom() external returns(address);
    function forta() external returns(IForta);
}

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

interface ICryptoVault {
    function sweptTokensRecipient() external returns(address);
    function underlying() external returns(IERC20);
    function setUnderlying(address latestToken) external;
    function sweepToken(IERC20 token) external;
}

interface IForta {
    function setDetectionBot(address detectionBotAddress) external;
    function notify(address user, bytes calldata msgData) external;
    function raiseAlert(address user) external;
    function usersDetectionBots(address) external returns(IDetectionBot);
    function botRaisedAlerts(address) external returns(uint256);
}

contract DetectionBot {
    IDoubleEntryPoint doubleEntryPoint;
    ICryptoVault vault;
    IForta forta;

    constructor(address doubleEntryPointAddr) {
        doubleEntryPoint = IDoubleEntryPoint(doubleEntryPointAddr);
        vault = ICryptoVault(doubleEntryPoint.cryptoVault());
        forta = doubleEntryPoint.forta();
    }

    function handleTransaction(address user, bytes calldata msgData) public {
        (, , address origSender) = abi.decode(msgData[4:], (address, uint256, address));

        if (origSender == address(vault)) {
            forta.raiseAlert(user);
        }
    }
}
