// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "./library.sol";
import "./Bank.sol";

/**
 * @title
 * @dev Implements ERC20 in combination with ERC721, and a transaction system between them.
 */
struct Product{
    uint256 salePrice;
    string title;
    string image;
    string description;
    uint256 size;
    uint256[] otherInfo;
}

contract MarketPlace is ISignable, IPartnerable {
    // Mapping from token ID to owner address
    mapping(uint256 => address) public _owners;
    // Linked List with first, last
    mapping(uint256 => uint256) public _tokenLinkedList;
    
    uint256 public _lastTokenCreated;
    uint256 public _numberOfTokens;

    mapping (uint256 => Product) public product;

    Bank public bank;
    
    constructor (address bankAddr)
    IPartnerable(address(0))
    {
        if (bankAddr == address(0))
            bank = new Bank(address(this));
        else
            bank = Bank(bankAddr);
    }
    /*
    constructor (address owner, TestTokenERC20 partner){
        ChainOwner = owner;
        ERC20 = partner;
    }
    // */
    /**
     * @dev Returns the token collection name.
     */
    function name() external pure returns (string memory){
        return "Token";
    }

    /**
     * @dev Returns the token collection symbol.
     */
    function symbol() external pure returns (string memory){
        return "TKN";
    }
    
    /**
     * @dev See {IERC721-ownerOf}.
     */
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");
        return owner;
    }
    
    function tokensOwned(address account) public view returns (uint256[] memory){
        uint256 iter = _tokenLinkedList[0x00];
        uint256[] memory result = new uint256[](_numberOfTokens);
        uint256 count;
        while (iter != 0x00)
        {
            if (_owners[iter] == account)
            {
                result[count] = iter;
                count++;
            }
            iter = _tokenLinkedList[iter];
        }
        uint256[] memory shrunkResult = new uint256[](count);
        for (uint256 i = 0; i < count; i++)
        {
            shrunkResult[i] = result[i];
        }
        return shrunkResult;
    }
    
    function balanceOf(address account) external view returns (uint256){
        uint256 iter = _tokenLinkedList[0x00];
        uint256[] memory result = new uint256[](_numberOfTokens);
        uint256 count;
        while (iter != 0x00)
        {
            if (_owners[iter] == account)
            {
                result[count] = iter;
                count++;
            }
            iter = _tokenLinkedList[iter];
        }
        
        return count;
    }
    /**
     * @dev Transfers `tokenId` token from `from` to `to` in ERC721.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public
    {
        require (from == msg.sender);
        _transferERC721(from, to, tokenId);
    }
    function transferFrom(address from, address to, uint256 tokenId) public {
        require (from == msg.sender);
        _transferERC721(from, to, tokenId);
    }
    
    /**
     * @dev Transfers `tokenId` from `from` to `to`.
     *  As opposed to {transferFrom}, this imposes no restrictions on msg.sender.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     *
     * Emits a {Transfer} event.
     */
    function _transferERC721(
        address from,
        address to,
        uint256 tokenId
    ) internal {
        require(ownerOf(tokenId) == from);
        require(to != address(0));
        
        _owners[tokenId] = to;
        product[tokenId].salePrice = 0;
    }
    
    function _transferERC721Partner(
        address from,
        address to,
        uint256 tokenId
    ) onlyPartner public {
        _transferERC721(from, to, tokenId);
    }

    function mint(address to, uint256 tokenId) onlyOwner public {
        _mintERC721(to, tokenId);
    }

    function _mintERC721(address to, uint256 tokenId) internal virtual {
        require(to != address(0));
        require(!_exists(tokenId));
        require(tokenId != 0x00);

        _owners[tokenId] = to;
        _tokenLinkedList[_lastTokenCreated] = tokenId;
        _lastTokenCreated = tokenId;
        _numberOfTokens++;
        //require(_tokenLinkedList[_lastTokenCreated] == 0x00, "ERC721: unknown error - linked list loop.");
    }
    
    function _exists(uint256 tokenId) public view returns (bool) {
        return _owners[tokenId] != address(0);
    }
    
    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function getProduct(uint256 tokenId) public view returns (Product memory) {
        require(_exists(tokenId));

        Product memory _tokenURI = product[tokenId];

        return _tokenURI;
    }

    /**
     * @dev Sets `_tokenURI` as the tokenURI of `tokenId`.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function setProductInfo(
        uint256 tokenId,
        uint256 salePrice,
        string calldata title,
        string calldata image,
        string calldata description,
        uint256 size,
        uint256[] calldata otherInfo) public {
        address owner = ownerOf(tokenId);
        require(owner != address(0));
        require(msg.sender == owner || msg.sender == ChainOwner);
        product[tokenId].salePrice = salePrice;
        product[tokenId].title = title;
        product[tokenId].image = image;
        product[tokenId].description = description;
        product[tokenId].size = size;
        product[tokenId].otherInfo = otherInfo;
    }
    /**
    function _approve(
        address,
        address,
        uint256
    ) internal pure {
        _dontDoThis();
    }
    
    function _dontDoThis() private pure {
        revert("CHZ: Not supported.");
    }
    //*/
    /**
     * The token is put on the market at the sale price.
     * Requirements:
     *  The sender of this message owns the token to be put on sale.
     */
    function setSalePrice(uint256 tokenId, uint256 price) public {
        require(msg.sender == ownerOf(tokenId));
        product[tokenId].salePrice = price;
    }
    
    function cancelSale(uint256 tokenId) public {
        setSalePrice(tokenId, 0);
    }
    
    function buy(uint256 tokenId) public payable {
        if (msg.value > 0) 
            BuyCurrency();
        uint256 buyPrice = product[tokenId].salePrice;
        require(buyPrice != 0);
        address seller = ownerOf(tokenId);
        address buyer = msg.sender;
        bank._transfer(buyer, seller, buyPrice);
        _transferERC721(seller, buyer, tokenId);
    }
    
    function buyWithBudget(uint256 tokenId, uint256 budget) public payable {
        if (msg.value > 0) 
            BuyCurrency();
        require (budget >= product[tokenId].salePrice);
        buy(tokenId);
    }
    
    function getSalePrice(uint256 tokenId) public view returns (uint256){
        uint256 buyPrice = product[tokenId].salePrice;
        require(buyPrice != 0);
        return buyPrice;
    }

    function browseMarketItems(uint256 indexFirst, uint256 amount) public view returns (uint256[] memory) {
        uint256 iter = _tokenLinkedList[0x00];
        uint256[] memory result = new uint256[](amount);
        uint256 count;
        while (iter != 0x00 && count < amount)
        {
            uint256 _salePrice = product[iter].salePrice;
            if (_salePrice != 0)
            {
                if (indexFirst > 0) {
                    indexFirst--;
                } else {
                    result[count] = iter;
                    count++;
                }
            }
            iter = _tokenLinkedList[iter];
        }
        return result;
    }
    
    /**
     * The message sender buys the tokenID with the sellPrice using an external Coupon.
     * The coupon is overridden by the sale price on this contract.
     * Requirements:
     *  The token exists.
     *  The buyer have enough money buy.
     *  The item is not on sale currently.
     *  The Coupon is real.
     */
    function buyWithCoupon(uint256 tokenId, uint256 sellPrice, bytes calldata signature) public {
        address seller = _owners[tokenId];
        address buyer = _msgSender();
        require (_exists(tokenId));
        require (bank.balanceOf(buyer) >= sellPrice);
        require (getSalePrice(tokenId) == 0);
        
        bytes32 message = keccak256(abi.encodePacked(tokenId, sellPrice, seller));
        require (recoverSigner(message, signature) == seller);
        
        bank._transfer(buyer, seller, sellPrice);
        _transferERC721(seller, buyer, tokenId);
    }

    function BuyCurrency() public payable{
        bank._buy{value:msg.value}(msg.sender);
    }
}