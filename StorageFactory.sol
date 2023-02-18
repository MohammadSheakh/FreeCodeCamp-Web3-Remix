// SPDX-License-Identifier: MIT 

//pragma solidity ^0.8.7;
pragma solidity ^0.8.8;

import "./SimpleStorage.sol";  // contract ei file e likhar cheye .. sheta onno file e likhe import 
// kora better .  

contract StorageFactory {
    // now .. we want to create a function . that can actually deploy our simple storage contract.  
    //// SimpleStorage[] public simpleStorage
    SimpleStorage[] public simpleStorageArray; // global variable create kortesi .. SimpleStorage Type er .. simpleStorageArray hocche variable name
    // view of simpleStorage Contract .  

    // we will have to deploy a simpleo storage contract and save it to a global  variable .  
    // before we can do it how can our storage factory contract  know what our simple storage contract looks like in order to deploy it .  

    // if our storage factory contract is gonna deploy simple storage, it is going to need to know code of simple storage. One way we can do
    // this is we can actually go to simpleStorage.sol and copy everything and paste it into our StorageFactory.sol 
    // single file of solidity can hold multiple different contracts. 
    function createSimpleStorageContract() public {
        // public .. so, anybody can call it .   
        // we can actually go ahead and create this function to deploy a simpleStorage.sol 
        //// simpleStorage = new SimpleStorage();
        SimpleStorage simpleStorage = new SimpleStorage(); // new keyword er maddhome solidity jante pare .. okey , we are going to deploy a new 
        // simpleStorage contract .  So
        simpleStorageArray.push(simpleStorage); // simpleStorage ke amra simpleStorageArray er moddhe push korbo 
    }

    /**
        in order to interact with any contract .. you are always going to need two things . And we are 
        going to refer to this a lot .  You are always going to need the address of the contract and the ABI
        of the contract. 
        ABI -> application binary interface. 
        ABI will tell our code exactly how it can interact with the contract . it tells us all the different
        inputs and outputs and everything you could do with this contract . 
    */
    
    // storageFactory Store ..  
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // Address 
        // ABI 
        // SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber);
        // so to call the store function on one of our contracts, we first gonna need to get that contract 
        // object . 
        // SimpleStorage (type) simpleStorage (variable name) = SimpleStorage(simpleStorageArray[_simpleStorageIndex]) (object or address of SimpleStorage)
        // jeta amra array theke pabo .. SimpleStorage(_) (simpleStorage contract at address simpleStorageArray[ at index _simpleStorageIndex])
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
        // our array here is keeping track of the addresses for us . And it automatically comes with the ABI .. 
        // jodi address[] public simpleStorageArray; erokom thake .. taile amra SimpleStorage simpleStorage = SimpleStorage(simpleStorageArray[_simpleStorageIndex])); // evabe likhbo 
        // eta amra pore shikhbo 

        // store function call kore .. tar moddhe simpleStorageNumber ta pass kore dibo ..  
    }

    // now lets create another function that can read from the simple storage contract from the storage factory. 
    
    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        // SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex]; // simpleStorageArray[_simpleStorageIndex] this return simpleStorage object 
        // return simpleStorage.retrieve();
        // return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve();
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }
}

/**
    First Function called Create Simple Storage Contract .. which we can click and it will actually 
    create a simple storage contract for us . 

    then we can go ahead and interact with it. 

    sfStore -> 0, 1 ;; 0 index e amra 1 save korlam . 
    sfGet -> 0  -> 1 ;; // sfGet er moddhe 0 likhle ... it will give us 1 
    simpleStorageArray -> 0 -> And we can see the address of the simple storage contract that we
        just deployed. 

    Additionally we are going to learn about number of solidity features, such as importing , inheritance,
    and so much more . 
*/

/**
    //---------------------------------- Interacting with other contracts --- 3 : 16 : 37


    //---------------------------------- Inheritance And Overrides ---- 3: 25 : 23 

    in simple Storage Contract .. we may be want to have some additional functionality . 
    when ever we actually store value doesnot store the favourit number , it stores the favourit number + 5 ... 

    For Some reason , you want a contract like this ..  But you really like everything else that this contract offer .  
    Lets create this new contract. And we will call it extra storage.  we will create this new contract ..



*/
