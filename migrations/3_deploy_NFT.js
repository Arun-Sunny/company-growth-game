
const NFT = artifacts.require("./utils/CompanyNFT.sol");
module.exports = async (deployer, network, accounts) => {
    await deployer.deploy(NFT,"0x431bAef3f61a3E9E62380a9b30ca616e7f7799f4");
    const nft = await NFT.deployed();

    
    console.log("nft address ", nft.address);

    //Team A
    await nft.createNFT(accounts[0],"ipfs/QmYZbTSGSNrp8vyMNFape32maw67gpE88UvgiC6Yu5aEkc","0") //Cisco
    await nft.createNFT(accounts[0],"ipfs/QmVjD5XbkfCPR1rg8Mwwcx1FGuVtSMDhqNwcPVpWyxxqBc","0") //TCS
    await nft.createNFT(accounts[0],"ipfs/QmRKfH5yuwr6MD87u15Bd11ypZEPkQSUhCkB1P1Prmg77F","0") //Reliance
    await nft.createNFT(accounts[0],"ipfs/QmVRmBDFqWkPGEvE4PS79pcr4dRiwNNJWwNkBbTgv3Kvya","0") //Saudi
    await nft.createNFT(accounts[0],"ipfs/QmcgpvWEztJLgmbMXUWpqVWjVAejzZAAE8pMLCnSvgDQBY","0") //China Western

    //Team B
    await nft.createNFT(accounts[0],"ipfs/QmRaYUXZnFXYHfST52XDFyVtBVkobomGc2ugf5bCm218Zv","1") //Banco do Brasil 
    await nft.createNFT(accounts[0],"ipfs/QmUaEc3ydLC7cXFEY2nhD38jFi7as6wkhvx28TUA2kytLF","1") //Balfour Beatty plc
    await nft.createNFT(accounts[0],"ipfs/QmWUXC7xu4tmDqMMH7nDSQsq3hAuAknE8WndRn2oUbhD3F","1") //Zomato
    await nft.createNFT(accounts[0],"ipfs/QmQDoLT1q54muG9dZYci4No9KJJ3MJXoCU7SkYKir8eqUu","1") //Jiangsu
    await nft.createNFT(accounts[0],"ipfs/QmW2vafFcuhrQxafgt9ZQYujfW52jXUxxLJgJR1vQsgUVU","1") //Toyota
};