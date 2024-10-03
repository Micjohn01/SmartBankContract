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

    // Function to deposit funds to an account
    function deposit() public payable returns (bool) {
        require(users[msg.sender].exists, "Account does not exist");
        User storage user = users[msg.sender];
        user.balance += msg.value;
        totalBankBalance += msg.value;
        user.depositTime = block.timestamp;

        return true;
    }

    // Function to get the balance of a specific user
    function getBalance(address userAddress) public view returns (uint256) {
        require(users[userAddress].exists, "Account does not exist");
        User storage user = users[userAddress];
        uint256 capital = user.balance;
        return capital;
    }

    // Function to withdraw balance from the sender's account
    function withdraw(uint256 amount) public returns (bool) {
        require(users[msg.sender].exists, "Account does not exist");
        uint256 availableBalance = getBalance(msg.sender);
        require(availableBalance >= amount, "Insufficient balance");
        require(totalBankBalance >= amount, "Bank does not have enough balance");

        User storage user = users[msg.sender];
        user.balance -= amount;
        totalBankBalance -= amount;

        (bool sent, ) = payable(msg.sender).call{value: amount}("");
        require(sent, "Transaction failed");

        return true;
    }


}