#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import fletcher.shapes: diamond

#set heading(numbering: "1.")
#show heading: set text(blue)

// headers and footers
#set par(spacing: 1em)
#set page(
  margin: (top: 2cm, bottom: 2cm),
  header: [
    Ivan Leung
    #h(1fr)
    Candidate Number: 4022
    #h(1fr)
    Centre Number: 22245
    #v(-1.25em)
  ]
    + line(length: 100%),
  footer: line(length: 100%)
    + context [
      #v(-1.25em)
      H446
      #h(1fr)
      Page #counter(page).display("1 of 1", both: true)
      #h(1fr)
      2026
    ],
)

// setting stuff
#set par(spacing: 2em)
#set list(
  spacing: 0.5em,
  indent: 1em,
)
#show figure.caption: set text(size: 0.7em)

// bigger headings
#show heading.where(level: 1): set text(size: 30pt)
#show heading.where(level: 2): set text(size: 20pt)

// more margin under headings
#show heading.where(level: 1): set block(below: 1em)
#show heading.where(level: 2): set block(below: 1em)

// start each L1/L2 heading on a new page (ie with a page break before it)
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}
#show heading.where(level: 2): it => {
  pagebreak(weak: true)
  it
}


// format code blocks with line numbers
#show raw.where(block: true): code => {
  show raw.line: line => {
    text(fill: luma(120))[~#line.number]
    h(1em)
    line.body
  }
  code
}

// format code blocks with a background and margin
#show raw.where(block: true): block.with(fill: luma(240), inset: 1em, radius: 0.5em, width: 100%)

// format inline code as well
#show raw.where(block: false): box.with(fill: luma(240), inset: (x: 3pt), outset: (y: 5pt), radius: 0.5em)

// ------------------ document setup finished ----

// a nicely formatted title page

#align(center + horizon)[
  #set text(navy, size: 50pt)
  *BlockChain Simulator*\
  #set text(size: 20pt, style: "italic")
]

#text[
  #set text(size: 20pt)
  Candidate name: Ivan Leung\
  Candidate number: 4022\
  Centre name: 22245\
  Qualification code: H446\
  Year: 2026
]


#outline()

