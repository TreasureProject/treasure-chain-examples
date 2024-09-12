// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IContractDeployer} from "@matterlabs/zksync-contracts/l2/system-contracts/interfaces/IContractDeployer.sol";
import {Utils} from "@matterlabs/zksync-contracts/l2/system-contracts/libraries/Utils.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {Greeter} from "../Greeter.sol";

contract GreeterFactory {
    event GreeterImplCreated(address greeter);
    event GreeterCreated(address greeter, string greeting, uint256 nonce);

    uint256 public nonce;
    IContractDeployer public contractDeployer = IContractDeployer(0x0000000000000000000000000000000000008006);
    Greeter public immutable greeterImplementation;
    bytes32 public constant erc1967ProxyBytecodeHash =
        0x01000097693de023f3276547d7e999b09e52465237a299ad50ac141494ec893d;

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

    function create2ContractAddress(uint256 _nonce, string memory _greeting) public view returns (address) {
        return contractDeployer.getNewAddressCreate2(
            address(this),
            erc1967ProxyBytecodeHash,
            bytes32(_nonce),
            abi.encode(address(greeterImplementation), abi.encodeCall(Greeter.initialize, (_greeting)))
        );
    }
}
