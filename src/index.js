const { Relayer } = require('defender-relay-client');
const Web3 = require('web3');
const web3 = new Web3(new Web3.providers.WebsocketProvider("wss://goerli.infura.io/ws/v3/f282de0c6571487aa01db622d6949517"));
const BN = web3.utils.BN;
const healthOracleABI = [
    {
      "inputs": [],
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_nftID",
          "type": "uint256"
        },
        {
          "internalType": "int256",
          "name": "_growth",
          "type": "int256"
        }
      ],
      "name": "setHealth",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256[]",
          "name": "_nftIDs",
          "type": "uint256[]"
        },
        {
          "internalType": "int256[]",
          "name": "_growth",
          "type": "int256[]"
        }
      ],
      "name": "setHealthBatch",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_nftID",
          "type": "uint256"
        }
      ],
      "name": "getHealth",
      "outputs": [
        {
          "internalType": "int256",
          "name": "",
          "type": "int256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    }
  ];
const axios = require('axios');
const healthOracleAddress = "0x431bAef3f61a3E9E62380a9b30ca616e7f7799f4";

const sendTransaction = async (data, secrets) => {
    try {
        let privateKey = secrets.PRIVATE_KEY;
        let acc = web3.eth.accounts.privateKeyToAccount(privateKey);
        let wallet = web3.eth.accounts.wallet.add(acc);

        const txn = await web3.eth.sendTransaction({
            to: healthOracleAddress,
            from: 0,
            data: data,
            gas: "1000000"
        })
        return { status: true, message: "txn.hash" }
    } catch (error) {
        console.log(error)
        return { status: false, message: error }
    }
}

exports.handler = async (events) => {
    try {
        const secrets = events.secrets;
        let oracle = new web3.eth.Contract(healthOracleABI, healthOracleAddress)
        let arr = ["CSCO", "TCS.NS", "RELIANCE.NS", "2222.SR", "002630.SZ", "BBAS3.SA", "BBY.L", "ZOMATO.NS", "002471.SZ", "7203.T"]
        let apiURL = "https://query1.finance.yahoo.com/v7/finance/options/";

        let healthArr = []

        for (let index = 0; index < arr.length; index++) {
            const element = arr[index];
            let apiData = await axios.get(`${apiURL}/${element}`);
            let data = apiData.data.optionChain.result[0].quote.regularMarketChangePercent;

            let currentHealth = await oracle.methods.getHealth(index).call();

            let health = new BN((Math.trunc(data * 100)).toString());
            let newHealth = (new BN(currentHealth)).add(health)

            healthArr.push(newHealth.toString());

        }

        let instruction = web3.eth.abi.encodeFunctionCall({
            name: "setHealthBatch",
            type: "function",
            inputs: [{
                type: "uint256[]",
                name: "_nftIDs"
            },
            {
                type: "int256[]",
                name: "_growth"
            }]
        }, [['0','1','2','3','4','5','6','7','8','9'], healthArr])
        // console.log(index, (Math.trunc(data * 100)).toString(), health, data, currentHealth, newHealth.toString())
        console.log(instruction)
        console.log(healthArr)
        // await sendTransaction(instruction, secrets)

    } catch (error) {
        console.log("ERROR:-",error)
    }

}

// To run locally (this code will not be executed in Autotasks)
if (require.main === module) {
    const { API_KEY: apiKey, API_SECRET: apiSecret } = process.env;
    exports.handler({ apiKey, apiSecret })
        .then(() => process.exit(0))
        .catch(error => { console.error(error); process.exit(1); });
}
