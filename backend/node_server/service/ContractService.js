const Web3 = require('web3');
const fs = require('fs');
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()
const deployedAddress = process.env.DEPLOY_ADDRESS
var web3 = new Web3(new Web3.providers.HttpProvider('https://data-seed-prebsc-1-s1.binance.org:8545'));
var contract;
const getRawContract = () => {
    // read contract from file
    let contractFile = fs.readFileSync("./Shop.json");
    let contractRaw = JSON.parse(contractFile);
    return contractRaw;
}

const getDeployedContractAddress = () => {
    return deployedAddress;
}
const getContract = () => {
    return { contract, coinbase };

}

let contractRaw = getRawContract();
// const account = web3.eth.accounts.create();
const account = web3.eth.accounts.privateKeyToAccount(process.env.PRIKEY)
web3.eth.accounts.wallet.add(account);
contract = new web3.eth.Contract(contractRaw.abi, getDeployedContractAddress());
coinbase = account.address
exports.getRawContract = getRawContract;
exports.getDeployedContractAddress = getDeployedContractAddress;
exports.getContract = getContract;