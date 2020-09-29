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
    ) internal {
        IToken iTokenContract = IToken(iToken);
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
    ) external {
        emit BalanceOf(IERC20(loanToken).balanceOf(address(this)));
        emit ExecuteOperation(loanToken, iToken, loanAmount);
        repayFlashLoan(loanToken, iToken, loanAmount);
    }

    function doStuffWithFlashLoan(
        address token,
        address iToken,
        uint256 amount
    ) external onlyOwner {
        emit BalanceOf(IERC20(token).balanceOf(address(this)));

        initiateFlashLoanBzx(token, iToken, amount);

        emit BalanceOf(IERC20(token).balanceOf(address(this)));

        // after loan checks and what not.
    }

    event ExecuteOperation(
        address loanToken,
        address iToken,
        uint256 loanAmount
    );

    event BalanceOf(uint256 balance);
}
