pragma solidity ^0.4.18;

import './MyToken.sol';
//import './Whitelist.sol';

import 'zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol';
import 'zeppelin-solidity/contracts/lifecycle/Pausable.sol';


//contract MyPresale is CappedCrowdsale, Whitelist, Pausable {
contract MyPresale is CappedCrowdsale, Pausable {

  uint256 public minimalInvestmentInWei = 0.1 ether;
  uint256 public maximumInvestmentInWei = 1 ether;
  address public tokenAddress;

  MyToken public myToken;

  function MyPresale(uint256 _cap, uint256 _startTime, uint256 _endTime, uint256 _rate, address _wallet, address _tokenAddress) 
    CappedCrowdsale(_cap)
    Crowdsale(_startTime, _endTime, _rate, _wallet) public {
      tokenAddress = _tokenAddress;
      token = createTokenContract();
    }

  function createTokenContract() internal returns (MintableToken) {
    myToken = MyToken(tokenAddress);
    return MyToken(tokenAddress);
  }  

  // overriding Crowdsale#validPurchase to add extra cap logic
  // @return true if investors can buy at the moment
  function validPurchase() internal view returns (bool) {
    bool minimalInvested = msg.value >= minimalInvestmentInWei;
    bool maximumInvested = msg.value <= maximumInvestmentInWei;

    //bool whitelisted = addressIsWhitelisted(msg.sender);

    //return super.validPurchase() && minimalInvested && whitelisted;
    return super.validPurchase() && minimalInvested && maximumInvested && !paused;
  }
  
}