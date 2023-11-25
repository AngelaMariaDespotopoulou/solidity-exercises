//SPDX-License-Identifier: MIT

pragma solidity 0.7.0;

contract ExampleExceptionAssert {

    mapping(address => uint8) public balanceReceived;

    // Assert is used to check invariants. Those are states our contract or variables should never reach, ever.
    function receiveMoney() public payable {
        assert(msg.value == uint8(msg.value));                  // In older versions of Solidity than 0.8 uint8 rolls over after 256 starting counting from zero.
        balanceReceived[msg.sender] += uint8(msg.value);
        assert(balanceReceived[msg.sender] >= uint8(msg.value));
    }

    function withdrawMoney(address payable _to, uint8 _amount) public {
        require(_amount <= balanceReceived[msg.sender], "Not Enough Funds, aborting");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    // 'assert', on the other hand, is used to check for conditions that should never, ever be false. It is used to check for internal errors or bugs in the code.
    // If the condition specified in assert evaluates to false, it indicates a critical bug in the code, and the transaction is reverted. Unlike require, assert will 
    // always consume all gas in the transaction, and any changes made to the state of the contract before the assert statement will be reverted.
    
}