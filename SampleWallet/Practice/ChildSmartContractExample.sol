//SPDX-License-Identifier: MIT

pragma solidity 0.8.22;

contract Wallet {

    PaymentReceived public payment;

    function payContract() public payable {
        payment = new PaymentReceived(msg.sender, msg.value);
    }

}

contract PaymentReceived {

    address public from;
    uint public amount;

    constructor(address _from, uint _amount) {
        from = _from;
        amount = _amount;
    }

}


// If you deploy the "Wallet" smart contract and send 1 wei to the payContract function (1) , 
// it will use up 221530 gas (2). Why? Because it deploys a new contract "PaymentReceived", then links it. 
// To avoid this, one has to change the Smart Contract above to use a struct instead. 


