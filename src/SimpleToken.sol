// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

error InvalidAddress();
error InsufficientBalance();
error InsufficientAllowance();

contract SimpleToken {
    string public name;
    string public symbol;
    uint8 public immutable decimals;

    uint256 public totalSupply;

    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _totalSupply
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;

        _mint(msg.sender, _totalSupply);
    }

    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return allowances[owner][spender];
    }

    function transfer(address to, uint256 value) external returns (bool) {
        _transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) external returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        uint256 currentAllowance = allowances[from][msg.sender];

        if (currentAllowance < value) revert InsufficientAllowance();

        if (currentAllowance != type(uint256).max) {
            unchecked {
                allowances[from][msg.sender] = currentAllowance - value;
            }
            emit Approval(from, msg.sender, allowances[from][msg.sender]);
        }

        _transfer(from, to, value);
        return true;
    }


    function _transfer(address from, address to, uint256 value) internal {
        if (to == address(0) || from == address(0)) revert InvalidAddress();

        uint256 fromBal = balances[from];
        if (fromBal < value) revert InsufficientBalance();

        unchecked {
            balances[from] = fromBal - value;
            balances[to] += value;
        }

        emit Transfer(from, to, value);
    }

    function _approve(address owner, address spender, uint256 value) internal {
        if (owner == address(0) || spender == address(0)) revert InvalidAddress();

        allowances[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    function _mint(address to, uint256 value) internal {
        if (to == address(0)) revert InvalidAddress();

        totalSupply += value;
        balances[to] += value;

        emit Transfer(address(0), to, value);
    }
}
