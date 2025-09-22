#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import fletcher.shapes: diamond

#set heading(numbering: "1.")
#show heading: set text(blue)

// setting stuff
#set par(
  spacing: 2em,
)
#set list(
  spacing: 1em,
  indent: 2em,
)

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

// headers and footers
#set page(
  header: [
    Ivan Leung
    #h(1fr)
    Candidate Number: 4022
    #h(1fr)
    Centre Number: 22245
  ]
    + line(length: 100%),
  footer: line(length: 100%)
    + context [
      H446
      #h(1fr)
      Page #counter(page).display("1 of 1", both: true)
      #h(1fr)
      2026
    ],
)

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

#align(center)[
  #diagram(
    node-stroke: 1pt,
    node((0, 0), [Start], corner-radius: 2pt, extrude: (0, 3)),
    edge("-|>"),
    node(
      (0, 1),
      align(center)[
        Verify \ T.signature \ using sender's \ public key
      ],
      shape: diamond,
    ),
    edge("d,d", "-|>", [Valid], label-pos: 0.5),
    edge("r,r", "-|>", [Invalid], label-pos: 0.4),
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
  )]

3. Block and block structure
A block is a container for transactions and metadata. Each block contains:
+ Multiple transactions from the mempool
+ Previous block hash — linking the block to its predecessor
+ Timestamp — recording creation time
+ Nonce — adjusted during mining to solve the Proof-of-Work puzzle
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
4. Repeat steps 2-3 for each peer`

Block propagation in p2p network:\
Input: Mined Block B\
Output: Network consensus\

`1. Miner broadcasts B to connected peers
2. Each peer verifies:
   a. Block hash meets difficulty
   b. Transactions are valid
   c. Previous hash matches last block in local chain
3. If valid, peer appends B to local blockchain
4. Peer forwards B to its connected peers`

== Existing models
I found this blockchain simulator Command Line Interface (CLI) on GitHub (https://github.com/0xs34n/blockchain) by Sean. I have forked the repository and ran it on my local machine using `node.js`. The simulator offers a basic understanding of blockchain technologies with features like possessing blockchains and connecting to peers in different networks. However, it doesn't contain features such as transactions of blockchains or the process of mining blockchains.
#image("images/SeanCLI.png")
#image("images/SeanP2P.png")
In this image, Sean's Blockchain simulator has shown the connection between different ports in local host. However, there is not any features that allow different ports to interact, like trading blocks. It also doesn't allow user to see other's user blocks.
== Initial Features
The solution will be developed in an agile way. This means that it will be developed in different iterations. The analysis of requirements has been done in this section (Section 1).
In each iterations I will
- Design the prototype for that iteration
- Build the prototype
- Asking for User Feedback
- Refine prototype
Each feature of the solution might be improved throughout the iterations.

In this BlockChain Simulator project, I will build a simplified model of BlockChain and mainly focusing on visualisation of different technologies, so that learners would be able to easily understand them.

The final project will be running on a browser and has a Graphical User Interface (GUI). The project will be developed in HTML, CSS, and JavaScript with WebGL to gain control over the user's Graphical Processing Unit (GPU). This allows the code to be rendered faster and also better simulate how blockchains are being mined as this is usually being done by a crypto mining rig - a customised personal computer that uses GPUs to solve cryptographic equations and verify transactions on a blockchain.

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
People who will be using the system, including developers, users, and administrators. This also includes the people who would like to invest in cryptocurrencies, allowing them to learn about the technology and how it works. By understanding the underlying principles of blockchain
=== Survey
=== Interview
== Features <features>
The platform will have the following features:

- Introduction to the platform, allowing users to learn about blockchain technology and how it works.
- A graph representation of the users and their relationships, allowing users to see how they are connected to each other.
- A visualisation of the blockchain, allowing users to see how the blockchains are connected to each other.

- Allowing users to create a new block, add a transaction, and verify a transaction.

- Allowing users to transact with each other, to move the blocks around between users.

- Checking the blocks in a chain

- Checking the users’ profiles

- Adding users to the system

- Settings page allowing users to modify the UI for better aesthetics, such as dark mode

- Allow removing users from the system

- Allowing users to view the transactions between users

- Allowing users to make transactions between users.

== Extensions <extensions>
The platform can be extended to include more features, such as:

- A visualisation of how blocks are created by Proof of Work (PoW), allowing users to see how blocks are added to the blockchain.

- Implementing the Proof of Stake (PoS) algorithm, allowing users to see how blocks are added to the blockchain using PoS.

- A tutorial system that allows users to learn about controlling the blockchain, such as how to create a new block, how to add a transaction, and how to verify a transaction.

- A visualisation of what happens when a blockchain is forked, allowing users to see how the blockchain splits into two separate chains, and how this can be resolved.

- Showing different users are mining at the same time and competing to add the next block to the blockchain.

- Visualisation on how public and private key pairs play a role in the transaction process, including how they are used to sign transactions and verify ownership.

- Introducing multiple chains and visualising the conflict

= Iterations
== Iteration 1
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
