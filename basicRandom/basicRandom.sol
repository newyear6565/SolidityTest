/*
  返回0-99之间的随机数
*/

pragma solidity^0.4.24;

contract basicRandom{
    uint rand = 0;
    
    function random() public returns(uint) {
        rand++;
        return uint(keccak256(abi.encodePacked(blockhash(block.number - 1), rand, now))) % 100;
    }
    
}