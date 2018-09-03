/*
  ���غ�Լ��ַ
  ���غ�Լ�����ߵĵ�ַ
  ���ط����˵ĵ�ַ
  ���غ�Լ�����
  ���غ�Լ�ƶ��ߵ���������Ϊ�ú�Լ�����ߵ�ǰ���£�
  ���ط����˵����
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