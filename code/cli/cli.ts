import { Network } from "./network.ts";
// @ts-ignore
import readline from "readline";

let rl = readline.createInterface({
  // @ts-ignore
  input: process.stdin,
  // @ts-ignore
  output: process.stdout,
});

let network = new Network();

function prompt(): Promise<string> {
  return new Promise((resolve) => rl.question("> ", resolve));
}

async function main() {
  console.log("=== Blockchain Network Simulator ===");

  while (true) {
    let input = (await prompt()).trim();
    let [cmd, ...args] = input.split(" ");

    switch (cmd) {
      case "add_user":
        console.log(network.addUser(args[0]));
        break;
      case "add_tx":
        network.addTransaction(args[0], args[1], parseInt(args[2]));
        break;
      case "mine":
        await network.mine(args[0]);
        break;
      case "propagate":
        network.propagate(args[0], args[1] as "bfs" | "dfs");
        break;
      case "show_chain":
        network.showChain(args[0]);
        break;
      case "validate":
        network.validate(args[0]);
        break;
      case "connect":
        network.connectUsers(args[0], args[1]);
        break;
      case "exit":
        rl.close();
        return;
      case "show_users":
        console.log("Users in network:");
        let user_num = 0
        for (let username of network.nodes.keys()) {
          user_num += 1
          console.log("- " + username);
          console.log(`There are ${user_num} users in the network.`)
        }
        break;
      case "show_neighbours":
        network.showneighbours(args[0]);
        break;
      case "show_mempool":
        network.showMempool(args[0]);
        break;

      default:
        console.log("Unknown command");
    }
  }
}

main();
