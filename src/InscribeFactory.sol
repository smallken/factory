pragma solidity ^0.8.13;
import "@openzeppelin/contracts/proxy/Clones.sol";

interface IErc20Inscribe {
    function init(string memory name, string memory symbol) external;
    function mintlnScription(address to, uint value) external;
    function balanceOf(address account) external returns (uint256);
    //  function name() external   returns (string memory);
    // function symbol() external   returns (string memory);
     function  getName() external returns (string memory);

}
contract InscribeFactory {
    using Clones for address;
    address tokenAddress;
    mapping(address => uint) maxInscribed;
    mapping(address => uint) perMint;
    constructor (address _tokenAddress) {
        tokenAddress = _tokenAddress;
    }
    // n(string name, string symbol, uint totalSupply, uint perMint)
    function deployInscription(string memory _name, string memory _symbol, uint _totalSupply, uint _perMint) public returns(address){
        address newAddress = tokenAddress.clone();
        IErc20Inscribe(newAddress).init(_name, _symbol);
        maxInscribed[newAddress] = _totalSupply;
        perMint[newAddress] = _perMint;
        return newAddress;
    }

    function mintInscription(address token) public {
        require(perMint[token] > 0, "permint should bigger 0!");
        IErc20Inscribe(token).mintlnScription(msg.sender, perMint[token]);
    }
}