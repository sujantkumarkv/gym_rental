// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract gym_rental{
    uint256 slotTime= 30 minutes;
    address public owner;
    constructor (address owner) public {
        owner= msg.sender;
    }
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    struct GymEquipment{
        string name;
        uint id;
        uint price;
    }
    struct Client{
        string name;
        //OPTIMISING GAS FEES :) by stacking struct data together
        uint128 id;
        uint128 time;
    }
    mapping (address => uint) CentralGymWallet;
    mapping (address => uint) ownerWallet;

    /*Event to be emitted when requesting client details which can be fetched in some other JS file*/
    event ClientDetails(string _clientName, uint _id, string message); 
    
    // array to store all gym's equipments where each equipment is a data structure struct as defined above.
    GymEquipment[] public gym_equipments;
    Client[] public clients;

    GymEquipment the_equipment; //declare an equipment of struct type GymEquipment (used later)
    Client the_client; //declare a client of struct type Client (used later)
    function _addGymEquiment(string memory _name, uint _price) internal onlyOwner{ //
        uint _id= gym_equipments.length;//running 1st time, it would be "0" & indexing begins with "0"
        gym_equipments.push(GymEquipment(_name, _id, _price)); //push no longer returns length of array.
    }

    function _buyAccessToGym(string memory _clientName, uint _id) external payable{
        //the client calls this function
    
        the_equipment= gym_equipments[_id]; //fetch the equipment from the array using the _id of equipment.
        require(msg.value == the_equipment.price); //to check if client is paying the correct amount.
        /*if require is true-
            #we allot the time to the client who called this function  
            #add the money received to the central gym wallet
            (NOTE: here we have two wallets, one central gym's & one owner's personal wallet. I have made both to be owned by him btw
            but it's like business acc VS personal one. He can choose to transfer funds from it to his personal account :D)
        */
        clients.push(Client(_clientName, uint128(_id), uint128(block.timestamp + 30 minutes))); //'now' is replaced by 'block.timestamp'
        CentralGymWallet[owner] += msg.value;
    }

    function _changePrice(uint _id, uint _newPrice) internal onlyOwner{ //_id of the equipment 
        the_equipment= gym_equipments[_id]; //fetch the equipment from the array using the _id of equipment.
        the_equipment.price= _newPrice;
    }

    function _withdrawProfits(uint _withdrawAmount) internal onlyOwner{
        //check if requested amount is available in CentralGymWallet OR NOT.
        require(_withdrawAmount <= CentralGymWallet[msg.sender]);
        ownerWallet[msg.sender] += _withdrawAmount;//add to personal's wallet
        CentralGymWallet[msg.sender] -= _withdrawAmount;//deduct from CentralGymWallet's balance
    }

    function _checkClientDetails(string memory _clientName, uint _id) public{ //gym equipment Id
        //We assume gym has only one equipment of each type & one client can obviously with common sense use one equipment at a time.
        the_client= clients[_id];
        if(block.timestamp >= the_client.time){
            emit ClientDetails(_clientName, _id, "30mins of Usage time over!!!");
        }
        else{
            //uint time_left= the_client.time - block.timestamp;
            emit ClientDetails(_clientName, _id, "Usage time left!!!");
        }
    }
}

