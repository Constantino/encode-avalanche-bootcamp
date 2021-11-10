// SPDX-License-Identifier: UNLICENSED 
// Author: Constantino Mora
// Date: Nov 8, 2021

pragma solidity ^0.8.0;

contract Score {
    
    uint score;
    address owner;
    
    mapping(address => uint) public score_list;
    
    event NewScore(uint _newScore);
    
    constructor() {
        owner = msg.sender;    
    }
    
    modifier onlyOwner {
        if(msg.sender == owner) {
            _;
        }
            
    }
    
    function getScore() public view returns(uint) {
        return score;
    }
    
    function setScore(uint _score) public onlyOwner {
        score = _score;
        
        score_list[msg.sender] = score;
        
        emit NewScore(score);
    }
}
