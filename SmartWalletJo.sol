// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SmartWallet {
    mapping(address => uint256) private _balances;
     address private _owners;
     uint256 private _percentFees;
     uint256 private _gain;
     
    
    constructor(uint256 pourcentage) {
        require(pourcentage >= 0 && pourcentage < 50, "SmartWallet: le pourcentage doit etre entre 0 et 50");
        _owners = msg.sender;
        _percentFees = pourcentage;
    }
    
    function getFees(uint256 amount) private returns(uint256) {
         uint256 fees = (amount * _percentFees) / 100;
        _gain += fees;
        _balances[_owners] += fees;
        return(fees);
    }
    
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function deposit() public payable {
        _balances[msg.sender] += msg.value;
    }
    
    // Exerice 1: 
    // Implementer une fonction withdrawAmount pour permettre à un utilisateur
    // de récupérer un certain amount de ses fonds
    function withdrawAmount(uint256 amount) public {
        require(amount <= _balances[msg.sender], "SmartWallet: Vous ne disposez pas de ce montant");
        uint256 fees = 0;
        
        if(msg.sender != _owners) {
            fees = getFees(amount);
        }
        _balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount - fees);
    }
    
    // Exercice 2:
    // Implementer une fonction transfer pour permettre à un utilisateur d'envoyer
    // des fonds à un autre utilisateur de notre SmartWallet
    // ATTENTION on effectue pas un vrai transfer d'ETHER, 
    // un transfer n'est qu'une ecriture comptable dans un registre
    function transfer(address account, uint256 amount) public {
        require((_balances[account] > 0 && _balances[msg.sender] >= amount), "SmartWallet: desoler soit l'utilisateur n'existe pas soit vous n'avez pas la moula demandee");
        _balances[account] += amount;
        _balances[msg.sender] -= amount;
    }
    
    function withdraw() public {
        require(_balances[msg.sender] > 0, "SmartWallet: can not withdraw 0 ether");
        uint256 fees = 0;
        uint256 amount = _balances[msg.sender];
        
        if(msg.sender != _owners) {
            fees = getFees(amount);
        }
        _balances[msg.sender] = 0;
        payable(msg.sender).transfer(amount - fees);
    }
    
    function setPercentage(uint256 percentFees_) public {
        require(percentFees_ >= 0 && percentFees_ < 50, 'SmartWallet: le pourcentage doit etre entre 0 et 50');
        require(_owners == msg.sender, 'SmartWallet: Only owner can use this function.');
        _percentFees = percentFees_;
    }

    
    function seegains() public view returns(uint256) {
        return _gain;
    }
    
    function seeFees() public view returns(uint256) {
        return _percentFees;
    }
    
    function total() public view returns (uint256) {
        return address(this).balance;
    }
    
     
}