// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {BridgedETH} from "../src/BridgedETH.sol";
import {USDT} from "../src/USDT.sol";
import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract BridgedETHTest is Test{
    BridgedETH bridge;
    USDT usdt;

    function setUp() public{
        usdt= new USDT();
        bridge= new BridgedETH(address(usdt));
    }

    function testDeposit() public{
        usdt.mint(0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24, 300);
        vm.startPrank(0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24);// important as vm.prank will only apply for the approve transaction and then the brideg depost transaction gas fees will have to be paid by the one deploying the contract.

        usdt.approve(address(bridge), 200);
        bridge.deposit(usdt, 150);

        assertEq(usdt.balanceOf(address(bridge)), 150);
        assertEq(usdt.balanceOf(0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24), 150);

    }

    function testWithdrawl() public{

        usdt.mint(0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24, 300);
        vm.startPrank(0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24);

        usdt.approve(address(bridge), 300);
        bridge.deposit(usdt, 300);

        bridge.withdraw(usdt, 200);
        assertEq(usdt.balanceOf(0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24), 200);
        assertEq(usdt.balanceOf(address(bridge)), 100);

    }

}