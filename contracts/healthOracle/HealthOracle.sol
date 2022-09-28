// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract HealthOracle {
    address executor;

    mapping(uint256 => int256) growth;

    constructor() {
        executor = msg.sender;
    }
    
    modifier onlyExecutor() {
        require(msg.sender == executor, "only executor can call this");
        _;
    }

    function setGrowth(uint256 _nftID,int256 _growth) external onlyExecutor {
        growth[_nftID] = _growth;
    }

    function getGrowth(uint256 _nftID) external view returns(int256){
        return growth[_nftID];
    }
}
