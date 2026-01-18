// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {ERC20Token} from "../src/ERC20Token.sol";

contract ERC20TokenTest is Test {
    ERC20Token token;

    address deployer = address(this);
    address person1 = address(0xA11CE);
    address person2 = address(0xB0B);

    function setUp() public {
        token = new ERC20Token("SimpleToken", "STOK", 18, 1_000 ether);
    }

    function testInitialSupplyGoesToDeployer() public view {
        assertEq(token.totalSupply(), 1_000 ether);
        assertEq(token.balanceOf(deployer), 1_000 ether);
    }

    function testTransfer() public {
        token.transfer(person1, 100 ether);

        assertEq(token.balanceOf(person1), 100 ether);
        assertEq(token.balanceOf(deployer), 900 ether);
    }

    function testTransferFailsIfInsufficientBalance() public {
        vm.prank(person1);
        vm.expectRevert();
        token.transfer(person2, 1 ether);
    }

    function testApproveAndTransferFrom() public {
        token.approve(person1, 200 ether);

        vm.prank(person1);
        token.transferFrom(deployer, person2, 150 ether);

        assertEq(token.balanceOf(person2), 150 ether);
        assertEq(token.allowance(deployer, person1), 50 ether);
    }
}
