const ContractService = require('./service/ContractService');
const fs = require('fs');

let {contract, coinbase } = ContractService.getContract();

// contract.methods.addOrder(
//     1,
//     1,
//     1,
//     "address",
//     "details",
//     "name",
//     "phone",
//     1
// ).send({
//     from: coinbase,
// })
//     .on('receipt', function (receipt) {
//     console.log(receipt)        
//     })
//     .on('error', function (error, receipt) { // If the transaction was rejected by the network with a receipt, the second parameter will be the receipt.
//        console.log(error)
//     });

// contract.methods.getOrder(
//     1
// ).call({
//     from: coinbase,
// }, function (error, result) {
//     console.log(result)
// });

// contract.methods.createUser(
//     1,
//     "name",
//     "phone",
//     "email",
//     1
// ).send({
//     from: coinbase,
// })
//     .on('receipt', function (receipt) {
//     console.log(receipt)        
//     })
//     .on('error', function (error, receipt) { // If the transaction was rejected by the network with a receipt, the second parameter will be the receipt.
//         console.log(error)
//     });
