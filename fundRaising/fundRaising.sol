/*
  有筹款目标的(创立时设定数额)
  筹资有时间限制(创立时设定时间)
  任何人都可以增加任何金额，直到时间结束或目标达到为止。
  时间到了，但目标尚未完成，用户可以撤回他们的资金。
  当目标达到时，所有者可以取出所有钱
*/

pragma solidity^0.4.24;

contract fundRaising {
    uint deadLine;
    uint public totalAmount;
    uint public nowAmount;
    address owner;
    
    mapping(address => uint) balance;
    
    constructor(uint _totalEth, uint _minutesAfter) public {
        totalAmount = _totalEth * 10 ** 18;
        deadLine = now + _minutesAfter * 1 minutes;
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }
    
    function addAmount() public payable {
        require(!isTimesUp() && !isEnoughAmount());
        balance[msg.sender] += msg.value;
        nowAmount += msg.value;
    }
    
    function withdraw() public {
        if(isTimesUp() && !isEnoughAmount()) {
            uint amount = balance[msg.sender];
            nowAmount -= amount;
            balance[msg.sender] = 0;
            msg.sender.transfer(amount);
        }
    }
    
    function withdrawOwner() public onlyOwner {
        if(isTimesUp() && isEnoughAmount()) {
            owner.transfer(nowAmount);
        }
    }
    
    function isTimesUp() public view returns(bool) {
        if(deadLine <= now)
            return true;
        else
            return false;
    }
    
    function isEnoughAmount() public view returns(bool) {
        if(nowAmount >= totalAmount)
            return true;
        else
            return false;
    }
}