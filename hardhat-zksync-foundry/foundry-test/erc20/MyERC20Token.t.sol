//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";
import {MyERC20Token} from "../../contracts/erc20/MyERC20Token.sol";

contract MyERC20TokenTest is Test {
    MyERC20Token token;
    address owner = vm.addr(1);
    address user = vm.addr(2);

    function setUp() public {
        vm.startPrank(owner);
        token = new MyERC20Token();
        vm.stopPrank();
    }

    function test_InitialSupply() public {
        assertEq(token.totalSupply(), 1000000000000000000000000);
    }

    function test_burn_SuccessIfOwner() public {
        vm.startPrank(owner);
        token.burn(10);
        vm.stopPrank();
        assertEq(token.totalSupply(), 999999999999999999999990);
    }

    function test_transfer_Success() public {
        uint256 transferAmount = 50;
        vm.startPrank(owner);
        token.transfer(user, transferAmount);
        vm.stopPrank();
        assertEq(token.balanceOf(user), transferAmount);
    }

    function test_burn_FailWhenLessThanBalance() public {
        uint256 burnAmount = 100;
        vm.startPrank(user);
        vm.expectRevert("ERC20: burn amount exceeds balance");
        token.burn(burnAmount);
        vm.stopPrank();
    }
}
