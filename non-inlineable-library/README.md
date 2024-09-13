# Non-inlineable library

This project was scaffolded with [zksync-cli](https://github.com/matter-labs/zksync-cli).
It contains some basic examples on how to deploy a contract depending on a non-inlineable library, with `hardhat-zksync-deploy`. To deploy a non-inlineable library with `hardhat-zksync`, it has to be deployed separately in another project, and then the address of the contract has to be added to `hardhat.config.ts`, as described in the ZKSync [docs](https://docs.zksync.io/build/tooling/hardhat/guides/compiling-libraries#manual-deployment).

## Project Layout

- `/contracts`: contains solidity smart contracts
- `/deploy`: scripts for contract deployment and interaction
- `/test`: test files
- `hardhat.config.ts`: configuration settings

## Getting started
Install dependencies
```bash
npm install
```

## How it Works
1. `zksolc` detects the non-inlineable libraries
2. `hardhat deploy-zksync:libraries` deploys these libraries (works with a chain of dependencies too), and fills in the missing details in `hardhat.config.ts`. This is not committed, so it's easy to spot the changes when running the scripts
3. the contract which depends on the non-inlineable contract can now be deployed

## How to Use

- `npm run compile`: compiles contracts
- `npm run deploy:missing-libraries`: fills in the library details in `hardhat.config.ts`
- `npm run deploy`: deploys the contract
- `npm run interact`: interact with the deployed contract

Finally the output should be:
```bash
(base) ➜  non-inlineable-library git:(main) ✗ npm run interact

> interact
> hardhat deploy-zksync --script interact.ts

Running script to interact with contract 0x1aEd00Bd0D8639F42C922209733Fb79B64A7E548
Current message is: Hi Alice!
Transaction hash of setting new message: 0x148b86e5040b81d3c614116b6a54e468775352c21b3b21382ab2571fc7b4322f
The message now is: Aloha Alice!
```

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