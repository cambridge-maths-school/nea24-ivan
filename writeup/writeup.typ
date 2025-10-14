#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/subpar:0.2.2"
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
    #v(-0.5em)
  ]
    + line(length: 100%),
  footer: line(length: 100%)
    + context [
      #v(-0.5em)
      H446
      #h(1fr)
      Page #counter(page).display("1 of 1", both: true)
      #h(1fr)
      2026
    ],
)

// setting stuff
// #set par(spacing: 2em)
#set list(
  spacing: 0.5em,
  indent: 1em,
)

#show heading.where(level: 4): set heading(outlined: false)
#show heading.where(level: 5): set heading(outlined: false)
#show heading.where(level: 6): set heading(outlined: false)
#show heading.where(level: 7): set heading(outlined: false)
// removing numbering for headings >= level 3
#show figure.caption: set text(size: 0.7em)
// #show heading.where(level: 3): set heading(numbering: none)
#show heading.where(level: 4): set heading(numbering: none)
#show heading.where(level: 5): set heading(numbering: none)
#show heading.where(level: 6): set heading(numbering: none)
#show heading.where(level: 7): set heading(numbering: none)

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
  // pagebreak(weak: true)
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
#pagebreak()

== Research
Blockchain is a distributed ledger technology that records transactions across a network of nodes. Each block is a container for multiple transactions, linked to the previous block via a cryptographic hash. New blocks are added through mining, a process where participants solve a computational puzzle (Proof-of-Work). Miners are incentivized with rewards, such as cryptocurrency and transaction fees, for successfully adding a valid block to the chain.


Research in Blockchain Technology: \
I gained knowledge on the blockchain technologies after watching this #link("https://youtu.be/bBC-nXj3Ng4?si=7UgRxuPQdJOzkzG4")[YouTube video] [#footnote[https://youtu.be/bBC-nXj3Ng4?si=7UgRxuPQdJOzkzG4]] by #link("https://www.youtube.com/@3blue1brown")[3Blue1Brown] which explains how blockchain technologies work behind the scene and different algorithms to power it. I also confirmed my knowledge with the winner of award of distinction in the Hong Kong BlockChain Olympiad - Lester Chong by asking him questions to clearly understand the concepts behind blockchain technologies.

Here are my summary to some main concepts in Blockchain technology:
#[
  #set par(spacing: 1em)
  1. Transactions
  A transaction represents a transfer of value or information between users. Each transaction typically includes:
  - Sender and receiver addresses
  - Amount or data being transferred
  - Digital signature to verify authenticity
  Transactions are first broadcast to the network and stored in the mempool, a collec tion of unconfirmed transactions awaiting inclusion in a block.
]
\
#[
  #set par(spacing: 1em)
  2. Transaction Validity
  Transactions must satisfy several criteria before being considered valid. Miners only include valid transactions in blocks.

  Algorithm: Validate Transaction \
  Input: Transaction T, Blockchain ledger L \
  Output: Valid or Invalid
]
Algorithm flowchart - see next page
#figure(
  move(dx: 3em, dy: -10em)[
    #scale(x: 70%, y: 70%)[
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
  caption: [Algorithm flowchart to validate a transaction],
)
\
\


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
\
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
\
\

6. Peer to Peer network
Blockchain relies on a decentralized peer-to-peer (P2P) network. Each node maintains a copy of the blockchain and independently verifies transactions and blocks.\

Transaction propagation in P2P network:\
Input: Transaction T\
Output: Broadcast to network\
Algorithm - see next page

`1. User signs and sends T to a connected node
2. Node verifies T:
   - If valid, add to local mempool
   - If invalid, discard
3. Node forwards T to all connected peers
4. Iterate steps 2-3 for each peer`
\
\

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
\
\

7. Block linking and immutability
- Each block contains the hash of the previous block, forming a cryptographically linked chain.
- Altering a block invalidates all subsequent blocks, making tampering computationally infeasible.
- Only blocks meeting the Proof-of-Work and containing valid transactions are accepted by the network.

