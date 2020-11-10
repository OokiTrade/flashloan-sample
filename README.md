<br/>
<p align="center"><img src="https://bzx.network/images/logo.svg" width="256" /></p>

<div align="center">

  <a href='' style="text-decoration:none;">
    <img src='https://img.shields.io/coveralls/github/bZxNetwork/contractsV2' alt='Coverage Status' />
  </a>
  <a href='https://github.com/bZxNetwork/contractsV2/blob/master/LICENSE' style="text-decoration:none;">
    <img src='https://img.shields.io/github/license/bZxNetwork/contractsV2' alt='License' />
  </a>
  <a href='https://docs.openzeppelin.com/' style="text-decoration:none;">
    <img src='https://img.shields.io/badge/built%20with-OpenZeppelin-3677FF' alt='OpenZeppelin' />
  </a>
  <br/>
  <a href='https://t.me/b0xNet' style="text-decoration:none;">
    <img src='https://img.shields.io/badge/chat-on%20telegram-9cf.svg?longCache=true' alt='Telegram' />
  </a>
  <a href='https://bzx.network/discord' style="text-decoration:none;">
    <img src='https://img.shields.io/discord/450115178516971531?label=Discord' alt='Discord' />
  </a>
  <a href='https://t.me/b0xNet' style="text-decoration:none;">
    <img src='https://img.shields.io/twitter/follow/bzxHQ?style=social' alt='Telegram' />
  </a>
  
</div>

# bZx v2.0 Smart Contracts

## Dependencies

* [python3](https://www.python.org/downloads/release/python-368/) version 3.6 or greater, python3-dev
* [ganache-cli](https://github.com/trufflesuite/ganache-cli) - tested with version [6.10.1](https://github.com/trufflesuite/ganache-cli/releases/tag/v6.10.1)
* [brownie](https://github.com/eth-brownie/brownie/) version 1.11.6 or greater

## Documentation and Support

Install all necessary packages with
```bash
yarn install
```

Function signature for bZx flash loan
``` 
    function flashBorrow(
        uint256 borrowAmount,
        address borrower,
        address target,
        string calldata signature,
        bytes calldata data
    ) external payable returns (bytes memory);
```

+ borrowAmount - amount you want to flash borrow
+ borrower - receiver of the flash borrow call
+ target - target address for flash borrow callback
+ signature - function signature to be encoded with `abi.encodePacked(bytes4(keccak256(bytes(signature))), data)`, if not provided `data` will be used as callData instead
+ data - target address function arguments.
+ returns signature funciton operation results. 

To take a flash loan in USDC you need to call `flashBorrow` on the iUSDC contract. List of iToken contracts can be found [here](https://bzx.network/itokens)

`BZxFlashLoaner` is an example contract that takes opportunity of the bZx flash loans. it does so in several steps:
1. Transaction entry point `doStuffWithFlashLoan`
2. Loan initialization `initiateFlashLoanBzx`
3. operation with loaned money `executeOperation`
4. return loaned money before executeOperation end `repayFlashLoan`
5. final checks `doStuffWithFlashLoan` . you can actually revert a transaction at this time if you consider your transaction not profitable for example



Flash Loans are uncolaterized loans that are required to be returned in the same transaction. There is no real world analogy. the closes you can compare is with `overnight market` or `Repurchase Agreement` but without collateral.

Please note currently bZx flash loans are FREE. you pay ZERO fees for taking a flash loan. 

There are a couple of use cases where someone might use flash loans:
+ Arbitrage
+ Liquidations
+ re-finance exiting loans
+ other

## Support
For any dev related questions and support please join our Discord [#dev](https://discord.gg/6uW2R39u) channel. We have a very active community.

## Testing

To run the tests, first install the developer dependencies:

```bash
pip install -r requirements.txt
```

Make sure you have environemtn variables setup for ETHERSCAN and INFIRA
```
export ETHERSCAN_TOKEN= ...
export WEB3_INFURA_PROJECT_ID= ...
```

Run the all tests with:

```bash
brownie test --network mainnet-fork
```

## License

This project is licensed under the [Apache License, Version 2.0](LICENSE).
