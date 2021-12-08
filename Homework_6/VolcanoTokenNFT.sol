// SPDX-License-Identifier: UNLICENSED
// Homework 6

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoTokenNFT is ERC721URIStorage, Ownable {

    constructor() ERC721("Volcano", "VLC") {

    }

    struct tokenMetadata {
        uint tokenTimestamp;
        uint tokenId;
        string tokenURI;
    }

    uint counter;

    mapping(address => tokenMetadata[]) public tokensOf;

    function mintAVolcano(string memory _tokenURI) public {
        _safeMint(msg.sender, counter);
        tokensOf[msg.sender].push(tokenMetadata(block.timestamp, counter, _tokenURI));
        _setTokenURI(counter, _tokenURI);
        counter++;
    }

    function burnNFT(uint _tokenId) public {        
        require(ownerOf(_tokenId) == msg.sender, "Only owner of token Id can burn it.");
        _burn(_tokenId);
        removeNFT(_tokenId);
    }

    function removeNFT(uint _tokenId) internal {
        uint tokensLen = tokensOf[msg.sender].length;

        for(uint i = 0; i < tokensLen; i++) {
            if(tokensOf[msg.sender][i].tokenId == _tokenId) {
                tokensOf[msg.sender][i] = tokensOf[msg.sender][tokensLen-1];
                tokensOf[msg.sender].pop();
            }
        }
    }

    
}