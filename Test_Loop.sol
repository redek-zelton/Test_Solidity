pragma solidity >=0.7.0 <0.9.0;

contract TestLoop{
    uint256 private number;
    constructor(){
        number =0;
    }
    
    struct Monster {
        string monstre;
        uint256 attaque;
        uint256 defense;
        uint etoile;
    }
    
    mapping(uint256 => Monster) private Liste_Monster;
    
    function Monster_Creation(string memory name) public returns(bool){
        uint256 att = rand_Attack();
        uint256 def = rand_Defense();
        uint etoile = (att+def)/1000;
        Monster memory New= Monster(name,att,def,etoile);
        Liste_Monster[number]=New;
        number++;
        return true;
    }
    
    function rand_Attack() private returns(uint256) {
    uint256 seed = uint256(keccak256(abi.encodePacked(
        block.timestamp + block.difficulty  +
        block.gaslimit + 
        ((uint256(keccak256(abi.encodePacked(msg.sender)))) / (block.timestamp)) +
        block.number
    )));
    return seed%5000;
    }
    function rand_Defense() private returns(uint256) {
    uint256 seed = uint256(keccak256(abi.encodePacked(
        block.timestamp + block.difficulty +
        ((uint256(keccak256(abi.encodePacked(block.coinbase)))) / (block.timestamp)) +
        block.gaslimit + 
        block.number
    )));
    return seed%5000;
    }
    
    function Show(uint256 nb) public view returns(Monster memory){
        return Liste_Monster[nb];
    }
    
    function Show_all() public view returns(Monster[] memory){
        Monster[] memory M = new Monster[](number);
        for(uint i=0; i < number;i++){
            M[i] = Show(i);
        }
        return M;
    }
}
