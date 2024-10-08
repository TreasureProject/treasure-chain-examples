import * as hre from "hardhat";
import { ethers } from "ethers";
import { getWallet } from "../utils";
import { Greeter } from "../../typechain-types";

const INSTANCE_ADDRESS = process.env.INSTANCE_ADDRESS ?? "";
if (INSTANCE_ADDRESS === "") throw "⛔️ Please configure the instance address in .env!";

// An example of a script to interact with the contract
export default async function () {
  console.log(`Running script to interact with Greeter contract ${INSTANCE_ADDRESS}`);
    const greeterArtifact = await hre.artifacts.readArtifact("Greeter");

    // Initialize contract instance for interaction
    const instanceContract = new ethers.Contract(
        INSTANCE_ADDRESS,
        greeterArtifact.abi,
        getWallet() // Interact with the contract on behalf of this wallet
    ) as unknown as Greeter;

  // Run contract read function
  const greetResponse = await instanceContract.greet();
  console.log(`Current message is: ${greetResponse}`);

  // Run contract write function
  const setGreetingTx = await instanceContract.setGreeting("Hello again, people!");
  console.log(`Transaction hash of setting new message: ${setGreetingTx.hash}`);

  // Wait until transaction is processed
  await setGreetingTx.wait();

  // Read message after transaction
  console.log(`The message now is: ${await instanceContract.greet()}`);
}
