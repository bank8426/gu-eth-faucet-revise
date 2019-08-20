pragma solidity 0.5.10;

import "./SafeMath.sol";
import "./IERC20.sol";

contract ERC20GuBank {
    using SafeMath for uint256;
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    string public name;                   // Set the name for display purposes
    uint8 public decimals;                // Amount of decimals for display purposes
    string public symbol;                 // Set the symbol for display purposes
    string public version = 'H1.0';      

    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping (address => uint256)) _allowances;
    
    constructor(uint256 totalSupply) public {
        _totalSupply = totalSupply;
        _balances[msg.sender] = totalSupply;
        name = "GuBank";
        decimals = 0;
        symbol = "GUB";
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256){
        return _balances[account];
    }
    
    function tranfer(address to, uint256 amount) public returns (bool){
        _transfer(msg.sender,to,amount);
        return true;
    }
    
    function _transfer(address from, address to, uint256 amount) internal {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(_balances[from] >= amount,"INSUFICIENT TOKENS");
        
        _balances[from] = _balances[from].sub(amount);
        _balances[to] = _balances[to].add(amount);
        emit Transfer(from, to, amount);
    }
    
    /*
        approve delegate to withdraw tokens
        set amount that allow
    */
    function approve(address delegate, uint256 amount) public returns (bool) {
        _approve(msg.sender, delegate, amount);
        return true;
    }
    
    function _approve(address owner, address delegate, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(delegate != address(0), "ERC20: approve to the zero address");

        _allowances[owner][delegate] = amount;
        emit Approval(owner, delegate, amount);
    }
    
    
    //get number of tokens that tokens's owner approved for withdrawal to delegate
    function allowance(address owner, address delegate) public view returns(uint256){
        return _allowances[owner][delegate];
    }
    
    function transferFrom(address owner, address buyer, uint256 amount) public returns(bool){
        _transfer(owner,buyer,amount);
        
        require(_allowances[owner][msg.sender] >= amount,"INSUFICIENT ALLOWANCE");
        _approve(owner, msg.sender, _allowances[owner][msg.sender].sub(amount));
        return true;
    }
}