// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/Erc20Inscribe.sol";
import "../src/InscribeFactory.sol";


contract InscribeFactoryTest is Test {
    Erc20Inscribe public erc20Incribe;
    InscribeFactory public factory;
    address admin = makeAddr("admin");
    address user = makeAddr("user1");
    address userTwo = makeAddr("user2");
    function  setUp() public{
        erc20Incribe = new Erc20Inscribe();
        factory = new InscribeFactory(address(erc20Incribe));
    }

    function test() public {
        vm.startPrank(admin);
        address newAddress = factory.deployInscription("Dragon", "DRG", 10000*10**18, 500);
        console.log("newAddress:", newAddress);
        console.log("admin balance:");
        console.log(IErc20Inscribe(newAddress).balanceOf(admin));
        factory.mintInscription(newAddress);
        vm.stopPrank();
        vm.startPrank(user);
        factory.mintInscription(newAddress);
        getBalance(newAddress, user);
        assertEq(IErc20Inscribe(newAddress).balanceOf(user),500);
        vm.stopPrank();
        vm.startPrank(userTwo);
        factory.mintInscription(newAddress);
        getBalance(newAddress, userTwo);
        assertEq(IErc20Inscribe(newAddress).balanceOf(userTwo),500);
        address address2 = factory.deployInscription("Dragon2", "DRG2", 10000*10**18, 500);
        factory.mintInscription(address2);
        getBalance(address2, userTwo);
        vm.stopPrank();

    }

    function getBalance(address tokenAddress, address userAccount) public returns(uint){
        console.log(IErc20Inscribe(tokenAddress).getName(),",user balance:");
        console.log(IErc20Inscribe(tokenAddress).balanceOf(userAccount));
    }
}