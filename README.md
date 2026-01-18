# SimpleToken (ERC20-style)

A minimal ERC20-style token implementation built with Foundry. This project is a learning-focused smart contract that covers the core ERC20 behaviors: balances, allowances, transfers, approvals, and transferFrom.

## What it includes

- `SimpleToken` contract with:
  - immutable token metadata (`name`, `symbol`, `decimals`)
  - `totalSupply` tracked on deploy
  - balance tracking via `balances`
  - allowance tracking via `allowances`
  - `transfer`, `approve`, and `transferFrom` flows
  - custom errors for invalid address/value

## Contract overview

- **Metadata**: `name`, `symbol`, `decimals`
- **Supply**: `totalSupply` set in constructor
- **Balances**: `balanceOf(address)` getter
- **Allowances**: `allowance(owner, spender)` getter
- **Transfers**: `transfer(to, value)` and `transferFrom(from, to, value)`
- **Events**: `Transfer`, `Approval`

## Quick start (Foundry)

### Build

```shell
forge build
```

### Test

```shell
forge test
```

### Format

```shell
forge fmt
```
