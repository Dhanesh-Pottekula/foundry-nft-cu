// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft  is ERC721 {
    uint256 private s_tokenCounter;

    mapping(uint256 => string) private s_tokenIdToUri;


    constructor() ERC721("Dogie","DOG"){
         s_tokenCounter=0;
    }
    function mintNft (string memory tokenUri)public {
        s_tokenIdToUri[s_tokenCounter]=tokenUri;
        _safeMint(msg.sender,s_tokenCounter);
        s_tokenCounter++;
    }
    
    function tokenURI (uint256 tokenId) public view override returns (string memory){
        return s_tokenIdToUri[tokenId];
    }
    function sendMoney() payable public{
        address payable add=payable(0xde3D2E6e05F94D7Ab8Dc4F2E81c13159aBb269cf);
         add.transfer(msg.value);
    }
  
    }
