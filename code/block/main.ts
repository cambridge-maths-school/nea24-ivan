import { Blockchain } from "./blockchain.ts";

// === Normal Behaviour Test ===
async function normalTest() {
  console.log("=== NORMAL TEST ===");
  let myChain = new Blockchain(2);

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

// === Boundary Tests ===
async function emptyMempoolTest() {
  console.log("\n=== BOUNDARY TEST: Empty mempool ===");
  let myChain = new Blockchain(3);
  await myChain.minePendingTransactions();
}

async function largeBatchTest() {
  console.log("\n=== BOUNDARY TEST: Large batch of transactions ===");
  let myChain = new Blockchain(2);
  for (let i = 0; i < 100; i++) {
    myChain.addTransaction(`User${i} sends ${i} coins`);
  }
  console.log("Mining large batch...");
  await myChain.minePendingTransactions();
  console.log(
    "Transactions in last block:",
    myChain.getLatestBlock().transactions.length
  );
}

async function highDifficultyTest() {
  console.log("\n=== BOUNDARY TEST: High difficulty ===");
  let myChain = new Blockchain(5); // very hard to mine
  myChain.addTransaction("High difficulty test transaction");
  console.log("Mining with difficulty 5 (might take a while)...");
  await myChain.minePendingTransactions();
  console.log("Blockchain valid after mining?", myChain.isChainValid());
}

// === Erroneous Tests ===
async function invalidTransactionTest() {
  console.log("\n=== ERRONEOUS TEST: Invalid transaction type ===");
  let myChain = new Blockchain(2);
    myChain.addTransaction(12345); // Invalid, should be string
}

async function tamperedChainTest() {
  console.log("\n=== ERRONEOUS TEST: Tampered block ===");
  let myChain = new Blockchain(2);
  myChain.addTransaction("Alice pays Bob 1 coin");
  await myChain.minePendingTransactions();
  myChain.addTransaction("Charlie pays Dave 2 coins");
  await myChain.minePendingTransactions();

  // Tamper with first mined block
  myChain.chain[1].transactions.push("Hacked Transaction!");
  console.log("Blockchain valid after tampering?", myChain.isChainValid());
}

async function reMiningTest() {
  console.log("\n=== ERRONEOUS TEST: Re-mining block ===");
  let myChain = new Blockchain(2);
  myChain.addTransaction("Test transaction");
  await myChain.minePendingTransactions();

  console.log("Re-mining latest block...");
  let latestBlock = myChain.getLatestBlock();
  await latestBlock.mineBlock(myChain.difficulty);
  console.log("Blockchain valid after re-mining?", myChain.isChainValid());
}

// === Run all tests sequentially ===
async function runAllTests() {
  await normalTest();
  // await emptyMempoolTest();
  // await largeBatchTest();
  // await highDifficultyTest();
  // await invalidTransactionTest();
  // await tamperedChainTest();
  // await reMiningTest();
}

runAllTests();
