// SPDX-License-Identifier: MIT
pragma solidity 0.8.37;

contract Counter {
    uint256 public number;      // public : lisible par tous
    address private owner;      // private : seulement ce contrat

    // Erreurs personnalisées
    error TooLarge(uint256 value);
    error NotOwner();

    // Events
    event Incremented(uint256 newValue);
    event Reset(address by);

    // Modifier
    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    constructor() {
        owner = msg.sender;
        number = 255;
    }

    // external : appelée seulement de l'extérieur
    function increment() external {
        if (!_canIncrement()) revert TooLarge(number);
        number++;
        emit Incremented(number);
    }

    // Seul l'owner peut remettre à zéro
    function reset_counter() external onlyOwner {
        number = 0;
        emit Reset(msg.sender);
    }

    // On garde un require ici pour comparer
    function decrement_counter() public {
        require(number > 0, "too small");
        number--;
    }

    // internal : utilisable seulement dans le contrat
    function _canIncrement() internal view returns (bool) {
        return number < 255;
    }
}