= Analysis <sec:introduction>
== The Problem <the-problem>
Blockchain is a rapidly growing technology that underpins cryptocurrencies, NFTs, and secure digital record-keeping. Blockchain and Cryptography area mong the most in-demand STEM skills in the post-web economy. According to a new report from POST, UK Parliament, nearly half of engineering and tech businesses are struggling to recruit skilled talent. STEM skills shortages are costing the UK economy £1.5 billion per year [#footnote[source: medium (https://britblockchain.medium.com/uk-faces-stem-talent-shortage-as-demand-for-blockchain-skills-surges-says-parliamentary-report-ca626c0f5928)]]. Despite its increasing importance in finance, computing, and data security, understanding how blockchain works is conceptually challenging for most students. Key concepts such as distributed ledgers, mining, proof-of-work, hashing, and peer-to-peer networks are often abstract and difficult to visualise. This creates a barrier to learning, especially when students encounter blockchain only through media or cryptocurrency hype, without practical experience. Consequently, there is a need for an educational tool that allows students to interact with and visualise blockchain mechanics in a safe, simplified, and engaging way.

== Research
Blockchain is a distributed ledger technology that records transactions across a network of nodes. Each block is a container for multiple transactions, linked to the previous block via a cryptographic hash. New blocks are added through mining, a process where participants solve a computational puzzle (Proof-of-Work). Miners are incentivized with rewards, such as cryptocurrency and transaction fees, for successfully adding a valid block to the chain.


Research in Blockchain Technology: \
I gained knowledge on the blockchain technologies after watching this #link("https://youtu.be/bBC-nXj3Ng4?si=7UgRxuPQdJOzkzG4")[YouTube video] [#footnote[https://youtu.be/bBC-nXj3Ng4?si=7UgRxuPQdJOzkzG4]] by #link("https://www.youtube.com/@3blue1brown")[3Blue1Brown] which explains how blockchain technologies work behind the scene and different algorithms to power it. I also confirmed my knowledge with the winner of award of distinction in the Hong Kong BlockChain Olympiad - Lester Chong by asking him questions to clearly understand the concepts behind blockchain technologies.

Here are my summary to some main concepts in Blockchain technology:

1. Transactions

A transaction represents a transfer of value or information between users. Each transaction typically includes:
- Sender and receiver addresses
- Amount or data being transferred
- Digital signature to verify authenticity
Transactions are first broadcast to the network and stored in the mempool, a collection of unconfirmed transactions awaiting inclusion in a block.

2. Transaction Validity
Transactions must satisfy several criteria before being considered valid. Miners only include valid transactions in blocks.

Algorithm: Validate Transaction \
Input: Transaction T, Blockchain ledger L \
Output: Valid or Invalid

Algorithm flowchart - see next page
#figure(
move(dx:3em, dy:-10em)[
#scale(x: 70%,y:70%)[
  #diagram(
    node-stroke: 1pt,
    node((0, 0), [Start], corner-radius: 2pt, extrude: (0, 3)),
    edge("-|>"),
    node(
      (0, 1),
      align(center)[
        Verify \ T.signature using sender's \ public key
      ],
      shape: diamond,
    ),
    edge("d,d", "-|>", [Valid], label-pos: 0.5),
    edge("r,r", "-|>", [Invalid], label-pos: 0.7),
    node(
      (2, 1),
      align(center)[
        Reject the \ transaction
      ],
      shape: rect,
    ),
    node(
      (0, 3),
      align(center)[
        Check sender's \ balance
      ],
      shape: diamond,
    ),
    edge("r,r", "-|>", [If L\u{2264}T.amount], label-pos: 0.4),
    edge("d,d", "-|>", [If L\u{2265}T.amount], label-pos: 0.4),
    node(
      (2, 3),
      align(center)[
        Reject the \ transaction
      ],
      shape: rect,
    ),
    node(
      (0, 5),
      align(center)[
        Ensure T \ does not double-spend \ coins already spent \ in L
      ],
      shape: diamond,
    ),
    edge("d,d", "-|>", [No Double spending isues], label-pos: 0.5),
    edge("r,r", "-|>", [Double\ spending\ detected], label-pos: 0.6),
    node(
      (2, 5),
      align(center)[
        Reject the \ transaction
      ],
      shape: rect,
    ),
    node(
      (0, 7),
      align(center)[
        \ Check transaction \ structure (fields, \ format, protocol rules) \ ‎
      ],
      shape: diamond,
    ),
    edge("d,d", "-|>", [Valid], label-pos: 0.6),
    edge("r,r", "-|>", [Invalid], label-pos: 0.7),
    node(
      (2, 7),
      align(center)[
        Reject the \ transaction
      ],
      shape: rect,
    ),
    node(
      (0, 9),
      align(center)[
        All check pass
      ],
      shape: rect,
    ),
    edge("d", "-|>", label-pos: 0.7),
    node(
      (0, 10),
      align(center)[
        Add to mempool
      ],
      shape: rect,
    ),
    edge("d", "-|>", label-pos: 0.7),
    node((0, 11), [End], corner-radius: 2pt, extrude: (0, 3)),
  )]],
  caption: [Algorithm flowchart to validate a transaction]
  )

3. Block and block structure
A block is a container for transactions and metadata. Each block contains:
+ Multiple transactions from the mempool
+ Previous block hash — linking the block to its predecessor
+ Timestamp — recording creation time
+ Nonce — Number used Once; adjusted during mining to solve the Proof-of-Work puzzle
+ Block hash — a cryptographic hash of all block contents
\
4. Hashing

Blocks are uniquely identified using a cryptographic hash function (e.g., SHA-256).\ 
Algorithm: Compute Block Hash
Input: Block B (transactions, previous hash, timestamp, nonce)
Output: Block hash H
1. Concatenate block transactions, previous hash, timestamp, and nonce
2. Apply SHA-256 hash function
3. Output fixed-length hash 
Properties of cryptographic hashes:
- Deterministic: Same input always produces the same hash
- Irreversible: Impossible to deduce the original input from the hash
- Sensitive: Any change in the input drastically changes the output (avalanche effect)

5. Mining and Proof of Work
Mining involves finding a nonce so that the block hash meets a difficulty target, typically requiring a certain number of leading zeros in binary. One of the mining algorithm is the proof of work mining.

