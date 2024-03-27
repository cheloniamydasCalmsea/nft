require("@nomicfoundation/hardhat-toolbox");

const API_URL = "https://eth-sepolia.g.alchemy.com/v2/K90yXonhml-7EF3eLOdA61CTVeCCxFBN";
const PRIVATE_KEY = "7da1571d757f5c55fd8072f099168804c0a6ff6fa2c5d0171b896df411907031";

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  defaultNetwork: "sepolia",
  networks: {
    hardhat: {},
    sepolia: {
      url: API_URL,
      accounts: [PRIVATE_KEY]
    }
  },
};
