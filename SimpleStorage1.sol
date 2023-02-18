// spdx lisence identifier // optional // this is to make licensing and sharing code lot easier 

// SPDX-License-Identifier: MIT


//First thing we are gonna need version of solidity that we are going to use .. 
// Constantly changing language
pragma solidity ^0.8.8; // 0.8.7 // stable // 0.8.12 current
// we are okey with the more new version .. ^0.8.17 .. which means .17 or above version is ok for this contract
// >= 0.8.7 < 0.9.0 // any compiler between this 2 number can compile our code 

///// define our contract // its like a class in OOP
contract SimpleStorage1{
    // we can deploy our contract right now and it would be a valid contract
    // basic types 
    // boolean, uint => unsigned integer, whole number , isn't positive or negetive, its just positive
    // int => positive or negetive whole number 
    // address => meta mask e amra jei address dekhi sheita.. 
    // bytes
    bool hasFavoriteNumber = true;
    uint favNum = 123; // we cen specify how many bits want to allocate to this number uint8 to uint256 // automatic 256
    // int256, int
    string name = "Five";
    int value = -3;
    address myAddress = 0x6DDB1e97Da2134FCCe4E54eEb6cD36ad9c9A1ad9;
    bytes32 favCat = "cat" ; // how many bytes we want them to be   // String are secretly just bytes objects
    // bytes1 , bytes3

    ///////////////////////////////// type visibility name 
    uint256 public favAge; // has a default value = 0 // normally visibility private thake // 
    /////////////////////////////////////////////////// Basic Solidity Functions

    function store(uint256 _favAge) public{
        // it will change the value of favAge
        favAge = _favAge;
    } 

    // now to see this actually in action , lets deploy it to an even thicker blockchain than a testnet

    // Remix VM(London) its a fake local blockchain where we can simulate transactions
    // really quickly  without having to wait for them to go through on a test net . 

    // we are giving whole bunch of fake accounts from where to deploy from, we
    // are given 100 eth for each one of these fake account 

    // after clicking deploy button , we can see a contract was deployed. 

    // on our fake local blockchain, we are actually given an address, every 
    // single smart contract , it has an address, just like how our wallets 
    // have an address. So, if we hit that copy button . 
    // and comment that address here ..
    // 0xd9145CCE52D386f254917e481eB44e9943F39138
    // the address of this contract that we just deployed . is located at this 
    // address. 

    // Any time you change something on-chain, including making a new contract,
    // it happens in a transaction. 

    // when we deploy a contract , Its actually the same as sending a transaction.
    // Remember anytime we do anything on the blockchain, we modify any value, 
    // we are sending a transaction.  So deploying a contract is modifying the 
    // blockchain to have this contract. Its modifying the state of the blockchain


    // by clicking store button , we actually execute a trasaction on our Fake
    // Remix blockchain .... 
    // And we can see .. we have little bit less ether .. 

    // dont modify the state of the blockchain .. 
    function retrieve() public view returns(uint256){
        // view and pure functions, when called alone , dont spend gas 
        // view mane hocche amra ei contract theke kichu just read korte chai 
        // amra kono modification korte pari na .. pure function eo kono 
        // modification kora jay na .. 
        // pure functions additionally disallow you to read from blockchain 
        // state . 
        return favAge;
    }

    function add() public pure returns(uint256){
        return(1 + 1) ; // pure function parameter hishebe kichu accept kore na .. 
        // etar maddhome amra blockchain state/storage theke kono kichu change o korte 
        // pari na .. 
    }
    /*
        if we do have a function that updating state thats called view or pure 
        function ... Thats the only time .. it will cost gas .. 
        /// If a gas calling function calls a view or pure function - only then
        // it will cost gas .  


        // If our store function, which is not a view or pure function ... 
        // if it call retrieve function at some point .  Then we have to pay the 
        // cost of retrieve at some point .  Because reading from the block chain
        // cost this computation cost gas 
    */

    //--------------------  Basic Solidity Arrays And Structs 2 : 35 : 31-----------
    // struct of people .. 
    // new type or data type 
    struct People {
        uint256 favNum;
        string name;
    }

    People public person = People({
        favNum  : 3,
        name : "Mohammad"
    }); // {} er maddhome solidy ke bujhailam je 
    // eita ekta struct ke consider korbe .. 

    People public person2 = People({
        favNum  : 4,
        name : "Sheakh"
    }); 

    // we can create list .. its more convinient 
    People[] public people; // People Array , we call it people 
    // dynamic array // initialize kora nai .. [3] mane 3 people thakte parbe .. 
    // ei array er moddhe .. 
    uint256[] public favNumberList; // favNumberList is now array or list
    /*
        Since its public and its variable it automatically gives us a view 
        function . 
        our people list is automatically empty now .. eta amader ke ekta 
        input box dise .. but number type korle kono kaj hocche na .. 

        input box ta ashole index ney amader theke .. amra jodi 0 input dei 
        0 input/index er against e jodi kono value assign kora thake .. 
        tahole shei value ta show korbe .. 
    */ 
    /*
        dynamic array vs fixed size array 

    */

    /*
        /*************---------------Basic Solidity Mapping-----------------------------------
        amra mapping data structure use korte pari  .. A mapping data structure where a key is 
        "mapped" to a single value .. 

    */
   
    // dictionary or hash table ..  key dile value return korbe ... 
    mapping(string => uint256) public nameToFavNumber; // name gonna map specific
    // number // amra input hishebe string dibo .. she amader ke number back dibe 

    // amra ekhon amra function banabo .. jeta people array te value add korte 
    // parbe .. 

    // function modifies the state of blockchain  
    function addPerson(string memory _name, uint256 _favNumber ) public {
        // people object er push function call korlam .. 

        ///////people.push(People(_favNumber, _name)) ; // create new Person, new People Object ..
        // array.push(Struct(parameter, parameter));

        // amra arek vabeo kaj ta korte pari .. 
        // create a variable of type people 

        /// People memory newPerson = People({
        ///         favNum : _favNumber,
        ///         name : _name
        ///     });



        // People memory newPerson = People(_favNumber, _name);
        //people.push(newPerson);

        // eita ke .. evabeo likha jay .. ekhon ar amader memory keyword ta
        // dorkar nai .. 
        people.push(People(_favNumber, _name)) ;

        // Array te add korar pashapahi mapping o korbo .. 
        nameToFavNumber[_name] = _favNumber; // at key name , it will give us the favNumber

    }

    //--------------------  Basic Solidity Errors And Wanrings 2 : 45 : 36 -------


    //--------------------  Basic Solidity Memory, Storage And Calldata(Intro) 2 : 46 : 35 -------

    // ekta error amra face kori .. memory na likhle .. data location must be "memory" or "calldata" for 
    // parameter in function, but none was given 
    /*
        there actually 6 places you can store data in solidity 
            1. Stack
            2. Memory ----- important
            3. Storage ----- important 
            4. Calldata ------ important 
            5. Code
            6. Logs 

        Calldata and memory is only gonna exist temporarily .. 
        _name variable only exist temporarily during the transaction , when addPerson function is called 
        Storage variable exist even outside of just the function executing. .. 

        jehetu function run shesh hoye gele .. amader ar _name variable dorkar nai .. tai amra eita ke 
        memory boltesi .. ar  or we can keep that as calldata . if you dont end up modifying the _name 

        calldata is temporarily variable that can be modify
        but memory can not be modified . 

        Stoage is permanent variable . that can be modified . 

        uint256 ke modify korte parleo .. string ke korte pare na .. string ektu complicated ..  
        string jehetu array of byte .. so amader ke memory add kora lage ..  
    */

     //--------------------  Deploying your first contract in testnet  2 : 53 : 40 -------

     //-------------------- Lesson 3 - Remix Storage Factory -----------------------------




}
