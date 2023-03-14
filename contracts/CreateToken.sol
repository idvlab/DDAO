// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

// Объявляем контракт
contract dTEST {

    // Указываем символ и имя токена
    string public constant symbol = "dTEST";
    string public constant name = "Synthetic dTEST Token";

    // Указываем количество десятичных знаков
    uint8 public constant decimals = 2;

    // Указываем общее количество токенов
    uint256 public totalSupply = 100000 ether;

    // Указываем баланс для каждого адреса
    mapping (address => uint256) public balanceOf;

    // Указываем конструктор
    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    // Функция для перевода токенов
    function transfer(address _to, uint256 _value) public returns (bool success) {
        // Проверяем, достаточно ли токенов на балансе отправителя
        require(balanceOf[msg.sender] >= _value, "Not enough tokens");
        // Проверяем, не произойдет ли переполнения
        require(balanceOf[_to] + _value >= balanceOf[_to], "Overflow detected");
        // Вычитаем количество токенов со счета отправителя
        balanceOf[msg.sender] -= _value;
        // Добавляем количество токенов на счет получателя
        balanceOf[_to] += _value;
        // Вызываем событие перевода токенов
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // Указываем событие перевода токенов
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
}