import { Blockchain } from "./blockchain.ts";

// Initialize blockchain
let myChain = new Blockchain(3);

// Add transactions to mempool
myChain.addTransaction("Alice pays Bob 10 coins");
myChain.addTransaction("Bob pays Charlie 5 coins");

// Mine mempool
console.log("Mining pending transactions...");
myChain.minePendingTransactions();

console.log("Current Blockchain:");
console.log(myChain.chain);

// Add more transactions and mine again
myChain.addTransaction("Charlie pays Dave 2 coins");
myChain.addTransaction("Eve pays Frank 1 coin");

console.log("Mining pending transactions again...");
myChain.minePendingTransactions();

console.log("Blockchain after second mining:");
console.log(myChain.chain);

// Validate chain
console.log("Is blockchain valid?", myChain.isChainValid());
