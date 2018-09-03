/*
  �г��Ŀ���(����ʱ�趨����)
  ������ʱ������(����ʱ�趨ʱ��)
  �κ��˶����������κν�ֱ��ʱ�������Ŀ��ﵽΪֹ��
  ʱ�䵽�ˣ���Ŀ����δ��ɣ��û����Գ������ǵ��ʽ�
  ��Ŀ��ﵽʱ�������߿���ȡ������Ǯ
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