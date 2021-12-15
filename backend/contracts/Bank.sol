// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./library.sol";

contract Bank is IPartnerable {
    mapping(address => uint256) private _balances;

    uint256 private _totalSupply;

    uint256 public exchangeRateTKN;
    uint256 public exchangeRateETH;
    // exchangeRateTKN TKN = exchangeRateETH ETH

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * The default value of {decimals} is 18. To select a different value for
     * {decimals} you should overload it.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(address partner) 
    IPartnerable(partner)
    {
        exchangeRateTKN = 100;
        exchangeRateETH = 1;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public pure returns (string memory) {
        return "Token";
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public pure returns (string memory) {
        return "TKN";
    }

    function setExchangeRate(uint256 rateTKN, uint256 rateETH) public onlyOwner{
        exchangeRateTKN = rateTKN;
        exchangeRateETH = rateETH;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless this function is
     * overridden;
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public pure returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public returns (bool) {
        require(sender == msg.sender);
        _transfer(_msgSender(), recipient, amount);

        return true;
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) public onlyPartner {
        require(sender != address(0));
        //require(recipient != address(0), "ERC20: transfer to the zero address");

        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount);
        unchecked {
            _balances[sender] = senderBalance - amount;
        }
        _balances[recipient] += amount;
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function mint(address account, uint256 amount) public onlyPartner {
        _mint(account, amount);
    }

    function _mint(address account, uint256 amount) public onlyPartner {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply += amount;
        _balances[account] += amount;
    }

    function _buy(address account) public payable {
        uint256 number = msg.value / exchangeRateETH;
        _mint(account, number * exchangeRateTKN);
    }

    function _withdraw(address account, uint256 amount) public {
        uint256 number = amount / exchangeRateTKN;
        uint256 reduce = number * exchangeRateTKN;
        uint256 withdraw = number * exchangeRateETH;

        require(reduce < _balances[msg.sender]);

        _balances[msg.sender] -= reduce;

        (bool result, ) = account.call{value: withdraw}("");
        require(result);
    }
}
