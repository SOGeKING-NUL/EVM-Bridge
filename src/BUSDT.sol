//SPDX-License_Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract BUSDT is Ownable{
    constructor() ERC20("USDT","USDT") Ownable(msg.sender){
    }

    function mint(address _to, uint256 _amount) public onlyOwner{
        _mint(_to, _amount);
    }

    function burn(address _from, uint256 _amount) public onlyOwner(){
        _burn(_from, _amount);
    }
}