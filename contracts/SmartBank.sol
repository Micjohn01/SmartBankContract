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

}