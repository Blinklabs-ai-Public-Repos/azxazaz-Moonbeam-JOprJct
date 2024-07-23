// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Abaha Token
 * @dev Implementation of the Abaha Token
 */
contract Abaha is ERC20, Ownable {
    uint256 private immutable _maxSupply;

    /**
     * @dev Constructor that gives msg.sender all of existing tokens.
     * @param name_ The name of the token
     * @param symbol_ The symbol of the token
     * @param maxSupply_ The maximum supply of the token
     */
    constructor(string memory name_, string memory symbol_, uint256 maxSupply_) 
        ERC20(name_, symbol_)
    {
        require(maxSupply_ > 0, "Max supply must be greater than 0");
        _maxSupply = maxSupply_;
        _mint(msg.sender, maxSupply_);
    }

    /**
     * @dev Returns the max supply of the token.
     * @return The max supply of the token
     */
    function maxSupply() public view returns (uint256) {
        return _maxSupply;
    }

    /**
     * @dev Overrides the mint function to ensure the max supply is not exceeded.
     * @param to The address that will receive the minted tokens
     * @param amount The amount of tokens to mint
     */
    function mint(address to, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= _maxSupply, "Cannot exceed max supply");
        _mint(to, amount);
    }
}