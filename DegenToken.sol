// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    constructor() ERC20("Degen", "DGN") {}

    event RedeemToken(address account, uint rewardCategory);
    event BurnToken(address account, uint amount);
    event TransferToken(address from, address to, uint amount);

    // onlyOwner modifier allows only the user to execute the function
    function mint(address to, uint256 amount) public onlyOwner {
            _mint(to, amount);
    }
    
    // In-built transfer function is used
    // transfer(to, amount);

    //Wrapper function for balanceOf function of ERC20
    function getBalance() public view returns (uint){
        return balanceOf(msg.sender);
    }

    function gameStore() public pure returns(string memory) {
            return "get random Amount = [0-1000]";
        }


   function reedemTokens(uint _userInput) external payable{
            require(_userInput==1,"Invalid selection");
            if(_userInput ==1){
                uint amount =  uint(keccak256(abi.encodePacked(block.timestamp,msg.sender))) % 100;
                uint amount2 =  uint(keccak256(abi.encodePacked(block.timestamp,msg.sender))) % 10;
                require(balanceOf(msg.sender)>=200, "There is not sufficient Balance to for this redemption");
                uint finalAmount = amount * amount2;
                approve(msg.sender, finalAmount);
                transferFrom(msg.sender, owner(), finalAmount);
            }
   }
    // Wrapper function to access the private _burn function of ERC20
    function burn(uint amount) public {
        _burn(msg.sender, amount);
        emit BurnToken(msg.sender, amount);
    }
}
