pragma solidity ^0.8.13;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract Erc20Inscribe is ERC20{
    using SafeERC20 for Erc20Inscribe;
    // 需求，以太上发一个铭文的工厂
    string private _name;
    string private _symbol;
    address factory;

    event MintlnScription(address to, uint value);

    constructor () ERC20("","") {}

    modifier CheckInscribe(address sender) {
        require(sender == factory, "only owner!");
        _;
    }
    function init(string memory name, string memory symbol) public {
        factory = msg.sender;
        _name = name;
        _symbol = symbol;
    }
    
    function mintlnScription(address to, uint value) public CheckInscribe(msg.sender){
        _mint(to, value);
        emit MintlnScription(to, value);
    }

    function  getName() public returns (string memory){
        return _name;
    }
    
}