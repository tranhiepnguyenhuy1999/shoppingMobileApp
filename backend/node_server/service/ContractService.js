const Web3 = require('web3');
const fs = require('fs');
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()
const deployedAddress = process.env.DEPLOY_ADDRESS
var coinbase = process.env.COINBASE
// var web3 = new Web3(Web3.givenProvider || "ws://localhost:8545");
var web3 = new Web3(new Web3.providers.HttpProvider('https://data-seed-prebsc-2-s2.binance.org:8545'));
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

//  web3.eth.personal.unlockAccount(account.address, '');
// var accounts = await web3.eth.getAccounts(); 
//   personal.unlockAccount(coinbase, "123456", 15000)
contract = new web3.eth.Contract(contractRaw.abi, getDeployedContractAddress());
exports.getRawContract = getRawContract;
exports.getDeployedContractAddress = getDeployedContractAddress;
exports.getContract = getContract;