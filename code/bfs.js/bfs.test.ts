import { expect, test } from "bun:test";
import { addition } from "./bfs.ts";

test("boomboom", () => {
  expect(addition(1, 2)).toBe(3);
  expect(addition(1, 3)).toBe(34);
});
