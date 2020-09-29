pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
// "SPDX-License-Identifier: Apache-2.0"

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IToken.sol";

contract BZxFlashLoaner is Ownable {
    function initiateFlashLoanBzx(
        address loanToken,
        address iToken,
        uint256 flashLoanAmount
    ) internal returns (bytes memory success) {
        IToken iTokenContract = IToken(iToken);
        return
            iTokenContract.flashBorrow(
                flashLoanAmount,
                address(this),
                address(this),
                "",
                abi.encodeWithSignature(
                    "executeOperation(address,address,uint256)",
                    loanToken,
                    iToken,
                    flashLoanAmount
                )
            );
    }

    function repayFlashLoan(
        address loanToken,
        address iToken,
        uint256 loanAmount
    ) internal {
        IERC20(loanToken).transfer(iToken, loanAmount);
    }

    function executeOperation(
        address loanToken,
        address iToken,
        uint256 loanAmount
    ) external returns (bytes memory success) {
        emit BalanceOf(IERC20(loanToken).balanceOf(address(this)));
        emit ExecuteOperation(loanToken, iToken, loanAmount);
        repayFlashLoan(loanToken, iToken, loanAmount);
        return bytes("1");
    }

    function doStuffWithFlashLoan(
        address token,
        address iToken,
        uint256 amount
    ) external onlyOwner {
        bytes memory result;
        emit BalanceOf(IERC20(token).balanceOf(address(this)));

        result = initiateFlashLoanBzx(token, iToken, amount);

        emit BalanceOf(IERC20(token).balanceOf(address(this)));

        // after loan checks and what not.
        if (hashCompareWithLengthCheck(bytes("1"), result)) {
            revert("failed executeOperation");
        }
    }

    function hashCompareWithLengthCheck(bytes memory a, bytes memory b)
        pure
        internal
        returns (bool)
    {
        if (a.length != b.length) {
            return false;
        } else {
            return keccak256(a) == keccak256(b);
        }
    }

    event ExecuteOperation(
        address loanToken,
        address iToken,
        uint256 loanAmount
    );

    event BalanceOf(uint256 balance);
}
