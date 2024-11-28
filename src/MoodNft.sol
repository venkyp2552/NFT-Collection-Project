//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    //errors
    error MoodNft__CannotFlipIfNotOwner();

    uint256 private s_tokenCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;
    address private s_owner;

    enum Mood{
        HAPPY,
        SAD
    }
    
    mapping(uint256=>Mood) private s_tokenIdToMood;

    constructor(string memory happySvgImageUri,string memory sadSvgImageUri)
    ERC721("Mood NFT","MN") {
        s_sadSvgImageUri=sadSvgImageUri;
        s_happySvgImageUri=happySvgImageUri;
        s_tokenCounter=0;
        s_owner=msg.sender;
    }
    

    function mintNft() public {
        _safeMint(msg.sender,s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter]=Mood.HAPPY;
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public{
        //Only Owner Can Change the NFT Mode
        if(s_owner !=msg.sender){
            revert MoodNft__CannotFlipIfNotOwner();
        }
        if(s_tokenIdToMood[tokenId]==Mood.HAPPY){
            s_tokenIdToMood[tokenId]=Mood.SAD;
        }else{
            s_tokenIdToMood[tokenId]=Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns(string memory){
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns(string memory){
        string memory imageURI;
        if(s_tokenIdToMood[tokenId]==Mood.HAPPY){
            imageURI=s_happySvgImageUri;
        }else{
            imageURI=s_sadSvgImageUri;

        }
        //we need to form a metadata object like name,description,imageURI,atributes
        //First we need to convert this into using bytes method,using Base64.encode method we should again convert that bytes data into encoded hashed format.
        // string memory tokenMetadata=string.concat(
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                                '{"name":"',
                                name(),
                                '","description":"An NFT That Reflects Owner Moods",',
                                '"attributes":[{"trait_type":"moodines","value":1000}],',
                                '"image":"',
                                imageURI,
                                '"}'
                        )
                    )
                )
            )
        );
      
    }

    
}
