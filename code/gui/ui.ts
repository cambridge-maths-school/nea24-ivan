import * as Backend from "./backend.ts";
import * as Vis from "./visManager.ts";

export function initUI() {
  let usernameInput = document.getElementById(
    "usernameInput"
  ) as HTMLInputElement;
  let addUserBtn = document.getElementById("addUserBtn")!;
  let connectFromInput = document.getElementById(
    "connectFrom"
  ) as HTMLInputElement;
  let connectToInput = document.getElementById("connectTo") as HTMLInputElement;
  let connectBtn = document.getElementById("connectBtn")!;
  let txFrom = document.getElementById("txFrom") as HTMLInputElement;
  let txTo = document.getElementById("txTo") as HTMLInputElement;
  let txAmount = document.getElementById("txAmount") as HTMLInputElement;
  let sendTxBtn = document.getElementById("sendTxBtn")!;
  let mineBtn = document.getElementById("mineBtn")!;
  let mineStatus = document.getElementById("mineStatus")!;
  // TODO: Propagation
  let propagateBFSBtn = document.getElementById("propagateBFS")!;
  let propagateDFSBtn = document.getElementById("propagateDFS")!;
  let balancesDiv = document.getElementById("balances")!;
  let blockchainDiv = document.getElementById("blockchain")!;
  let mempoolDiv = document.getElementById("mempool")!;

  // --- ADD USER ---
  addUserBtn.onclick = () => {
    let username = usernameInput.value.trim();
    if (!username) return;

    if (Vis.nodes.length > 0 && !Vis.selectedUser) {
      alert("Select a user first to attach the new user!");
      return;
    }

    let res = Backend.addUser(username);
    alert(res);
    Vis.addNode(username, username);

    if (Vis.selectedUser) {
      Backend.connectUsers(Vis.selectedUser, username);
      Vis.addEdge(Vis.selectedUser, username);
    }

    usernameInput.value = "";
  };

  // --- CONNECT USERS ---
  connectBtn.onclick = () => {
    let from = connectFromInput.value.trim(),
      to = connectToInput.value.trim();
    if (!from || !to) return alert("Fill both fields");
    Backend.connectUsers(from, to);
    Vis.addEdge(from, to);
    connectFromInput.value = "";
    connectToInput.value = "";
  };

  // --- SEND TRANSACTION ---
  sendTxBtn.onclick = () => {
    let from = txFrom.value.trim(),
      to = txTo.value.trim(),
      amount = parseInt(txAmount.value);
    if (!from || !to || !amount) return alert("Fill all fields");
    alert(Backend.sendTransaction(from, to, amount));
    mempoolDiv.innerHTML = Backend.backend.showMempool().join("<br>");
  };

  // --- MINING ---
  mineBtn.onclick = async () => {
    if (!Vis.selectedUser) return alert("Select a node first!");
    mineStatus.innerHTML = "Mining...";
    try {
      let result = await Backend.mineUser(Vis.selectedUser);
      mineStatus.innerHTML = result.replace(/\n/g, "<br>");
      Vis.highlightNode(Vis.selectedUser);
      setTimeout(() => Vis.resetNodeColor(Vis.selectedUser!), 500);
      mempoolDiv.innerHTML = Backend.backend.showMempool().join("<br>");
    } catch (err) {
      alert("Mining error: " + err);
    }
  };

  // --- SIDEBAR UPDATE ---
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

  // --- PROPAGATION ---
  // TODO
}
