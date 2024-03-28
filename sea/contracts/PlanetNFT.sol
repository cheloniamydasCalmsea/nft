// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PlanetNFT is ERC721, Ownable{
    using Strings for uint256;
    uint256 MAX_SUPPLY;
    uint256 totalSupply;
    bool public isSalesActive;
    string baseURI;

    mapping(uint256 => uint256) tokenMetadataNo;

    constructor () ERC721("PlanetNFT", "P_NFT") Ownable(msg.sender){
        MAX_SUPPLY = 100; // 예시로 MAX_SUPPLY를 100으로 설정
        totalSupply = 0;
        isSalesActive = false; // 판매 활성화 여부를 기본으로 비활성화로 설정
        baseURI = "ipfs://QmY7rJKMLjX2fdjMHN9m2xWxdz131FW2GLB2rrTNit5e13/";
    }

    function setSaleActive(bool _flag) external onlyOwner{
        isSalesActive = _flag;
    }

    function setBaseURI(string memory _newBaseURI) external onlyOwner {
        baseURI = _newBaseURI;
    }

    function mintPlanet(address _targetAddress, string memory _type) external onlyOwner {
        require(isSalesActive, "not on sale");
        require(keccak256(bytes(_type)) != keccak256(bytes("")), "_type should not be null");
        require(totalSupply <= MAX_SUPPLY, "max supply exceeded");

        uint256 tokenType;

        if(keccak256(bytes(_type)) == keccak256(bytes("bronze"))){
            tokenType = 1;
        }else if(keccak256(bytes(_type)) == keccak256(bytes("silver"))){
            tokenType = 2;
        }else if(keccak256(bytes(_type)) == keccak256(bytes("gold"))){
            tokenType = 3;
        }else if(keccak256(bytes(_type)) == keccak256(bytes("diamond"))){
            tokenType = 4;
        }

        tokenMetadataNo[totalSupply+1] = tokenType;
        _safeMint(_targetAddress, totalSupply+1);
        totalSupply++;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);
        return string.concat(baseURI, tokenMetadataNo[tokenId].toString());
    }

    function withDraw() external onlyOwner{
        payable(msg.sender).transfer(address(this).balance);
    }

    function helloworld() external pure returns (string memory){
        return "hello";
    }

}