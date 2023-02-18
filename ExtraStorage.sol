// SPDX-License-Identifier: MIT

//pragma solidity ^0.8.8;
// pragma solidity ^0.8.7;

pragma solidity ^0.8.8;

import "./SimpleStorage.sol"; // for inheritance purpose .. 

contract ExtraStorage is SimpleStorage {
    // ExtraStorage is a child contract of our simpleStorage contract. 
    // inherit all the functionality of simpleStorage. 

    // now we can add additional functionality ..  amra override o korte parbo .. 
    // SimpleStorage e ei function ta ke virtual keyword deowa thakte hobe .. 
    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }
}

/**
    so what can we do .. well the first thing we could do is we could copy paste all this code back into
    here from simpleStorage and then modify our extra storage contract as we see fit . this seems 
    little bit redundant . So, whats another way we can actually get our extra storage contract to be like 
    our simpleStorage Contract . 

    ExtraStorage is a child contract of our simpleStorage contract. 

    And we can have extra storage, inherit all 
*/

/**
    //---------------------- 3 : 30 : 32 ------- Lesson 3 Recap 

    //---------------------- 3 : 31 : 56 ------- Lesson 4 Remix Fund Me 
*/
