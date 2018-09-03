/*
  返回合约地址
  返回合约创建者的地址
  返回发送人的地址
  返回合约的余额
  返回合约制定者的余额（仅在你为该合约所有者的前提下）
  返回发送人的余额
*/

pragma solidity^0.4.24;

contract balanceAddressChecker {
    address owner;
    
    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }
    
    constructor() public {
        owner = msg.sender;
    }
    
    function() public payable {
        
    }
    
    function contractAddress() public view returns(address) {
        return address(this);
    }
    
    function ownerAddress() public view returns(address) {
        return owner;
    }
    
    function senderAddress() public view returns(address) {
        return msg.sender;
    }
    
    function contractBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function ownerBalance() public view onlyOwner returns(uint) {
        return owner.balance;
    }
    
    function senderBalance() public view returns(uint) {
        return msg.sender.balance;
    }
}