// type Nodes = "A" | "B" | "C" | "D" | "E" | "F";

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

function bfs_traverse(
  adjacencyList: AList,
  startNode: string
): string[] {
  // enqueue starting node
  let queue: string[] = [startNode];
  let visited: string[] = [startNode];

  while (queue.length) {
    let node: string = queue.shift() ?? "";
    if (!node) continue;
    for (let neighbour of adjacencyList[node]) {
      if (!visited.includes(neighbour)) {
        visited.push(neighbour);
        queue.push(neighbour);
      }
    }
  }
  return visited;
}

console.log(bfs_traverse(adjacencyList, "A"));
console.log(bfs_traverse(complicatedList, "M"))
export { bfs_traverse };
