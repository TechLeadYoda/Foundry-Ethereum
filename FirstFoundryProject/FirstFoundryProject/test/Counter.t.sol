// SPDX-License-Identifier: MIT
pragma solidity 0.8.37;

import "forge-std/Test.sol";
import "../src/Counter.sol";

contract CounterTest is Test {
    Counter counter;
    address alice = makeAddr("alice");

    function setUp() public {
        counter = new Counter(); // le test est l'owner, number = 255
    }

    // require
    function test_RevertWhen_DecrementAtZero() public {
        counter.reset_counter();
        vm.expectRevert(bytes("too small"));
        counter.decrement_counter();
    }

    // Erreur personnalisée AVEC valeur
    function test_RevertWhen_IncrementAt255() public {
        vm.expectRevert(abi.encodeWithSelector(Counter.TooLarge.selector, 255));
        counter.increment();
    }

    // Modifier + erreur personnalisée SANS valeur
    function test_RevertWhen_NotOwnerResets() public {
        vm.prank(alice); // le prochain appel vient d'alice
        vm.expectRevert(Counter.NotOwner.selector);
        counter.reset_counter();
    }

    // L'owner, lui, peut reset
    function test_OwnerCanReset() public {
        counter.reset_counter();
        assertEq(counter.number(), 0);
    }

    // Event
    function test_EmitIncremented() public {
        counter.reset_counter();

        vm.expectEmit(false, false, false, true); // on vérifie les données
        emit Counter.Incremented(1);              // event attendu

        counter.increment();                      // appel réel
    }
}