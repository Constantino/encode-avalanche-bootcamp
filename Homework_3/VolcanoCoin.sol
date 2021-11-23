// SPDX-License-Identifier: UNLICENSED
// Author: Constantino Mora
// Homework 3

pragma solidity ^0.8.0;

contract VolcanoCoin {
    
    uint total_supply = 10000;
    address owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        if(msg.sender == owner) {
            _;
        }
            
    }
    
    event TotalSupplyIncreased(uint);
    
    
    function getTotalSupply() public view returns(uint) {
        return total_supply;
    }
    
    function increaseTotalSupply() public onlyOwner{
        total_supply += 1000;
        emit TotalSupplyIncreased(total_supply);
    }
}