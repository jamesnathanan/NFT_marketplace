// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
        building out the minting function:
        a. nft to point to an address
        b. keep track of the token id
        c. keep track of token owner addresses to token ids
        d. keep track of how many tokens an owner address has
        e. create an event that emits a transfer log - contract address , where it is being minted to,

        Exercise: 
        1. write a function called _mint that takes two arguments, an address called "to" and int called tokenId
        2. add invisibility to the signature
        3. set the _tokenOwner of the tokenID to the address argument 'to'
        4. increase the owner token count by 1 each time the function is called

    */

contract ERC721 {
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );
    // mapping in solidity create a hash table of key value pairs
    // Mapping from token id to the owner
    mapping(uint256 => address) private _tokenOwner;

    // Mapping from owner to number of owned tokens
    mapping(address => uint256) private _ownedTokensCount;

    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    function _mint(address to, uint256 tokenId) internal {
        // require that an address is not zero
        require(to != address(0), "ERC721: minting to the zero address");
        // require that token doesn't already exist
        require(!_exists(tokenId), "ERC721: token already minted");
        // we are adding a new address with a token id for minting
        _tokenOwner[tokenId] = to;
        // keeping track of each address that is minting and adding one to that account
        _ownedTokensCount[to] += 1;

        emit Transfer(address(0), to, tokenId);
    }
}
