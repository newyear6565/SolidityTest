/*
  限制为5个用户
  用户必须支付0.1ETH才能加入以太坊彩票
  同一用户只能加入一次
  合约创建者可以加入以太坊彩票
  第5个用户进入后，选择获胜者
  赢家收走所有的钱
  选出获胜者之后，开始下一轮
*/

pragma solidity^0.4.24;

contract fiveUsersLottery {
    uint total = 0;
    address[5] player;
    
    constructor() public {
    }
    
    function() public payable {
    }
    
    function joinGame() public payable {
        require(
            msg.value == 0.1 ether &&
            total < 5 &&
            !_isJoin(msg.sender)
        );
        
        player[total] = msg.sender;
        total++;
        if(total == 5) {
            total = 0;
            _openLottery();
        }
    }
    
    function _isJoin(address _addr) internal view returns(bool) {
        for(uint i = 0; i > total; i++) {
            if(player[i] == _addr) {
                return true;
            }
        }
        
        return false;
    }
    
    function _openLottery() internal {
        uint random = uint(keccak256(abi.encodePacked(now, blockhash(block.number - 1)))) % 5;
        player[random].transfer(address(this).balance);
    }
    
}