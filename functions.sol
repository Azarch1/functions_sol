pragma solidity ^0.7.4;

contract functions {
    address owner;
     
    mapping(address => uint) public balanceReceived;
    
    constructor () public {
        owner = msg.sender;
    }
    
    function sendMoney() public payable {
        assert(balanceReceived[msg.sender] + msg.value >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    }
    
    function withdrawMoney (address payable _to, uint _amount) public {
        require(_amount <= balanceReceived[msg.sender], "You don't have enough funds!");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] -_amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
    
    // fallback function initiates when a function is not specified otherwise the transaction will revert
    fallback() external payable  {
        sendMoney();
    }
}