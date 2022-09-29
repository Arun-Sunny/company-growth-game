// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./interfaces/IOracle.sol";

contract CompanyNFT is ERC721, ERC721Enumerable, ERC721URIStorage {
    using Counters for Counters.Counter;

    Counters.Counter private _idCounter;

    address public owner;
    address public healthOracle;
    mapping(uint256 => uint8) team;

    constructor(address _healthOracle) ERC721("COMPANY-NFT TOKEN", "CPToken") {
        healthOracle = _healthOracle;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can call this");
        _;
    }

    function createNFT(
        address _to,
        string memory _uri,
        uint8 _team
    ) external onlyOwner {
        uint256 tokenId = _idCounter.current();
        _idCounter.increment();
        _safeMint(_to, tokenId);
        _setTokenURI(tokenId, _uri);
        team[tokenId] = _team; //0 signifies team A, 1 signifies team B
    }

    function getHealth(uint256 _tokenId) external view returns (int256) {
        return IHealthOracle(healthOracle).getHealth(_tokenId);
    }

    function setHealthOracle(address _healthOracle) external onlyOwner {
        healthOracle = _healthOracle;
    }

    function getTeam(uint256 _tokenId) external view returns (uint8) {
        return team[_tokenId];
    }

    function changeOwner(address _newOwner) external onlyOwner {
        owner = _newOwner;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
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

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}

/**
(1 * 10000)/10000
 */
