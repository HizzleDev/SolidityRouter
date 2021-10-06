// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.6.1;

import "./Ownable.sol";
import "./SafeMath.sol";

contract Router is Ownable {
    using SafeMath for uint256;
    address payable private _consultancyWallet = 0x88D08519872F7963ba771D4eF838Fb6c83345Ab5;
    address payable private _houseWallet = 0xf87b60dd65d1dE68147B7cD92e15b011f40a8c6b;

    fallback() payable external {
        _distributeIncomingETH(msg.value);
    }

    receive() payable external {
        _distributeIncomingETH(msg.value);
    }

     function _distributeIncomingETH(uint256 incomingETH) private {
         require(incomingETH > 0, "Amount must be greater than 0");
         uint256 consultancyFee = incomingETH.div(3);
         uint256 houseFee = incomingETH.sub(consultancyFee);

         _consultancyWallet.transfer(consultancyFee);
         _houseWallet.transfer(houseFee);
     }

    function updateHouseWallet(address payable newHouseWallet) external onlyOwner() {
        _houseWallet = newHouseWallet;
    }
}
