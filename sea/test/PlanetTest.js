const { expect } = require("chai");
const { ethers } = require("hardhat");


describe("PlanetNFT", async function() {

    let owner;
    let otherAccount;

    before(async() => {
        [owner, otherAccount] = await ethers.getSigners();
    });

    it("should have 10 nft", async function() {
        const LectureNFT = await ethers.getContractFactory("PlanetNFT");
        const contract = await LectureNFT.connect(owner).deploy();

       await contract.waitForDeployment();

        expect(await contract.balanceOf(await owner.getAddress())).to.be.equal(8);
    });

});