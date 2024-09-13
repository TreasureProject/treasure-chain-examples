//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import {LibWithPublicMethods} from "./LibWithPublicMethods.sol";

contract Greeter {
    string private greeting;

    constructor(string memory _greeting) {
        greeting = _greeting;
    }

    function greetSomeone(string calldata person) public view returns (string memory) {
        return LibWithPublicMethods.concat(greeting, person);
    }

    function setGreeting(string memory _greeting) public {
        greeting = _greeting;
    }
}
