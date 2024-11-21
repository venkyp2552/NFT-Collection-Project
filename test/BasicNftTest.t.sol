//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "lib/forge-std/src/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";
contract BasicNftTest is Test{
    DeployBasicNft deployBasicNft;
    BasicNft public basicNft;
    string public constant PUG_URI="ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    address public USER=makeAddr('user');

    function setUp() public {
        deployBasicNft=new DeployBasicNft();
        basicNft=deployBasicNft.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName="Dogie";
        string memory actualName=basicNft.name();
        assert(keccak256(abi.encodePacked(expectedName))==keccak256(abi.encodePacked(actualName)));
    }

    function testSymbolIsCorrect() public view{
        string memory expectedSymbol="DOG";
        string memory actualSymbol=basicNft.symbol();
        assert(keccak256(abi.encodePacked(expectedSymbol))==keccak256(abi.encodePacked(actualSymbol)));
    }

    function testCanMintANdHaveABalance() public {
        vm.prank(USER);
        basicNft.minNft(PUG_URI);
        assertEq(basicNft.balanceOf(USER),1);
        assertEq(keccak256(abi.encodePacked(PUG_URI)),keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }
}
