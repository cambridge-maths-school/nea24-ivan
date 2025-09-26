let adjacencyList: object = {
  A: ["C", "B"],
  B: ["F", "A"],
  C: ["A", "D", "E"],
  D: ["C"],
  E: ["C"],
  F: ["B"],
};

function bfs_traverse(adjacencyList: object, startNode: string) {
  // enqueue starting node
  let queue: string[] = [startNode];
  let visited: string[] = [startNode];

  while (queue.length) {
    if (!node) continue;
    let node: string[] = queue.shift();
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