Conceptual Flowchart:\
I created the flowchart below to visualise the workflow of a blockchain:
#figure(
  image("images/blockchain_conceptual_flowchart.png", width: 100%),
  caption: [Conceptual flowchart of blockchain workflow.],
)
#pagebreak()
== Existing models
I found this blockchain simulator Command Line Interface (CLI) on GitHub (https://github.com/0xs34n/blockchain) by Sean. I have forked the repository and ran it on my local machine using `node.js`. The simulator offers a basic understanding of blockchain technologies with features like possessing blockchains and connecting to peers in different networks. However, it doesn't contain features such as transactions of blockchains or the process of mining blockchains.
#subpar.grid(
  figure(image("images/SeanCLI.png", width: 140%, height: 60%)), <a>,
  figure(image("images/SeanP2P.png", width: 50%, height: 20%)), <b>,
  columns: (1fr, 1fr),
  label: <full>,
)
In this image, Sean's Blockchain simulator has shown the connection between different ports in local host. However, there is not any features that allow different ports to interact, like trading blocks. It also doesn't allow user to see other's user blocks.

Many of the simulators on the internet allows you to change the content in a blockchain but this is not a realistic feature as in real life, once a block is mined and added to the blockchain, it is immutable and cannot be changed. This is misleading for learners as they might think that blocks in a blockchain can be changed.
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
#pagebreak()
=== Intial Design
The figure below shows the user interface design of different sections of the platform, including the Introduction Page, Main Page, Users Page, Chains Page, Mining Page, Transactions Page, and the Settings Page.

#figure(image("images/ui.jpeg", width: 110%), caption: [
  Intial Design for User interface of the blockchain simulator.
])

=== Project Management Methodology
The solution will be developed in an agile way. This means that it will be developed in different iterations. The analysis of requirements has been done in this section (Section 1).
In each iterations I will
- Design the prototype for that iteration
- Build the prototype
- Asking for User Feedback
- Refine prototype
Each feature of the solution might be improved throughout the iterations.

Abstracted plans for my iterations:
- Iteration 1-2: Proof of Concept for the technologies that I will be using in the simulator
- Iteration 3-4: Developing a Command Line Interface (CLI)
- Iteration 5: Developing a Graphical User Interface (GUI) to visualise blockchain

=== Technology
The simulator will run purely on client side code to reduce server costs and workload, improve scalability, and create a more interactive and responsive user experience\
Frontend: HTML + CSS + JavaScript \
Graph visualisation: canvas
=== Device Compatibility
The blockchain simulator is designed to run entirely in the browser and therefore requires TypeScript support to function. It is optimised for modern desktop and laptop environments using Chromium-based browsers (Google Chrome, Microsoft Edge, Opera). Mobile browsers may support basic interaction, but performance and visualisation features are best experienced on computer systems. The device running to program should have at least a refresh rate of 60Hz to run the requestAnimationFrame() function in canvas to visualise blockchain workflow.
// TODO: Justify TypeScript

#pagebreak()
== Intital Sucess Criteria
These are the initial Success Criteria (SC) which is what I am aiming for while developing a MVP (Minimum Viable Product). As I am developing in an agile methodology, the Success Critea might be ammended or new Success Criteria might be added in the process of iterations.

=== Success Criteria
#table(
  columns: (auto, auto, auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header([*Category*], [*SC*], [*Target*], [*Justification (This is an SC because...)*], [*Testing*]),
  table.cell(
    rowspan: 6,
    align: center,
    rotate(-90deg, reflow: true)[
      *Graphical User Interface (GUI)*
    ],
  ),
  $ 1.1 $,
  [GUI],
  $ sqrt(2) / 12 a^3 $,
  $ "Ewuation" $,
  $ 1.2 $,
)
#pagebreak()
== Stakeholders <stakeholders>
Primary Stakeholders:
\ \  Students: My blockchain simulator is aimed at A level student who would like to go beyond the standard A level . This will serve as a great resource for them to gain an insight of what blockchain is, how they can propagate
\ \ Developer: As a developer myself, I will be a stakeholder myself
=== Survey
=== Interview
= Iterations
== Iteration 1
In Interation 1, I will be focusing on the proof of concept for the technologies that I will be using in my blockchain simulator.
=== Decomposing Iteration 1
// To change: no require web browser console
#figure(image("images/iteration1_decompose.jpg"), caption: [Decomposing iteration 1])
Here I have a brief decompostion of what I am going to do in iteration 1. Each leaf nodes of my diagram represents an algorithm or files that I have to work on. Further on in the iteration 1, each algorithms will be decomposed further and carefully designed.
=== Main Goal
+ Proof of concept for Breadth First Search (BFS) and Depth First Search (DFS) so that I can later use them for visualising the broadcast of blockchain within the network.
+ Simplifying the SHA-256 hash function and implement it called the fakeHash() function.
+ Using web workers, build a mining algorithm that uses the concept of nonce to find the hash of a block.

