//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

contract Greeter is Initializable
{
    string private greeting;

    constructor() {
        _disableInitializers();
    }

    function initialize(string memory _greeting)
        public virtual
        initializer
    {
        greeting = _greeting;
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    function setGreeting(string memory _greeting) public {
        greeting = _greeting;
    }
}
