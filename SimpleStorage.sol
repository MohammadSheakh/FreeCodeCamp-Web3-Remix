// I'm a comment!
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;
//pragma solidity 0.8.7;
// pragma solidity ^0.8.0;
// pragma solidity >=0.8.0 <0.9.0;

contract SimpleStorage {

    uint256 favoriteNumber;

    struct People {
        uint256 favoriteNumber;
        string name;
    }
    // uint256[] public anArray;
    People[] public people;

    mapping(string => uint256) public nameToFavoriteNumber;

    // er mane hocche ei function ta override kora jabe ............... 
    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }
    
    function retrieve() public view returns (uint256){
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
/**
    we want to able to deploy simple storage contracts from a contract itself. Yes, contracts can indeed
    deploy contracts, we are going to create a contract called StorageFactory.sol .. >> thats gonna be 
    able to deploy and interact with other contracts itself . So, what we could do is we could go 
    deploy this to a JavaScript VM . we are going to choose storageFactory 
*/

/**
    ----------------------------- Importing Contrcts into other Contracts -- 3 : 07 : 30
    we have our SimpleStorage.sol . which is SimpleStorage Contract. which allow us to store favourit 
    number. and it allows us to store favourit numbers across different people in both mappings and 
    arrays. 
    But lets say we want to get even more advanced with this , we actually can have a contract actually
    deploy other contracts for us. And then go ahead and interact with those  contracts from other 
    contracts. Contracts interacting with each other is an essential part of working with solidity and 
    working with smart contract . 

    The ability for contracts to seamlessly interact with each other is whats known as composability. 

    smart contract are composable, because they can easily interact with each other. This is especially
    awsome when it comes to thinks like defy .. where you can have really complex financial products 
    interact with each other incredibly easily ,  we are going to create a new contract called storage 
    factory.  
    so, lets jump into StorageFactory.sol ... 
*/