// Justify why BFS and DFS
==== BFS and DFS
To simulate the blockchain propagation along the network, I have decided to use the Breadth First Search and Depth First Search (DFS) algorithms. This is because both algorithms are in the A level Computer Science specifications across multiple exam boards. This can help students to understand the blockchain technology easily by applying their prior knowledge in traversing/searching a graph to a new problem - blockchain network propagation.
#pagebreak()
=== Proof of Concept: BFS
Breadth First Search is an algorithm to traverse an undirected graph. A BFS algorithm starts at a selected node (often referred to as the 'root' node in tree structures) and explores all its neighbouring nodes at the present depth prior to moving on to nodes at the next depth level. This approach ensures that all nodes at the current level are visited before any nodes at the next level are explored, making BFS particularly useful for finding the shortest path in unweighted graphs.

==== Design of algorithm: BFS
I used a queue data structure in my BFS algorithm to keep track of nodes to be explored. The algorithm begins by enqueuing the starting node and making it as visited. It then enters a loop where it dequeues a node, and enqueue all its unvisited neighbours, marking them as visited. This process continues until the queue is empty, meaning all reachable nodes have been visited.

To store the data, I used an adjacency list --- a data structure used to store a collection of unordered lists used to represent a finite graph.
==== Unit Test for BFS
For the unit test, I am making a new file `bfs.test.ts` and testing it using Bun. This allows me to test individual functions from the `bfs.ts` file by importing them into the test file.\ \
To make a unit test for my BFS algorithm, I have to firstly design some graphs and traversing them by hand, then convert them into adjacency list where I input the neighbouring nodes for each node so that the graph can be 'undestood' by the algorithm
===== Normal Test
I have designed the following basic tree (an abstract data type that is a graph that has a hierarchial structure) graph to test my algorithm (left). While traversing the graph with a BFS algorithm, I will start at node A (layer 1) and visit its neighbours C and B (layer 2). Then I will move on to layer 3 and visit F, D, and E. Therefore one of the ways to traverse the graph with the BFS algorithms is with the order: A -> C -> B -> F -> D -> E (right).
#subpar.grid(
  figure(image("images/basic_tree_graph.png", width: 100%), caption: [basic tree graph]), <a>,
  figure(image("images/bfs_tree_graph.png", width: 60%), caption: [BFS traversal of the basic tree graph]), <b>,

  columns: (1fr, 1fr),
  label: <normal-test>,
)


