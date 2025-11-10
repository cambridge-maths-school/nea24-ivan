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

function dfs_traverse(
  adjacencyList: AList,
  startNode: string,
  visited: string[] = []
): string[] {
  // Defensive type check for completely invalid inputs
  if (typeof adjacencyList !== "object" || typeof startNode !== "string") {
    // @ts-ignore
    return [null];
  }
  // Return the start startNode even if it doesn't exist in the graph
  if (!adjacencyList[startNode]) {
    return [startNode];
  }

  // Skip startNodes that do not exist in the adjacency list
  if (!(startNode in adjacencyList)) return visited;

  // Mark the current startNode as visited
  if (!visited.includes(startNode)) {
    visited.push(startNode);
  }

  // Recursively visit each unvisited neighbour
  for (let neighbour of adjacencyList[startNode]) {
    if (!visited.includes(neighbour)) {
      dfs_traverse(adjacencyList, neighbour, visited);
    }
  }

  return visited;
}

// console.log(dfs_traverse(adjacencyList, "A"));
// console.log(dfs_traverse(complicatedList, "M"));
export { dfs_traverse };
