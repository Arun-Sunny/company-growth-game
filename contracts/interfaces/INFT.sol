// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

interface INFT {
    function totalSupply() external view returns (uint256);

    function getHealth(uint256) external view returns (int256);

    function getTeam(uint256) external view returns (uint8);

    function tokenByIndex(uint256) external view returns (uint256);
}
