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
  async minePendingTransactions(transactions: string[]): Promise<Block> {
    console.log("Current mempool:", transactions);

    let newBlock = new Block(
      this.chain.length,
      Date.now(),
      transactions,
      this.getLatestBlock().hash
    );

    await newBlock.mineBlock(this.difficulty);
    return newBlock;
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
