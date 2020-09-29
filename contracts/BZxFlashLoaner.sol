pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
// "SPDX-License-Identifier: UNLICENSED"

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IToken.sol";

contract BZxFlashLoaner is Ownable {
    function initiateFlashLoanBzx(
        address iToken,
        address loanToken,
        uint256 flashLoanAmount
    ) internal {
        IToken iTokenContract = IToken(iToken);

        iTokenContract.flashBorrow (
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
    ) internal {
        // log3(bytes32("executeOperation"), loanToken, iToken, loanAmount);
        emit ExecuteOperation(
            loanToken,
            iToken,
            loanAmount
        );
        repayFlashLoan(loanToken, iToken, loanAmount);
    }

    function doStuffWithFlashLoan() public onlyOwner {
        // initiateFlashLoanBzx();
    }

    event ExecuteOperation(
        address loanToken,
        address iToken,
        uint256 loanAmount
    );
}
