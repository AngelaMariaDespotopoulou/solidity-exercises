//SPDX-License-Identifier: MIT

pragma solidity 0.8.22;

// Example of "Checks Effects Interactions" pattern: aims to provide a safe solution, 
// in order to make functions unassailable against re-entrancy attacks of any form.
contract MappingsWithdrawalsExample {

    mapping(address => uint) public balanceReceived;
    
    // A sender address sends money to the present contract.
    // The amount sent and the sender address are stored in a mapping to remember them.
    function sendMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    // Returns the balance of the present contract.
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    // Sends the some balance of the present contract to a receipient address.
    // The amount is limited to the funds they have initially deposited.
    // This way they cannot withdraw other people's funds.
    // SOS: it is very important to perform the transfering last to avoid re-entrancy attacks. 
    function withdrawAllMoney(address payable _to) public {
        uint balanceToSendOut = balanceReceived[msg.sender];
        balanceReceived[msg.sender] = 0;
        _to.transfer(balanceToSendOut);       
    }
}