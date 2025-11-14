# nea24-ivan

Hello World!

Project Proposal:

Blockchain & Networking Simulator

- Blockchain system

  - Blocks hold transaction details
  - Each block is linked securely to the previous one using hashes (e.g. SHA256)
  - Mining to validate transactions and adds them to a blockchain
  - The system checks the whole chain to make sure it’s valid and can handle cases when two blocks are added at the same time (ACID)
  - New transactions wait in a queue before being added to a block

- Networking features:

  - Show how data moves through the network in two ways: packet switching/circuit switching
  - Visualize network setup, delays, and when data collides or gets lost
  - Simulate how nodes communicate, resend lost data, and handle slow connections

- Cryptography:

  - Make pairs of keys (one private, one public) to identify users and their wallets
  - Use these keys to securely sign and protect transactions before sending them
  - Keep track of wallet balances and prevent spending the same money twice (ACID)
  - Simulate a simple wallet system to manage money and keys

- Database:

  - Use a small database (like SQLite) to save all blockchain data and wallets so nothing is lost when closing the app (ACID)
  - Let the program search and verify past blocks easily

- Interface:
  - Show the blockchain as connected blocks and let users click to see details like transactions and hashes
  - Animate how transactions are created, signed, and sent through the network
  - Show the mining process live, including trying different nonces
  - Display logs of what’s happening in the network and blockchain for better understanding

Building and running code

- run in development with `bun server.ts --watch`
- build with `bun build ./index.html --outdir=dist`
- run a build with `bunx --bun serve dist`
- live website "https://ivan-nea.2024.compsci.me"
