pragma solidity^0.4.24;


contract DataCenter {

    struct personalInfo {
        //���֤��
        string id;
        //����
        string name;
        //���ڵ�ַ
        string addr;
        //����������
        uint16 year;
        uint8 month;
        uint8 day;
        //�Ա�
        uint8 sex;
        //�Ƿ��й������¼
        bool isCrime;
    }
        
    address admin;
    
    //��Լ�Ƿ���Բ�ѯ��Ϣ
    mapping(address => bool) queryContract;
    //�˻���ַ=>��Ϣ
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
    //���ÿɲ�ѯ�ĺ�Լ
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