Since I am developing in TypeScript, I have to declare the type of my adjacency list. Therefore I have to create an interface for my adjacency lists. Considering my input being the nodes and its neighbours in an array of strings, I will require a key-value pair (a basic data structure that stores data as a collection of unique, constant keys and their corresponding, variable values). Therefore my type AList (adjancency list) takes in 2 parameters, the key as a string --- this will be the nodes and the values as an array of strings --- this will be the neighbours in arrays of strings. The interface can be defined as following --- see next page#pagebreak()
```js
 interface AList {
  [key: string]: string[]
}
```
Writing the nodes from the basic tree graph in an adjacency list gives me:
```js
let adjacencyList: AList = {
  A: ["C", "B"],
  B: ["F", "A"],
  C: ["A", "D", "E"],
  D: ["C"],
  E: ["C"],
  F: ["B"],
};
```
Now I have to design unit tests for my list. I have to consider that BFS allows multiple ways to traverse it as long as it finished traversing one layer of the nodes until it moves on to the next layer until all the nodes are traversed. I can allow this by splitting the list in layers and allowing them in any order. I can do this with using `slice` to split the traversed array of strings into layers, then sorting them using the `sort` function and check them against the traversed layer in order.
```jsa
test("Normal List", () => {
  let result = bfs_traverse(normalList, "A");
  expect(result[0]).toBe("A");
  let layer1 = result.slice(1, 3).sort();
  expect(layer1).toEqual(["B", "C"]);
  let layer2 = result.slice(3).sort();
  expect(layer2).toEqual(["D", "E", "F"]);
});
```
// Setting other starting nodes
To further test my bfs algorithm whether it is capable of taking and processing more input nodes, I made another graph which is *a little bit* more complicated. Then I traversed it with the starting node 'M'.
#subpar.grid(
  align(
    horizon,

    figure(
      image("images/little_bit_more_complicated_graph.jpeg", width: 100%),
      caption: [A bit more complicated tree graph],
    ),
  ),
  <a>,

  figure(
    image("images/BFS_traversal_of_little_more_complicated_graph.png", width: 100%),
    caption: [BFS traversal of the a bit more complicated graph],
  ),
  <b>,

  columns: (1fr, 1fr),
  label: <normal-test>,
)
The 'bit more complicated graph' can be represented by the following adjacency list arranged in alphabetical order:
```js
let complicatedList: AList = {
  A: ["C", "H", "I", "N"],
  B: ["D", "H", "I", "J", "K"],
  C: ["A", "E", "L"],
  D: ["B", "E", "G", "L", "M"],
  E: ["C", "D", "G", "J"],
  F: ["G"],
  G: ["D", "E", "F", "H"],
  H: ["A", "B", "G"],
  I: ["A", "B", "M"],
  J: ["B", "E"],
  K: ["B"],
  L: ["C", "D"],
  M: ["D", "I"],
  N: ["A", "O"],
  O: ["N"],
};
```

Using the same idea of splitting the graph into layers, I can make the test for the 'bit more complicated graph' with
```js
test("Complicated List", () => {
  let result = dfs_traverse(complicatedList, "M");
  expect(result[0]).toBe("M");
  let layer1 = result.slice(1, 3).sort();
  expect(layer1).toEqual(["D", "I"]);
  let layer2 = result.slice(3, 8).sort();
  expect(layer2).toEqual(["A", "B", "E", "G", "L"]);
  let layer3 = result.slice(8, 14).sort();
  expect(layer3).toEqual(["C", "F", "H", "J", "K", "N"]);
  let layer4 = result.slice(14).sort();
  expect(layer4).toEqual(["O"]);
});
```

As expected, initially, when no code has been made, the bfs test fails due to no such function `bfs_traverse()` being defined.
#figure(image("images/bfs_test_error.png"), caption: [Error: bfs_traverse not found])

===== Boundary Test
For boundary test I decided to make some special looking graphs such as a self looped graph, graph with only one node and graph with
===== Erroneous Test
I decided to do erroneous testing with unexpected input types.

==== Development of BFS

=== Proof of Concept: DFS
Depth First Serch is another algorithm to traverse an undirected graph. A DFS algorithm also starts at a selected node (the 'root' node) and explores as far as possible along each branch before backtracking. This means that DFS goes deep into the graph, visiting a node and then recursively visiting one of its unvisited neighbours until it reaches a node with no unvisited neighbours. At this point, the algorithm backtracks to the most recent node that has unvisited neighbours and continues the process until all nodes have been visited.

==== Design of algorithm: DFS
I used a stack data structure in my DFS algorithm to keep track of nodes to be explored. The algorithm begins by pushing the starting node onto the stack and marking it as visited. It then enters a loop where it pops a node from the stack, and pushes all its unvisited neighbours onto the stack, marking them as visited. This process continues until the stack is empty, meaning all reachable nodes have been visited.

I decided to make use of the call stack and implement the DFS algorithm recursively. The algorithm starts at the root node, marks it as visited, and then recursively visits each unvisited neighbour. This continues until all nodes have been visited.

