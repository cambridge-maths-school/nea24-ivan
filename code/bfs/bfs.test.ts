import { expect, test } from "bun:test";
import { bfs_traverse } from "./bfs.ts";

let adjacencyList: object = {
  A: ["C", "B"],
  B: ["F", "A"],
  C: ["A", "D", "E"],
  D: ["C"],
  E: ["C"],
  F: ["B"],
};

test("Normal List", () => {
  let result = bfs_traverse(adjacencyList, "A");
  expect(result[0]).toBe("A");
  let layer2 = result.slice(1, 3).sort();
  expect(layer2).toEqual(["B", "C"]);
  let layer3 = result.slice(3).sort();
  expect(layer3).toEqual(["D", "E", "F"]);
});
