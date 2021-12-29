

var fs = require('fs');
var jsonFile = "../contract/contracts/Bank_sol_Bank.abi";
var parsed = JSON.parse(fs.readFileSync(jsonFile));
// var abi = parsed.abi;

const Web3 = require('web3');
const web3 = new Web3(Web3.givenProvider || "ws://localhost:8545");
web3.eth.getAccounts(console.log);
// console.log(web3.eth.Contract.options)
var Contract = require('web3-eth-contract');
// set provider for all later instances to use
Contract.setProvider('ws://localhost:8545');
var contract = new Contract(parsed, "0xA7052B52Aee7f7E5977fE25d78fb4ec1C73264de");

// contract.methods.totalSupply().send({ from: '0x505Bad8d9f8194BE8616e5312106113724C6d3ca' }, function (error, transactionHash) {
//     console.log(transactionHash)
//     if (error)
//         console.log(error)
// });
contract.methods.totalSupply().call({ from: '0x60E448458b69F79548ffFCA46ff2A6f4a8e92DCe' })
    .then(function (receipt) {
        console.log(receipt)
    });
    
contract.methods.setProductInfo(1, 2, '3', '4', '5', 6, [7]).send({ from: '0x0B92D89272BA7CCb205B6186cDB11B8350F37B6A' }, function (error, transactionHash) {
    console.log(transactionHash)
    if (error)
        console.log(error)
});
// web3.eth.sendTransaction({ from: '0xBCeaccE432e0Ac357d52e1e43B35AF4aA9dd2C67', data: Buffer.from('hello world', 'utf8').toString('hex') })
//     .once('sending', function (payload) { console.log('sending') })
//     .once('sent', function (payload) { console.log('send') })
//     .once('transactionHash', function (hash) { console.log({ hash }) })
//     .once('receipt', function (receipt) {
//         console.log({ receipt })
//     })
//     .on('confirmation', function (confNumber, receipt, latestBlockHash) {
//         console.log({ confNumber })
//         console.log({ receipt })
//         console.log({ latestBlockHash })
//     })
//     .on('error', function (error) { console.log({ error }) })
//     .then(function (receipt) {
//         console.log({ receipt })
//     });