==== Unit Test for DFS
===== Normal Test
I am using the same tree graph from BFS to test my DFS. However this time I will have to manually traverse it in a DFS algorithm.
===== Boundary Test
===== Erroneous Test
=== Proof of Concept: Hashing
Hashing is a fundamental concept in blockchain technology, used to ensure data integrity and security. A hash function takes an input (or 'message') and returns a fixed-size string of bytes. The output appears random and is unique to the specific input. Even a small change in the input will produce a significantly different hash, a property known as the avalanche effect. In blockchain, hashing is used to link blocks together, verify transactions, and secure data against tampering.
BlockChain commonly uses the SHA-256 (Secure Hash Algorithm 256-bit) hashing algorithm. However, brute forcing SHA-256 is an incredibly computational heavy task. Instead, I have created a simplified version of a hashing function that captures the essence of how hashing works in blockchain.

#pagebreak()
==== Research on the SHA-256 algorithm
Summarising this article about cyber security from #link("https://www.simplilearn.com/tutorials/cyber-security-tutorial/sha-256-algorithm")[simplilearn] #footnote[https://www.simplilearn.com/tutorials/cyber-security-tutorial/sha-256-algorithm], the SHA-256 algorithm works
==== Design of algorithm: Hashing
My idea for the simplified hashing:
Iterate over each character in the input string:
- Set hash = 0
- Multiply the current hash by 67; 67 is a prime number, chosen because multiplying by a prime reduces collisions and spreads the effect of each character across the final hash value.
- Add the character's ASCII code, ensuring each character uniquely influences the hash.
- Mask with 0xffffffff to keep the result within 32 bits, simulating integer overflow; 0xffffffff—which in binary is 32 ones—keeps only the lowest 32 bits of a number, ensuring the hash behaves like a real 32-bit hash, remains fixed-size, deterministic, and avoids large-number rounding errors in JavaScript.
- Convert the 32-bit integer to hexadecimal, producing a fixed-length string representation suitable for comparing against the difficulty target in the PoW simulation.
- Disadvantage of simplication: As the result is constrained to 32 bits, this can lead to collisions (different inputs producing the same hash), which is a limitation of this simplified approach.

Example Data: 'cat'
+ The data is being split into individual characters 'c','a', and 't'
+ Initially the hash = 0, therefore the the updated hash will just be `0*67 + ASCII code 99 = 99`
+ Then the algorithm moves to the second character 'a' and multiply the current hash by 67 then add the ASCII code for 'a' which gives `new hash = 99 * 67 + 97 = 6730`
+ The algorithms repeats step 3 on the last character 't' (ASCII code of 116) giving `hash = 6730 * 67 + 116 = 451026`
+ Convert `451026` and `0xffffffff` (32 ones) into binary and apply a bitwise AND mask which doesnt make any difference since the hash of string `cat` doesn't exceed 32-bit
+ Convert `451026` into hexadecimal which gives `6e1d2`
+ Add 0's in front of `6e1d2` to form a 32 bit data which is 8 hexadecimal characters
This process cannot be reversed as you wouldn't know how many characters there are or what the characters are when you work backwards.

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


// Issues with Bun
=== Testing
=== Evaluation
In this iteration I have done the proof of concept

In this iteration the stakeholder would be me - the developer of the simulator, as there isn't a Minimal Viable Product (MVP) yet for the external stakeholders to review.
== Iteration 2
In Iteration 2, I will be continuing on Proof of Concept.


// Making blocks as global objects so that it can be accessed throughout different part of the programme while keeping it modular
// Justify modular coding
// Not repeating code, improve readability, allowing future developers to be able pick things up straight away
// Good for decomposed code
// Easier to code and debug
// Reducing risk of cascading bugs throughout the application
// Easier to test
=== Testing
=== Evaluation
== Iteration 3
In Iteration 3, I will start to code a Command Line Interface (CLI) for my simulator.
=== Testing
=== Evaluation
== Iteration 4
In Iteration 4, I will finish off my Command Line Interface (CLI) for my simulator
=== Testing
=== Evaluation
== Iteration 5
In Iteration 5, I will be developing a
=== Testing
=== Evaluation
== Algorithms <algorithms>
== Test Data <test-data>
== Data Validation
= Evaluation <evaluation>
// Data Validation

== Decomposition <decomposition>
TODO:Justify for decomposition
