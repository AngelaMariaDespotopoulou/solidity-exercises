//SPDX-License-Identifier: MIT

pragma solidity 0.8.22;

contract MappingsStructExample {
   
    struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numDeposits;
        mapping(uint => Transaction) deposits;
        uint numWithdrawals;
        mapping(uint => Transaction) withdrawals;
    }

    mapping(address => Balance) public balanceReceived;


    function getBalance(address _addr) public view returns(uint) {
        return balanceReceived[_addr].totalBalance;
    }

    function getDepositNum(address _from, uint _numDeposit) public view returns(Transaction memory) {
        return balanceReceived[_from].deposits[_numDeposit];
    }

    function getWithdrawalNum(address _from, uint _numWithdrawal) public view returns(Transaction memory) {
        return balanceReceived[_from].withdrawals[_numWithdrawal];
    }

     // Notice that to receive money we declare the function payable.
    function depositMoney() public payable {
        
        // Recording new augmented balance.
        balanceReceived[msg.sender].totalBalance += msg.value;

        // Storing a transaction in memory.
        Transaction memory deposit = Transaction(msg.value, block.timestamp);

        // Placing the transaction in the mapping.
        balanceReceived[msg.sender].deposits[balanceReceived[msg.sender].numDeposits] = deposit;
        
        // Augmenting the counter.
        balanceReceived[msg.sender].numDeposits++;
    }

    // Notice that to send money we declare the address payable.
    function withdrawMoney(address payable _to, uint _amount) public {
        
        // Recording new reduced balance.
        balanceReceived[msg.sender].totalBalance -= _amount;

        // Storing a transaction in memory.
        Transaction memory withdrawal = Transaction(_amount, block.timestamp);
        
        // Placing the transaction in the mapping.
        balanceReceived[msg.sender].withdrawals[balanceReceived[msg.sender].numWithdrawals] = withdrawal;
        
        // Decreasing the counter.
        balanceReceived[msg.sender].numWithdrawals++;

        // Sending the amount out.
        _to.transfer(_amount);
    }

}
