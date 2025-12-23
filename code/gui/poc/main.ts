import { DataSet, Network } from "vis-network/standalone";

let container = document.getElementById("network")!;
export let nodes: any;
export let edges: any;

// Initial graph
nodes = new DataSet([
  { id: "A", label: "A" },
  { id: "B", label: "B" },
  { id: "C", label: "C" },
]);

edges = new DataSet([
  { from: "A", to: "B" },
  { from: "B", to: "C" },
  { from: "A", to: "C" },
]);

// Graph setup
let network = new Network(
  container,
  { nodes, edges },
  {
    physics: {
      enabled: true,
    },
    interaction: {
      dragNodes: true,
      dragView: true,
      hover: true,
      selectConnectedEdges: true,
    },
  }
);

// Dynamic Testing
setTimeout(() => {
  nodes.add({ id: "D", label: "D" });
  edges.add({ from: "A", to: "D" });

  nodes.add({ id: "E", label: "E" });
  edges.add({ from: "E", to: "C" });
}, 2000);
