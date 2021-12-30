var Web3 = require('web3');


var web3 = new Web3(new Web3.providers.HttpProvider('https://data-seed-prebsc-1-s1.binance.org:8545'));
web3.eth.net.isListening()
        .then(() => {
            console.log('Web3 connected');
        })
        .catch((e) => {
            console.log('Wow. Something went wrong: ' + e);
            process.exit();
        });