/*
  基于EIP规范实现ERC 20 token
  实现空投
*/

pragma solidity^0.4.24;

import "./erc20.sol";
import "./safeMath.sol";

contract ecc is EIP20Interface{
    using SafeMath for uint;
    
    string public name = "ecc";
    string public symbol = "$";
    uint8 decimals = 18;
    address fundation;
    uint supplyNow;
    
    mapping(address => uint) balance;
    mapping(address => mapping(address => uint)) allow;
    
    modifier onlyOwner {
        require(msg.sender == fundation);
        _;
    }
    
    constructor(uint _total, address _owner) public {
        totalSupply = _total * 10 ** uint256(decimals);
        fundation = _owner;
        balance[fundation] = totalSupply.mul(20) / 100;
        supplyNow += balance[fundation];
    }
    
    function balanceOf(address _owner) public view returns (uint256 balance_) {
        balance_ = balance[_owner];
    }
    
    function transfer(address _to, uint256 _value) public returns (bool success) {
        if(
            balanceOf(msg.sender) >= _value &&
            balanceOf(_to) + _value >= _value &&
            _to != address(0)
          )
        {
            balance[msg.sender].sub(_value);
            balance[_to].add(_value);
            emit Transfer(msg.sender, _to, _value);
            return true;
        } else {
            return false;
        }
    }
    
    function approve(address _spender, uint256 _value) public returns (bool success) {
        if(
            balanceOf(msg.sender) >= _value &&
            _spender != address(0)
          )
        {
            allow[msg.sender][_spender] = _value;
            emit Approval(msg.sender, _spender, _value);
            return true;
        } else {
            return false;
        }
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        if(
            allow[_from][_to] >= _value &&
            balanceOf(_from) >= _value &&
            balanceOf(_to) + _value >= _value &&
            _to != address(0)
          )
          {
              balance[_from].sub(_value);
              balance[_to].add(_value);
              allow[_from][_to].sub(_value);
              emit Transfer(msg.sender, _to, _value);
              return true;
          } else {
              return false;
          }
    }
    
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        remaining = allow[_owner][_spender];
    }
    
    function airDrop(address _to, uint _value) public onlyOwner returns(bool) {
        if(
            supplyNow + _value >= _value &&
            supplyNow + _value <= totalSupply &&
            _to != address(0)
          )
        {
            supplyNow += _value;
            balance[_to] += _value;
            
            emit Transfer(address(this), _to, _value);
            return true; 
        } else {
            return false;
        }
    }
    
}