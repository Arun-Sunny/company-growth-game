// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract CompanyNFT is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _idCounter;
    address public playfield;

    mapping(uint256=>int256) health;

    constructor(address _playfield) ERC721("COMPANY-NFT TOKEN", "CPToken") {
        playfield = _playfield;
    }

    function createNFT(
        address to,
        string memory uri
    ) external onlyOwner {
        uint256 tokenId = _idCounter.current();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        health[tokenId] = 1; // assuming health starts at 1
    }

    function changeHealth(uint256 _tokenId,int256 growth) external {
        health[_tokenId] = ((health[_tokenId]) +(growth * health[_tokenId]))/10000;
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}

/**
(1 * 10000)/10000
 */