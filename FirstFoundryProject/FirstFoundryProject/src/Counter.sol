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
                                                                                                                                                
   function increment() public {
      if (number == type(uint256).max) {
         revert CannotIncrementAboveMax();
      }
      number++;
 }
    function decrement() public {
      if (number == 0) {
         revert CannotDecrementBelowZero();
      }
      number--;
 }
   function reset() public {
      require(number > 0, "Already zero");
      number = 0;
 }

}