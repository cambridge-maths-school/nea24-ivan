import { Blockchain } from "../block/blockchain.ts";
import { bfs_traverse } from "../bfs/bfs.ts";
import { dfs_traverse } from "../dfs/dfs.ts";

// Represents a network node (user)
export class Node {
  username: string;
  blockchain: Blockchain;
  neighbours: Node[] = [];

  constructor(username: string, difficulty = 2) {
    this.username = username;
    this.blockchain = new Blockchain(difficulty);
  }

  addneighbour(node: Node) {
    if (!this.neighbours.includes(node)) this.neighbours.push(node);
  }
}

// Represents the full network
export class Network {
  nodes: Map<string, Node> = new Map();
  mempool: string[] = []; // global mempool

  // Add a new node
  addUser(username: string) {
    if (this.nodes.has(username)) {
      return `User ${username} already exists.`;
    }
    let node = new Node(username);
    this.nodes.set(username, node);
    return `User ${username} added.`;
  }

  getNode(username: string): Node | undefined {
    return this.nodes.get(username);
  }

  // Add transaction to global mempool
  addTransaction(from: string, to: string, amount: number) {
    let sender = this.getNode(from);
    if (!sender) {
      console.log(`Sender ${from} not found.`);
      return;
    }
    let tx = `${from} pays ${to} ${amount} coins`;
    this.mempool.push(tx);
    console.log(`Transaction added to global mempool: ${tx}`);
  }

  // Mine transactions for a given node
  async mine(username: string) {
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
    console.log(node.blockchain.minePendingTransactions(transactionsToMine));
    await node.blockchain.minePendingTransactions(transactionsToMine);
    // node.blockchain.chain.push[]
    // Remove mined transactions from global mempool
    this.mempool = [];

    let latestBlock = node.blockchain.getLatestBlock();
    console.log(
      `Block mined by ${username}: Index=${latestBlock.index}, Hash=${latestBlock.hash}, Nonce=${latestBlock.nonce}`
    );
  }

  // BFS/DFS propagation of latest block using imported traversals
  propagate(startUsername: string, method: "bfs" | "dfs") {
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
  showChain(username: string) {
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
  validate(username: string) {
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
  showUsers() {
    if (this.nodes.size === 0) {
      console.log("No users in the network.");
      return;
    }
    console.log(this.nodes.keys());
    return this.nodes.keys();
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
  showMempool(username: string) {
    if (!username) {
      if (this.mempool.length === 0) {
        console.log("Global mempool is empty.");
        return;
      }
      console.log("Global mempool:");
      this.mempool.forEach((tx) => console.log("- " + tx));
      return;
    }

    let node = this.getNode(username);
    if (!node) {
      console.log(`User ${username} not found.`);
      return;
    }

    if (node.blockchain.mempool.length === 0) {
      console.log(`${username}'s mempool is empty.`);
      return;
    }
    console.log(`${username}'s mempool:`);
    node.blockchain.mempool.forEach((tx) => console.log("- " + tx));
  }

  // Connect two users as neighbours
  connectUsers(user1: string, user2: string) {
    let n1 = this.getNode(user1);
    let n2 = this.getNode(user2);
    if (!n1 || !n2) return;
    n1.addneighbour(n2);
    n2.addneighbour(n1);
    console.log(`${user1} and ${user2} are now neighbours.`);
  }
}
