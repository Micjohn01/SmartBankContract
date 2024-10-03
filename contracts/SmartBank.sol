// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract SmartBank {
    uint256 public totalBankBalance = 0;
    uint256 public constant INTEREST_RATE = 10; // 10% annual interest

    struct User {
        uint256 balance;
        uint256 depositTime;
        bool exists;
    }

    mapping(address => User) private users;

    function createAccount() public returns (bool) {
        require(!users[msg.sender].exists, "Account already exists");
        users[msg.sender] = User({
            balance: 0,
            depositTime: 0,
            exists: true
        });
        return true;
    }

    // Function to check if an account exists
    function accountExists(address userAddress) public view returns (bool) {
        return users[userAddress].exists;
    }


}