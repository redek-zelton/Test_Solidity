pragma solidity >=0.7.0 <0.9.0;

contract TestAdresse{
    address payable private Owner;
    uint256 private OBalance;
    address private AContrat;
    uint256 private CBalance;
    
    constructor(address payable owner){
        Owner = owner;
        OBalance = owner.balance;
        AContrat = address(this);
        CBalance = address(this).balance;
    }
    function ShowAdresse(uint choix) public view returns(address){
        if(choix ==1){
            return Owner;
        }
        if(choix ==2){
            return AContrat;
        }
        else{
            return address(0);
        }
    }
    function ShowBalance(uint choix) public view returns(uint){
        if(choix ==1){
            return OBalance;
        }
        if(choix ==2){
            return CBalance;
        }
        else{
            return address(0).balance;
        }
    }
    function Transfert() public payable returns(bool){
        require(msg.sender == Owner,'Pas proprio');
        require(msg.value > 0, 'Pas de ether');
        OBalance= msg.sender.balance;
        CBalance=address(this).balance;
        return true;
    }
    
    function Back(uint amount) public returns(bool){
        require(msg.sender == Owner,'Pas proprio');
        Owner.transfer(amount);
        OBalance= msg.sender.balance;
        CBalance=address(this).balance;
        return true;
    }
    function Attak() public {
     selfdestruct(Owner); 
    }
}