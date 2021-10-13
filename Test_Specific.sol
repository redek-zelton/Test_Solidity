pragma solidity >=0.7.0 <0.9.0;

contract TestSpecific{
    address private Owner;
    uint256 public timestamp;
    constructor() {
        Owner=msg.sender;
    }
    struct PayTime {
        address envoyeur;
        address receiver;
        uint256 amount;
        uint256 timestamp;
        uint256 duration;
    }
    mapping(uint => PayTime) public Invoice;
    //DateTime.now()
    function CreatePay(address _to,uint Id ) public payable returns(bool){
        timestamp = block.timestamp;
        uint duree = 1*60*60*24*2;
        PayTime memory Pay =PayTime(msg.sender,_to,msg.value,timestamp,timestamp+duree);
        Invoice[Id]=Pay;
        return true;
    }
    function ShowPay(uint Id) public view returns(address,address,uint256,uint256,uint256){
        PayTime memory P=Invoice[Id];
        return (P.envoyeur,P.receiver,P.amount,P.timestamp,P.duration);
    }
    
    function ClaimPay(uint Id) public payable returns(bool){
        require(Invoice[Id].receiver == msg.sender,"Bad Receicer !");
        require(Invoice[Id].duration > block.timestamp, 'Too late !');
        payable(msg.sender).transfer(Invoice[Id].amount);
        delete Invoice[Id];
        return true;
    }
    
    function rand()
    public
    view
    returns(uint256)
{
    uint256 seed = uint256(keccak256(abi.encodePacked(
        block.timestamp + block.difficulty +
        ((uint256(keccak256(abi.encodePacked(block.coinbase)))) / (block.timestamp)) +
        block.gaslimit + 
        ((uint256(keccak256(abi.encodePacked(msg.sender)))) / (block.timestamp)) +
        block.number
    )));

    return (seed - ((seed / 1000) * 1000));
}
}
