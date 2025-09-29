interface AList {
  [key: string]: string[]
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
  A: ['C','H','I','N'],
  B: ['D','H','I', 'J', 'K'],
  C: ['A','E','L'],
  D: ['B','E','G','L','M'],
  E: ['C','D','G','J'],
  F: ['G'],
  G: ['D', 'E','F','H'],
  H: ['A','B','G'],
  I: ['A','B','M'],
  J: ['B','E'],
  K: ['B'],
  L: ['C','D'],
  M: ['D','I'],
  N: ['A','O'],
  O: ['N']
}


function dfs_traverse(
  adjacencyList: AList,
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
console.log(dfs_traverse(complicatedList, "M"));
export { dfs_traverse };