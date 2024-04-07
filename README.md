# Note to the reviewer
    * Versions
    Truffle v5.4.1 (core: 5.4.1)
    Solidity v0.5.16 (solc-js)
    Web3.js v1.4.0
    Node v16.17.1
    npm: v8.15.0

    * Setup
        1- Open a terminal and run 'npm install'
        2- Run 'ganache-cli -m "candy maple cake sugar pudding cream honey rich smooth crumble sweet treat"'
        3- Copy the addresses of the "Available Accounts" provided by genache into the account addresses in \FlightSurety\config\testConfig.js
        4- Open a new terminal and run 'npm run server'
        5- Open a new terminal and run 'truffle compile' and observe that the contracts are compiled successfully
        6- Run 'truffle test ./test/flightSurety.js' and observe that all the tests pass.
        7- Run 'truffle test ./test/oracles.js' and observe that all the tests pass.
        8- Run 'truffle migrate' to deploy the contracts.
        9- Run 'npm run dapp', visit the URL 'http://localhost:8000' and observe that the dapp is running.
        10- Run 'npm run dapp:prod' to build the dapp for production.

# FlightSurety

FlightSurety is a sample application project for Udacity's Blockchain course.

## Install

This repository contains Smart Contract code in Solidity (using Truffle), tests (also using Truffle), dApp scaffolding (using HTML, CSS and JS) and server app scaffolding.

To install, download or clone the repo, then:

`npm install`
`truffle compile`

## Develop Client

To run truffle tests:

`truffle test ./test/flightSurety.js`
`truffle test ./test/oracles.js`

To use the dapp:

`truffle migrate`
`npm run dapp`

To view dapp:

`http://localhost:8000`

## Develop Server

`npm run server`
`truffle test ./test/oracles.js`

## Deploy

To build dapp for prod:
`npm run dapp:prod`

Deploy the contents of the ./dapp folder


## Resources

* [How does Ethereum work anyway?](https://medium.com/@preethikasireddy/how-does-ethereum-work-anyway-22d1df506369)
* [BIP39 Mnemonic Generator](https://iancoleman.io/bip39/)
* [Truffle Framework](http://truffleframework.com/)
* [Ganache Local Blockchain](http://truffleframework.com/ganache/)
* [Remix Solidity IDE](https://remix.ethereum.org/)
* [Solidity Language Reference](http://solidity.readthedocs.io/en/v0.4.24/)
* [Ethereum Blockchain Explorer](https://etherscan.io/)
* [Web3Js Reference](https://github.com/ethereum/wiki/wiki/JavaScript-API)