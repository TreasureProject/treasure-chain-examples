//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

library LibWithPublicMethods {
    function concat(string calldata str1, string calldata str2) public pure returns (string memory) {
        return string.concat(str1, " ", str2, "!");
    }
}
