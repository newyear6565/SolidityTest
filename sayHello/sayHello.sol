/*
  �ڴ���ʱ�����ʺ��ﲢ���������ߣ���Լ�����ߣ����и���
  ��ÿ������sayHelloWorld�������˷����ʺ���
  ��Hello Admin���ظ�������
*/

pragma solidity^0.4.24;

contract sayHello{
    
    address owner;
    
    string helloWorld;
    
    constructor(string _helloWorld) public {
        owner = msg.sender;
        helloWorld = _helloWorld;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    function sayHelloWorld() public view returns(string) {
        if(_isOwner()){
            return "Hello Admin";
        } else {
            return helloWorld;
        }
    }
    
    function setHelloWorld(string _helloWorld) public onlyOwner{
        helloWorld = _helloWorld;
    }
    
    function _isOwner() private view returns(bool) {
        if(msg.sender == owner)
            return true;
        else
            return false;
    }
}