pragma solidity ^0.5.9;

import "./ERC20.sol";
import "./ERC20Detailed.sol";
import "./IMineableToken.sol";

contract MineableToken is IMineableToken, ERC20, ERC20Detailed, Ownable {

    constructor(address _owner, string memory _name, string memory _symbol, uint8 _decimals)
    public ERC20Detailed(_name, _symbol, _decimals) Ownable(_owner){}

    mapping(address=>address) public minters;

    function setMinter(address _minter) public onlyOwner {
        minters[_minter] = _minter;
    }

    function removeMinter(address _minter) public onlyOwner {
        delete minters[_minter];
    }

    function mint(address to, uint256 amount) public {
        require(minters[msg.sender] != address(0), "not minter");
        _mint(to, amount);
    }

    function signature() external pure returns (string memory) {
        return "provided by Seal-SC / www.sealsc.com";
    }
}
