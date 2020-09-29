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
    # TODO
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

## Testing

To run the tests, first install the developer dependencies:

```bash
pip install -r requirements.txt
```

Run the all tests with:

```bash
brownie test --network mainnet-fork
```

## License

This project is licensed under the [Apache License, Version 2.0](LICENSE).
