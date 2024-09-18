import { Deployer } from '@matterlabs/hardhat-zksync-deploy';

import * as hre from "hardhat";
import { getWallet } from "./utils";
import { Greeter } from '../typechain-types';

export default async function () {
  const contractName = "Greeter";
  console.log("Deploying " + contractName + "...");

  const wallet = getWallet();
  const deployer = new Deployer(hre, wallet);
  const contract = await deployer.loadArtifact(contractName);
  const greeter = await hre.zkUpgrades.deployProxy(deployer.zkWallet, contract, ["¡Hola!"], { initializer: "initialize" }) as unknown as Greeter;
  await greeter.waitForDeployment();
  console.log(contractName + " deployed to:", await greeter.getAddress());

  greeter.connect(wallet);
  const value = await greeter.greet();
  console.log("Greeting is: ", value);
}
