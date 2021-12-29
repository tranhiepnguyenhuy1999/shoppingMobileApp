// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract BankTransfer {
    // owner of this contract
    address public owner;

    // bank balance
    uint256 public balance;

    // bank account info
    struct BankAccount {
        string accountNumber;
        string ownerPhoneNumber;
        uint256 balance;
        address accountAddress;
    }

    //struct data of a transaction
    struct Transaction {
        string code;
        string fromAccountNumber;
        string toAccountNumber;
        uint256 amount;
        uint fee;
        uint timeStamp;
    }

    // mapping from account number to account
    mapping(string => BankAccount) public bankAccounts;

    // mapping from code to transaction
    mapping(string => Transaction) public transactions;
    
    constructor()  {
        owner = msg.sender;
    }

// owner functions
    function addBalance(uint256 amount)
    public
    onlyOwner()
    {
        balance += amount;
    }

    function addAccountBalance(
        string memory code,
        string memory accountNumber,
        uint amount,
        uint timeStamp
    )
    public
    onlyOwner()
    balanceValidate(amount)
    transactionCodeNotExists(code)
    {
        balance -= amount;
        bankAccounts[accountNumber].balance += amount;

        //create transaction
        transactions[code] = Transaction({
            code: code,
            fromAccountNumber: "000000000000",
            toAccountNumber: accountNumber,
            amount: amount,
            fee: 0,
            timeStamp: timeStamp
        });
    }

    function changeAddressOfAccount(string memory accountNumber, address newAddress)
    public
    onlyOwner()
    accountExists(accountNumber)
    {
        bankAccounts[accountNumber].accountAddress = newAddress;
    }
// user functions
    function createAccount(
        string memory accountNumber,
        string memory ownerPhoneNumber,
        address accountAddress
    )
    accountNotExists(accountNumber)
    public
    {
        bankAccounts[accountNumber] = BankAccount({
            accountNumber: accountNumber,
            ownerPhoneNumber: ownerPhoneNumber,
            balance: 0,
            accountAddress: accountAddress
        });
    }
    
    function transfer(
        string memory code,
        string memory fromAccount, 
        string memory toAccount,
        uint fee, 
        uint amount, 
        uint timeStamp
    ) 
    public 
    accountValidateTransfer(fromAccount, amount, fee)
    accountExists(toAccount)
    transactionCodeNotExists(code)
    {
        bankAccounts[fromAccount].balance -= amount;
        bankAccounts[toAccount].balance += amount;

        bankAccounts[fromAccount].balance -= fee;
        balance += fee;

        //create transaction
        transactions[code] = Transaction({
            code: code,
            fromAccountNumber: fromAccount,
            toAccountNumber: toAccount,
            amount: amount,
            fee: fee,
            timeStamp: timeStamp
        });
    }    

// modifiers

    // modifier that use to require caller is owner
    modifier onlyOwner() 
    {
        require(msg.sender == owner);
        _;
    }

    // modifier that use to make sure account not exists
    modifier accountNotExists(string memory accountNumber) 
    {
        string memory empty = "";
        require(
            keccak256(bytes(bankAccounts[accountNumber].accountNumber)) 
            == keccak256(bytes(empty))
        );
        _;
    }

    // modifier that use to make sure account exists
    modifier accountExists(string memory accountNumber) 
    {
        string memory moneyBaseAccount = "000000000000";

        require(
            keccak256(bytes(bankAccounts[accountNumber].accountNumber)) 
            == keccak256(bytes(accountNumber))
        );
        _;
    }

    // modifier that use to make sure account have right secure hash
    // and valid amount for transfer 
    modifier accountValidateTransfer(string memory accountNumber, uint amount, uint fee) 
    {
        require(bankAccounts[accountNumber].accountAddress == msg.sender
        && bankAccounts[accountNumber].balance >= amount + fee);
        _;
    }

    // modifier that make sure bank balance have enough money
    // to add account balance
    modifier balanceValidate(uint amount) 
    {
        require(balance >= amount);
        _;
    }

    // modifier that make sure transaction 
    // with code have not exist
    modifier transactionCodeNotExists(string memory code) 
    {
        string memory empty = "";
        require(
            keccak256(bytes(transactions[code].code)) 
            == keccak256(bytes(empty))
        );
        _;
    }

}
