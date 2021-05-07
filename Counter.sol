// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Counter {
  address private _owner;
  uint256 private _counter;
  uint256 private _step;
  
  
//owner c est celui qui deploy

  constructor(uint256 step_) {
    _owner = msg.sender;
    _step = step_;
  }
  
 //si je suis pas le owner 
//   constructor(uint256 , owner_) {  
//     _owner = owner_;
//     _step = step_; 
//   }

  function increment() public {
      require(msg.sender == _owner, "Counter: Only owner can increment counter");
      _counter += _step;
  }

  function reset() public {
      require(msg.sender == _owner, "Counter: Only owner can increment counter");
      _counter = 0;
  }

  function owner() public view returns (address) {
      return _owner;
  }

  function counter() public view returns (uint256) {
      return _counter;
  }

  function step() public view returns (uint256) {
      return _step;
  }

}