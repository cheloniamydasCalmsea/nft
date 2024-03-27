// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LectureNFT is ERC721, Ownable{
    using Strings for uint256;
    uint256 MAX_SUPPLY;
    uint256 totalSupply;
    bool isSalesActive;
    string baseURI;

    mapping(uint256 => uint256) tokenMetadataNo;

    constructor () ERC721("LectureNFT", "LNFT") Ownable(msg.sender){
        MAX_SUPPLY = 100; // 예시로 MAX_SUPPLY를 100으로 설정
        totalSupply = 0;
        isSalesActive = false; // 판매 활성화 여부를 기본으로 비활성화로 설정
        baseURI = "ipfs://QmS5fTZh8DGJKaPBNAhMXezQ7NHpYdA2deQVvyGACC11Pr";
    }

    function setSaleActive(bool _flag) external onlyOwner{
        isSalesActive = _flag;
    }

    function setBaseURI(string memory _newBaseURI) external onlyOwner {
        baseURI = _newBaseURI;
    }

    function mintPlanet(uint256 _count) external {
        require(isSalesActive, "not on sale");
        require(_count <= 10, "mint maxium 10 nft at once");
        for(uint i=0; i< _count ; i++){
            require(totalSupply < MAX_SUPPLY, "max supply exceeded");
            tokenMetadataNo[totalSupply] = uint256(blockhash(block.number))%8;
            _safeMint(msg.sender, totalSupply++);
        }
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);
        return string.concat(baseURI, tokenMetadataNo[tokenId].toString());
    }

    function withDraw() external onlyOwner{
        payable(msg.sender).transfer(address(this).balance);
    }

}