Algorithm: Proof of Work Mining\
Input: Block B, Difficulty D\
Output: Valid nonce, block hash\
`// Pseudocode algorithm
1. Set nonce = 0
2. Repeat:
    a. Compute hash H = SHA-256(B.transactions + B.previousHash + B.timestamp + nonce)
    b. Convert H to binary
    c. Count leading zeros LZ in binary H
    d. If LZ ≥ D:
        - Stop: valid nonce found
    e. Else:
        - Increment nonce by 1
3. Return valid nonce and hash H
`

When a valid nonce (an arbitrary number that can be used just once in a cryptographic communication) is found, the block is broadcast to the network for inclusion in the blockchain. There are also other mining algorithms such as the proof of stake algorithm.

6. Peer to Peer network
Blockchain relies on a decentralized peer-to-peer (P2P) network. Each node maintains a copy of the blockchain and independently verifies transactions and blocks.

Transaction propagation in P2P network:\
Input: Transaction T\
Output: Broadcast to network\
`1. User signs and sends T to a connected node
2. Node verifies T:
   - If valid, add to local mempool
   - If invalid, discard
3. Node forwards T to all connected peers
4. Iterate steps 2-3 for each peer`

Block propagation in p2p network:\
Input: Mined Block B\
Output: Network consensus\
`1. Miner broadcasts B to connected peers
2. Each peer verifies:
   a. Block hash meets difficulty
   b. Transactions are valid
   c. Previous hash matches last block in local chain
3. If valid, peer appends B to local blockchain
4. Peer forwards B to all its connected peers until it reaches everyone in the network`

#[
  #set par(spacing: 1em)
7. Block linking and immutability 
- Each block contains the hash of the previous block, forming a cryptographically linked chain.
- Altering a block invalidates all subsequent blocks, making tampering computationally infeasible.
- Only blocks meeting the Proof-of-Work and containing valid transactions are accepted by the network.
]
Conceptual Flowchart:\
I created the flowchart below to visualise the workflow of a blockchain:
#figure(
  image("images/blockchain_conceptual_flowchart.png", width: 85%),
  caption: [Conceptual flowchart of blockchain workflow.],
)
== Existing models
I found this blockchain simulator Command Line Interface (CLI) on GitHub (https://github.com/0xs34n/blockchain) by Sean. I have forked the repository and ran it on my local machine using `node.js`. The simulator offers a basic understanding of blockchain technologies with features like possessing blockchains and connecting to peers in different networks. However, it doesn't contain features such as transactions of blockchains or the process of mining blockchains.
#image("images/SeanCLI.png")
#image("images/SeanP2P.png")
In this image, Sean's Blockchain simulator has shown the connection between different ports in local host. However, there is not any features that allow different ports to interact, like trading blocks. It also doesn't allow user to see other's user blocks.

Many of the simulators out allows you to change the content in a blockchain but this is not a realistic feature as in real life, once a block is mined and added to the blockchain, it is immutable and cannot be changed. This is misleading for learners as they might think that blocks in a blockchain can be changed.
== Initial Features
In this BlockChain Simulator project, I will build a simplified model of BlockChain and mainly focusing on visualisation of different technologies, so that learners would be able to easily understand them.

The final project will be running on a browser and has a Graphical User Interface (GUI). The project will be developed in HTML, CSS, and TypeScript with web workers. This allows the nonce to be rendered faster and also better simulate how blockchains are being mined as this is usually being done by a crypto mining rig - a customised personal computer that uses multicore CPU/GPU to solve cryptographic equations and verify transactions on a blockchain.

Features
1. Core Blockchain Mechanics
- Block structure \u{27F6} index, timestamp, list of transactions, previous hash, nonce, and current hash, implemented by Object Oriented Programming OOP
- Hashing algorithm \u{27F6} a simplified SHA-256 function
- Mining algorithm \u{27F6} find a nonce such that block hash starts with N zeros (difficulty)
- Transaction system \u{27F6} sender, receiver, amount stored in a mempool before being mined, also implemented by OOP
- Chain validation \u{27F6} check each block's previous_hash matches the last block's hash


2. Network Simulation (Peer-to-Peer)
- Each node has its own blockchain copy
- Nodes are connected in an undirected graph
- When a transaction or block is created, it is propagated to all nodes via Breadth First Search (BFS) or Depth First Search (DFS) traversal
- New nodes can join by connecting to at least one existing node

3. Visualisation
- Blockchain view \u{27F6} show blocks as boxes linked in a chain.
- Each block displays: index, hash, previous hash, transactions.
- Mempool view \u{27F6} list of pending transactions waiting to be mined.


4. Abstraction 
- Ignoring Double Spending Issues during Chain Validation
- No digital signatures (trust all transactions)
- No forks (always extend the longest chain)
- Assume honest nodes (no attackers)

Controls (buttons):
- "Add Transaction" \u{27F6} enter sender, receiver, amount
- "Mine Block" \u{27F6} mines transactions into a block
- "Propagate Transaction" \u{27F6} spreads it across nodes
- Network view \u{27F6} graph of nodes (circles), with edges showing connections

=== Project Management Methodology
The solution will be developed in an agile way. This means that it will be developed in different iterations. The analysis of requirements has been done in this section (Section 1).
In each iterations I will
- Design the prototype for that iteration
- Build the prototype
- Asking for User Feedback
- Refine prototype
Each feature of the solution might be improved throughout the iterations.
=== Technology 
The simulator will run purely on client side code to reduce server costs and workload, improve scalability, and create a more interactive and responsive user experience\
Frontend: HTML + CSS + JavaScript \ 
Graph visualisation: canvas
=== Device Compatibility 
The blockchain simulator is designed to run entirely in the browser and therefore requires TypeScript support to function. It is optimised for modern desktop and laptop environments using Chromium-based browsers (Google Chrome, Microsoft Edge, Opera). Mobile browsers may support basic interaction, but performance and visualisation features are best experienced on computer systems. The device running to program should have at least a refresh rate of 60Hz to run the requestAnimationFrame() function in canvas to visualise blockchain workflow.

== Intital Sucess Criteria
These are the initial Success Criteria (SC) which is what I am aiming for while developing a MVP (Minimum Viable Product). As I am developing in an agile methodology, the Success Critea might be ammended or new Success Criteria might be added in the process of iterations.

Success Criteria
#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header([*SC*], [*Target*], [*Testing*]),
  $ 1.1 $, [GUI], $ sqrt(2) / 12 a^3 $,
  $ 1.2 $,
)
== Stakeholders <stakeholders>
Primary Stakeholders:
\ \  Students: They are the main users of the simulator  
=== Survey
=== Interview
= Iterations
== Iteration 1
In Interation 1, I will be focusing on the proof of concept for the technologies that I will be using in my blockchain simulator.
=== Goal
+ Proof of concept for Breadth First Search (BFS) and Depth First Search (DFS) so that I can later use them for visualising the broadcast of blockchain within the network.
+ 


