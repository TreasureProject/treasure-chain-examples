import * as hre from "hardhat";
import { ethers } from "ethers";
import { getWallet } from "../utils";
import { Greeter, GreeterFactory } from "../../typechain-types";

const FACTORY_ADDRESS = "0x2037ADe36b4bF2bc813590702FaBaBBee5e6f4fC";
if (!FACTORY_ADDRESS) throw "⛔️ Provide address of the contract to interact with!";

// An example of a script to interact with the contract
export default async function () {
  console.log(`Running script to interact with contract ${FACTORY_ADDRESS}`);

  // Load compiled contract info
  const factoryArtifact = await hre.artifacts.readArtifact("GreeterFactory");

  // Initialize contract instance for interaction
  const factoryContract = new ethers.Contract(
    FACTORY_ADDRESS,
    factoryArtifact.abi,
    getWallet() // Interact with the contract on behalf of this wallet
  ) as unknown as GreeterFactory;

  // Create new greeter instance
  const createTx = await factoryContract.createContract("Hello instance!");
  await createTx.wait();
  console.log(`Transaction hash of create: ${createTx.hash}`);
}
