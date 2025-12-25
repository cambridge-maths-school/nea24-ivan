export let visNetwork: any;
export let nodes: any;
export let edges: any;
export let selectedUser: string | null = null;
selectedUser = "A";
export function initVisNetwork(containerId: string) {
  // @ts-ignore
  nodes = new vis.DataSet([]);
  // @ts-ignore
  edges = new vis.DataSet([]);
  let container = document.getElementById(containerId)!;

  // @ts-ignore
  // Graph properties
  visNetwork = new vis.Network(
    container,
    { nodes, edges },
    {
      physics: { enabled: true },
      interaction: {
        dragNodes: true,
        dragView: true,
        zoomView: true,
        hover: true,
      },
      nodes: {
        shape: "circle",
        size: 30,
        font: { color: "#fff", face: "Arial", multi: false },
        borderWidth: 2,
        color: {
          background: "#0077ff",
          border: "#fff",
          highlight: { background: "#0af", border: "#ff0" },
        },
        labelHighlightBold: true,
      },
      edges: { color: "#777", width: 2, smooth: { type: "dynamic" } },
    }
  );

  // Selecting/Deselecting node
  visNetwork.on("click", (params: any) => {
    if (params.nodes.length > 0) {
      if (selectedUser) resetNodeColor(selectedUser);
      selectedUser = params.nodes[0];
      if (selectedUser) highlightNode(selectedUser);
    } else if (selectedUser) {
      resetNodeColor(selectedUser);
      selectedUser = null;
    }
  });
  // addNode("A", "A");
  // addEdge("A", "B");
  // addNode("B", "B");
  // addNode("C", "C");
  // addEdge("B", "C");
  // // addNode("D", "D");
  // // addEdge("B", "D");
  // // addEdge("D", "B");
  // // addEdge("C", "C");

  // // for (let i = 0; i < 1000; i++) {
  // //   addNode(i.toString(), i.toString());
  // // }
  // // for (let i = 0; i < 900; i++) {
  // //   addEdge(i.toString(), (i + 1).toString());
  // // }
}

export function addNode(id: string, label: string) {
  nodes.add({ id, label });
}

export function addEdge(from: string, to: string) {
  edges.add({ id: `${from}-${to}`, from, to, color: "#777" });
}

export function highlightNode(id: string) {
  nodes.update({ id, color: { background: "#0077ff", border: "#ff0" } });
}

export function resetNodeColor(id: string) {
  nodes.update({ id, color: { background: "#0077ff", border: "#fff" } });
}

interface VisNode {
  id: string | number;
  label: string;
}

// Changing colour of multiple nodes
export function highlightNodes(
  usernames: string[],
  color: { background: string; border: string }
) {
  (nodes.get() as VisNode[]).forEach((node) => {
    if (usernames.includes(node.label)) {
      nodes.update({ id: node.id, color });
    }
  });
}

// Reset multiple nodes colour
export function resetNodes(usernames: string[]) {
  highlightNodes(usernames, { background: "#0077ff", border: "#fff" });
}
