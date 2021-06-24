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

     //Issue Tokens to users
      function issueTokens() public {
      require(msg.sender == owner);
      for (uint i=0; i<stakers.length; i++) {
            address recipient = stakers[i];
            uint balance = stakingBalance[msg.sender];
      if (balance < 500) {
         avaToken.transfer(recipient, balance);
         balance = balance*8/100 * 30; //User gets 8% APY when they stake less than 500 tokens ie when their balance is less than 500
      }

      if (balance >= 500 && < 1000) {
         avaToken.transfer(recipient, balance);
         balance = balance*10/100 * 30; //User gets 10% APY when they stake grater than or equal to 500 tokens i.e their balance is greater than or equal to 500 but less than 1000
      }

      if (balance >=1000 && < 1500 ) {
      avaToken.transfer(recipient, balance);
      balance = balance*15/100 * 30; //Users gets 15% APY when they stake greater than or equal to 1000 tokens i.e when their balance is 1000 tokens or more but less than 1500
   }

   if (balance >= 1500) {
   avaToken.transfer(recipient, balance);
   balance = balance*25/100 * 30; //User gets 25% APY When they stake greater or equal to 1500 tokens i.e when their balance is greater or equal to 1500
      }

   }
}
