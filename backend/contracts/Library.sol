
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

abstract contract IContract{
    function _msgSender() public view returns(address) {
        return msg.sender;
    }
}

abstract contract IOwnable is IContract{
    address internal ChainOwner;

    constructor(){
        ChainOwner = msg.sender;
    }

    function selfDestruct() public onlyOwner{
        selfdestruct(payable(ChainOwner));
    }

    modifier onlyOwner(){
        require(msg.sender == ChainOwner);
        _;
    }
}

abstract contract IPartnerable is IOwnable{
    address public _partner;

    constructor(address partner){
        _partner = partner;
    }

    modifier onlyPartner(){
        require (_partner == msg.sender);
        _;
    }
}

abstract contract ISignable{
    function recoverSigner(bytes32 message, bytes memory sig)
        internal
        pure
        returns (address)
    {
        uint8 v;
        bytes32 r;
        bytes32 s;
        (v, r, s) = splitSignature(sig);
        return ecrecover(message, v, r, s);
    }
    function splitSignature(bytes memory sig)
        internal
        pure
        returns (uint8, bytes32, bytes32)
    {
        require(sig.length == 65);
       
        bytes32 r;
        bytes32 s;
        uint8 v;
        assembly {
            // first 32 bytes, after the length prefix
            r := mload(add(sig, 32))
            // second 32 bytes
            s := mload(add(sig, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(sig, 96)))
        }
        return (v, r, s);
    }
}