import { Block } from "./block.ts";

// Represents the full blockchain
export class Blockchain {
  chain: Block[] = []; // Array of all blocks
  mempool: string[] = []; // Transactions waiting to be mined
  difficulty: number; // Mining difficulty (number of leading zeros)

  constructor(difficulty: number = 2) {
    this.difficulty = difficulty;
    this.chain.push(this.createGenesisBlock()); // Start chain with genesis block
  }

  // Create the first block in the chain
  createGenesisBlock(): Block {
    let genesis = new Block(0, Date.now(), ["Genesis Block"], "0");
    return genesis;
  }

  // Get the latest block in the chain
  getLatestBlock(): Block {
    let latest = this.chain[this.chain.length - 1];
    return latest;
  }

  // Add a transaction to the mempool
  addTransaction(tx: string) {
    this.mempool.push(tx);
  }

  // Mine all pending transactions and add as a new block
  // async minePendingTransactions() {
  //   if (this.mempool.length === 0) {
  //     console.log("No transactions to mine.");
  //     return;
  //   }

  //   console.log("Current mempool:", this.mempool);

  //   let newBlock = new Block(
  //     this.chain.length,
  //     Date.now(),
  //     this.mempool,
  //     this.getLatestBlock().hash
  //   );

  //   await newBlock.mineBlock(this.difficulty);

  //   this.chain.push(newBlock);
  //   this.mempool = []; // Clear mempool after mining
  //   console.log("Mempool cleared after mining.\n");
  // }

  async minePendingTransactions(transactions?: string[]) {
    // Use passed transactions if given, otherwise use the blockchain's own mempool
    const txs = transactions ?? this.mempool;

    if (txs.length === 0) {
      console.log("No transactions to mine.");
      return;
    }

    console.log("Current transactions being mined:", txs);

    let newBlock = new Block(
      this.chain.length,
      Date.now(),
      txs,
      this.getLatestBlock().hash
    );

    await newBlock.mineBlock(this.difficulty);

    this.chain.push(newBlock);

    // Clear mempool if mining the blockchain's own mempool
    if (!transactions) {
      this.mempool = [];
      console.log("Mempool cleared after mining.\n");
    }
  }

  // Check if blockchain is valid by comparing hashes
  isChainValid(): boolean {
    for (let i = 1; i < this.chain.length; i++) {
      let current = this.chain[i];
      let previous = this.chain[i - 1];

      if (current.hash !== current.calculateHash()) return false;
      if (current.previousHash !== previous.hash) return false;
    }
    return true;
  }
}
