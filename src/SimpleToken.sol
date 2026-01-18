// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

error InvalidAddress();
error InvalidValue();

contract SimpleToken { 
       string immutable public name;
       string immutable public symbol;
       uint8 immutable public decimals;
       uint256 public totalSupply;
       mapping(address => uint256) balances;
       mapping(address => mapping (address => uint256)) allowances;

       constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _totalSupply) {
              name = _name;
              symbol = _symbol;
              decimals = _decimals;
              totalSupply = _totalSupply;
              balances[msg.sender] = _totalSupply;
       }


       event Transfer(address indexed from, address indexed to, uint256 value);
       event Approval(address indexed owner, address indexed spender, uint256 value);

       modifier validateAddress(address a) {
              if (a == address(0)) {revert InvalidAddress();}
              _;
       }

       modifier validateValue(uint256 value) {
              if (value > balanceOf(msg.sender)) {revert InvalidValue();}
              _;
       }

       function balanceOf(address account) public view validateAddress(account) returns (uint256) {
              return balances[account];
       }

       function allowance(address owner, address spender) public view validateAddress(owner) validateAddress(spender) returns (uint256) {
              return allowances[owner][spender];
       }

       function transfer (address to, uint256 value) public validateAddress(to) validateValue(value) returns (bool) {
              balances[to] += value;
              balances[msg.sender] -= value;

              emit Transfer(msg.sender, to, value);
              return true;
       }

       function approve (address spender, uint256 value) public validateAddress(spender) returns (bool) {
              allowances[msg.sender][spender] = value;
              emit Approval(msg.sender, spender, value);
              return true;
       }

       function transferFrom(address from, address to, uint256 value) public validateAddress(from) validateAddress(to) returns (bool) {

       }

}