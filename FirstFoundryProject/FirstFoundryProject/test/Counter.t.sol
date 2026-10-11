//SPDX-License-Identifier: MIT
pragma solidity 0.8.37;

import {Test} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract TestContract is Test {
    Counter counter;

    function setUp() public{
        counter = new Counter();
    }

        function test_SetNumber() internal {
        counter.setNumber(42);            // act
        assertEq(counter.number(), 42);   // check
    }

    function test_increment() public{
        counter.increment();
        assertEq(counter.number(), 1);   // check
    }
    // limit value
function test_SetNumber_Max() public {
    counter.setNumber(255);
    assertEq(counter.number(), 255);
}

// failure case: 255 + 1 must revert
function test_RevertWhen_IncrementAtMax() public {
    counter.setNumber(255);
    vm.expectRevert();
    counter.increment();
}

// starting state
function test_StartsAtZero() public view {
    assertEq(counter.number(), 0);
}

}