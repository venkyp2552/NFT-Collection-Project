//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test,console} from "lib/forge-std/src/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";

contract DeploMoodNftTest is Test{
    DeployMoodNft public deployer;
    function setUp() public {
        deployer=new DeployMoodNft();
    }

    function testConvertSvgtoUri() public view{
        string memory expectedImageUri="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48Y2lyY2xlIGN4PSI1MCIgY3k9IjUwIiByPSI0MCIgc3Ryb2tlPSJncmVlbiIgc3Ryb2tlLXdpZHRoPSI0IiBmaWxsPSJ5ZWxsb3ciIC8+PC9zdmc+";
        string memory svg='<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><circle cx="50" cy="50" r="40" stroke="green" stroke-width="4" fill="yellow" /></svg>';
        string memory encodedUri=deployer.svgToImgUri(svg);
        assert(keccak256(abi.encodePacked(encodedUri))==keccak256(abi.encodePacked(expectedImageUri)));
    }

}