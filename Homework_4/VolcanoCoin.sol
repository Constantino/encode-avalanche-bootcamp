// SPDX-License-Identifier: UNLICENSED
// Author: Constantino Mora
// Homework 4

pragma solidity ^0.8.0;

contract VolcanoCoin {
    
    uint total_supply = 10000;
    address owner;
    mapping(address => uint256) public balance;

    constructor() {
        owner = msg.sender;
        balance[owner] = total_supply;
    }
    
    modifier onlyOwner {
        if(msg.sender == owner) {
            _;
        }
            
    }

    struct Payment {
        uint amount;
        address payable recipent;
    }

    mapping(address => Payment[]) public payments;
    
    event TotalSupplyIncreased(uint);
    event Transfer(uint, address);
    
    function getTotalSupply() public view returns(uint) {
        return total_supply;
    }
    
    function increaseTotalSupply() public onlyOwner{
        total_supply += 1000;
        emit TotalSupplyIncreased(total_supply);
    }

    function transfer(uint _amount, address payable _recipient) public {
        balance[msg.sender] -= _amount;
        balance[_recipient] += _amount;

        payments[msg.sender].push(Payment(_amount, _recipient));

        emit Transfer(_amount, _recipient);
    }
}