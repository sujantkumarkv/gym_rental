## WEC NITK RECRUITMENTS: 
I'm a bit late and I have contacted the mentors as to why. Thanks for allowing time. There's many fine tunes needed, I also didn't deploy but I did all I can under 4 hours. Thanks again :)
### Problem Statement:
The task is to write a smart contract for gym machine rental.

● The contract should have exactly one owner (the gym's management)

● Clients can buy access to machines in the gym for time slots of 30 minutes (Each time
payment is made for a machine)

● The owner can set the price per time slot whenever he wants.

● Owner can add a new machine anytime he wants

● Anyone can check whether a client has access to the machine at any given time.

● The owner can withdraw the profits to his personal account anytime

Bonus:

● Can set or delegate more than one owner.

● Use solidity practices and features to minimise gas costs.

● Use Modifiers, events and comments to increase readability and debugging.

● Publish the smart contract on a test network

***********************************************
# Soln Code - 

- I assume here for owner to have two wallets, one personal & other `CentralGymWallet` i.e., business account kinda (because the problem asked to allow owner to transfer profits so there should a central place where to store funds from client's transactions I thought and later owner can transfer as much they wish to `ownerWallet`).
- several functions are written w.r.t the points mentioned in the questions.
- `onlyOwner` is a defined under constructor which when used on function's name acts as modifier and verifying each time whether it's been called by owner/NOT thus giving a check :)
- When client calls `_buyAccesToGym`, the funds i.e., `msg.value` are put to `CentralGymWallet` which is just a `mapping` from user's address to an `uint` value.
- For client details, the `function` is `public` as to allow anyone to call this function & it `emit` events with message as this can be caught by a JS file and can be also shown using frontend. (NOW, ALL IS VERY PROTOTYPE LEVEL)


