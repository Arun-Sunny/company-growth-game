
const HEALTHORACLE = artifacts.require("./healthOracle/HealthOracle.sol");
module.exports = async (deployer, network, accounts) => {
    await deployer.deploy(HEALTHORACLE);
    const healthOracle = await HEALTHORACLE.deployed();

    
    console.log("Health Oracle address ", healthOracle.address);
};