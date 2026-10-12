// SPDX-License-Identifier: MIT
pragma solidity 0.8.37;

contract Counter {
    // ---- custom error: who tried to call without permission ----
    error NotOwner(address caller);

    // ---- event: tells the outside world the value changed ----
    event NumberChanged(uint256 oldValue, uint256 newValue);

    // ---- state ----
    address public owner;
    uint256 public number;

    // ---- modifier: reusable "only the owner" check ----
    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner(msg.sender);
        _;
    }

    // runs once, at deployment: the deployer becomes the owner
    constructor() {
        owner = msg.sender;
    }

    function setNumber(uint256 newNumber) public onlyOwner {
        require(newNumber <= 1000, "Too big");

        uint256 oldValue = number;
        number = newNumber;

        emit NumberChanged(oldValue, newNumber);
    }

    // open to everyone
    function increment() public {
        number++;
    }
}