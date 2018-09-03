/*
  用户支付0.1以太即可加入lottery
  不限用户数量
  同一用户可以多次加入
  合约所有人亦可以加入
  合约所有人决定何时选出赢家
  赢家将得到所有奖金
  选出赢家即可开始新一轮lottery
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