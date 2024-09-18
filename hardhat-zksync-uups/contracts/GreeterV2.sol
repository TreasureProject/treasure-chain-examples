//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract GreeterV2 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    string private greeting;

    function initialize(string memory _greeting) public initializer {
        greeting = _greeting;
        __Ownable_init();
        __UUPSUpgradeable_init();
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function greet(string memory name) public view returns (string memory) {
        return string.concat(greeting, " ", name, "!");
    }

    function setGreeting(string memory _greeting) public {
        greeting = _greeting;
    }

    // solhint-disable-next-line no-empty-blocks
    function _authorizeUpgrade(address) internal override onlyOwner {}
}
