pragma solidity^0.4.24;


contract DataCenter {

    struct personalInfo {
        //身份证号
        string id;
        //姓名
        string name;
        //户口地址
        string addr;
        //出生年月日
        uint16 year;
        uint8 month;
        uint8 day;
        //性别
        uint8 sex;
        //是否有过犯罪记录
        bool isCrime;
    }
        
    address admin;
    
    //合约是否可以查询信息
    mapping(address => bool) queryContract;
    //账户地址=>信息
    mapping(address => personalInfo) personData;
    
    constructor(address _admin) public {
        admin = _admin;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "You are not admin");
        _;
    }
    
    modifier onlyCanQuery(address _addr) {
        require(
            queryContract[_addr] ||  msg.sender == admin,
            "No priority"
        );
        _;
    }
    //设置可查询的合约
    function setQueryContract(address _contract) public onlyAdmin {
        queryContract[_contract] = true;
    }
    
    function unsetQueryContract(address _contract) public onlyAdmin {
        queryContract[_contract] = false;
    }
    
    function getInfoForQuery(address _ethAddr) public view onlyCanQuery(msg.sender) returns(string id_, string name_, string addr_, uint16 year_, uint8 month_, uint8 day_, uint8 sex_, bool isCrime_) {
        personalInfo memory pinfo = personData[_ethAddr];
        id_ = pinfo.id;
        name_ = pinfo.name;
        addr_ = pinfo.addr;
        year_ = pinfo.year;
        month_ = pinfo.month;
        day_ = pinfo.day;
        sex_ = pinfo.sex;
        isCrime_ = pinfo.isCrime;
    }
    
    function setInfo(address _ethaddr, string _id, string _name, string _addr, uint16 _year, uint8 _month, uint8 _day, uint8 _sex, bool _isCrime) public onlyAdmin {
        personalInfo memory pinfo = personalInfo(_id, _name, _addr, _year, _month, _day, _sex, _isCrime);
        personData[_ethaddr] = pinfo;
    }
    
    
    
}


