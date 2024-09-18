import { Deployer } from '@matterlabs/hardhat-zksync-deploy';
import chalk from 'chalk';

import * as hre from 'hardhat';
import { getWallet } from './utils';
import { Greeter, GreeterV2 } from '../typechain-types';

// Address of the contract to interact with
const GREETER_ADDRESS = process.env.GREETER_ADDRESS ?? "";
if (!GREETER_ADDRESS) throw "⛔️ Provide address of the contract to interact with!";

export default async function () {
  const wallet = getWallet();
    const deployer = new Deployer(hre, wallet);

  // Load compiled contract info
  const contractArtifact = await hre.artifacts.readArtifact("Greeter");
  // Initialize contract instance for interaction

  const contract = new hre.ethers.Contract(
    GREETER_ADDRESS,
    contractArtifact.abi,
    wallet // Interact with the contract on behalf of this wallet
  ) as unknown as Greeter;

    // upgrade proxy implementation

    const GreeterV2 = await deployer.loadArtifact('GreeterV2');
    const upgradedGreeter = await hre.upgrades.upgradeProxy(deployer.zkWallet, await contract.getAddress(), GreeterV2) as unknown as GreeterV2;
    console.info(chalk.green('Successfully upgraded Greeter to GreeterV2'));

    upgradedGreeter.connect(wallet);
    // wait some time before the next call
    await new Promise((resolve) => setTimeout(resolve, 2000));
    const value = await upgradedGreeter.greet("Kevin");
    console.info(chalk.cyan('BoxUups value is', value));
}
