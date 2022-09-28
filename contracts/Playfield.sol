// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
import "./interfaces/INFT.sol";

contract Playfield {
    function calculateWinner(address _NFT)
        external
        view
        returns (
            string memory,
            int256,
            int256
        )
    {
        INFT nft = INFT(_NFT);
        uint256 totalSupply = nft.totalSupply();

        int256 scoreA;
        int256 scoreB;
        for (uint256 index = 0; index < totalSupply; index++) {
            uint256 nftIndex = nft.tokenByIndex(index);
            int256 score = nft.getHealth(nftIndex);
            if (nft.getTeam(nftIndex) == 0) scoreA = scoreA + score;
            else scoreB = scoreB + score;
        }

        if (scoreA > scoreB) return ("Team A Wins", scoreA, scoreB);
        else if (scoreB > scoreA) return ("Team B Wins", scoreA, scoreB);
        else return ("A draw", scoreA, scoreB);
    }
}
