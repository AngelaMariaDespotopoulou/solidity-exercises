//SPDX-License-Identifier: MIT

pragma solidity 0.8.22;


contract WillThrow {

    error ThisIsACustomError(string, string);

    // Note: the "pure" keyword is used to indicate that a function does not modify the state 
    // of the contract. It is a function qualifier that ensures that the function only performs 
    // computations and does not read from or modify the storage, nor does it interact with 
    // other contracts or external services.
    
    function errorTest() public pure {
        require(false, "This is a message denoting Error in require.");
    }

    function panicTest() public pure {
        assert(false);
    }

    function customNamedExceptionTest() public pure {
        revert ThisIsACustomError("A custom error was triggered.", "Additional details.");
    }
    
}


// Try/catch blocks work only in the context of other contracts.

contract ErrorHandling {

    event ErrorLogging(string reason);
    event PanicLogging(uint code);
    event ErrorLogBytes(bytes lowLevelData);

    function catchTheError() public {
        
        WillThrow will = new WillThrow();

        // Require
        try will.errorTest() {
            // Add code here, if it works.
        } catch Error(string memory reason) {
            emit ErrorLogging(reason);
        }

        // Assert
        try will.panicTest() {
            // Add code here, if it works.
        } catch Panic(uint errorCode) {
            emit PanicLogging(errorCode);
        }

        // Custom
        try will.panicTest() {
            // Add code here, if it works.
        } catch (bytes memory lowLevelData) {
            emit ErrorLogBytes(lowLevelData);
        }
    }
}