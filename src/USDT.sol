//SPDX-License_Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract USDT is ERC20, Ownable{
    constructor() ERC20("USDT", "USDT") Ownable(msg.sender){

    }

    function mint(address _to, uint _amount) public onlyOwner{
        _mint(_to, _amount);
    }
}