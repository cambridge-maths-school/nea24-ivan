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
  addTransaction(from: string, to: string, amount: number): string {
    let sender = this.getNode(from);
    let receiver = this.getNode(to);
    if (!sender || !receiver) {
      return "Sender or receiver not found.";
    }

    // Fix Debt Issues
    // let pendingBalance = this.balances.getBalance(from);
    // for (let tx of this.mempool) {
    //   let [f, , , amtStr] = tx.split(" ");
    //   let a = parseInt(amtStr);
    //   if (f === from) pendingBalance -= a;
    // }
    // if (pendingBalance < amount) {
    //   return `${from} does not have enough coins after pending transactions.`;
    // }

    if (!this.balances.hasFunds(from, amount)) {
      return `${from} does not have enough coins.`;
    }

    let tx = `${from} pays ${to} ${amount} coins`;
    this.mempool.push(tx);
    return `Transaction added to global mempool: ${tx}`;
  }

  // Mine transactions for a given node
  async mine(username: string): Promise<string> {
    let node = this.getNode(username);
    if (!node) {
      return `User ${username} not found.`;
    }

    if (this.mempool.length === 0) {
      return "No transactions to mine.";
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
    // this.balances.applyTransaction("system", username, 10);

    // Clear mempool after mining
    this.mempool = [];

    let latestBlock = node.blockchain.getLatestBlock();
    return `Block mined by ${username}: Index=${latestBlock.index}, Hash=${latestBlock.hash}, Nonce=${latestBlock.nonce}`;
  }

  // BFS/DFS propagation of latest block using imported traversals
  propagate(startUsername: string, method: "bfs" | "dfs"): string {
    let startNode = this.getNode(startUsername);
    if (!startNode) {
      return `Start user ${startUsername} not found.`;
    }

    let latestBlock = startNode.blockchain.getLatestBlock();
    let targetPrefix = "0".repeat(startNode.blockchain.difficulty);

    if (!latestBlock.hash.startsWith(targetPrefix)) {
      return `Cannot propagate: latest block by ${startUsername} is not mined yet.`;
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

    return `${method.toUpperCase()} propagation: ${order.join(" -> ")}`;
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
  // Display a user's blockchain
  showChain(username: string): string {
    let node = this.getNode(username);
    if (!node) return `User ${username} not found.`;
    let output_str = `===== ${username}'s Blockchain =====`;
    node.blockchain.chain.forEach((block) => {
      output_str += `\n\nIndex: ${block.index}, Hash: ${
        block.hash
      }\n Transactions: ${block.transactions.join(", ")}`;
    });
    return output_str;
  }

  // Validate a user's blockchain
  validate(username: string): string {
    let node = this.getNode(username);
    if (!node) {
      return `User ${username} not found.`;
    }
    return `Blockchain valid for ${username}? ${node.blockchain.isChainValid()}`;
  }

  // Show all users
  showUsers(): IterableIterator<string> | string {
    if (this.nodes.size === 0) {
      return "No users in the network.";
    }
    console.log(this.nodes.keys());
    return this.nodes.keys();
  }
  // Show user balances
  showBalances(username?: string) {
    return "=== Balances ===\n" + this.balances.printBalances(username);
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
  showMempool(): string[] {
    return this.mempool;
  }

  getEdges() {
    let result = [];
    for (let [name, node] of this.nodes.entries()) {
      for (let n of node.neighbours) {
        result.push({ from: name, to: n.username });
      }
    }
    return result;
  }
}
