// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Script} from "lib/forge-std/src/Script.sol";
import {Attack} from "../src/Attack.sol";

contract DeployAttack is Script {
    function run() external returns (Attack) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        Attack attack = new Attack();
        vm.stopBroadcast();

        return (attack);
    }
}

// forge script script/DeployAttack.s.sol:DeployAttack --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvv
