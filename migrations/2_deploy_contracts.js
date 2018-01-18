var Whitelist = artifacts.require("Whitelist.sol");
var MyToken   = artifacts.require("MyToken.sol");
var MyPresale = artifacts.require("MyPresale.sol");

function latestTime () {
    web3.eth.getBlock('latest', function(error, result){
        if(!error)
            return result.timestamp;
        else
            console.error(error);
    })
    //return web3.eth.getBlock('latest').timestamp;
  }
  
  const duration = {
    seconds: function (val) { return val; },
    minutes: function (val) { return val * this.seconds(60); },
    hours: function (val) { return val * this.minutes(60); },
    days: function (val) { return val * this.hours(24); },
    weeks: function (val) { return val * this.days(7); },
    years: function (val) { return val * this.days(365); },
  };

  
module.exports = function(deployer, network, accounts) {
    
    // Account & Wallet configuration
    var admin            = accounts[0];
    const startTime      = Date.now()/1000|0 + 240;
    const endTime        = startTime + duration.weeks(1);
    const ethRate        = new web3.BigNumber(100);
    const wallet         = accounts[0];
    const maxTokenSupply = 500e18;
    const presaleCap     = 5000e18;

    deployer.deploy(MyToken, maxTokenSupply).then(function() {
        return deployer.deploy(MyPresale, presaleCap, startTime, endTime, ethRate, wallet, MyToken.address);
    });  
};