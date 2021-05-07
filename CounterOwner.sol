// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Counter {
  mapping(address => bool) _owners;
  int256 private _counter;
  int256 private _step;


  constructor(int256 initialSupply) {
    _owners[msg.sender] = true;
    _step = initialSupply;
  }

   function setStep(int256 x) public {
       _step = x;
   }

    function step() public view returns (int256) {
      return _step;
  }
  
   function addOwner(address account) public {
      require(_owners[msg.sender] == true, "Counter: Only an owner can add owner");
      _owners[account] = true;
  }

  function increment() public {
      require(_owners[msg.sender] == true, "Counter: Only owners can increment counter");
      _counter += _step;
  }
  
  function decrement() public {
      require(_owners[msg.sender] == true, "Counter: Only owners can decrement counter");
      _counter -= _step;
  }
  
  function reset() public {
      require(_owners[msg.sender] == true, "Counter: Only owners can reset counter");
      _counter = 0;
  }

  function isOwner(address account) public view returns (bool) {
      return _owners[account];
  }

  function counter() public view returns (int256) {
      return _counter;
  }
}