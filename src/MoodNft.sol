// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {

    //errors
    error MoodNft__cantFlipMoodIfNotOwner();

    uint256 private s_tokenCounter;
    string private s_sadSvg;
    string private s_happySvg;

enum Mood {
    HAPPY,SAD
}

    mapping (uint256 => Mood) private s_tokenIdToMood;
    constructor (
        string memory sadSvgImageUri,
        string memory happySvgImageUri

    ) ERC721("MoodNft","MN"){
        s_tokenCounter=0;
        s_sadSvg= sadSvgImageUri;
        s_happySvg = happySvgImageUri;
    }

    function _baseURI()internal pure override returns (string memory){
        return "data:application/json;base64,";
    }
    function mintNft()  public {
        _safeMint(msg.sender,s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter]=Mood.HAPPY;
        s_tokenCounter++;
    }
/**@return string application uri
 */
    function tokenURI(uint256 tokenId) public view override returns (string memory){
        string memory imageUri;
        if(s_tokenIdToMood[tokenId]==Mood.HAPPY){
            imageUri = s_happySvg;
        }else{
            imageUri=s_sadSvg;
        }
      return string(abi.encodePacked(_baseURI(),Base64.encode(bytes(abi.encodePacked('{"name":"',name(),'", "description":"an nft to represt owners mood","attributes":[{"trait_type":"moodiness", "value":100}],"image":"',imageUri,'"}')))));
    }

    function flipMood(uint256 tokenId) public{
        if(_ownerOf(tokenId)!= msg.sender){
            revert MoodNft__cantFlipMoodIfNotOwner();
        }
        if(s_tokenIdToMood[tokenId]==Mood.HAPPY){
            s_tokenIdToMood[tokenId]=Mood.SAD;
        }else{
            s_tokenIdToMood[tokenId]=Mood.HAPPY;
        }
    }
}
