    // SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract sellerr{
    // ___________________________________SELLER_________________________________________________________
    struct Seller{
        string Name; 
        uint Age; 
        string City; 
        uint CNIC; 
        string Email;    
    }

    mapping (address =>Seller) public sellerData;
    mapping (address => bool) public isValidSeller;

function regSeller(address _key , string memory _Name,uint _Age ,string memory _City,uint _CNIC, string memory _Email) public{
    sellerData[_key]= Seller(_Name,_Age,_City,_CNIC,_Email);
    isValidSeller[msg.sender]=false;
}

function SellerIsVerifed(address _address) public{
    isValidSeller[_address]= true;
}

function LandInspRejectSeller(address _address) public{
    isValidSeller[_address]= false;
}

function updateSellerRecord(address _key , string memory _Name,uint _Age ,string memory _City,uint _CNIC, string memory _Email) public{
    sellerData[_key].Name=_Name;
    sellerData[_key].Age=_Age;
    sellerData[_key].City=_City;
    sellerData[_key].CNIC=_CNIC;
    sellerData[_key].Email=_Email;
}

// _______________________________________________________Land_______________________________________________________
    struct landRegistry{
        address Owner; 
        string Area; 
        string City; 
        string State; 
        uint LandPrice; 
        uint PropertyID;
    }

    mapping (uint =>landRegistry) public LandReg;
    mapping (uint => bool) public isValidLand;

function Landreg(uint _LandId,address,string memory _Area,string memory _City,string memory _State, uint _LandPrice,  uint _PropertyID) public {
    LandReg[_LandId]=landRegistry(msg.sender,_Area,_City,_State,_LandPrice,_PropertyID);
    isValidLand[_LandId]=false;
}
function LandIsVerifed(uint _LandId) public{
    isValidLand[_LandId]= true;
}
function LandInspRejectLand(uint _LandId) public{
    isValidLand[_LandId]= false;
}
function LandsOwner(uint _LandId) public view returns(address){
    return LandReg[_LandId].Owner;
}
function GetLandCity(uint _LandId) public view returns(string memory){
    return LandReg[_LandId].City;
}
function GetLandPrice(uint _LandId) public view returns(uint){
    return LandReg[_LandId].LandPrice;
}
function GetArea(uint _LandId) public view returns(string memory){
    return LandReg[_LandId].Area;
}

// _______________________________BUYER________________________________________________
struct Buyer{
        string Name; 
        uint Age; 
        string City; 
        uint CNIC; 
        string Email;
    }

    mapping (address =>Buyer) public buyerData;
    mapping (address => bool) public isValidBuyer;

function regBuyer(address _key , string memory _Name,uint _Age ,string memory _City,uint _CNIC, string memory _Email) public{
    buyerData[_key]= Buyer(_Name,_Age,_City,_CNIC,_Email);
    isValidBuyer[msg.sender]=false;    
}
function BuyerIsVerifed(address _address) public{
    isValidBuyer[_address]= true;
}
function LandInspRejectBuyer(address _address) public{
    isValidBuyer[_address]= false;
}
function updateBuyerRecord(address _key , string memory _Name,uint _Age ,string memory _City,uint _CNIC, string memory _Email) public{
    buyerData[_key].Name=_Name;
    buyerData[_key].Age=_Age;
    buyerData[_key].City=_City;
    buyerData[_key].CNIC=_CNIC;
    buyerData[_key].Email=_Email;
}
 struct LandInspector{
        uint Id; 
        string Name; 
        uint Age; 
        string Designation; 
    }

    mapping (uint =>LandInspector) public LandInspectorData;

function Land_Inspector(uint _key ,uint _Id, string memory _Name,uint _Age,string memory _Destination) public{
    LandInspectorData[_key]= LandInspector(_Id,_Name,_Age,_Destination);
}
function BuyLand(uint _LandId) public payable{
    require(isValidBuyer[msg.sender] == true,"please verify buyer");
    require(isValidLand[_LandId] == true,"please verify seller or Land");
    payable(LandReg[_LandId].Owner).transfer(msg.value);
    LandReg[_LandId].Owner = msg.sender;
}
function LandOwnershipTransfer(uint _landId, address payable _newOwner) public{
    LandReg[_landId].Owner = _newOwner;
}
function tansferAny(uint _LandId ,address _addr) public {
    LandReg[_LandId].Owner=_addr;
    }
}
