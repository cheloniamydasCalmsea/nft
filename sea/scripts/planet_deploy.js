const { ethers } = require("hardhat");

async function main() {

    const deployerAddr = "0x9C64F3c4e8f5804E9be78529c7C76d3b826043bc";
    const deployer = await ethers.getSigner(deployerAddr);

    const PlanetNFT = await ethers.getContractFactory("PlanetNFT");
    const contract = await PlanetNFT.connect(deployer).deploy();
    console.log('lets go');
    let info = await contract.waitForDeployment();
    console.log(info);
    console.log('good : '+ info.target);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});