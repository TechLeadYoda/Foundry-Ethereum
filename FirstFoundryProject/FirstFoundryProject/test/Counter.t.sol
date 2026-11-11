//License-SPDX-Identifier : MIT

pragma solidity^0.8.37;


import {Test} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";


contract test_Counter is Test {
   Counter Test_Counter;

    function setUp() public{
         Test_Counter = new Counter();
    }

    function test_increment () public  {
        uint256 avant = Test_Counter.number();
        Test_Counter.increment();
        assertEq(Test_Counter.number(),avant + 1);
    }

    function test_increment_revert_above_max () public  {
    vm.store(address(Test_Counter), bytes32(uint256(0)), bytes32(type(uint256).max));
    vm.expectRevert(Counter.CannotIncrementAboveMax.selector);
    Test_Counter.increment();
    }

    function test_decrement () public  {
    Test_Counter.increment();
    uint256 avant = Test_Counter.number();
    Test_Counter.decrement();
    assertEq(Test_Counter.number(),avant - 1);
    }

    function test_decrement_revert_below_zero () public  {
    vm.expectRevert(Counter.CannotDecrementBelowZero.selector);
    Test_Counter.decrement();
    }

    function test_reset () public  {
    Test_Counter.increment();
    Test_Counter.reset();
    assertEq(Test_Counter.number(), 0);
    }

    function test_reset_revert_already_zero () public  {
    vm.expectRevert("Already zero");
    Test_Counter.reset();
    }

}