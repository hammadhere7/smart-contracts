// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Coin{
    
    
    address public minter;
    mapping(address=>uint256) public balances;
    
    
    constructor () {
        minter=msg.sender;
    }
    
    //Only owner is allowed to mint new coins
    modifier onlyOwner{
        
        require(minter==msg.sender);
        _;
    }
    
    //Notify sender and recipient about the coin movement
    event Sent(address from, address to, uint256 amount);
    
    
    //The creator of smart contract can mint new coins   
    function mint(address receiver, uint256 amount) public onlyOwner {
        
        balances[receiver]+=amount;
        
    }
    
     error insufficientBalance (uint requested, uint available);
     
       function send(address receiver, uint256 amount) public {
         
        if(amount>balances[msg.sender])
        revert insufficientBalance({
            requested: amount,
            available: balances[msg.sender]
        });
       
        
        balances[receiver]+=amount;
        balances[msg.sender]-=amount;
        
        emit Sent(msg.sender, receiver, amount);
        
    }
  
}
