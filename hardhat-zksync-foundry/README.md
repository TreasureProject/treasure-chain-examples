# Foundry tests in hardhat-zksync project

This project was scaffolded with [zksync-cli](https://github.com/matter-labs/zksync-cli).
It contains some basic examples on how to deploy an ERC20, and the Greeter contract. The same unit tests are implemented in both foundry and hardhat.

## Prerequisites

Install foundry-zksync according to the  [docs](https://docs.zksync.io/build/tooling/foundry/getting-started)
> Note: doing the above will overwrite the standard foundry tools. To revert back, run `foundryup` which will install the latest non-zksync version.

## Project Layout

- `/contracts`: contains solidity smart contracts
- `/deploy`: scripts for contract deployment and interaction
- `/test`: hardhat test files
- `/foundry-test`: foundry test files
- `hardhat.config.ts`: configuration settings

## Getting started

Install node dependencies
```bash
npm install
```

Install foundry dependencies
```bash
forge install
```
> This example is configured to work with both git submodules and submodules with foundry for dependencies, but you can also use [soldeer](https://book.getfoundry.sh/projects/soldeer), which is a solidity native package manager.

## How to Use

- `npm run compile`: compiles contracts
- `npm run erc20:deploy`: deploys the erc20 contract
- `npm run greeter:deploy`: deploys the greeter contract
- `npm run test:hardhat`: runs the hardhat tests
- `npm run test:forge`: runs the foundry tests

Note: Both `npm run deploy` and `npm run interact` are set in the `package.json`. You can also run your files directly, for example: `npx hardhat deploy-zksync --script deploy.ts`

### Environment Settings

To keep private keys safe, this project pulls in environment variables from `.env` files. Primarily, it fetches the wallet's private key.

Copy `.env.example` to `.env` and fill in your private key:

```
WALLET_PRIVATE_KEY=your_private_key_here...
```

### Network Support

`hardhat.config.ts` comes with a list of networks to deploy and test contracts. Add more by adjusting the `networks` section in the `hardhat.config.ts`. To make a network the default, set the `defaultNetwork` to its name. You can also override the default using the `--network` option, like: `hardhat test --network dockerizedNode`.

### Local Tests

Running `npm run test` by default runs the [ZKsync In-memory Node](https://docs.zksync.io/build/test-and-debug/in-memory-node) provided by the [@matterlabs/hardhat-zksync-node](https://docs.zksync.io/build/tooling/hardhat/hardhat-zksync-node) tool.

Important: ZKsync In-memory Node currently supports only the L2 node. If contracts also need L1, use another testing environment like Dockerized Node. Refer to [test documentation](https://docs.zksync.io/build/test-and-debug) for details.

## Useful Links

- [Docs](https://docs.zksync.io/build)
- [Official Site](https://treasure.lol/)
- [GitHub](https://github.com/TreasureProject)
- [Twitter](https://twitter.com/zksync)
- [Discord](https://discord.com/invite/treasuredao)

## License

This project is under the [MIT](./LICENSE) license.