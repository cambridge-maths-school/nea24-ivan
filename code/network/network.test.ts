// @ts-ignore
import { expect, test } from "bun:test";
import { Node, Network } from "./network.ts";

// ====== Node Test =======
test("Adding new node to the network", () => {
  let Dave = new Node("Dave");
  let Alice = new Node("Alice");
  Dave.addNeighbour(Alice);
  expect(Dave.neighbours.includes(Alice));
  expect(Alice.neighbours.includes(Dave));
});

test("Adding a whole network", () => {
  let nodes: string[] = ["A", "B", "C", "D", "E", "F", "G", "H"];
  let users: Node[] = [];
  for (let node of nodes) {
    users.push(new Node(node));
  }
  for (let i = 0; i < users.length - 1; i++) {
    users[i].addNeighbour(users[i + 1]);
  }
  for (let i = 0; i < users.length - 1; i++) {
    expect(users[i].neighbours.includes(users[i + 1]));
  }
});
