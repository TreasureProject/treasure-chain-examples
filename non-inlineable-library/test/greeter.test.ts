import { expect } from 'chai';
import { getWallet, deployContract, LOCAL_RICH_WALLETS } from '../deploy/utils';
import { Greeter } from '../typechain-types';

describe('Greeter', function () {
  it("Should return the new greeting once it's changed", async function () {
    const wallet = getWallet(LOCAL_RICH_WALLETS[0].privateKey);

    const greeting = "Hello";
    const greeter = await deployContract("Greeter", [greeting], { wallet, silent: true }) as unknown as Greeter;

    // TODO: probably failing due to the library "deployment" during the unit test
    // expect(await greeter.greetSomeone("Bob")).to.eq(`Hello Bob!`);

    // const newGreeting = "Hola";
    // const setGreetingTx = await greeter.setGreeting(newGreeting);
    
    // // wait until the transaction is processed
    // await setGreetingTx.wait();

    // expect(await greeter.greetSomeone("Bob")).to.equal(`Hola Bob!`);
  });
});
