//SPDX-License-Identifier:  MIT
pragma solidity ^0.8.0;

contract Desafio {
    uint private pin;
    mapping(address => uint) balances;

    constructor(uint ownerPin) {
        pin = ownerPin;
    }

    function min(uint ownerPin, uint amount) public {
        require(pin == ownerPin, "El pin no es correcto");
        balances[msg.sender] += amount;
    }

    function depositar() public payable{
        balances[msg.sender] += msg.value;
    }

    function retirar() public {
        require(balances[msg.sender] > 0);
        msg.sender.call{value:balances[msg.sender]}("");
        balances[msg.sender] = 0;
    }
}
