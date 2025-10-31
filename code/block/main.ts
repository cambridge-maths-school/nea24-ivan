import { Blockchain } from "./blockchain.ts";

// Run blockchain demo
async function normalTest() {
  let myChain = new Blockchain(3);

  // Add first batch of transactions
  console.log("Adding transactions...");
  myChain.addTransaction("Alice pays Bob 10 coins");
  myChain.addTransaction("Bob pays Charlie 5 coins");

  console.log("Mempool before mining:", myChain.mempool);
  console.log("Mining pending transactions...");
  await myChain.minePendingTransactions();
  console.log("Current Blockchain:");
  console.log(JSON.stringify(myChain.chain, null, 2));

  // Add second batch of transactions
  myChain.addTransaction("Charlie pays Dave 2 coins");
  myChain.addTransaction("Eve pays Frank 1 coin");

  console.log("Mempool before second mining:", myChain.mempool);
  console.log("Mining pending transactions again...");
  await myChain.minePendingTransactions();

  console.log("Blockchain after second mining:");
  console.log(JSON.stringify(myChain.chain, null, 2));

  // Validate chain
  console.log("Is blockchain valid?", myChain.isChainValid());
}

normalTest();
