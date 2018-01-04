pragma solidity ^0.4.17;

import 'zeppelin-solidity/contracts/token/CappedToken.sol';


contract MyToken is CappedToken {

  string public constant name = "MyToken";
  string public constant symbol = "MTK";
  uint8 public constant decimals = 18;

  function MyToken(uint256 _cap) 
    CappedToken(_cap) public {
  }
}
