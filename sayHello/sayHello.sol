/*
  在创建时设置问候语并允许所有者（合约创建者）进行更改
  向每个调用sayHelloWorld方法的人返回问候语
  将Hello Admin返回给创建者
*/

pragma solidity^0.4.20;

contract sayHello{
    
    address owner;
    
    string helloWorld;
    
    constructor(string memory _helloWorld) public {
        owner = msg.sender;
        helloWorld = _helloWorld;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    function sayHelloWorld() public view returns(string memory) {
        if(_isOwner()){
            return "Hello Admin";
        } else {
            return helloWorld;
        }
    }
    
    function setHelloWorld(string memory _helloWorld) public onlyOwner{
        helloWorld = _helloWorld;
    }
    
    function _isOwner() private view returns(bool) {
        if(msg.sender == owner)
            return true;
        else
            return false;
    }
}