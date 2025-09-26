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

function bfs_traverse(
  adjacencyList: AList,
  startNode: string
) {
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
export { bfs_traverse };