=== Proof of Concept: BFS
Breadth First Search is an algorithm to traverse an undirected graph. A BFS algorithm starts at a selected node (often referred to as the 'root' node in tree structures) and explores all its neighbouring nodes at the present depth prior to moving on to nodes at the next depth level. This approach ensures that all nodes at the current level are visited before any nodes at the next level are explored, making BFS particularly useful for finding the shortest path in unweighted graphs.

==== Design of algorithm: BFS
I used a queue data structure in my BFS algorithm to keep track of nodes to be explored. The algorithm begins by enqueuing the starting node and making it as visited. It then enters a loop where it dequeues a node, and enqueue all its unvisited neighbours, marking them as visited. This process continues until the queue is empty, meaning all reachable nodes have been visited.

=== Proof of Concept:DFS
Depth First Serch is another algorithm to traverse an undirected graph. A DFS algorithm also starts at a selected node (the 'root' node) and explores as far as possible along each branch before backtracking. This means that DFS goes deep into the graph, visiting a node and then recursively visiting one of its unvisited neighbours until it reaches a node with no unvisited neighbours. At this point, the algorithm backtracks to the most recent node that has unvisited neighbours and continues the process until all nodes have been visited.

==== Design of algorithm: DFS
I used a stack data structure in my DFS algorithm to keep track of nodes to be explored. The algorithm begins by pushing the starting node onto the stack and marking it as visited. It then enters a loop where it pops a node from the stack, and pushes all its unvisited neighbours onto the stack, marking them as visited. This process continues until the stack is empty, meaning all reachable nodes have been visited.

