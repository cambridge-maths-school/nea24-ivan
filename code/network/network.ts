import { Blockchain } from "../block/blockchain.ts";
import { bfs_traverse } from "../bfs/bfs.ts";
import { dfs_traverse } from "../dfs/dfs.ts";
import { Balances } from "./balances.ts";

export class Node {
  username: string;
  blockchain: Blockchain;
  neighbours: Node[] = [];

  constructor(username: string, difficulty = 2) {
    this.username = username;
    this.blockchain = new Blockchain(difficulty);
  }

  addNeighbour(node: Node) {
    if (!this.neighbours.includes(node)) this.neighbours.push(node);
  }
}

// Represents the full network
export class Network {
  nodes: Map<string, Node> = new Map();
  mempool: string[] = []; // global mempool
  balances: Balances = new Balances(100);

  // Add a new node
  addUser(username: string): string {
    if (this.nodes.has(username)) {
      return `User ${username} already exists.`;
    }
    let node = new Node(username);
    this.nodes.set(username, node);
    this.balances.addUser(username);
    return `User ${username} added.`;
  }

  getNode(username: string): Node | undefined {
    return this.nodes.get(username);
  }

  // Add transaction to global mempool
  addTransaction(from: string, to: string, amount: number): void {
    let sender = this.getNode(from);
    let receiver = this.getNode(to);
    if (!sender || !receiver) {
      console.log("Sender or receiver not found.");
      return;
    }

    // Fix Debt Issues
    // let pendingBalance = this.balances.getBalance(from);
    // for (let tx of this.mempool) {
    //   let [f, , , amtStr] = tx.split(" ");
    //   let a = parseInt(amtStr);
    //   if (f === from) pendingBalance -= a;
    // }
    // if (pendingBalance < amount) {
    //   console.log(
    //     `${from} does not have enough coins after pending transactions.`
    //   );
    //   return;
    // }

    if (!this.balances.hasFunds(from, amount)) {
      console.log(`${from} does not have enough coins.`);
      return;
    }

    let tx = `${from} pays ${to} ${amount} coins`;
    this.mempool.push(tx);
    console.log(`Transaction added to global mempool: ${tx}`);
  }

  // Mine transactions for a given node
  async mine(username: string): Promise<void> {
    let node = this.getNode(username);
    if (!node) {
      console.log(`User ${username} not found.`);
      return;
    }

    if (this.mempool.length === 0) {
      console.log("No transactions to mine.");
      return;
    }
    let transactionsToMine = [...this.mempool];
    let newBlock = await node.blockchain.minePendingTransactions(
      transactionsToMine
    );
    node.blockchain.chain.push(newBlock);

    for (let tx of transactionsToMine) {
      let parts = tx.split(" ");
      let from = parts[0];
      let to = parts[2];
      let amount = parseInt(parts[3]);
      this.balances.applyTransaction(from, to, amount);
    }

    // Give miner a reward
    this.balances.applyTransaction("system", username, 10);

    // Clear mempool after mining
    this.mempool = [];

    let latestBlock = node.blockchain.getLatestBlock();
    console.log(
      `Block mined by ${username}: Index=${latestBlock.index}, Hash=${latestBlock.hash}, Nonce=${latestBlock.nonce}`
    );
  }

  // BFS/DFS propagation of latest block using imported traversals
  propagate(startUsername: string, method: "bfs" | "dfs"): void {
    let startNode = this.getNode(startUsername);
    if (!startNode) {
      console.log(`Start user ${startUsername} not found.`);
      return;
    }

    let latestBlock = startNode.blockchain.getLatestBlock();
    let targetPrefix = "0".repeat(startNode.blockchain.difficulty);

    if (!latestBlock.hash.startsWith(targetPrefix)) {
      console.log(
        `Cannot propagate: latest block by ${startUsername} is not mined yet.`
      );
      return;
    }

    // Build adjacency list for traversal
    let adjacencyList: Record<string, string[]> = {};
    for (let [username, node] of this.nodes.entries()) {
      adjacencyList[username] = node.neighbours.map((n) => n.username);
    }

    // Get traversal order
    let order =
      method === "dfs"
        ? dfs_traverse(adjacencyList, startUsername)
        : bfs_traverse(adjacencyList, startUsername);

    // Propagate block along traversal order
    for (let username of order) {
      let node = this.getNode(username)!;
      if (node.blockchain.chain.length <= latestBlock.index) {
        node.blockchain.chain.push(latestBlock);
      }
    }

    console.log(`${method.toUpperCase()} propagation: ${order.join(" -> ")}`);
  }

  // Display a user's blockchain
  showChain(username: string): void {
    let node = this.getNode(username);
    if (!node) {
      console.log(`User ${username} not found.`);
      return;
    }
    node.blockchain.chain.forEach((block) => {
      console.log(`Index: ${block.index}, Hash: ${block.hash}`);
      console.log(`Transactions: ${block.transactions.join(", ")}`);
    });
  }

  // Validate a user's blockchain
  validate(username: string): void {
    let node = this.getNode(username);
    if (!node) {
      console.log(`User ${username} not found.`);
      return;
    }
    console.log(
      `Blockchain valid for ${username}? ${node.blockchain.isChainValid()}`
    );
  }

  // Show all users
  showUsers(): IterableIterator<string> | void {
    if (this.nodes.size === 0) {
      console.log("No users in the network.");
      return;
    }
    console.log(this.nodes.keys());
    return this.nodes.keys();
  }
  // Show user balances
  showBalances(username?: string) {
    console.log("=== Balances ===");
    console.log(this.balances.printBalances(username));
  }

  // Show a user's neighbours
  showneighbours(username: string) {
    let node = this.getNode(username);
    if (!node) {
      console.log(`User ${username} not found.`);
      return;
    }
    if (node.neighbours.length === 0) {
      console.log(`${username} has no neighbours.`);
      return;
    }
    console.log(
      `neighbours of ${username}: ${node.neighbours
        .map((n) => n.username)
        .join(", ")}`
    );
  }

  // Show global mempool or per-user mempool
  showMempool() {
    return this.mempool;
  }

  // Connect two users as neighbours
  connectUsers(user1: string, user2: string) {
    let n1 = this.getNode(user1);
    let n2 = this.getNode(user2);
    if (!n1 || !n2) return;
    n1.addNeighbour(n2);
    n2.addNeighbour(n1);
    console.log(`${user1} and ${user2} are now neighbours.`);
  }
}
