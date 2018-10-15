pragma solidity^0.4.24;

import "./DataCenter.sol";

contract Query {

    DataCenter dataCenter;
    
    constructor(address _dataCenter) public {
        dataCenter = DataCenter(_dataCenter);
    }
    
    modifier validDate(uint16 _year, uint8 _month, uint8 _day) {
        require(_year > 1900);
        require(
            _month >= 1 &&
            _month <= 12
        );
        
        if(_month==1||_month==3||_month==5||_month==7||_month==8||_month==10||_month==12)
        {
            require(
                _day >= 1 &&
                _day <= 31
            );
        } else if(_month != 2) {
            require(
                _day >= 1 &&
                _day <= 30
            );
        } else {
            //闰年
            if((_year%4==0)&&(_year%100!=0)||(_year%400==0)) {
                require(
                    _day >= 1 &&
                    _day <= 29
                );
            } else {
                require(
                    _day >= 1 &&
                    _day <= 28
                );
            }
        }
        
        _;
    }
    
    function isOk(address _ethAddr, uint16 _yearNow, uint8 _monthNow, uint8 _dayNow) public view validDate(_yearNow, _monthNow, _dayNow) returns(bool) {
        uint16 year;
        uint8 month;
        uint8 day;
        bool isCrime;

        (,,,year, month, day,, isCrime) = dataCenter.getInfoForQuery(_ethAddr);
        //有犯罪记录
        if(isCrime) {
            return false;
        }
        
        if(_yearNow - year < 18) {
            //小于18岁
            return false;
        } else if (_yearNow - year == 18) {
            //刚好18需要判断年月
            if(_monthNow < month) {
                return false;
            } else if(_monthNow == month) {
                if(_dayNow < day){
                    return false;
                }
            }
        }
        
        return true;
    }
}
