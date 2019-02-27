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
