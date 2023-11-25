//SPDX-License-Identifier: MIT

pragma solidity 0.8.22;

contract ExampleExceptionRequire {

    mapping(address => uint) public balanceReceived;

    function receiveMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    // Require is here for user-input validation and if it evaluates to false, it will throw an exception. 
    // Not only your transaction fails, which is what we want, we also get proper feedback to the user. 
    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceReceived[msg.sender], "Not Enough Funds, aborting");

        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    // 'require' is typically used to ensure the inputs to a function or a contract are valid. 
    // It is used for checking conditions that users have control over, such as inputs or external factors.
    // If the condition specified in 'require' evaluates to false, the function will throw an exception, 
    // and all changes made to the state of the contract will be rolled back.
    
}