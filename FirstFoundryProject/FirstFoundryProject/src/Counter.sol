//License-SPDX-Identifier : MIT or  Apache-2.0
pragma solidity^0.8.37;

/*
1/ create a constructor to initilaize
2/deploy 

*/
contract Counter{

   //custom error
   error CannotDecrementBelowZero();
   error CannotIncrementAboveMax();

   //variable
   uint256 public number;


   constructor(){
   }

   //modifier
   modifier notAtMax() {
      require(number < type(uint256).max, CannotIncrementAboveMax());
      _;
   }

   modifier notZero() {
      require(number > 0, CannotDecrementBelowZero());
      _;
   }

   function increment() public notAtMax {
      number++;
 }
    function decrement() public notZero {
      number--;
 }
   function reset() public {
      require(number > 0, "Already zero");
      number = 0;
 }

}