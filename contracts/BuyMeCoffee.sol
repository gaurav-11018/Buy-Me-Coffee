// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";

contract BuyMeCoffee {
    event NewMemo(
        address indexed from_address,
        uint256 time_stamp,
        string name,
        string message
    );

    struct memo {
        address from_address;
        uint256 time_stamp;
        string name;
        string message;
    }

    address payable owner;

    memo[] Memos;

    constructor() {
        owner = payable(msg.sender);
    }

    function getMemos() public view returns (memo[] memory) {
        return Memos;
    }

    function BuyCoffee(string memory _name, string memory _messsage)
        public
        payable
    {
        require(msg.value > 0, "Coffees dont come for free!!");
        Memos.push(memo(msg.sender, block.timestamp, _name, _messsage));
        emit NewMemo(msg.sender, block.timestamp, _name, _messsage);
    }

    function withdraw() public {
        require(owner.send(address(this).balance));
    }
}
