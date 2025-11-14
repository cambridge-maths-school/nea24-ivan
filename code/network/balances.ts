export class Balances {
  private balances: Map<string, number> = new Map();
  private initialBalance: number;

  constructor(initialBalance: number = 100) {
    this.initialBalance = initialBalance;
  }

  addUser(username: string) {
    if (!this.balances.has(username)) {
      this.balances.set(username, this.initialBalance);
    }
  }

  getBalance(username: string): number {
    return this.balances.get(username) ?? 0;
  }

  hasFunds(username: string, amount: number): boolean {
    return this.getBalance(username) >= amount;
  }

  applyTransaction(from: string, to: string, amount: number) {
    if (from !== "system") {
      let fromBal = this.getBalance(from);
      this.balances.set(from, fromBal - amount);
    }
    let toBal = this.getBalance(to);
    this.balances.set(to, toBal + amount);
  }

  printBalances(username?: string) {
    console.log("=== Balances ===");

    if (username) {
      let balance = this.balances.get(username);
      if (balance === undefined) {
        console.log(`User ${username} not found.`);
      } else {
        console.log(`${username}: ${balance}`);
      }
      return;
    }

    if (this.balances.size === 0) {
      console.log("No users in network.");
      return;
    }

    for (let [user, balance] of this.balances.entries()) {
      console.log(`${user}: ${balance}`);
    }
  }
}
