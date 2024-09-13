//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";
import {Greeter} from "../contracts/Greeter.sol";

contract GreeterTest is Test {
    Greeter greeter;

    function setUp() public {
        greeter = new Greeter("Hello, world!");
    }

    function testGreet() public {
        assertEq(greeter.greet(), "Hello, world!");
    }

    function testSetGreeting() public {
        greeter.setGreeting("Hola, mundo!");
        assertEq(greeter.greet(), "Hola, mundo!");
    }
}
