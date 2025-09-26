let adjacencyList: object = {
  A: ["C", "B"],
  B: ["F", "A"],
  C: ["A", "D", "E"],
  D: ["C"],
  E: ["C"],
  F: ["B"],
};

function dfs_traverse(
  adjacencyList: object,
  node: string,
  visited: string[] = []
): string[] {
  if (!visited.includes(node)) {
    visited.push(node);
  }

  for (let neighbour of adjacencyList[node]) {
    if (!visited.includes(neighbour)) {
      dfs_traverse(adjacencyList, neighbour, visited);
    }
  }

  return visited;
}

console.log(dfs_traverse(adjacencyList, "A"));
export { dfs_traverse };
