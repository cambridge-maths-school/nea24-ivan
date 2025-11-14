// type Nodes = "A" | "B" | "C" | "D" | "E" | "F";

interface AList {
  [key: string]: string[];
}

let adjacencyList: AList = {
  A: ["C", "B"],
  B: ["F", "A"],
  C: ["A", "D", "E"],
  D: ["C"],
  E: ["C"],
  F: ["B"],
};

let complicatedList: AList = {
  A: ["C", "H", "I", "N"],
  B: ["D", "H", "I", "J", "K"],
  C: ["A", "E", "L"],
  D: ["B", "E", "G", "L", "M"],
  E: ["C", "D", "G", "J"],
  F: ["G"],
  G: ["D", "E", "F", "H"],
  H: ["A", "B", "G"],
  I: ["A", "B", "M"],
  J: ["B", "E"],
  K: ["B"],
  L: ["C", "D"],
  M: ["D", "I"],
  N: ["A", "O"],
  O: ["N"],
};

function bfs_traverse(adjacencyList: AList, startNode: string): string[] {
  // Defensive type check for completely invalid inputs
  if (typeof adjacencyList !== "object" || typeof startNode !== "string") {
    // @ts-ignore
    return [null];
  }

  // Initialise the queue and mark the starting node as visited
  let queue: string[] = [startNode];
  let visited: string[] = [startNode];

  // Continue exploring while there are nodes left in the queue
  while (queue.length) {
    // Dequeue the next node to explore
    let node: string = queue.shift() ?? "";
    if (!node) continue;
    // Skip nodes not in the adjacency list
    if (!(node in adjacencyList)) continue;

    // Explore each unvisited neighbour of the current node
    for (let neighbour of adjacencyList[node]) {
      if (!visited.includes(neighbour)) {
        visited.push(neighbour);
        queue.push(neighbour); // Enqueue neighbour for later exploration
      }
    }
  }

  // Return the order in which nodes were visited
  return visited;
}

// console.log(bfs_traverse(adjacencyList, "C"));
// console.log(bfs_traverse(complicatedList, "M"));
export { bfs_traverse };
