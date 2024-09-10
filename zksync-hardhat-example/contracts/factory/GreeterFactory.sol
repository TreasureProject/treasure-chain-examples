// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Create2.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

import "../Greeter.sol";

interface IContractDeployer {
    function getNewAddressCreate2(address _sender, bytes32 _bytecodeHash, bytes32 _salt, bytes calldata _input)
        external
        view
        returns (address newAddress);
}

contract GreeterFactory {
    event GreeterImplCreated(address greeter);
    event GreeterCreated(address greeter, string greeting, uint256 nonce);

    IContractDeployer contractDeployer = IContractDeployer(address(0x8000 + 0x06));

    uint256 public nonce;
    Greeter public immutable greeterImplementation;

    constructor() {
        greeterImplementation = new Greeter();
        emit GreeterImplCreated(address(greeterImplementation));
    }

    function createContract(string memory _greeting) public returns (Greeter greeter) {
        address addr = getGreeterAddress(nonce, _greeting);

        uint256 codeSize = addr.code.length;

        if (codeSize > 0) {
            return Greeter(payable(addr));
        }

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

    function getGreeterAddress(uint256 _nonce, string memory _greeting) public view returns (address newAddress) {
        newAddress = contractDeployer.getNewAddressCreate2(
            msg.sender,
            keccak256(
                abi.encodePacked(
                    type(ERC1967Proxy).creationCode,
                    abi.encode(address(greeterImplementation), abi.encodeCall(Greeter.initialize, (_greeting)))
                )
            ),
            bytes32(_nonce),
            abi.encode(_greeting)
        );
        // bytes memory bytecode = type(MyContract).creationCode;
        // assembly {
        //     newAddress := create2(0, add(bytecode, 32), mload(bytecode), salt)
        // }

        // No collision is possible with the Ethereum's CREATE2, since
        // the prefix begins with 0x20....
        // bytes32 constructorInputHash = EfficientCall.keccak(_greeting);

        // bytes32 hash = keccak256(
        //     // solhint-disable-next-line func-named-parameters
        //     bytes.concat(
        //         keccak256("zksyncCreate2"),
        //         bytes32(uint256(uint160(this))),
        //         bytes32(_nonce),
        //         type(ERC1967Proxy).creationCode,
        //         constructorInputHash
        //     )
        // );

        // newAddress = address(uint160(uint256(hash)));
    }

    // function getGreeterAddress(string memory _greeting, uint256 _nonce) public view returns (address) {
    //     return Create2.computeAddress(
    //         bytes32(_nonce),
    //         keccak256(
    //             abi.encodePacked(
    //                 type(ERC1967Proxy).creationCode,
    //                 abi.encode(address(greeterImplementation), abi.encodeCall(Greeter.initialize, (_greeting)))
    //             )
    //         )
    //     );
    // }
}
