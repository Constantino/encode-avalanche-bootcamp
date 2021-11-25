// SPDX-License-Identifier: UNLICENSED
// Author: Constantino Mora
// Homework 5

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract RegioCoin is ERC20("RegioCoin", "Regio"), Ownable {
    
    uint constant initialSupply = 21000000*10**18; 

    constructor() {        
        _mint(msg.sender, initialSupply);
    }

    struct Payment {
        uint amount;
        address payable recipent;
    }

    mapping(address => Payment[]) public payments;

    event TotalSupplyIncreased(uint);
    event Transfer(uint, address);

    function increaseTotalSupply(uint _amount) public onlyOwner {
        _mint(msg.sender, _amount);
        emit TotalSupplyIncreased(_amount);
    }
    
    function transfer(address _to, uint _amount) override public returns(bool) {
        payments[msg.sender].push(Payment(_amount, payable(_to)));
        _transfer(msg.sender, _to, _amount);        
        emit Transfer(_amount, msg.sender);

        return true;
    }
    
}