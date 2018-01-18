pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

contract Whitelist is Ownable {

    mapping(address => bool) public allowedAddresses;
    uint count = 0;
    
    event RegistrationStatusChanged(uint timestamp, string operation, address indexed member, uint totalAddresses);

    modifier whitelisted() {
      require(allowedAddresses[msg.sender] == true);
      _;
    }

    function addToWhitelist(address[] _addresses) public onlyOwner {
      for (uint i = 0; i < _addresses.length; i++) {
        allowedAddresses[_addresses[i]] = true;
        count++;
        RegistrationStatusChanged(block.timestamp, "Added", _addresses[i], count);
      }        
    }

    function removeFromWhitelist(address[] _addresses) public onlyOwner {
      for (uint i = 0; i < _addresses.length; i++) {
        allowedAddresses[_addresses[i]] = false;
        count--;
        RegistrationStatusChanged(block.timestamp, "Removed", _addresses[i], count);
      }         
    }    

    // function isWhitelisted() public whitelisted constant returns (bool) {
    //   return true;
    // }    

    function addressIsWhitelisted(address _address) public constant returns (bool) {
      return allowedAddresses[_address];
    }

    function getAddressCount() public constant returns (uint) {
      return count;
    }    

}
