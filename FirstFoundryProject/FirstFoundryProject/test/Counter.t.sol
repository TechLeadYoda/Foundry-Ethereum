// SPDX-License-Identifier: MIT
pragma solidity 0.8.37;

import {Test} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter counter;
    address stranger = makeAddr("stranger");

    function setUp() public {
        // the test contract deploys, so the owner is address(this)
        counter = new Counter();
    }

    function test_OwnerIsDeployer() public view {
        assertEq(counter.owner(), address(this));
    }

    function test_OwnerCanSetNumber() public {
        counter.setNumber(42);
        assertEq(counter.number(), 42);
    }

    function test_RevertWhen_StrangerSetsNumber() public {
        vm.prank(stranger); // next call comes from stranger
        vm.expectRevert(abi.encodeWithSelector(Counter.NotOwner.selector, stranger));
        counter.setNumber(5);
    }

    function test_RevertWhen_NumberTooBig() public {
        vm.expectRevert(bytes("Too big"));
        counter.setNumber(1001);
    }

    function test_SetNumber_MaxAllowed() public {
        counter.setNumber(1000); // the limit itself must work
        assertEq(counter.number(), 1000);
    }

    function test_EmitsNumberChanged() public {
        counter.setNumber(10);

        vm.expectEmit();
        emit Counter.NumberChanged(10, 42); // the event we expect...
        counter.setNumber(42); // ...from this call
    }

    function test_AnyoneCanIncrement() public {
        vm.prank(stranger);
        counter.increment();
        assertEq(counter.number(), 1);
    }
}