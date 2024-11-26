// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "src/BasicNft.sol";
import {DeployBasicNft} from "script/DeployBasicNft.s.sol";
contract BasicNftTest is Test{
    BasicNft basicNft ;
    DeployBasicNft deployBasicNft;
    string constant PUG ="dhaneshhhdhhdfhakdhflaksdlakjdflakjhdfkadf";
    address USER=makeAddr("user");

    function setUp() public{
        deployBasicNft=new DeployBasicNft();
        basicNft=deployBasicNft.run();
    }

    function testNftNameCorrect () public view {
        string memory expectedName ="Dogie";
        string memory name=basicNft.name();
        //strings are stored as array of bytes,
        // we cant compare array to array with ==
        // we can compare their binary data
        assertEq(keccak256(abi.encodePacked(expectedName)),keccak256(abi.encodePacked(name)));
    }

    function testCanMintHaveBalance () public {
        vm.prank(USER);
        basicNft.mintNft(PUG);
        assertEq(basicNft.balanceOf(USER),1);
        assertEq(keccak256(abi.encodePacked(basicNft.tokenURI(0))),keccak256(abi.encodePacked(PUG)));
    }

}