const fs = require('fs');
const Web3 = require('web3');
const net = require('net');
const express = require('express')
const { getUserInfoFromToken } = require('./authenticate');
const appRoute = require('./routes/v1/app.route');

const app = express()
app.use(express.json());

const port = process.env.PORT;
var coinbase;
var web3;

app.get('/', function (req, res) {
    res.send('Hello World')
})

app.get('/coin-base-balance', function (req, res) {
    web3.eth.getBalance(coinbase, function (error, result) {
        if (!error) {
            res.send(result);
        };
    });
})

app.use("/v1", async function (req, res, next) {
    const rawToken = req.headers && req.headers.authorization ? req.headers.authorization : null;
    req.user = await getUserInfoFromToken(rawToken)
    next()
})
app.use('/v1', appRoute)

const getCoinbase = (callBack) => {
    web3.eth.getCoinbase((err, _coinbase) => {
        coinbase = _coinbase;
        if (callBack) {
            callBack()
        }
    })
}

const connectWeb3 = (callBack) => {
    web3 = new Web3(Web3.givenProvider || "ws://localhost:8545");
    web3.eth.net.isListening()
        .then(() => {
            console.log('Web3 connected');
            callBack();
        })
        .catch((e) => {
            console.log('Wow. Something went wrong: ' + e);
            process.exit();
        });
}

app.listen(port, async () => {
    connectWeb3(() => {
        getCoinbase();
        console.log(`App running on port ${port}`);
    });
})