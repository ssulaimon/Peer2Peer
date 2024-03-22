//SPDX-License-Identifier:MIT
pragma solidity >=0.8.0 <0.9.0;

interface ITokenInterface{
    function name()external pure returns(string memory);

    function symbol()external pure returns(string memory);

    function decimals()external pure returns(uint256);
    function totalSupply()external view returns (uint256);

    function balanceOf(address _address)external  view returns(uint256);
    function transfer(address _to, uint256 _value)external returns(bool);

    function approve(address _spender, uint256 _amount) external returns(bool);

    function allowance(address _owner, address _spender) external view returns(uint256);

    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    

}