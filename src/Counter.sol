// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {console} from "../lib/forge-std/src/console.sol";
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol"; 

contract BridgedETH is Ownable(){
    uint256 public balance;
    uint256 public tokenAddress;

    mapping(address=> uint256) public pendingBalance;

    constructor(address _tokenAddress) Ownable(msg.sender) {
        tokenAddress = _tokenAddress;
    }
    
    function deposit(IERC20 _tokenAddress, uint amount) public{
        require(address(_tokenAddress) == tokenAddress);// function can be called anytime, thus need to ensure that the same token is given
        require(_tokenAddress.allowance(msg.sender, addres(this) >= _amount)); //need to set an allowance before using this function
        require(_tokenAddress.transferFrom(msg.sender, address(this), _amount);); // the function inside actually executes first and then checked for requirment
        pendingBalance[msg.sender] +=_amount;

    }

    function withdraw() public{}
}
