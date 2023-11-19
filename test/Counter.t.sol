// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {DivineAuraBliss} from "../src/DivineAuraBliss.sol";

contract CounterTest is Test {
    DivineAuraBliss public divineAuraBliss;

    function setUp() public {
        divineAuraBliss = new DivineAuraBliss();
        divineAuraBliss.shareAura("sd");
    }

    // function testIncrement() public {
    //     divineAuraBliss.increment();
    //     assertEq(divineAuraBliss.number(), 1);
    // }

    // function testSetNumber(uint256 x) public {
    //     divineAuraBliss.setNumber(x);
    //     assertEq(divineAuraBliss.number(), x);
    // }
}
