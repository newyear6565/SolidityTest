/*
  �û�֧��0.1��̫���ɼ���lottery
  �����û�����
  ͬһ�û����Զ�μ���
  ��Լ����������Լ���
  ��Լ�����˾�����ʱѡ��Ӯ��
  Ӯ�ҽ��õ����н���
  ѡ��Ӯ�Ҽ��ɿ�ʼ��һ��lottery
*/

pragma solidity^0.4.24;

contract lotteryNoLimit {
    address owner;
    address[] public player;
    uint random = 0;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }
    
    function joinGame() public payable {
        require(msg.value == 0.1 ether);
        player.push(msg.sender);
    }
    
    function getTotals() public view returns(uint) {
        return player.length;
    }
    
    function selectWinner() public onlyOwner returns(address){
        require(player.length > 0);
        random++;
        uint rand = uint(keccak256(abi.encodePacked(now, random, blockhash(block.number - 5)))) % player.length;
        address winner = player[rand];
        delete player;
        winner.transfer(address(this).balance);
    } 
    
}