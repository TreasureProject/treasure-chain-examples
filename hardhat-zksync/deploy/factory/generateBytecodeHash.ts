import { hexlify } from "ethers";
import * as hre from "hardhat";
import { hashBytecode } from "zksync-ethers/build/utils";

export default async function () {
    const erc1967ProxyArtifact = await hre.artifacts.readArtifact("ERC1967Proxy");
    const erc1967ProxyBytecode = erc1967ProxyArtifact.bytecode; 
    console.log("ERC1967Proxy bytecode hash:",hexlify(hashBytecode(erc1967ProxyBytecode)));
}
  