I decided to make use of the call stack and implement the DFS algorithm recursively. The algorithm starts at the root node, marks it as visited, and then recursively visits each unvisited neighbour. This continues until all nodes have been visited.

=== Proof of Concept: Hashing
Hashing is a fundamental concept in blockchain technology, used to ensure data integrity and security. A hash function takes an input (or 'message') and returns a fixed-size string of bytes. The output appears random and is unique to the specific input. Even a small change in the input will produce a significantly different hash, a property known as the avalanche effect. In blockchain, hashing is used to link blocks together, verify transactions, and secure data against tampering.
BlockChain commonly uses the SHA-256 (Secure Hash Algorithm 256-bit) hashing algorithm. However, implementing SHA-256 from scratch is complex and beyond the scope of this project. Instead, I have created a simplified version of a hashing function that captures the essence of how hashing works in blockchain.

==== Design of algorithm: Hashing
My idea for the simplified hashing:
Iterate over each character in the input string:
- Multiply the current hash by 31; 31 is a prime number, chosen because multiplying by a prime reduces collisions and spreads the effect of each character across the final hash value.
- Add the character's Unicode, ensuring each character uniquely influences the hash.
- Mask with 0xffffffff to keep the result within 32 bits, simulating integer overflow; 0xffffffff—which in binary is 32 ones—keeps only the lowest 32 bits of a number, ensuring the hash behaves like a real 32-bit hash, remains fixed-size, deterministic, and avoids large-number rounding errors in JavaScript.
- Convert the 32-bit integer to hexadecimal, producing a fixed-length string representation suitable for comparing against the difficulty target in the PoW simulation.
- Disadvantage of simplication: As the result is constrained to 32 bits, this can lead to collisions (different inputs producing the same hash), which is a limitation of this simplified approach.

=== Proof of Concept: Proof of Work Mining
I have decided to implement a simplified version of the Proof of Work (PoW) mining algorithm to demonstrate the concept of mining in blockchain technology. The goal of PoW is to find a nonce (a number used once) such that when it is combined with the block's data and hashed, the resulting hash meets a specific difficulty target, typically defined by a certain number of leading zeros in its binary representation. 
==== Design of algorithm: Proof of Work Mining
To ensure the speed of mining and simulate the reality of mining rigs which uses multicore CPU/GPU to mine, I have decided to use web workers to implement the PoW mining algorithm. Web workers allow for running scripts in background threads, enabling concurrent execution without blocking the main thread. This is particularly useful for computationally intensive tasks like mining, as it allows the user interface to remain responsive while the mining process is ongoing.
The PoW mining algorithm works as follows:
1. The main thread initiates multiple web workers, each assigned a unique range of nonce values to test.
2. Each worker receives the block data, difficulty level, starting nonce, and chunk size (the range of nonces to test).
3. The worker iterates through its assigned nonce range, combining each nonce with the block data and computing the hash using the simplified hashing function.
4. The hash is converted to binary, and the number of leading zeros is counted.
5. If a hash meets or exceeds the difficulty target (i.e., has the required number of leading zeros), the worker sends a message back to the main thread with the valid nonce and hash.
6. The main thread listens for messages from workers. Upon receiving a valid nonce, it terminates all other workers to stop further computation.
7. The valid nonce and hash are then used to complete the block, which can be added to the blockchain.
This approach effectively simulates the distributed nature of mining in a real blockchain network, where multiple miners work concurrently to find a valid nonce. By leveraging web workers, the mining process can be parallelized, significantly speeding up the search for a valid nonce.

=== Design
The figure below shows the user interface design of different sections of the platform, including the Introduction Page, Main Page, Users Page, Chains Page, Mining Page, Transactions Page, and the Settings Page.

#figure(image("images/ui.jpeg", width: 110%), caption: [
  User interface of the blockchain simulator.
])
<fig:user-interface>
== Decomposition <decomposition>
TODO:Justify for decomposition

=== Testing
=== Evaluation
== Iteration 2
=== Testing
=== Evaluation
== Iteration 3
=== Testing
=== Evaluation
== Iteration 4
=== Testing
=== Evaluation
== Iteration 5
=== Testing
=== Evaluation
== Algorithms <algorithms>
== Test Data <test-data>
== Data Validation
= Evaluation <evaluation>
// Data Validation
