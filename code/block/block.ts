class Block {
  index: number;
  previousHash: string;
  timestamp: number;
  data: string;
  difficulty: number;
  nonce: number;
  hash: string;
  miner: string;

  constructor(
    index: number,
    previousHash: string,
    timestamp: number,
    data: string,
    difficulty: number,
    nonce: number,
    hash: string,
    miner: string
  ) {
    this.index = index;
    this.previousHash = previousHash;
    this.timestamp = timestamp;
    this.data = data;
    this.difficulty = difficulty;
    this.nonce = nonce;
    this.hash = hash;
    this.miner = miner;
  }
}
export default Block;
