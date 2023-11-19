// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {DivineAuraBliss} from "../src/DivineAuraBliss.sol";

contract DeployDAB is Script {
    function setUp() public {}

    function run() public returns (DivineAuraBliss) {
        vm.startBroadcast();
        DivineAuraBliss dab = new DivineAuraBliss();
        vm.stopBroadcast();
        return dab;
    }
}
