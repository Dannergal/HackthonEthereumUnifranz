// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Casino is Ownable {
    event BetPlaced(address indexed player, uint256 amount, bool won);

    constructor() Ownable(msg.sender) {}

    function placeBet() public payable {
        require(msg.value > 0, "Debes apostar algo");

        bool won = (block.timestamp % 2 == 0); // Simulación de juego (cara o cruz)
        if (won) {
            payable(msg.sender).transfer(msg.value * 2);
        }

        emit BetPlaced(msg.sender, msg.value, won);
    }

    function withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    receive() external payable {}
}
