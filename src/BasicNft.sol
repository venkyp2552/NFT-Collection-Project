//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract BasicNft is ERC721{
    error BasicNft__OwnerONlyCanCall();
    address private s_owner;
    uint256 private s_tokenCounter;
    string private s_tokenName;
    string private s_tokenSymbol;
    mapping(uint256=>string) private s_tokenIdToUri;

    constructor() ERC721("Dogie","DOG"){
        s_tokenName="Dogie";
        s_tokenSymbol="DOG";
        s_tokenCounter=0;
        s_owner=msg.sender;
    }

    function minNft(string memory tokenUri) public{
        s_tokenIdToUri[s_tokenCounter]=tokenUri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(uint256 tokenId) public view override returns(string memory){
        return s_tokenIdToUri[tokenId];
    }

    /**Getter FUnctions */

    function getTokenName() public view returns(string memory){
        return s_tokenName;
    }

    function getTokenSymbol() public view returns(string memory){
        return s_tokenSymbol;
    }
}