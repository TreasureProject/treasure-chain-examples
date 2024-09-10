import * as hre from "hardhat";
import { ethers } from "ethers";
import { getWallet } from "../utils";
import { Greeter, GreeterFactory } from "../../typechain-types";

const FACTORY_ADDRESS = "0xC8aD9AB824DACb567739DaC346820d689fbBF54F";
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

  const nonce = await factoryContract.nonce();
  console.log("Current factory nonce", nonce);

  const impl = await factoryContract.greeterImplementation();
    console.log("Current implementation address", impl);
  // Create new greeter instance
  const createTx = await factoryContract.createContract("Hello instance!");
  await createTx.wait();
  const instanceAddress = await factoryContract.getGreeterAddress(nonce, "Hello instance!");
    console.log(`Created new instance at address: ${instanceAddress}`);

    const greeterArtifact = await hre.artifacts.readArtifact("Greeter");

    // Initialize contract instance for interaction
    const instanceContract = new ethers.Contract(
        instanceAddress,
        greeterArtifact.abi,
        getWallet() // Interact with the contract on behalf of this wallet
    ) as unknown as Greeter;

  // Run contract read function
  const greetResponse = await instanceContract.greet();
  console.log(`Current message is: ${greetResponse}`);

  // Run contract write function
  const setGreetingTx = await instanceContract.setGreeting("Hello people!");
  console.log(`Transaction hash of setting new message: ${setGreetingTx.hash}`);

  // Wait until transaction is processed
  await setGreetingTx.wait();

  // Read message after transaction
  console.log(`The message now is: ${await instanceContract.greet()}`);
}
