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
  let users = [];
  for (let node of ["A", "B", "C"]) {
    users.push(new Node(node));
  }
  console.log(users[0]);
});

// // ====== Adding Users Test ======
// test("Adding Users to the network", () => {
//   let network = new Network();
//   expect(network.addUser("Ada")).toBe("User Ada added.");
// });

// test("Adding Users to the network - Multiple requests", () => {
//   let network = new Network();
//   let num_of_users = 0;
//   for (let i = 0; i < 1000; i++) {
//     expect(network.addUser(`${i}`)).toBe(`User ${i} added.`);
//     num_of_users += 1;
//   }
//   expect(num_of_users).toBe(1000);
// });

// test("Adding Users already exist", () => {
//   let network = new Network();
//   network.addUser("Ada");
//   expect(network.addUser("Ada")).toBe(`User Ada already exists.`);
// });

// test("Adding Invalid User Types", () => {});
// // =====
