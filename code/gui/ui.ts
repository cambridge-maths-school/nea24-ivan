import * as Backend from "./backend.ts";
import * as Vis from "./visManager.ts";
import { startMining } from "../pow_with_blob/main.ts";
export let visNetwork: any;

export function initUI() {
  let usernameInput = document.getElementById(
    "usernameInput"
  ) as HTMLInputElement;
  let connectFromInput = document.getElementById(
    "connectFrom"
  ) as HTMLInputElement;
  let connectToInput = document.getElementById("connectTo") as HTMLInputElement;
  let txFrom = document.getElementById("txFrom") as HTMLInputElement;
  let txTo = document.getElementById("txTo") as HTMLInputElement;
  let txAmount = document.getElementById("txAmount") as HTMLInputElement;
  let mineBtn = document.getElementById("mineBtn")!;
  let mineStatus = document.getElementById("mineStatus")!;
  let propagateBFSBtn = document.getElementById("propagateBFS")!;
  let propagateDFSBtn = document.getElementById("propagateDFS")!;
  let balancesDiv = document.getElementById("balances")!;
  let blockchainDiv = document.getElementById("blockchain")!;
  let mempoolDiv = document.getElementById("mempool")!;
  let difficultySlider = document.getElementById(
    "difficultySlider"
  ) as HTMLInputElement;
  let difficultyValue = document.getElementById("difficultyValue")!;
  let addUserForm = document.getElementById("addUserForm")!;
  let connectForm = document.getElementById("connectForm")!;
  let txForm = document.getElementById("txForm")!;

  // add user to the network
  addUserForm.addEventListener("submit", (e) => {
    e.preventDefault();
    let username = usernameInput.value.trim();
    if (!username) return;
    if (Vis.nodes.getIds().includes(username)) {
      alert("That username already exists.");
      return;
    }
    if (Vis.nodes.length > 0 && !Vis.selectedUser) {
      alert("Select a user first to attach the new user!");
      return;
    }

    let res = Backend.addUser(username);
    alert(res);
    Vis.addNode(username, username);

    // Connect to existing user
    if (Vis.selectedUser) {
      Backend.connectUsers(Vis.selectedUser, username);
      Vis.addEdge(Vis.selectedUser, username);
    }

    usernameInput.value = "";
  });

  // Connecting existing users in the network
  connectForm.addEventListener("submit", (e) => {
    e.preventDefault();
    let from = connectFromInput.value.trim();
    let to = connectToInput.value.trim();
    if (!from || !to) return alert("Fill both fields");
    Backend.connectUsers(from, to);
    Vis.addEdge(from, to);
    connectFromInput.value = "";
    connectToInput.value = "";
  });

  // making a transaction
  txForm.addEventListener("submit", (e) => {
    e.preventDefault();
    let from = txFrom.value.trim();
    let to = txTo.value.trim();
    let amount = parseInt(txAmount.value);
    if (amount < 0) return alert("Amount has to be positive");
    if (!from || !to || !amount) return alert("Fill all fields");
    alert(Backend.sendTransaction(from, to, amount));
    mempoolDiv.innerHTML = Backend.backend.showMempool().join("<br>");
    txFrom.value = "";
    txTo.value = "";
    txAmount.value = "";
  });

  // Mining a block
  mineBtn.onclick = async () => {
    if (!Vis.selectedUser) return alert("Select a node first!");

    mineStatus.innerHTML = `Mining...`;
    Vis.highlightNode(Vis.selectedUser!);

    try {
      let node = Backend.backend.getNode(Vis.selectedUser!);
      if (!node) {
        alert(`User ${Vis.selectedUser} not found.`);
        Vis.resetNodeColor(Vis.selectedUser!);
        return;
      }

      let mempool = Backend.backend.showMempool();
      if (!mempool || mempool.length === 0) {
        alert("No transactions to mine.");
        Vis.resetNodeColor(Vis.selectedUser!);
        mineStatus.innerHTML = "";
        return;
      }

      // Passing inputs to mine block
      let index = node.blockchain.chain.length;
      let previousHash = node.blockchain.getLatestBlock().hash;
      let timestamp = Date.now();
      let transactions = [...mempool];
      let baseData =
        index + previousHash + timestamp + JSON.stringify(transactions);

      let lastNonce = 0;

      let result = await startMining(
        baseData,
        Backend.backend.difficulty,
        (nonce: number) => {
          // Updating progress
          mineStatus.innerHTML = `Mining... Nonce: ${lastNonce}`;
          lastNonce = nonce;
        }
      );

      // finalise the mined block in the backend using the produced nonce/hash
      let finaliseMsg = Backend.finaliseMinedBlock(
        Vis.selectedUser!,
        result.nonce,
        result.hash,
        timestamp,
        transactions
      );

      mineStatus.innerHTML = `${finaliseMsg.replace(/\n/g, "<br>")}<br>
      Nonce: ${result.nonce}, Mining took ${result.time}ms`;

      setTimeout(() => Vis.resetNodeColor(Vis.selectedUser!), 500);

      mempoolDiv.innerHTML = Backend.backend.showMempool().join("<br>");
    } catch (err) {
      alert("Mining error: " + err);
    }
  };

  // Sidebar
  function updateSidebar() {
    if (!Vis.selectedUser) {
      balancesDiv.innerHTML =
        "<h3>Global Balances</h3>" +
        Backend.backend.showBalances().replace(/\n/g, "<br>");
      blockchainDiv.innerHTML = "<i>Select a node to see its blockchain</i>";
    } else {
      balancesDiv.innerHTML =
        `<h3>${Vis.selectedUser}</h3>` +
        Backend.backend.showBalances(Vis.selectedUser).replace(/\n/g, "<br>");
      blockchainDiv.innerHTML =
        `<h3>Blockchain</h3>` +
        Backend.backend.showChain(Vis.selectedUser).replace(/\n/g, "<br>");
    }
    mempoolDiv.innerHTML = Backend.backend.showMempool().join("<br>");
  }

  setInterval(updateSidebar, 0);

  // Propagating a block through the network by BFS or DFS
  propagateBFSBtn.onclick = () => {
    if (!Vis.selectedUser) return alert("Select a node first!");

    let result = Backend.propagate(Vis.selectedUser, "bfs");

    if (typeof result === "string") {
      alert(result);
      return;
    }

    animatePropagation(result);
  };

  propagateDFSBtn.onclick = () => {
    if (!Vis.selectedUser) return alert("Select a node first!");

    let result = Backend.propagate(Vis.selectedUser, "dfs");

    if (typeof result === "string") {
      alert(result);
      return;
    }

    animatePropagation(result);
  };

  function animatePropagation(order: string[]) {
    if (!order || order.length === 0) return;

    let i = 0;

    function step() {
      if (i < order.length) {
        // Highlight current node, leave previous highlighted nodes as they are
        Vis.highlightNodes([order[i]], {
          background: "#12bd1bff",
          border: "rgba(8, 222, 230, 1)",
        });
        i++;
        setTimeout(step, 400);
      } else {
        // After all nodes are highlighted, wait a bit then reset everything
        setTimeout(() => {
          Vis.resetNodes(order);
        }, 1000); // Reset all the nodes back to default colour
      }
    }

    step();
  }

  // Difficulty slider
  difficultyValue.textContent = Backend.backend.difficulty.toString();
  difficultySlider.oninput = () => {
    let newDifficulty = parseInt(difficultySlider.value);
    Backend.setDifficulty(newDifficulty);
    difficultyValue.textContent = newDifficulty.toString();
  };
}
