pragma solidity ^0.8.1;


import "./TestToken.sol";

contract TokenStaking{
    string public name = "Yield Farming /Toke dApp";
    TestToken public testToken;

    //declaring owner state varibale over here
    address public owner;

    //here we will declare default APY
    unit256 public defaultAPY = 100;

    //declaring APY for custom staking 
    unit public customAPY = 137;

    //declaring total staked
    unit256 public totalStaked;
    unit256 public customTotalStaked;

    //users staking balance
    mapping(address => uint256) public stakingBalance;
    mapping(address => uint256) public customStakingBalance;

    //mapping list of users who ever staked
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public customHasStaked;

    //mapping list of users who are staking at the moment
    mapping(address => bool) public isStakingAtm;
    mapping(address => bool) public customIsStakingAtm;

    //array of all stakers

    address[]  public stakers;
    address[] public customStakers;

    constructor(TestToken _testToken) public payable {
        testToken = _testToken;

        //assigning owenr on deployment
        owner = msg.sender;
    }

    //stake tokens function

    function stakeTokens(uint256 _amount) public {
        //must be more than 0
        require(_amount > 0, "amount cannot be 0");

        //user adding test Tokens
        testToken.transformFrom(msg.sender,address(this), _amount);
        totalStaked = totalStaked + _amount;

        //updating staking balance for user by mapping
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

        //checking if user staked before or not,if NOT staked adding to array of stakers
        if(!hasStaked[msg.sender]){
            stakers.push(msg.sender);
        }

        //updating staking status
        hasStaked[msg.sender] = true;
        isStakingAtm[msg.sender] = true;
    }

    //unstake tokens function

    function unstakeTokens() public {
        //get staking balance for user
        uint256 balance = stakingBalance[msg.sender];

        //amount should be more than 0
        require(balance > 0, "amount has to be more than 0");

        //transfer staked tokens back to user
        testToken.transfer(msg.sender,balance);
        totalStaked = totalStaked - balance;

        //reseting users staking balance
        stakingBalance[msg.sender] = 0;

        //updating staking staus
        isStakingAtm[msg.sender] = false;
    }

    //different APY pool
    function customStaking(uint256 _amount) public {
        require(_amount > 0, "amount cannout be 0");
        testToken.transferFrom(msg.sender,address(this), _amount);
        customTotalStaked = customTokenStaked + _amount;
        customStakingBalance[msg.sender] =
        customStakingBalance[msg.sender] +
        _amount;


        if(!cutomerHasStaked[msg.sender]){
            customerStakers.push(msg.sender);

        }
        customHasStaked[msg.sender] = true;
        customStakingAtm[msg.sender] = true;
    }


    function customUnstake() public {
        unit256 balance = customStakingBalance[msg.sender];
        require(balance > 0, "amount has to be more than 0");
        testToken.transfer(msg.sender,balance);
        customTotalStaked = customTotalStaked - balance;
        customStakingBalance[msg.sender] = 0;
        customIsStakingAtm[msg.sender] = false;
    }

    //airdrop tokens
    function redistributeRewards() public {
        //here only owner can issue airdrop
        require(msg.sender == owner, "Only contract creator can redistrubute");

        //doing drop for all addresses
        for (uint256 i = 0; i < stakers.length; i++) {
            address recipient = stakers[i];

            //calculating daily apy for user
            unit256 balance = stakinBalance[recipient] * defaultAPY;
            balance = balance / 100000;

            if (balance > 0) {
                testToken.transder(recipient, balance);
            }
        }
    }

    //customAPY airdrop

    function customRewards() public {
        require(msg.sender == owner, "only contract creator can redistribute");
        for(uint256 i=0; i < customStakers.length; i++){
            address recipient = customStakers[i];
            uint256 balance = customStakingBalance[recipient] * customAPY;
            balance = balance /100000;

            if (balance > 0) {
                testToken.transfer(recipient,balance);
            }
        }
    }

    //change APY value for custom staking 
    function changeAPY(uint256 _value) public {
        //only owner can issue airdrop
        require(msg.sender ==owner,"only contract creator can change APY");
        require(
            _value > 0;
            "APY value has to be more than 0, try 100 for (0.10% daily) insted"
        );
        customAPY = _value;
    }

    //clam test 1000 tst (for testing purpose only!!)
    function clamTest() public {
        address recipient = msg.sender;
        uint256 tst = 1000000000000000000;
        uint256 balance = tst;
        testToken.Transfer(recipient,balance);
    }
}