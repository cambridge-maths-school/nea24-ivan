// @ts-ignore
import { test, expect } from "bun:test";
import { fakeHash } from "./hash.ts";

// Tests basic functionality and determinism
test("input: cat", () => {
  let hash = fakeHash("cat");
  expect(hash).toBe("0006e1d2");
});
test("input: hello", () => {
  let hash = fakeHash("hello");
  expect(hash).toBe("7ec11fce");
});

// Test for determinism
test("Always produces a string of length 8", () => {
  let hash = fakeHash("test");
  expect(typeof hash).toBe("string");
  expect(hash.length).toBe(8);
});

// Tests determinism
test("fakeHash produces the same hash for the same input", () => {
  expect(fakeHash("hello")).toBe(fakeHash("hello"));
});

// Another test for determinism
test("fakeHash is deterministic", () => {
  let input = "deterministic input";
  let hash1 = fakeHash(input);
  let hash2 = fakeHash(input);
  expect(hash1).toBe(hash2);
});

// Tests avalanche effect
test("Produces different hashes for different input", () => {
  expect(fakeHash("hello")).not.toBe(fakeHash("world"));
});

// Tests edge case handling for empty string
test("Empty string input", () => {
  let hash = fakeHash("");
  expect(typeof hash).toBe("string");
  expect(hash.length).toBe(8);
});
