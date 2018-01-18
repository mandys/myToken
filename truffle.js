var WalletProvider = require("truffle-wallet-provider");
// var keystore       = require('fs').readFileSync('./test/keystore/key.json').toString();
// var pass           = require('fs').readFileSync('./test/keystore/pass').toString();
// var wallet         = require('ethereumjs-wallet').fromV3(keystore, pass);

var pkey_str = require('fs').readFileSync('./test/keystore/key').toString();
var prkey_buff = new Buffer(pkey_str, 'hex')
var wallet = require('ethereumjs-wallet').fromPrivateKey(prkey_buff)
const defaultGas = 6e6;
const defaultGasPrice = 5e9;

module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    },
    rinkeby: {
      provider: new WalletProvider(wallet, "https://rinkeby.infura.io/SNWrFm1CMX7BfYqvkFXf"),
      network_id: 3,
      gas: defaultGas,
      gasPrice: defaultGasPrice
    }
  }
};
