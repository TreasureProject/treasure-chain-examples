import { deployContract } from "../utils";

// This script is used to deploy the greeter factory contract
// as well as verify it on Block Explorer if possible for the network
export default async function () {
    await deployContract("GreeterFactory");
}
  
