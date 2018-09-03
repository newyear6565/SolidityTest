/*
  ����Ϊ5���û�
  �û�����֧��0.1ETH���ܼ�����̫����Ʊ
  ͬһ�û�ֻ�ܼ���һ��
  ��Լ�����߿��Լ�����̫����Ʊ
  ��5���û������ѡ���ʤ��
  Ӯ���������е�Ǯ
  ѡ����ʤ��֮�󣬿�ʼ��һ��
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