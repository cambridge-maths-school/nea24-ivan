import { Block } from "./block.ts";

export class Blockchain {
  chain: Block[] = [];
  mempool: string[] = [];
  difficulty: number;

  constructor(difficulty: number = 2) {
    this.difficulty = difficulty;
    this.chain.push(this.createGenesisBlock());
  }

  createGenesisBlock(): Block {
    return new Block(0, Date.now(), ["Genesis Block"], "0");
  }

  getLatestBlock(): Block {
    return this.chain[this.chain.length - 1];
  }

  addTransaction(tx: string) {
    this.mempool.push(tx);
  }

  minePendingTransactions() {
    if (this.mempool.length === 0) {
      console.log("No transactions to mine.");
      return;
    }

    let block = new Block(
      this.chain.length,
      Date.now(),
      this.mempool,
      this.getLatestBlock().hash
    );

    block.mineBlock(this.mempool, this.difficulty);
    this.chain.push(block);
    this.mempool = []; // clear mempool
  }

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
