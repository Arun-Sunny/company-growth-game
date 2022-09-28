// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

interface IHealthOracle {
    function getGrowth(uint256) external view returns(int256);
}
