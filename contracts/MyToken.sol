pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/token/CappedToken.sol';
import 'zeppelin-solidity/contracts/token/PausableToken.sol';

/**
  Lets make the token pausable so we don't allow trading of the token
  We will decide at a later point when the token should be made tradable
  @author Mandy Singh
 */
contract MyToken is CappedToken, PausableToken {

  string public constant name = "MyToken";
  string public constant symbol = "MTK";
  uint8 public constant decimals = 18;

  function MyToken(uint256 _cap) 
    CappedToken(_cap) public {
      paused = true;
  }
}
