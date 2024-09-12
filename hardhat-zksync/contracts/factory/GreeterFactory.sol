// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {Greeter} from "../Greeter.sol";

contract GreeterFactory {
    event GreeterImplCreated(address greeter);
    event GreeterCreated(address greeter, string greeting, uint256 nonce);

    uint256 public nonce;
    Greeter public immutable greeterImplementation;

    constructor() {
        greeterImplementation = new Greeter();
        emit GreeterImplCreated(address(greeterImplementation));
    }

    function createContract(string memory _greeting) public returns (Greeter greeter) {
        greeter = Greeter(
            payable(
                new ERC1967Proxy{salt: bytes32(nonce)}(
                    address(greeterImplementation), abi.encodeCall(Greeter.initialize, (_greeting))
                )
            )
        );

        emit GreeterCreated(address(greeter), _greeting, nonce);

        nonce++;
    }
}
