//SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract SimpleCoin{
    address public owner;
    uint public totalSupply;

    // quantos tokens o endereço tem
    mapping(address => uint) public balanceOf; 

    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);

    string public name = "Meu Token";
    string public symbol = "MTK";
    uint8 public decimals = 8;

    // quantos tokens uma pessoa permite que a outra manuseie do seu balanço 
    mapping(address => mapping(address => uint)) public allowance;

    constructor(){
        owner = msg.sender;
        totalSupply = 1_000_000_000 * 10 ** decimals;
        balanceOf[owner] = totalSupply;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "You are not allowed");
        _;
    }

    // usado por quem vai transferir o dinheiro.
    // Eu, Issac, permito que o Ivo transfira um valor do meu balanço.
    // o Ivo é quem chama essa função
    // o valor que eu permito ao Ivo enviar, deve ser >= ao valor que ele passar no parâmetro
    // o balanço que tenho na minha conta deve ser >= ao valor que ele passar no parâmetro
    function transferFrom(address _from, address _to, uint _value) public returns(bool success) {
        require(_from != address(0) && _to != address(0));
        require(allowance[_from][msg.sender] >= _value);
        require(balanceOf[_from] >= _value);

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        // após o ivo enviar um valor da minha conta, eu subtraio o valor que ele enviou
        // da quantidade de envio permitida por ele. Ex: Se eu permito-o enviar 100, e ele chama
        // essa função enviando 20 da minha conta, então agora ele só pode enviar 80. 
        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);

        return true;
    }

    function approve(address _spender, uint _value) public returns(bool success) {
        require(msg.sender == owner);
        require(_spender != address(0));
        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        require(_to != address(0));

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);

        return true;
    }
}