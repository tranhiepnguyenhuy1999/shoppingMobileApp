const fs = require('fs');
const Web3 = require('web3');
const net = require('net');

var password = "123456";
var coinbase;
var web3; 

const getCoinbase = (callBack) => {
  web3.eth.getCoinbase((err, _coinbase) => {
    if(err) {
      console.log('Wow. Something went wrong: ' + e);
      process.exit();
    }
    coinbase = _coinbase;
    callBack()
  })
}

const connectWeb3 = (callBack) => {
  web3 = new Web3(Web3.givenProvider || "ws://localhost:8545");
  web3.eth.net.isListening()
    .then(() => callBack())
    .catch((e) => {
      console.log('Wow. Something went wrong: ' + e);
      process.exit();
    });
}

const deployContract = () => {
  let personal = web3.eth.personal;
  personal.unlockAccount(coinbase, password, 15000)
  
  let source = fs.readFileSync("../truffle_smart_contract/build/contracts/BankTransfer.json");
  let contracts = JSON.parse(source);

  // ABI description as JSON structure
  let abi = contracts.abi;

  // Smart contract EVM bytecode as hex
  let code = contracts.bytecode;

  // Create Contract proxy class
  let contract = new web3.eth.Contract(abi);

  contract.deploy({
    data: code,
    arguments: []
  })
  .send({
      from: coinbase,
      gas: 4712388,
      gasPrice: 100000000000
  })
  .then(function(newContractInstance){
    console.log(newContractInstance)
    // const content = JSON.stringify(newContractInstance, null, "\t");
    // fs.writeFileSync('./contract_deployed.json', content);
    console.log('Finish');
    process.exit();
  });

}

connectWeb3(() => {
  getCoinbase(deployContract);
});

