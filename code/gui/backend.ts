import { Network as BlockchainNetwork } from "../network/network.ts";

export let backend = new BlockchainNetwork(2);
export function setDifficulty(newDifficulty: number) {
  backend.difficulty = newDifficulty;
  console.log(newDifficulty);
}

export function addUser(username: string): string {
  return backend.addUser(username);
}

export function connectUsers(from: string, to: string): string {
  return backend.connectUsers(from, to);
}

export function sendTransaction(
  from: string,
  to: string,
  amount: number
): string {
  return backend.addTransaction(from, to, amount);
}

export async function mineUser(username: string) {
  let nodeExists = backend.getNode(username);
  if (!nodeExists) {
    return { message: `User ${username} not found.`, nonce: null };
  }

  let resultMessage = await backend.mine(username);
  let latestBlock = backend.getNode(username)?.blockchain.getLatestBlock();

  return {
    message: resultMessage,
    nonce: latestBlock?.nonce ?? null,
  };
}

export function getBalances(username?: string) {
  return backend.showBalances(username);
}

export function getBlockchain(username: string): string {
  return backend.showChain(username);
}

export function propagate(username: string, method: "bfs" | "dfs") {
  return backend.propagate(username, method);
}

// Finalise a mined block
export function finaliseMinedBlock(
  username: string,
  nonce: number,
  hash: string,
  timestamp: number,
  transactions: string[]
) {
  return backend.finaliseMinedBlock(
    username,
    nonce,
    hash,
    timestamp,
    transactions
  );
}
