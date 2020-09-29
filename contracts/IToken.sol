pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

// "SPDX-License-Identifier: UNLICENSED"

interface IToken {
    function flashBorrow(
        uint256 borrowAmount,
        address borrower,
        address target,
        string calldata signature,
        bytes calldata data
    ) external payable returns (bytes memory);
}
