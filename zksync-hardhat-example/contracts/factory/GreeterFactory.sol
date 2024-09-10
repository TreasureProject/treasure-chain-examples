// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/utils/Create2.sol";
// import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

import "../Greeter.sol";

contract GreeterFactory {
    event GreeterCreated(address greeter);

    uint256 public nonce;
    // Greeter public immutable greeterImplementation;

    constructor() {
        // greeterImplementation = new Greeter();
    }

    function createContract(string memory _greeting) public returns (Greeter greeter) {
        greeter = new Greeter(_greeting);
        emit GreeterCreated(address(greeter));
        return greeter;
        // address addr = getGreeterAddress(_greeting, nonce);

        // uint codeSize = addr.code.length;

        // if (codeSize > 0) {
        //     return Greeter(payable(addr));
        // }

        // greeter = Greeter(payable(new ERC1967Proxy {salt : bytes32(nonce)} (
        //     address(greeterImplementation),
        //     abi.encodeCall(Greeter.initialize, (_greeting))
        // )));

        // nonce++;
    }

    // function getGreeterAddress(string memory _greeting, uint256 _nonce) public view returns (address) {
    //     return Create2.computeAddress(bytes32(_nonce), keccak256(abi.encodePacked(
    //             type(ERC1967Proxy).creationCode,
    //             abi.encode(
    //                 address(greeterImplementation),
    //                 abi.encodeCall(Greeter.initialize, (_greeting))
    //             )
    //     )));
    // }
}
