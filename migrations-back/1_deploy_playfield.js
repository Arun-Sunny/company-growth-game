
const PLAYFIELD = artifacts.require("./Playfield.sol");
module.exports = async (deployer, network, accounts) => {
    await deployer.deploy(PLAYFIELD);
    const playField = await PLAYFIELD.deployed();

    
    console.log("playField address ", playField.address);
};