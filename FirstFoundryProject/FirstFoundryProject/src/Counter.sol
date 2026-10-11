
//SPDX-License-Identifier: MIT
pragma solidity 0.8.37;

/*
state variable counter that increments
 */

contract Counter{
    uint8 public number;
    uint8 internal number_1;

    function setNumber(uint8 newNumber) public {
    number = newNumber;
    }

    function increment() public{
        number++;
    }
}