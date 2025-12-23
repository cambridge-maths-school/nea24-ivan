import { Network } from "../network/network.ts";
// @ts-ignore
import readline from "readline";

let rl = readline.createInterface({
  // @ts-ignore
  input: process.stdin,
  // @ts-ignore
  output: process.stdout,
});

let MENU: string = `Menu:
    - add_user <username>
    - connect <user1> <user2>
    - add_tx <from> <to> <amount>
    - show_users
    - show_mempool
    - show_neighbours <username>
    - show_chain <username>
    - show_balances <optional:username>
    - propagate <username> <bfs|dfs>
    - mine <username>
    - help
    - exit")
    `;
let network = new Network();

function prompt(): Promise<string> {
  return new Promise((resolve) => rl.question("> ", resolve));
}

async function main() {
  console.log("=== Blockchain Network Simulator ===");
  console.log(MENU);
  while (true) {
    let input = (await prompt()).trim();
    let [cmd, ...args] = input.split(" ");
    switch (cmd) {
      case "help":
        console.log(MENU);
      case "add_user":
        console.log(network.addUser(args[0]));
        break;
      case "add_tx":
        console.log(
          network.addTransaction(args[0], args[1], parseInt(args[2]))
        );
        break;
      case "mine":
        console.log(await network.mine(args[0]));
        break;
      case "propagate":
        if (args.length != 2) {
          console.log("Usage: propagate <username> <bfs|dfs>");
          break;
        }
        // Propagate for CLI/GUI
        let order = network.propagate(args[0], args[1] as "bfs" | "dfs");
        console.log("Propagation order:", order.join(" -> "));
        break;
      case "show_chain":
        console.log(network.showChain(args[0]));
        break;
      case "connect":
        console.log(network.connectUsers(args[0], args[1]));
        break;
      case "exit":
        rl.close();
        return;
      case "show_users":
        console.log("Users in network:");
        let user_num = 0;
        for (let username of network.nodes.keys()) {
          user_num += 1;
          console.log(`${user_num}. ${username}`);
        }
        console.log(`There are ${user_num} users in the network.`);
        break;
      case "show_neighbours":
        network.showneighbours(args[0]);
        break;
      case "show_mempool":
        for (let tx of network.showMempool()) console.log(`- ${tx}`);
        break;
      case "show_balances":
        args[0]
          ? console.log(network.showBalances(args[0]))
          : console.log(network.showBalances());
        break;

      default:
        console.log("Unknown command. Type 'help' for menu.");
    }
  }
}

main();
