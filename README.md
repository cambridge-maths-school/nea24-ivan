# nea24-ivan
Hello World! 

Ideas:
- Graph plotting application like desmos, including features that desmos doesnt have, e.g. Newton Raphson
- Trajectory simulator
- Block Chain: Including packet switching/circuit switching features; encryption
- Neural Network for OCR from scratch
- Virtual Machine


Project Proposal:

1. Graph Plotting Application (something looking like Desmos but more enhanced)
- Allow users to input expressions like `y = sin(x)`, `y = x^2 + 3x - 4`, or implicit forms (`x^2 + y^2 = 25`).
- Features to include:
  - Cartesian, parametric, polar, and implicit plotting, complex numbers (e.g. arg(z), |z| that desmos doesn't have)
  - Zoom, pan, and grid toggling
  - Highlight intersections, turning points, asymptotes
  - Numerical methods tools that desmos doesn't have, e.g., Newton-Raphson root finding (visual iteration)
  - Display first/second derivatives and integrals as shaded areas
  - Add user-defined sliders (e.g. to animate transformations)
  - Graph inequalities (e.g. `y < x^2`)
  - Save and load graph states

2. Trajectory Physics Simulator
- Simulate projectile motion with user-defined parameters:
  - Initial speed, angle, height, mass
  - Air resistance (linear or quadratic drag)
  - Wind effects (vector inputs)

- Display:
  - 2D motion path in real time
  - Realistic vs ideal trajectory comparisons (e.g. ignoring drag)
  - Velocity, acceleration, and displacement graphs
	- Showing how the equation of trajectory changes throughout the trajection

- Physics models:
  - Use numerical integration
  - Vector decomposition of motion
  - Optional: bouncing/collisions with surfaces

- Extensions:
  - Target hitting mini-game
  - Multi-projectile comparisons
  - Trajectories on different planets (Mars, Moon, Earth, etc.)

3. Blockchain & Networking Simulator
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
- run in development with `bun index.html`
- build with `bun build ./index.html --outdir=dist`
- run a build with `bunx --bun serve dist`
- live website is at https://your-url-here.deno.dev using Deno Deploy