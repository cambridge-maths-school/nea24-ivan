import { fakeHash } from "../pow/hash.ts";
import { startMining } from "../pow_with_blob/main.ts";

// Represents a single block in the blockchain
export class Block {
  index: number; // Position in the chain
  timestamp: number; // When the block was created
  transactions: string[]; // Transactions included in this block
  previousHash: string; // Hash of previous block
  nonce: number = 0; // Used for proof-of-work
  hash: string; // Hash of this block
  // mined: boolean = false;

  constructor(
    index: number,
    timestamp: number,
    transactions: string[],
    previousHash: string
  ) {
    this.index = index;
    this.timestamp = timestamp;
    this.transactions = transactions;
    this.previousHash = previousHash;
    this.hash = this.calculateHash(); // Initial hash
  }

  // Calculate hash based on block content and nonce
  calculateHash(): string {
    return fakeHash(
      this.index +
        this.previousHash +
        this.timestamp +
        JSON.stringify(this.transactions) +
        this.nonce // make sure nonce is included
    );
  }

  // Mine the block using proof of work
  async mineBlock(difficulty: number) {
    // Pass the full block data to startMining
    // if (this.mined) throw new Error("Block has already been mined!");
    let blockData =
      this.index +
      this.previousHash +
      this.timestamp +
      JSON.stringify(this.transactions);

    // Await mined result from workers
    let result = await startMining(blockData, difficulty);

    this.nonce = result.nonce; // store mined nonce
    this.hash = result.hash; // store mined hash
    // this.mined = true;
    console.log(`Block mined: hash=${this.hash}, nonce=${this.nonce}`);
  }
}
