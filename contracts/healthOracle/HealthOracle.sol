// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract HealthOracle {
    address executor;

    mapping(uint256 => int256) health;

    constructor() {
        executor = msg.sender;
    }

    modifier onlyExecutor() {
        require(msg.sender == executor, "only executor can call this");
        _;
    }

    function setHealth(uint256 _nftID, int256 _growth) external onlyExecutor {
        health[_nftID] = _growth;
    }

    function setHealthBatch(
        uint256[] calldata _nftIDs,
        int256[] calldata _growth
    ) external onlyExecutor {
        for (uint256 index = 0; index < _nftIDs.length; index++) {
            health[_nftIDs[index]] = _growth[index];
        }
    }

    function getHealth(uint256 _nftID) external view returns (int256) {
        return health[_nftID];
    }
}
