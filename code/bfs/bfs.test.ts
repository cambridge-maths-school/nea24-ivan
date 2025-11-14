// @ts-ignore
import { expect, test } from "bun:test";
import { bfs_traverse } from "./bfs.ts";

interface AList {
  [key: string]: string[];
}

let normalList: AList = {
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

// Normal Test
test("Normal List", () => {
  let result = bfs_traverse(normalList, "A");
  expect(result[0]).toBe("A");
  let layer1 = result.slice(1, 3).sort();
  expect(layer1).toEqual(["B", "C"]);
  let layer2 = result.slice(3).sort();
  expect(layer2).toEqual(["D", "E", "F"]);
});

test("Normal List", () => {
  let result = bfs_traverse(normalList, "B");
  expect(result[0]).toBe("B");
  let layer1 = result.slice(1, 3).sort();
  expect(layer1).toEqual(["A", "F"]);
  let layer2 = result.slice(3).sort();
  expect(layer2).toEqual(["C", "D", "E"]);
});

test("Complicated List", () => {
  let result = bfs_traverse(complicatedList, "M");
  expect(result[0]).toBe("M");
  let layer1 = result.slice(1, 3).sort();
  expect(layer1).toEqual(["D", "I"]);
  let layer2 = result.slice(3, 8).sort();
  expect(layer2).toEqual(["A", "B", "E", "G", "L"]);
  let layer3 = result.slice(8, 14).sort();
  expect(layer3).toEqual(["C", "F", "H", "J", "K", "N"]);
  let layer4 = result.slice(14).sort();
  expect(layer4).toEqual(["O"]);
});

// Boundary Test
test("Boundary Test: Single Node Graph", () => {
  let singleNodeList: AList = { A: [] };
  let result = bfs_traverse(singleNodeList, "A");
  expect(result).toEqual(["A"]);
});

test("Boundary Test: Disconnected Graph", () => {
  let disconnectedList: AList = {
    A: ["B"],
    B: ["A"],
    C: ["D"],
    D: ["C"],
  };
  let result = bfs_traverse(disconnectedList, "A");
  expect(result).toEqual(["A", "B"]);
});

test("Boundary Test: Empty Adjacency List", () => {
  let emptyList: AList = {};
  let result = bfs_traverse(emptyList, "A");
  expect(result).toEqual(["A"]);
});

test("Boundary Test: Cyclic Graph", () => {
  let cyclicList: AList = {
    A: ["B"],
    B: ["C"],
    C: ["A"],
  };
  let result = bfs_traverse(cyclicList, "A");
  expect(result).toEqual(["A", "B", "C"]);
});

// Erroneous Test
test("Erroneous Test: Non-existent Start Node", () => {
  let result = bfs_traverse(normalList, "Z");
  expect(result).toEqual(["Z"]);
});

test("Erroneous Test: unexpected input types", () => {
  // @ts-ignore
  let result = bfs_traverse(200, 400);
  expect(result).toEqual([null]);
});
