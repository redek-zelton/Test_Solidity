pragma solidity >=0.7.0 <0.9.0;

contract TestOperation{
    
    int private plus;
    int private moins;
    int private multi;
    int private divi;
    uint private dechet;
    
    function Operation(int a, int b,uint choix) public returns(bool){
        dechet=0;
        if(choix == 1){
            plus = a+b;
            return true;
        }
        if(choix == 2){
            moins = a-b;
            return true;
        }
        if(choix == 3){
            multi = a*b;
            return true;
        }
        if(choix == 4){
            divi = a*100/b;
            return true;
        }
        else{
            dechet=1;
            return false;
        }
    }
    
    function Show(uint choix) public view returns(int){
        if(choix == 1){
            return plus;
        }
        if(choix == 2){
            return moins;
        }
        if(choix == 3){
            return multi;
        }
        if(choix == 4){
            return divi;
        }
        else{
            return int(dechet);
        }
    }
}