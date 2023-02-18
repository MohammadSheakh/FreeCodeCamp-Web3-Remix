// Fund me.sol is going to be a contract that allows people to actually fund a collective good 
// so people can send etherium or polygon or whatever blockchain native token into this 
// contract and some owner of the contract can then withdraw those funds and do whatever they want 

// after deploying this to a test net , we can see list of functions that this contract has. 
// this will have 2 red buttons , which are used to notate to payable functions ..
// withdraw allow us to withdraw funding .. and fund allow us to send money to contract . 
/**
    what we can do , is ..  we can send some value along with our transaction. when we call this 
    fund function . then what we can do is  we can actually fund this contract with a cirtain amount 
    of eth.. 

    we will now have .. sent money into our deployed 

    we will be using chainlink price feeds to actually set the value of how much these people should 
    be able to fund in USD as opposed to just in terms of ether, we are going to over a lot of 
    advanced section here
*/

/**
    //-------------------------------- Sending Eth Through A function and Reverts -- 3 : 34 : 12 
    // GET Funds from users..
    // withdraw funds  
    // set a minimum funding value in USD

*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;

    // Could we make this constant?  /* hint: no! We should make it immutable! */
    address public /* immutable */ i_owner;
    uint256 public constant MINIMUM_USD = 50 * 10 ** 18;
    
    constructor() {
        i_owner = msg.sender;
    }

    // lets just add different functions that we are going to implement .. 
    function fund() public payable {
        // for people to actually send money .. 
        // we want anybody to call the fund function , so, we make this public .. 
        // want to be able to set a minimum fund amount in USD 
        /**
            1. how do we send ETH to this contract. 
            whenever we create a transaction on the any of the EVM blockchain theres this value 
            field that we can set . that value represents how much etherium we are going to be 
            sending with our transaction .   

            In fact every single transaction that we send. will have these fields.. 
            Nonce, Gas Price, Gas Limit, To, Value, Data, v,r,s

            First thing we need to do.. in order to make a function payable with Etherium or any 
            other native blockchain currency.. is we need to mark the function as 🔴 payable  

            we can access this value attribute by using one of the global keyword .. 😀 msg.value
            to get how much value somebody sending .. 

            //------------------------------ Chainlink And Oracles 3 : 42 : 36 -------- onek important 
            //////////////////// ei section ta abar dekhte hobe ...  onek jhamela ............ 
            // ------------ Review of Sending Eth And Working with chainlink ---- 4 : 00 : 31 

            // ------------ Interface And Price Feeds  ---- 4 : 01 : 53 

            // ------------ Floating Point Math in Solidity  --- 4 : 11 : 08

            // Sending Eth from a Contract  -- 4 : 42 : 36
            // Basic Solidity Constructor --------- 4 : 40 : 25
            // Advance Solidity Concepts --------- 5 : 04 : 32
            // Solidity Basics Done --------------  5: 30 : 39 !!
            // Lesson 5 : Ether.js Simple Storage... 5: 30 : 39
            // How to Post Problem to Github Discussion ------------ 5 : 37 : 25 

            // Installation and Setup .. Moving to local development .....  5 : 53 : 47 

            // Start At ---------------- 6  : 05 : 14
            // WSL installation ... linux system for windows .. 

            // Gitpod --------- 6 : 13 : 12 - Cloud Development Environment .. 
            /**
                You can run your code in remote server .. 
            */

            // to actually compile our simpleStorage.sol lets run the compilation command 
            // lets run -->>>>  yarn blah blah blah ---------------- 6 : 52 : 22 -- partially done 

            // Ganache And Networks  ------- 6 : 55 : 13 

            /**

            lets learn how we can deploy this thing ... 
                lets learn first deploy in Javascript VM (fake block chain ) and then Injected Web 3 

                hardhat is a fake blockchain .. but now we use Ganache as fake blockchian 
            */

            ////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////
            // Lets skip to Hardhat Simple Storage .. lesson - 6  - 8-20 - 19
            



        
        // first section false hoile error message dekhao .. and fund function revert.. which means previous state e back koro 
        require(msg.value.getConversionRate() >= MINIMUM_USD, "You need to spend more ETH!"); // condition , error message 
        // require(PriceConverter.getConversionRate(msg.value) >= MINIMUM_USD, "You need to spend more ETH!");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }
    
    function getVersion() public view returns (uint256){
        // ETH/USD price feed address of Goerli Network.
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }
    
    modifier onlyOwner {
        // require(msg.sender == owner);
        if (msg.sender != i_owner) revert NotOwner();
        _;
    }
    
    function withdraw() public onlyOwner {
        /// for the /  or the owner of the contract actually withdraw the funds that different funders 
        // actually give us 
        for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        // // transfer
        // payable(msg.sender).transfer(address(this).balance);
        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");
        // call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }
    // Explainer from: https://solidity-by-example.org/fallback/
    // Ether is sent to contract
    //      is msg.data empty?
    //          /   \ 
    //         yes  no
    //         /     \
    //    receive()?  fallback() 
    //     /   \ 
    //   yes   no
    //  /        \
    //receive()  fallback()

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }

}

// Concepts we didn't cover yet (will cover in later sections)
// 1. Enum
// 2. Events
// 3. Try / Catch
// 4. Function Selector
// 5. abi.encode / decode
// 6. Hash with keccak256
// 7. Yul / Assembly
