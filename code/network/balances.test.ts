// @ts-ignore
import { expect, test } from "bun:test";
import { Balances } from "./balances.ts";

// ====== Adding Users Test ====== (addUser() and getBalance())
test("Adding Users to the network", () => {
  let balances = new Balances();
  balances.addUser("Ada");
  expect(balances.getBalance("Ada")).toBe(100);
  balances.addUser("Bob");
  expect(balances.getBalance("Bob")).toBe(100);
  // Mutiple users
  for (let i = 0; i < 10; i++) {
    balances.addUser(`User${i}`);
    expect(balances.getBalance(`User${i}`)).toBe(100);
  }
});

// ======= hasFunds() ======
test("hasFunds()", () => {
  let balances = new Balances();
  balances.addUser("Alice");
  console.log(balances.getBalance("Alice"));
  expect(balances.hasFunds("Alice", 50)).toBe(true);
  expect(balances.hasFunds("Alice", 150)).toBe(false);
  expect(balances.hasFunds("Bob", 10)).toBe(false); // Bob does not exist
});

// ======= applyTransaction() ======
test("applyTransaction()", () => {
  let balances = new Balances();
  balances.addUser("Alice");
  balances.addUser("Bob");

  // Alice pays Bob 30 coins
  balances.applyTransaction("Alice", "Bob", 30);
  expect(balances.getBalance("Alice")).toBe(70);
  expect(balances.getBalance("Bob")).toBe(130);

  // Bob pays Alice 50 coins
  balances.applyTransaction("Bob", "Alice", 50);
  expect(balances.getBalance("Alice")).toBe(120);
  expect(balances.getBalance("Bob")).toBe(80);
});

// ======= printBalances() ======
test("printBalances() - Specific User", () => {
  let balances = new Balances();
  balances.addUser("Alice");
  balances.addUser("Bob");

  expect(balances.printBalances("Alice")).toBe("Alice: 100");
  expect(balances.printBalances("Bob")).toBe("Bob: 100");
  expect(() => {
    balances.printBalances("Charlie");
  }).toThrowError("User Charlie not found.");
});
test("printBalances() - All Users", () => {
  let balances = new Balances();
  balances.addUser("Alice");
  balances.addUser("Bob");

  let allBalances = balances.printBalances();
  expect(allBalances).toContain("Alice: 100");
  expect(allBalances).toContain("Bob: 100");
});
