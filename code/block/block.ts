import { fakeHash } from "../pow/hash.ts";
import { startMining, stopMining } from "../pow_with_blob/main.ts";
export class Block {
  index: number;
  timestamp: number;
  transactions: string[];
  previousHash: string;
  nonce: number = 0;
  hash: string;

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
    this.hash = this.calculateHash();
  }

  calculateHash(): string {
    return fakeHash(
      this.index +
        this.previousHash +
        this.timestamp +
        JSON.stringify(this.transactions) +
        this.nonce
    );
  }

  mineBlock(transactions: string[], difficulty: number) {
    let tx = JSON.stringify(transactions);
    let res = [startMining(tx, difficulty)];
    console.log(`Block mined: ${res[0]} with nonce ${res[1]}`);
  }
}
