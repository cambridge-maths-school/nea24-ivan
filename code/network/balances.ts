export class Balances {
  private balances: Map<string, number> = new Map();
  private initialBalance: number;

  constructor(initialBalance: number = 100) {
    this.initialBalance = initialBalance;
    this.balances.set("system", 10000000);
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
    if (username === "system") return true;
    if (this.balances.has(username)) {
      return this.getBalance(username) >= amount;
    }
    return false;
  }

  applyTransaction(from: string, to: string, amount: number): void {
    if (
      (from !== "system" && !this.balances.has(from)) ||
      !this.balances.has(to)
    ) {
      throw new Error("Sender or receiver does not exist.");
    }
    if (from !== "system") {
      let fromBal = this.getBalance(from);
      this.balances.set(from, fromBal - amount);
    }
    let toBal = this.getBalance(to);
    this.balances.set(to, toBal + amount);
  }

  printBalances(username?: string): string {
    if (username && !this.balances.has(username) && username !== "system") {
      console.log(`User ${username} not found.`);
    }

    if (username && username !== "system") {
      let balance = this.balances.get(username);
      if (balance === undefined) {
        throw new Error(`User ${username} not found.`);
      } else {
        return `${username}: ${balance}`;
      }
    }

    if (this.balances.size === 1) {
      return "No users in network.";
    }
    let arr = "";
    for (let [user, balance] of this.balances.entries()) {
      if (user === "system") continue;
      arr += `${user}: ${balance}\n`;
    }
    return arr;
  }
}
