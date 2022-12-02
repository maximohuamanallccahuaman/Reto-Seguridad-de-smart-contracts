// contracts/MyContract.sol
//SPDX-License-Identifier:  MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Desafio is Ownable{
    uint private pin; // Nada es privado en la blockchain
    // address private owner;
    mapping(address => uint) balances;

    constructor(uint ownerPin) {
        // owner = msg.sender;
        pin = ownerPin;
    }

    // Cualquiera puede ejecutarlo
    // El amount no está siendo controlado
    function min(uint ownerPin, uint amount) public onlyOwner{
        require(pin == ownerPin, "El pin no es correcto");
        balances[msg.sender] += amount;
    }

    function depositar() public payable {
        balances[msg.sender] += msg.value;
    }

    
    function retirar() public {
        require(balances[msg.sender] > 0, "Insufficient balance");
        balances[msg.sender] = 0; // No te tenemos garantia que se seteara a 0
        (bool success, ) = payable(msg.sender).call{value:balances[msg.sender], gas:1000000}(""); // No hay limite de gas, no estamos controlando el succes
        require(success, "Error al enviar eth");
    }
    
/*
    modifier onlyowner() {
        require(owner == msg.sender, "Solo el propietario puede actualizar los terminos");
        _;
    }*/
}
