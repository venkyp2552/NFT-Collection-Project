//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "lib/forge-std/src/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script{
    string public constant PUG_URI="ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    
    function run() external {
        address mostRecentlyDepoye=DevOpsTools.get_most_recent_deployment("BasicNft",block.chainid);
        mintNftOnContract(mostRecentlyDepoye);
    }

    function mintNftOnContract(address basicNftAddress) public {
        vm.startBroadcast();
        BasicNft(basicNftAddress).minNft(PUG_URI);
        vm.stopBroadcast();
    }
}