pragma solidity ^0.4.17;

import './MyToken.sol';
//import './Whitelist.sol';

import 'zeppelin-solidity/contracts/crowdsale/Crowdsale.sol';


//contract MyCrowdsale is Crowdsale, Whitelist {
contract MyCrowdsale is Crowdsale {

  uint256 public minimalInvestmentInWei = 0.1 ether;
  address public tokenAddress;

  MyToken public myToken;

  function MyCrowdsale(uint256 _startTime, uint256 _endTime, uint256 _rate, address _wallet, address _tokenAddress) public
    Crowdsale(_startTime, _endTime, _rate, _wallet)
    {
      tokenAddress = _tokenAddress;
      token = createTokenContract();
    }

  function createTokenContract() internal returns (MintableToken) {
    return MyToken(tokenAddress);
  }  

  // overriding Crowdsale#validPurchase to add extra cap logic
  // @return true if investors can buy at the moment
  function validPurchase() internal view returns (bool) {
    bool minimalInvested = msg.value >= minimalInvestmentInWei;
    //bool whitelisted = addressIsWhitelisted(msg.sender);

    //return super.validPurchase() && minimalInvested && whitelisted;
    return super.validPurchase() && minimalInvested;
  }
  
}