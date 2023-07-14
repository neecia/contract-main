// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 value) external returns (bool);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);
}

contract Bank {
    struct bankInfo {
        address from;
        address to;
        uint256 amount;
        string Time;
    }

    string[] public bankList;
    mapping(string => bankInfo) public bankInfos;

    event SetBankEvent(
        address indexed from,
        address indexed to,
        uint256 indexed amount,
        string Time
    );

    function setBank(
        address _from,
        address _to,
        uint256 _amount,
        string memory _Time
    ) public {
        bankList.push(_Time);
        bankInfos[_Time] = bankInfo(_from, _to, _amount, _Time);
        emit SetBankEvent(_from, _to, _amount, _Time);
    }

    function sendToken(
        address _tokenAddress,
        address _to,
        uint256 _amount
    ) public {
        IERC20(_tokenAddress).transferFrom(msg.sender, address(_to), _amount);
    }

    function sendTokenWithSetBank(
        address _tokenAddress,
        address _to,
        uint256 _amount,
        string memory _Time
    ) public {
        IERC20(_tokenAddress).transferFrom(msg.sender, address(_to), _amount);
        setBank(msg.sender, _to, _amount, _Time);
    }

    function getAllbankInfos()
        external
        view
        returns (bankInfo[] memory)
    {

        bankInfo[] memory mBankInfos = new bankInfo[](bankList.length);
        for (uint i = 0; i < bankList.length; i++) {
          bankInfo storage info = bankInfos[bankList[i]];
          mBankInfos[i] = info;
        }
        return mBankInfos;
    }
}
