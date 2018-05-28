pragma solidity 0.4.23;

contract COIN {
    uint256 public totalSupply;
    string public name;
    string public symbol;
    uint256 public decimals;
}

contract Query {
    constructor () public {}

    function query(address ERC20TokenAddr) public view returns (string name, string symbol, uint decimals, uint totalSupply) {
        COIN c = COIN(ERC20TokenAddr);
        return (c.name(), c.symbol(), c.decimals(), c.totalSupply());
    }
}
