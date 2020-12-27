pragma solidity ^0.7.4;

contract functions {
    address payable owner;
     
    mapping(address => uint) public balanceReceived;
    
    constructor () public {
        owner = msg.sender;
    }
    
    function getOwner () public view returns(address) {
        return owner;
    }
    
    // A pure function is used when the function does not interact with anything stored in memory i.e mapping or variables"
    function convertWeiToEther (uint _amountInEther) public pure returns(uint) {
        return _amountInEther / 1 ether;
    }
    
    
    function destroySmartContract() public {
        require(msg.sender == owner,"You are not the owner");
        selfdestruct(owner);
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