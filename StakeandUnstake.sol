pragma solidity ^0.5.0;
import "./AvaToken.sol";
import"./DaiToken.sol";

contract StakeandUnstake {
    string public name = "Ava Token Farm";
    AvaToken public avaToken;
    DaiToken public daiToken;
    address public owner;

    address[]public stakers;
    mapping(address => uint)public stakingBalance;
    mapping(address => bool)public hasStaked;
    mapping(address => bool)public isStaking;

    constructor(AvaToken _avaToken, DaiToken _daiToken) public {
        avaToken = _avaToken;
        daiToken = _daiToken;
        owner = msg.sender;

    }
        //Stake Tokens
     function stakeTokens(uint _amount) public {

        require(_amount > 0, 'amount cannot be cannot be 0');

        daiToken.transferFrom(msg.sender, address(this), _amount);

        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

     }

     //Unstake Tokens

     function unstakeTokens() public{
        uint balance = stakingBalance[msg.sender];

        require(balance > 0, "staking balance cannot be 0");
        daiToken.transfer(msg.sender, balance);
        stakingBalance[msg.sender] = 0;
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
        
     }

     //Issue Tokens
      function issueTokens() public {
      require(msg.sender == owner);
      if (balance < 500) {
         avaToken.transfer(recipient, balance);
      }
      if (balance >= 500 && <= 2000) {
         avaToken.transfer(recipient, balance);
      }
   }
}

