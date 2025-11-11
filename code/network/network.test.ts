// @ts-ignore
import { expect, test } from "bun:test";
import { Network } from "./network.ts";

// ====== Adding Users Test ======
test("Adding Users to the network", () => {
  let network = new Network();
  expect(network.addUser("Ada")).toBe("User Ada added.");
});

test("Adding Users to the network - Multiple requests", () => {
  let network = new Network();
  let num_of_users = 0;
  for (let i = 0; i < 1000; i++) {
    expect(network.addUser(`${i}`)).toBe(`User ${i} added.`);
    num_of_users += 1;
  }
  expect(num_of_users).toBe(1000);
});

test("Adding Users already exist", () => {
  let network = new Network();
  network.addUser("Ada");
  expect(network.addUser("Ada")).toBe(`User Ada already exists.`);
});

test("Adding Invalid User Types", () => {});
// =====
