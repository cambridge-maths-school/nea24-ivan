// @ts-ignore
import { expect, test } from "bun:test";
import { dfs_traverse } from "./dfs.ts";

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
  let result = dfs_traverse(normalList, "A");
  expect(result).toEqual(["A", "C", "D", "E", "B", "F"]);
});

test("Complicated List", () => {
  let result = dfs_traverse(complicatedList, "M");
  expect(result).toEqual([
    "M",
    "D",
    "B",
    "H",
    "A",
    "C",
    "E",
    "G",
    "F",
    "J",
    "L",
    "I",
    "N",
    "O",
    "K",
  ]);
});

// Boundary Test
test("Boundary Test: Single Node Graph", () => {
  let singleNodeList: AList = { A: [] };
  let result = dfs_traverse(singleNodeList, "A");
  expect(result).toEqual(["A"]);
});

test("Boundary Test: Disconnected Graph", () => {
  let disconnectedList: AList = {
    A: ["B"],
    B: ["A"],
    C: ["D"],
    D: ["C"],
  };
  let result = dfs_traverse(disconnectedList, "A");
  expect(result).toEqual(["A", "B"]);
});

test("Boundary Test: Empty Adjacency List", () => {
  let emptyList: AList = {};
  let result = dfs_traverse(emptyList, "A");
  expect(result).toEqual(["A"]);
});

test("Boundary Test: Cyclic Graph", () => {
  let cyclicList: AList = {
    A: ["B"],
    B: ["C"],
    C: ["A"],
  };
  let result = dfs_traverse(cyclicList, "A");
  expect(result).toEqual(["A", "B", "C"]);
});

// Erroneous Test
test("Erroneous Test: Non-existent Start Node", () => {
  let result = dfs_traverse(normalList, "Z");
  expect(result).toEqual(["Z"]);
});

test("Erroneous Test: unexpected input types", () => {
  // @ts-ignore
  let result = dfs_traverse(200, 400);
  expect(result).toEqual([null]);
});
