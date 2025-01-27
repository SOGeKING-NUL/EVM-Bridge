// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol"; 

contract BridgedETH is Ownable{
    address public tokenAddress;

    mapping(address=> uint256) public pendingBalance;

    constructor(address _tokenAddress) Ownable(msg.sender) {
        tokenAddress = _tokenAddress;
    }
    
    function deposit(IERC20 _tokenAddress, uint _amount) public{
        require(address(_tokenAddress) == tokenAddress);// function can be called anytime, thus need to ensure that the same token is given
        require(_tokenAddress.allowance(msg.sender, address(this)) >= _amount); //need to set an allowance before using this function
        require(_tokenAddress.transferFrom(msg.sender, address(this), _amount)); // the function inside actually executes first and then checked for requirment
        pendingBalance[msg.sender] +=_amount;

    }

    function withdraw(IERC20 _tokenAddress, uint _amount) public{
        require(address(_tokenAddress) == tokenAddress);
        require(pendingBalance[msg.sender] >= _amount);
        pendingBalance[msg.sender] -= _amount;
        _tokenAddress.transfer(msg.sender, _amount);
    }

    function burnTokenOnOtherSide(address _from, uint _amount) public{
        pendingBalance[_from] -= amount;
    } 
}
