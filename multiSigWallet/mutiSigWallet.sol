/*
  创建一个多签名钱包
  进行转移须有3名管理员签署交易
*/

pragma solidity^0.4.24;

contract mutiSigWallet{
    address owner;
    
    mapping(address => bool) public manager;
    
    struct payment {
        bool isFinish;
        uint sigCount;
        uint value;
        address to;
    }
    
    payment[] public payHistory;
    mapping(uint => address[]) public sigRecord;
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    modifier onlyManager() {
        require(
            msg.sender == owner ||
            manager[msg.sender] == true
        );
        _;
    }
    
    constructor() public {
        owner = msg.sender;
    }
    
    function() public payable {
    }
    
    function setManager(address _addr) public onlyOwner {
        manager[_addr] = true;
    }
    
    function unsetManager(address _addr) public onlyOwner {
        manager[_addr] = false;
    }
    
    function createNewPay(address _to, uint _value) public returns(uint) {
        require(address(this).balance >= _value);
        payment memory pay = payment(false, 0, _value, _to);
        return payHistory.push(pay) - 1;
    }
    
    function signPay(uint _id) public onlyManager returns(bool) {
        if(
            payHistory.length > _id &&
            !payHistory[_id].isFinish &&
            !_isSigned(msg.sender, _id)
          )
        {
            payment storage pay = payHistory[_id];
            pay.sigCount++;
            sigRecord[_id].push(msg.sender);
            return true;
        } else {
            return false;
        }
    }
    
    function _isSigned(address _addr, uint _id) internal view returns(bool) {
        for(uint i = 0; i < sigRecord[_id].length; i++) {
            if(_addr == sigRecord[_id][i])
                return true;
        }
        
        return false;
    }
    
    function withdraw(uint _id) public {
        payment storage pay = payHistory[_id];
        require(
            address(this).balance >= pay.value &&
            pay.sigCount >= 3
        );
        pay.isFinish = true;
        pay.to.transfer(pay.value);
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}