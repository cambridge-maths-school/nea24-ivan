import { expect, test } from "bun:test";
import { bfs_traverse } from "./bfs.ts";

interface AList {
  [key: string]: string[]
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
  A: ['H','I','N']
  B: ['D','H','I','K'],

}

test("Normal List", () => {
  let result = bfs_traverse(normalList, "A");
  expect(result[0]).toBe("A");
  let layer2 = result.slice(1, 3).sort();
  expect(layer2).toEqual(["B", "C"]);
  let layer3 = result.slice(3).sort();
  expect(layer3).toEqual(["D", "E", "F"]);
});
