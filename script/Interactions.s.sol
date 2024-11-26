// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "src/BasicNft.sol";
import {console} from "forge-std/console.sol";
contract BasicNftInteractions is Script {
    string constant PUG ="dhaneshhhdhhdfhakdhflaksdlakjdflakjhdfkadf";

    function run () public {
        address mostRecentlyDeployed =DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            31337
        );
        console.log(mostRecentlyDeployed);
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract (address _basicNftAddress) public{
        console.log(msg.sender);
        vm.startBroadcast();
        console.log(msg.sender);
        BasicNft(_basicNftAddress).mintNft(PUG);
        vm.stopBroadcast();
    }
}