import { Network as BlockchainNetwork } from "../network/network.ts";

export let backend = new BlockchainNetwork();

export function addUser(username: string) {
  return backend.addUser(username);
}

export function connectUsers(from: string, to: string) {
  backend.connectUsers(from, to);
}

export function sendTransaction(from: string, to: string, amount: number) {
  return backend.addTransaction(from, to, amount);
}

export async function mineUser(username: string) {
  return backend.mine(username);
}

export function getBalances(username?: string) {
  return backend.showBalances(username);
}

export function getBlockchain(username: string) {
  return backend.showChain(username);
}

export function propagate(username: string, method: "bfs" | "dfs") {
  return backend.propagate(username, method);
}
