import { test, expect } from "bun:test";
import { fakeHash } from "./hash";

test("fakeHash produces the same hash for the same input", () => {
  expect(fakeHash("hello")).toBe(fakeHash("hello"));
});
test("fakeHash produces different hashes for different input")(
  "produces different hashes for different input",
  () => {
    expect(fakeHash("hello")).not.toBe(fakeHash("world"));
  }
);

test("fakehash matches known values", () => {
  expect(fakeHash("hi")).toBe("000009ea");
});
