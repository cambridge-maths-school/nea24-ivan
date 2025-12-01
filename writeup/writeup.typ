#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/subpar:0.2.2"
#import fletcher.shapes: diamond

#set heading(numbering: "1.")
#show heading: set text(blue)
#set bibliography(style: "harvard-cite-them-right")
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
Blockchain is a rapidly growing technology that powers cryptocurrencies, NFTs, and secure digital record-keeping. Blockchain and Cryptography area mong the most in-demand STEM skills in the post-web economy. According to a new report from the UK Parliament, nearly half of engineering and tech businesses are struggling to recruit skilled talent. The shortage for STEM skills are costing the UK economy £1.5 billion per year [#footnote[source: medium (https://britblockchain.medium.com/uk-faces-stem-talent-shortage-as-demand-for-blockchain-skills-surges-says-parliamentary-report-ca626c0f5928)]]. Despite its increasing importance in finance, computing, and data security, not a lot of students in the UK are learning it. In addition, understanding how blockchain works is conceptually challenging for most students, especially with the lack of the resources online. Key concepts such as blockchain being decentralised distributed ledgers, mining, proof of work, hashing, and peer to peer (p2p) networks are often abstract and difficult to visualise. This creates a barrier to learn, especially when students encounter blockchain only through media or cryptocurrency hype, without practical experience. Consequently, there is a need for an educational tool which allows students to interact with. This can help them to visualise blockchain mechanics in a safe, simplified, and engaging way.
#pagebreak()

== Research <research>
Blockchain is a distributed ledger technology that keeps record of the transactions across a network of nodes. Each block is a container for multiple transactions, linked to the previous block using a cryptographic hash. New blocks are added to the BlockChain through mining -- a process where participants (miners) solve complex computational puzzles (proof of work). Once successfully adding a valid block to the chain, miners will be given rewards, such as cryptocurrency and transaction fees.


Research in Blockchain Technology: \
I gained knowledge on the blockchain technologies after watching this #link("https://youtu.be/bBC-nXj3Ng4?si=7UgRxuPQdJOzkzG4")[YouTube video] [#footnote[https://youtu.be/bBC-nXj3Ng4?si=7UgRxuPQdJOzkzG4]] by #link("https://www.youtube.com/@3blue1brown")[3Blue1Brown] which explains how blockchain technologies work behind the scene and different algorithms to power it. I also confirmed my knowledge with the winner of award of distinction in the Hong Kong BlockChain Olympiad - Lester Chong by asking him questions to clearly understand the concepts behind blockchain technologies.

Here are my summary to some main concepts in Blockchain technology:

1. Transactions
A transaction represents a transfer of value or information between users. Each transaction typically includes:
- Sender and receiver addresses
- Amount or data being transferred
- Digital signature to verify authenticity
Transactions are first broadcast to the network and stored in the mempool -- a collection of unconfirmed transactions awaiting inclusion in a block.

\

2. Transaction Validity
Transactions must satisfy several criteria before being considered valid. Miners only include valid transactions in blocks.

Algorithm: Validate Transaction \
Input: Transaction T, Blockchain ledger L \
Output: Valid or Invalid

Algorithm flowchart - see next page
#figure(
  move(dx: 5em, dy: 0em)[
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
    )],
  caption: [Algorithm flowchart to validate a transaction],
)
\
\


3. Block and block structure
A block is a container for transactions and metadata. Each block contains:
- Multiple transactions from the mempool
- Previous block hash -- linking the block to its predecessor
- Timestamp -- recording creation time
- Nonce (Number used Once) --  adjusted during mining to solve the proof of work puzzle
- Block hash -- a cryptographic hash of all block contents -- including
\
4. Hashing
Blocks are uniquely identified by a cryptographic hash function (e.g. SHA-256).\
Algorithm: Compute Block Hash
Input: Block B (transactions, previous hash, timestamp, nonce)
Output: Block hash H
1. Concatenate block transactions from the mempool, previous hash, timestamp, and nonce and turn it into a string
2. Apply SHA-256 hash function to the concatenated string
3. Output fixed-length hash
Properties of cryptographic hashes:
- Deterministic -- Same input always produces the same hash
- Irreversible -- It is impossible to find the original input from the hashed output
- Sensitive -- Any changes in the input drastically changes the output (avalanche effect)
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

When a valid nonce (an arbitrary number that can be used only once in a cryptographic communication) is found, the block is 'mined' to the blockchain and broadcasted to the network. There are also other mining algorithms such as the proof of stake algorithm.
\
\

6. Peer to Peer network
Blockchain relies on a decentralised peer to peer (P2P) network -- which means no central node. Each node maintains a copy of the blockchain and independently verifies transactions and blocks.\

Transaction propagation in P2P network:\
Input: Transaction T\
Output: Broadcast to network\
Algorithm - see next page

`1. User signs and sends T to a connected node
2. Node verifies T:
   - If valid, add to local mempool
   - If invalid, discard
3. Node forwards T to all connected peers
4. Iterate steps 2-3 for each peer
`
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
- Each block contains the hash of the previous block, forming a cryptographically linked chain
- Mutating a block makes all of its following blocks invalid -- This makes it infeasible to alter blocks
- Only blocks meeting the proof of work and containing valid transactions are accepted by the network

Conceptual Flowchart:\
I created the flowchart below to visualise the workflow of a blockchain:
#figure(
  image("images/blockchain_conceptual_flowchart.png", width: 100%),
  caption: [Conceptual flowchart of blockchain workflow.],
)

A very broad summary of the blockchain network workflow is as follows:
- Users create transactions (note: the transactions will get checked for validity first; Invalid transactions include double spending the same coin/token, insuffiecient balance, invalid digital signature, etc.)
- Valid transactions are then added to the mempool (mempool is global and every node has the same mempool)
- Miners select transactions from the mempool to include in a new block
- Miners perform proof of work to find a valid nonce (a number that is added to the block data to be hashed that results in a hash that meets the network difficulty target, which means it should have a certain number of leading zeros in binary) and hash of the new block
- Once a valid nonce is found, the new block is added to the blockchain and broadcasts to all nodes in the peer to peer network.
- Each node verifies the new block and appends it to their local copy of the blockchain if valid therefore everyone keeps a synchronised copy of the blockchain
- This process repeats for each new block being mined
Note:
- The difficulty of mining is set by the network and cannot be changed by miners.

== Existing models <sean-cli>
I found this blockchain simulator Command Line Interface (CLI) #footnote[https://github.com/0xs34n/blockchain] on GitHub by Sean. I have forked the repository and ran it on my local machine using `node.js`. The simulator offers a basic understanding of blockchain technologies with features like possessing blockchains and connecting to peers in different networks. However, it doesn't contain features such as transactions of blockchains or the process of mining blockchains.
#subpar.grid(
  figure(image("images/SeanCLI.png", width: 140%, height: 60%)), <a>,
  figure(image("images/SeanP2P.png", width: 50%, height: 20%)), <b>,
  columns: (1fr, 1fr),
  label: <full>,
)
In this image, Sean's Blockchain simulator has shown the connection between different ports in local host. However, there is not any features that allow different ports to interact, like trading blocks. It also doesn't allow user to see other's user blocks.


Another blockchain simulator #footnote[https://andersbrownworth.com/blockchain/] I found is made by Anders Brownworth.

Both of the simulators on the internet allows you to change the content in a blockchain but this is not a realistic feature as in real life, once a block is mined and added to the blockchain, it is immutable and cannot be changed. This is misleading for learners as they might think that blocks in a blockchain can be changed.
Features like mempool also isn't implemented onto the online simulators. This makes the idea of the process of converting transactions into blocks quite hard to understand. Therefore we could try to implement that.
#pagebreak()
== Initial Features
In this BlockChain Simulator project, I will build a simplified model of BlockChain and mainly focusing on visualisation of different technologies, so that learners would be able to easily understand them. There will be one BlockChain running.

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

Limitations:
- This is a simplified model of the blockchain, which means that I will abstract the idea of blockchain and ignore a few details. For example, there will not be a handler for colliding blocks (forks) in the blockchain. This is because handling forks requires more complex consensus algorithms and network communication, which is beyond the scope of this project. Instead, I will assume that all nodes are honest and always extend the longest chain. Besides, I will also assume that there will be no attackers in the network, so I will not be implementing any security measures against malicious nodes. This is because implementing security measures would require more complex cryptographic techniques and network protocols, which are beyond the scope of this project.
#pagebreak()
=== Usability Features
This is my initial rough sketch on the graphical user interface (GUI) design of my blockchain simulator. It shows shows the user interface design of different sections of the platform, including the Introduction Page, Main Page, Users Page, Chains Page, Mining Page, Transactions Page, and the Settings Page.

#figure(image("images/ui.jpeg", width: 110%), caption: [
  Intial Design for User interface of the blockchain simulator.
]) <Initial-GUI-Design>

=== Project Management Methodology
The solution will be developed in an agile way. This means that it will be developed in different iterations. The analysis of requirements has been done in this section (Section 1).
In each iterations I will
- Design the prototype for that iteration
- Build the prototype
- Asking for User Feedback
- Refine prototype
Each feature of the solution might be improved throughout the iterations.

Abstracted plans for my iterations:
- Iteration 1: Proof of Concept for the technologies that I will be using in the simulator
- Iteration 2: Building the core blockchain structure (Block and Blockchain classes)
- Iteration 3: Developing a Command Line Interface (CLI)
- Iteration 4-5: Developing a Graphical User Interface (GUI) to visualise blockchain
#pagebreak()
=== Computational methods
// TODO: justify all of these
In the project, all the algorithms will be developed using the following computational methods:
- Decomposition
  - At the start of each iteration, I will decompose the iteration, analyse what has to be done in that iteration and setting goals. This allows a more efficient development as I only have to think about each small goal while developing, including the targets and requirements. This also means that the code overall will be more modular, making it easier for future development and increasing maintainability.
- Abstraction
  - I will focus on essential features rather than unnecessary details before developing. This can help me to achieve the overall goal quicker in each development stage. I will be using different methods such as writing psuedocode or drawing flowchart diagrams before development.
- Thinking parallel
  - I will think about what is happening at the same time. For example, in my proof of work algorithm, I will require multiple
- Thinking Ahead
- Problem solving using
  - Visualisation
=== Technology <technology>
The simulator will run purely on client side code to reduce server costs and workload, improve scalability, and create a more interactive and responsive user experience\
Frontend: HTML + CSS + TypeScript \
Graph visualisation: canvas
=== Device Compatibility
The blockchain simulator is designed to run entirely in the browser. Therefore a JavaScript supporting browser is required. The simulator will be optimised for modern desktop and laptop environments using Chromium browsers (Google Chrome, Microsoft Edge, Opera). Mobile browsers may support basic interactios, but visualisation features are best experienced on computer systems. The device running to program should have at least a refresh rate of 60Hz to run the `requestAnimationFrame()` function in canvas to visualise blockchain workflow.
==== TypeScript
I will be using TypeScript to develop my blockchain simulator. TypeScript is a superset of JavaScript that adds types, interfaces, and other features to enhance code quality and maintainability. Here are some reasons why TypeScript is a good choice for this project:
+ Type Safety: TypeScript's static typing helps catch errors at compile time, reducing bugs in runtime. This is  important in a complex project like a blockchain simulator where data structures and algorithms need to be precise. It also helps me to think about the input and output of the functions while doing modular coding
+ Sustainability: TypeScript's type makes it easier to understand and maintain code over time. This is important because it allows other developers to look at the code and understand it to develop new features and improvements
However, when the website gets online, the TypeScript code will be transpiled (convert between two high-level languages) into JavaScript, so that it can be run on all Chromium browsers. Therefore, users do not have to install TypeScript on their devices to run the Blockchain Simulator. Their browsers only have to support JavaScript. Since I will be developing in Bun, the TypeScript will be automatically transpiled into JavaScript and I could just plug the file into the html file.
#pagebreak()
== Stakeholders <stakeholders>
Primary Stakeholders:
+ Students: My blockchain simulator is aimed at A level student who would like to go beyond the standard A level . This will serve as a great resource for them to gain an insight of what blockchain is, how they can propagate
+ Teachers: They could use it as a teaching tool in lessons or demonstrations.
\
Secondary Stakeholders
+ Developer: As a developer myself, I will be a stakeholder myself. This means that I will be responsible for design, coding, testing, and documentation.
\
=== Interview
I have selected a few A level students to represent my target users to interview them about their expectations of blockchain simulator. These are the questions that I have asked during the interview:
`Section 1: Background and Experience
1. How familiar are you with blockchain concepts such as blocks, mining, and transactions?
2. Have you ever used any blockchain simulator or visualisation tool before? If yes, which ones and what did you like/dislike about them?

Section 2: Learning Goals
3. What would you like to learn or understand better about blockchain through a simulator?
4. Are there specific concepts (e.g., network propagation, mining difficulty) that you find difficult and would like the simulator to explain visually?

Section 3: Features and Usability
5. Which features would you consider essential in a blockchain simulator?
6. How should the simulator allow you to interact with the blockchain (e.g., add transactions, mine blocks, view the network)?
7. Do you prefer a simple interface for learning or more detailed technical controls? Why?

Section 4: Performance and Limits
8. How fast or responsive do you expect the simulator to be when adding blocks or mining blocks?
9. Would you like the simulator to simulate multiple nodes on one computer, or one node on each computer over the network?

Section 5: Expectations and Concerns
10. What potential difficulties or frustrations do you anticipate when using a blockchain simulator?
11. How important is it for the simulator to be visually engaging (e.g., showing block links, network paths)?
12. If you could suggest one unique feature for this simulator, what would it be?`
#pagebreak()
I have interviewed 4 A level students (Ben, James, Jeremy, and William), in which all of them takes Computer Science as their A level subject. Here are some key points that I have gathered from the interview:

Most of them are very unfamiliar with the blockchain technology. However, one of them -- Ben, did some research in the blockchain in his free time. The majority of my stakeholders have never used a blockchain simulator or any visualisation tools before, except from Ben who has used the Ethereum Virtual Machine (EVM) to learn about proof of stake algorithm (one of the algorithm to mine blocks in the blockchain). However, the EVM doesn't provide any graphical visualisation of any blockchain concepts. \
\
Most of them have different aims that they would like to achieve from using a blockchain simulator. However, there are some common themes that they would like to learn about mining and how blocks are connected together. They also find network propagation quite difficult to understand. \
\
All of them would like to see visualisation of the blockchain process, as this is a completely new concept to them. They believe that visualisation can help them to understand the abstract concepts better. They would also like to interact with the blockchain by adding transactions and mining blocks. Most of them prefer a simple interface for learning as they are new to blockchain concepts.\
\
They would like the simulator to be responsive within 5 to 10 seconds while processing blockchain actions. This is because they have a short attention span and would like to see the results quickly. All of them would like the simulator to simulate multiple nodes on one computer, as they do not have access to multiple computers to run the simulator on a network. \
\
William considers graph as an important visual element to help him understand the blockchain concepts. Jeremy would like to see instructions on how to use the simulator. Ben would like to see visualisation for the blocks to be linked, representing links between nodes. James didn't provide any unique feature.\
\
Therefore, I aim to create a blockchain simulator that simplifies the blockchain concepts so that the majority of A level students will be able to understand them. I will also include visualisation of different blockchain concepts such as network propagation, mining, and block linking to help students to understand them. The network difficulty should be able to be altered by the learners to see how it affects the mining speed. This allows the simulator to be responsive within their attention span if they set a lower difficulty. Finally, I will implement multiple nodes on one computer so that learners can experience the peer to peer network without needing multiple computers.
// William Stone -- A level Computer Science student:
// 1. Not at all
// 2. No
// 3. Learn about mining and how the blocks are connected together
// 4. network propagation
// 5. Blocks being in a chain
// 6. Mine blocks
// 7. Simple
// 8. within william's attention span (5 seconds) -- Visual stuff extends his attention span
// 9. multiple nodes on one computer
// 10. dont know whats actually happening
// 11. very
// 12. graphs
// Note:
// - I am a visual learner

// Jeremy Courten -- A level Computer Science Student
// 1. Not at all
// 2. no
// 3. learn how the blocks are shared
// 4. sharing of blocks
// 5. Visualisation
// 6. let you simulates a transaction
// 7. simple
// 8. within 10 seconds
// 9. multiple nodes on one computer
// 10. lack of features
// 11. very
// 12. instructions

// Ben Varea -- A level computer science student
// 1. Very familiar
// 2. yes -- EVM (proof of stake)
// 3. Visual process -- EVM doesn't provide
// 4. Validation -- agreement between nodes
// 5. Mining blocks
// 6. mine, create, add transactions into mempool
// 7. simple
// 8. sub 10 seconds
// 9. multiple nodes on one computer
// 10. not being able to find the nonce and hash (long runtimes)
// 11. very
// 12. visualisation for the blocks to be linked, represent links between nodes

// James Charles Bouttell -- A level Computer Science student
// 1. Not at all
// 2. no
// 3. how the blocks link together
// 4. how its mined
// 5. simple
// 6. create a new transaction and then turn it block
// 7. simple
// 8. 5 seconds (note: I dont wanna wait)
// 9. single computer (cuz no friends)
// 10. not knowing what it is or how to use it
// 11. very
// 12.


// TODO
\
Unfortunately, due to time constrains, I wasn't able to find a teacher who is interested in teaching blockchain to interview.
#pagebreak()
== Intital Sucess Criteria
These are the initial Success Criteria (SC) which is what I am aiming for while developing a MVP (Minimum Viable Product). As I am developing in an agile methodology, the Success Critea might be ammended or new Success Criteria might be added in the process of iterations.

=== Success Criteria
#table(
  columns: (64pt, 33pt, 100pt, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header([*Category*], [*SC*], [*Target*], [*Justification (This is an SC because...)*], [*Testing*]),
  table.cell(
    rowspan: 7,
    align: center,
    rotate(-90deg, reflow: true)[
      *Functionality*
    ],
  ),
  $ 1.1 $,
  [Users can create a new block with a hash linked to the previous block within 1 second],
  [Ensures blocks are linked correctly and the blockchain structure is maintained; 1 second chosen so that block creation is fast enough for interactive testing and demonstration],
  [Click 'Add Block' and a new block appears with previousHash matching last block's hash],

  $ 1.2 $,
  [Users can at least 10 transactions per block before mining],
  [Ensures multiple transactions can be stored and tested; 10 transactions chosen as the amount of transaction shouldn't matter as they are hashed to strings],
  [Add transactions and verify block.transactions.length matches number added],

  $ 1.3 $,
  [Mining a block produces a hash satisfying difficulty (\u{2264}2 leading zeros) and completes \u{003C}5s],
  [Demonstrates mining process works correctly and efficiently; 2 zeros chosen as low difficulty for demonstration, 5s ensures responsiveness for users],
  [Mine a block and check hash meets difficulty; measure mining time],

  $ 1.4 $,
  [Each block has a sequential index automatically assigned],
  [Ensures proper ordering of blocks for clarity and prevents confusion; automatic indexing prevents user errors],
  [Add multiple blocks and verify block.index === previousBlock.index + 1],

  $ 1.5 $,
  [Simulator handles unexpected user behaviour (keyboard smashing/spamming)],
  [Ensures robustness against accidental or malicious user actions; protects simulator from crashes and freezes],
  [Rapidly press input buttons or type random keys; confirm simulator does not crash],

  $ 1.6 $,
  [Simulator can broadcast a newly mined block to all connected nodes using BFS traversal within 2 seconds],
  [Ensures updates propagate efficiently across the network; 2s chosen for real-time demonstration],
  [Mine a block on one node and verify all connected nodes receive it within 2 seconds],

  $ 1.7 $,
  [Simulator can broadcast a newly mined block to all connected nodes using DFS traversal within 3 seconds],
  [Ensures correctness of alternative traversal method; DFS may be slower but must reach all nodes reliably],
  [Mine a block on one node and verify all connected nodes receive it within 3 seconds],

  table.cell(
    rowspan: 6,
    align: center,
    rotate(-90deg, reflow: true)[
      *Graphical User Interface (GUI)*
    ],
  ),
  $ 2.1 $,
  [Blocks visually display index, hash, previous hash, transactions on 100x100 pixel display],
  [Ensures accessibility and usability across devices; 100x100 chosen as minimum usable resolution],
  [Observe GUI or inspect DOM elements; verify visibility of all block data],

  $ 2.2 $,
  [Transaction input form accepts strings ≤100 characters; longer inputs rejected],
  [Prevents invalid transaction data entry; 100 character limit chosen for readability and UI layout],
  [Enter valid and invalid strings; confirm validation works],

  $ 2.3 $,
  [Chain validity visually indicated (green=valid, red=invalid)],
  [Gives immediate feedback on blockchain integrity; visual feedback reduces user errors],
  [Create a block and do validations; observe color change],

  $ 2.4 $,
  [Users can expand blocks to view transactions; expansion completes \u{003C}0.5s],
  [Ensures users can inspect block details quickly; 0.5s chosen for fast but noticeable animation],
  [Click block and verify transactions displayed; measure expansion time],

  $ 2.5 $,
  [GUI updates in \u{003C}1s after any user action (add transaction, mine block)],
  [Ensures responsiveness and smooth interaction; 1 second ensures users see updates promptly without lag],
  [Add transaction or mine block; measure GUI update time],

  $ 2.6 $,
  [GUI prevents spamming (>5 transactions/sec not allowed)],
  [Prevents system overload and ensures usability; 5 per second chosen to allow quick entry but prevent crashing],
  [Attempt to add >5 transactions/sec; verify only 5 are accepted],
  table.cell(
    rowspan: 6,
    align: center,
    rotate(-90deg, reflow: true)[
      *Security and Integrity*
    ],
  ),

  $ 3.1 $,
  [Block hash matches its data exactly],
  [Ensures blockchain security and integrity; prevents unnoticed tampering],
  [Recalculate block hash and compare to stored hash],

  $ 3.2 $,
  [Tampering invalidates the chain],
  [Demonstrates immutability of blockchain; crucial property of blockchain technology],
  [Modify block data and run validation; check isChainValid() returns false],

  $ 3.3 $,
  [Mined blocks cannot have transactions altered],
  [Ensures post-mining immutability; maintains trust in the blockchain],
  [Attempt to edit mined transactions; confirm error shown],

  $ 3.4 $,
  [Input validation prevents invalid characters or excessively long strings],
  [Prevents corruption of blockchain; protects integrity and UI],
  [Enter invalid strings; verify input rejected],

  $ 3.5 $,
  [Nodes maintain consistent blockchain state after BFS broadcast],
  [Ensures network consensus; BFS guarantees shortest-path propagation to all nodes],
  [Compare blockchains across all nodes after BFS broadcast; they must match exactly],

  $ 3.6 $,
  [Nodes maintain consistent blockchain state after DFS broadcast],
  [Ensures network consensus; DFS guarantees all nodes are visited, though order may differ],
  [Compare blockchains across all nodes after DFS broadcast; they must match exactly],

  table.cell(
    rowspan: 4,
    align: center,
    rotate(-90deg, reflow: true)[
      *Performance and reliability*
    ],
  ),

  $ 4.1 $,
  [Blockchain state persists while simulator runs; saving/loading \u{003C}1s],
  [Ensures continuity and reliability; 1s chosen as fast enough for user to continue interaction without noticeable delay],
  [Reload simulator and verify blockchain is intact],

  $ 4.2 $,
  [Memory usage \u{003C}100MB for 100 blocks],
  [Ensures efficient resource usage; prevents crashes and allows multiple sessions],
  [Monitor memory usage during simulation],

  $ 4.3 $,
  [Simulator and GUI pause when window unfocused],
  [Reduces CPU usage when not actively used; increases efficiency and prevents unnecessary computations],
  [Switch window focus; observe simulation pause],

  $ 4.4 $,
  [Memory usage \u{003C}50MB for 100 blocks stored in local storage],
  [Ensures efficient resource usage on a single computer; prevents crashes and keeps simulator responsive],
  [Monitor memory usage during simulation with 100 blocks in local storage],
)
= Iterations
== Iteration 1
In Interation 1, I will be focusing on the proof of concept for the technologies that I will be using in my blockchain simulator. These includes the Breadth First Search (BFS) and Depth First Search (DFS) algorithms to simulate the propagation of blockchain within a peer-to-peer network. I will also be implementing a simplified SHA-256 hash function called fakeHash() function to generate hashes for blocks. Finally, I will be building a mining algorithm that uses the concept of nonce to find the hash of a block using web workers to improve performance.
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
=== Proof of Concept: BFS <BFS-unit-test>
Breadth First Search is an algorithm to traverse an undirected graph. A BFS algorithm starts at a selected node (often referred to as the 'root' node in tree structures) and explores all its neighbouring nodes at the present depth prior to moving on to nodes at the next depth level. This approach ensures that all nodes at the current level are visited before any nodes at the next level are explored, making BFS particularly useful for finding the shortest path in unweighted graphs.

==== Design of algorithm: BFS
The idea of layers in BFS refers to how nodes are explored based on their distance from the starting node. The first layer contains the starting node itself, the second layer includes all nodes directly connected to it, and each subsequent layer contains nodes that are one step further away. This structure means BFS explores the graph moving outward one layer at a time. Each node is therefore assigned to a specific layer according to how many edges it takes to reach it from the start.

I will use a queue data structure in my BFS algorithm to keep track of nodes to be explored. The algorithm begins by enqueuing the starting node and marking it as visited. It then enters a loop where it dequeues a node and enqueues all its unvisited neighbours, marking them as visited. This process continues until the queue is empty, meaning all reachable nodes have been visited. To store the data, I used an adjacency list — a data structure used to store a collection of unordered lists used to represent a finite graph.

==== Unit Test for BFS
For the unit test, I am making a new file `bfs.test.ts` and testing it using Bun. This allows me to test individual functions from the `bfs.ts` file by importing them into the test file.\ \
To make a unit test for my BFS algorithm, I have to firstly design some graphs and traversing them by hand, then convert them into adjacency list where I input the neighbouring nodes for each node so that the graph can be 'undestood' by the algorithm
===== Normal Test
I have designed the following basic tree (an abstract data type that is a graph that has a hierarchial structure) graph to test my algorithm (left). While traversing the graph with a BFS algorithm, I will start at node A (layer 1) and visit its neighbours C and B (layer 2). Then I will move on to layer 3 and visit F, D, and E. Therefore one of the ways to traverse the graph with the BFS algorithms is with the order: A \u{2192} C \u{2192} B \u{2192} F \u{2192} D \u{2192} E (right).
#subpar.grid(
  figure(image("images/basic_tree_graph.png", width: 100%), caption: [basic tree graph]), <a>,
  figure(image("images/bfs_tree_graph.png", width: 60%), caption: [BFS traversal of the basic tree graph]), <b>,

  columns: (1fr, 1fr),
  label: <normal-test>,
)


Since I am developing in TypeScript, I have to declare the type of my adjacency list. Therefore I have to create an interface for my adjacency lists. Considering my input being the nodes and its neighbours in an array of strings, I will require a key-value pair (a basic data structure that stores data as a collection of unique, constant keys and their corresponding, variable values). Therefore my type AList (adjancency list) takes in 2 parameters, the key as a string --- this will be the nodes and the values as an array of strings --- this will be the neighbours in arrays of strings. The interface can be defined as following:
```ts
 interface AList {
  [key: string]: string[]
}
```
Writing the nodes from the basic tree graph in an adjacency list gives me:
```ts
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
```ts
test("Normal List", () => {
  let result = bfs_traverse(normalList, "A");
  expect(result[0]).toBe("A");
  let layer1 = result.slice(1, 3).sort();
  expect(layer1).toEqual(["B", "C"]);
  let layer2 = result.slice(3).sort();
  expect(layer2).toEqual(["D", "E", "F"]);
});
```

I have also considered different starting nodes. For example, if I start at node 'B', the BFS traversal order could be B \u{2192} A \u{2192} F \u{2192} C \u{2192} D \u{2192} E. The unit test for starting at node 'B' would be:
```ts
test("Normal List", () => {
  let result = bfs_traverse(normalList, "B");
  expect(result[0]).toBe("B");
  let layer1 = result.slice(1, 3).sort();
  expect(layer1).toEqual(["A", "F"]);
  let layer2 = result.slice(3).sort();
  expect(layer2).toEqual(["C", "D", "E"]);
});
```#pagebreak()
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
```ts
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
#pagebreak()
Using the same idea of splitting the graph into layers, I can make the test for the 'bit more complicated graph' with:
```ts
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
Besides normal tests, I have also designed boundary tests to test special cases. \
Boundary tests:
+ The adjacency list only contains one node with no neighbours. Therefore, when traversing the graph starting from that single node, the expected output should be an array containing only that node.
+ The adjacency list contains multiple disconnected components. When starting the traversal from a node in one component, the expected output should only include nodes from that component.
+ The adjacency list is empty. When attempting to traverse from any starting node, the expected output should be an array containing only the starting node, as there are no other nodes to visit.
+ The adjacency list contains cycles. The BFS algorithm should handle cycles correctly by ensuring that each node is visited only once, preventing infinite loops.

The tests for the boundary cases are as follows:
```ts
test("Boundary Test: Single Node Graph", () => {
  let singleNodeList: AList = { A: [] };
  let result = bfs_traverse(singleNodeList, "A");
  expect(result).toEqual(["A"]);
});


test("Boundary Test: Disconnected Graph", () => {
  let disconnectedList: AList = {
    A: ["B"],
    B: ["A"],
    C: ["D"],
    D: ["C"],
  };
  let result = bfs_traverse(disconnectedList, "A");
  expect(result).toEqual(["A", "B"]);
});

test("Boundary Test: Empty Adjacency List", () => {
  let emptyList: AList = {};
  let result = bfs_traverse(emptyList, "A");
  expect(result).toEqual(["A"]);
});

test("Boundary Test: Cyclic Graph", () => {
  let cyclicList: AList = {
    A: ["B"],
    B: ["C"],
    C: ["A"],
  };
  let result = bfs_traverse(cyclicList, "A");
  expect(result).toEqual(["A", "B", "C"]);
});
```
===== Erroneous Test
I decided to also do erroneous testing to test how my bfs algorithm handles unexpected inputs. The erroneous tests I have designed are:
+ The starting node does not exist in the adjacency list. The expected output should be an array containing only the starting node, as there are no reachable nodes to visit.
+ The adjacency list contains nodes with invalid data types (e.g., numbers instead of strings). The BFS algorithm should handle this gracefully, either by ignoring invalid nodes or throwing an appropriate error.
```ts
test("Erroneous Test: Non-existent Start Node", () => {
  let result = bfs_traverse(normalList, "Z");
  expect(result).toEqual(["Z"]);
});

test("Erroneous Test: unexpected input types", () => {
  // @ts-ignore
  let result = bfs_traverse(200, 400);
  expect(result).toEqual([null]);
});
```

==== Development of BFS
To implement the Breadth-First Search (BFS) algorithm, I developed a function named `bfs_traverse()` that accepts two parameters: an adjacency list (`adjacencyList`) with the `AList` interface and a starting node (`startNode`) as a string. The adjacency list provides an efficient way to represent the structure of a graph, where each key corresponds to a node and each value is a list of its directly connected neighbours. The output of the function should be the traversal order of nodes as an array of strings.\
\
The algorithm begins by initialising a queue with the starting node. The queue follows the First-In-First-Out (FIFO) principle, ensuring that nodes are explored in the order they are discovered. This structure allows the algorithm to process the graph in layers, visiting all nodes that are one edge away before progressing to nodes further out. A separate visited array is also initialised to keep track of nodes that have already been explored, preventing repetition and infinite loops.\
\
Within the main while loop, the algorithm continues executing as long as the queue is not empty. At each iteration, the first node in the queue is removed (dequeue) using the `shift()` operation. The algorithm then examines each of its neighbouring nodes, obtained from the adjacency list. If a neighbour has not yet been visited, it is appended to both the visited array and the queue, ensuring that it will be explored in subsequent iterations.\
\
The process continues until the queue becomes empty, meaning that all nodes reachable from the starting node have been visited. The function then returns the visited array, representing the order in which the nodes were explored.\
\
This implementation adopts an iterative approach rather than a recursive one, which enhances efficiency and avoids stack overflow in large graphs. The use of a queue structure naturally supports the concept of layered traversal, ensuring that all nodes at distance n from the starting node are processed before any nodes at distance n + 1. This guarantees that BFS correctly identifies the shortest path (in terms of the number of edges) in an unweighted graph while systematically exploring all reachable vertices.\
\
The final code for my BFS Proof of Concept is as follows:
```ts
function bfs_traverse(adjacencyList: AList, startNode: string): string[] {
  // Initialise the queue and mark the starting node as visited
  let queue: string[] = [startNode];
  let visited: string[] = [startNode];

  // Continue exploring while there are nodes left in the queue
  while (queue.length) {
    // Dequeue the next node to explore
    let node: string = queue.shift() ?? "";
    if (!node) continue;

    // Explore each unvisited neighbour of the current node
    for (let neighbour of adjacencyList[node]) {
      if (!visited.includes(neighbour)) {
        visited.push(neighbour);
        queue.push(neighbour); // Enqueue neighbour for later exploration
      }
    }
  }

  // Return the order in which nodes were visited
  return visited;
}
```\
\
\
\
This part of the code:
```ts
for (let neighbour of adjacencyList[node]) {
  if (!visited.includes(neighbour)) {
    visited.push(neighbour);
    queue.push(neighbour); // Enqueue neighbour for later exploration
  }
}
```
determines how the algorithm traverses the graph. For each node dequeued from the queue, it iterates through all its neighbours as defined in the adjacency list. If a neighbour has not been visited yet, it is marked as visited by adding it to the visited array and enqueued for future exploration. By adding neighbours to the end of the queue, the algorithm ensures a First-In-First-Out (FIFO) traversal order, meaning that nodes closer to the starting node are fully explored before moving on to nodes that are further away. This is what creates the layered property of BFS, allowing it to visit nodes level by level.\
\
==== Testing Results
After implementing the BFS algorithm, I ran the unit tests I designed earlier. The results were successful, with the normal testing passing as expected. The BFS algorithm correctly traversed the basic tree graph and the more complicated graph, producing the expected order of node visits.\
\
All of the boundary tests passed, including the 'Single Node Graph' and 'Disconnected Graph' tests. The 'Empty Adjacency List' boundary test produced an error because the algorithm attempted to access neighbours for a node that does not exist in the adjacency list, resulting in a `TypeError`.\
\
Both erroneous tests, the 'Non-existent Start Node' and the 'unexpected input types', also failed for similar reasons: the code assumed that the start node would always exist in the adjacency list and that the inputs would be of valid types. When this assumption was violated, the algorithm tried to iterate over undefined, causing runtime errors.\

#figure(
  image("images/bfs_fail_test_result.png", width: 42%),
  caption: [BFS Test Results - Some Boundary and Erroneous Test Failing],
)

To fix these issues, I added a defensive check before iterating over neighbours. If a node does not exist in the adjacency list, the algorithm simply skips the neighbour loop, allowing it to safely return the starting node as visited. Additionally, a type check can be added at the start to handle completely invalid inputs gracefully, returning [null] if the input types are incorrect.\
\
To fix this, I added a defensive check at the start of the function before iterating over neighbours:
```ts
  // Defensive type check for completely invalid inputs
  if (typeof adjacencyList !== "object" || typeof startNode !== "string") {
    // @ts-ignore
    return [null];
  }
```
Within the while loop, I also added a check to ensure the current node exists in the adjacency list before attempting to access its neighbours:
```ts
    // Skip nodes not in the adjacency list
    if (!(node in adjacencyList)) continue;
```
After applying these fixes, all unit tests passed successfully. The BFS algorithm now correctly handles normal, boundary, and erroneous cases without crashing, demonstrating that it is robust, reliable, and behaves as expected across a wide range of scenarios.
#figure(image("images/bfs_pass_test.png", width: 100%), caption: [BFS Test Results - All Tests Passed Successfully])
#pagebreak()
=== Proof of Concept: DFS
Depth First Serch is another algorithm to traverse an undirected graph. A DFS algorithm also starts at a selected node (the 'root' node) and explores as far as possible along each branch before backtracking. This means that DFS goes deep into the graph, visiting a node and then recursively visiting one of its unvisited neighbours until it reaches a node with no unvisited neighbours. At this point, the algorithm backtracks to the most recent node that has unvisited neighbours and continues the process until all nodes have been visited.

==== Design of algorithm: DFS
Depth-first search (DFS) explores a graph by moving as far as possible along each branch before backtracking. The algorithm conceptually follows a single path from the starting node, exploring one neighbour at a time until it reaches a node with no unvisited neighbours, at which point it backtracks to the previous node to explore other paths.\
\
I will use a stack data structure in my DFS algorithm to keep track of nodes to be explored. The algorithm begins by pushing the starting node onto the stack and marking it as visited. It then enters a loop where it pops a node from the stack, and pushes all its unvisited neighbours onto the stack, marking them as visited. This process continues until the stack is empty, meaning all reachable nodes have been visited.\
\
I decided to make use of the call stack and implement the DFS algorithm recursively. The algorithm starts at the root node, marks it as visited, and then recursively visits each unvisited neighbour. This continues until all nodes have been visited. Using recursion in DFS is justified because it naturally mirrors the algorithm's logic of exploring 'as deep as possible' along a branch before backtracking. The call stack inherently acts as the stack needed to keep track of nodes yet to be explored, so recursion simplifies the code and avoids manually managing a separate stack. It also makes the algorithm easier to read and understand, especially for complex graphs, since each recursive call represents the exploration of a node and its subtree. Recursion is particularly suitable for small to medium-sized graphs, like the ones in my simulator, because the depth of recursion is limited and won't cause stack overflow on a typical machine.\

// Justify why it is pre order
\
I will also using the same adjacency list data structure as BFS to store the graph.
==== Unit Test for DFS
Again I will be using Bun for the unit test, and the testing file will be called `dfs.test.ts`. This is used to test the `dfs_traverse()` function if it can accurately traverse the graph input with a Depth First Search algorithm.
===== Normal Test
I am using the same tree graph from BFS to test my DFS. However this time I will have to manually traverse it in a DFS algorithm. Since the graph is traversed with pre-order DFS, there is only one way to traverse the graph. The test is also less complicated to set up as only one case has to be considered. With the basic tree graph that we had, if the DFS traversal starts at node 'A', then the DFS traversal order is A \u{2192} C \u{2192} D \u{2192} E \u{2192} B \u{2192} F. Please find the dfs traversal on the next page.

#subpar.grid(
  figure(image("images/basic_tree_graph.png", width: 100%), caption: [basic tree graph]), <a>,
  figure(image("images/dfs_tree_graph.jpeg", width: 76%), caption: [DFS traversal of the basic tree graph]), <b>,

  columns: (1fr, 1fr),
  label: <normal-test>,
)

The 'bit more complicated graph' also has to be traversed again with a DFS algorithm:
#figure(
  image("images/DFS_traversal_of_little_more_complicated_graph.jpeg", width: 50%),
  caption: [DFS traversal of the a bit more complicated graph],
)

The test code for the normal tests are as follows:
```ts
test("Normal List", () => {
  let result = dfs_traverse(normalList, "A");
  expect(result).toEqual(["A", "C", "D", "E", "B", "F"]);
});

test("Complicated List", () => {
  let result = dfs_traverse(complicatedList, "M");
  expect(result).toEqual(["M", "D", "B", "H", "A", "C", "E", "G", "F", "J", "L", "I", "N", "O", "K"])
});
```
#pagebreak()
===== Boundary Test
I am using the same boundary tests for my DFS algorithm from my BFS test. Please refer back to unit test in @BFS-unit-test for the code of the tests (The `bfs_traverse()` function is replaced by the `dfs_traverse()` function). The tests includes:
- Single Node Graph
- Disconnected Graph
- Empty Adjacency list
- Cyclic Graph

===== Erroneous Test
I am also using the same erroneous tests for my DFS algorithm from my BFS test. Please refer back to unit test in @BFS-unit-test for the code of the tests (The `bfs_traverse()` function is replaced by the `dfs_traverse()` function). The tests includes:
- Non-existent Start Node
- unexpected input types\
\
==== Development of DFS
Similarly to BFS, to implement the `Depth-First Search (DFS)` algorithm, I developed a function named `dfs_traverse()` that accepts two parameters: an adjacency list (`adjacencyList`) with the AList interface and a starting node (`startNode`) as a string. The adjacency list efficiently represents the graph structure, where each key corresponds to a node and each value is a list of its directly connected neighbours. The output of the function is an array of strings representing the order in which the nodes were visited during traversal.\
\
The algorithm begins by marking the starting node as visited. It then recursively explores each of the starting node's unvisited neighbours, applying the same process at each subsequent node. This recursive approach leverages the call stack, which behaves as a *Last-In-First-Out (LIFO)* structure, to keep track of nodes that still have unvisited neighbours. Each recursive call pushes the current node onto the stack, so the most recently discovered node is explored first, while nodes visited earlier wait in the stack to be resumed later. Once a node has no more unvisited neighbours, the function returns, popping the previous node from the stack and backtracking to explore any remaining neighbours. This LIFO behavior naturally implements depth-first traversal without needing an explicit stack data structure.\
\
During traversal, a visited array is maintained to record which nodes have already been explored. This prevents revisiting nodes and avoids infinite loops in cyclic graphs. The recursion continues until all nodes reachable from the starting node have been visited, at which point the function returns the visited array, representing the traversal order.\
\
This implementation adopts a recursive approach rather than an iterative one with a manual stack, which simplifies the code and clearly shows the conceptual idea of DFS—exploring one branch as deeply as possible before backtracking. Since at the end product there will be a maximum number of nodes (to simulate users), the run time of the speed will not massively increase comparing to the iterative approach.\
\
Learning from the failure of BFS tests, I decided to add these defensive checks because of what I learned during the BFS development. In BFS, the “Non-existent Start Node” and “unexpected input types” tests initially failed because the algorithm assumed valid input and that the start node existed in the adjacency list. By including similar type and existence checks in DFS, the function can now safely handle invalid or missing inputs without crashing, ensuring robustness for all test cases.\
\
The final code for my DFS recursive Proof of Concept is as follows:
```ts
function dfs_traverse(
  adjacencyList: AList,
  startNode: string,
  visited: string[] = []
): string[] {
  // Defensive type check for completely invalid inputs
  if (typeof adjacencyList !== "object" || typeof startNode !== "string") {
    // @ts-ignore
    return [null];
  }
  // Return the start startNode even if it doesn't exist in the graph
  if (!adjacencyList[startNode]) {
    return [startNode];
  }

  // Skip startNodes that do not exist in the adjacency list
  if (!(startNode in adjacencyList)) return visited;

  // Mark the current startNode as visited
  if (!visited.includes(startNode)) {
    visited.push(startNode);
  }

  // Recursively visit each unvisited neighbour
  for (let neighbour of adjacencyList[startNode]) {
    if (!visited.includes(neighbour)) {
      dfs_traverse(adjacencyList, neighbour, visited);
    }
  }

  return visited;
}
```

In this part of code:
```ts
for (let neighbour of adjacencyList[startNode]) {
  if (!visited.includes(neighbour)) {
    dfs_traverse(adjacencyList, neighbour, visited);
  }
}
```
recursion and the call stack is used to track nodes with unvisited neighbours. Each recursive call pushes the current node's state onto the stack, explores its neighbours, and backtracks automatically when there are no more nodes to visit. This allows depth-first traversal without an explicit stack, ensuring all reachable nodes are visited.
#pagebreak()
===== Test results
Again, when nothing is created, the tests fail due to no such function `dfs_traverse()` being defined.

After the code is made, the normal tests pass as expected. The DFS algorithm correctly traversed the basic tree graph and the more complicated graph, producing the expected order of node visits.\
\
Crossing fingers, all of the boundary tests passed, including the 'Single Node Graph' and 'Disconnected Graph' tests. This is because the defensive checks I added earlier worked perfectly. The 'Empty Adjacency List' boundary test also passed this time because of the defensive check that I added at the start of the function to check if the start node exists in the adjacency list.\
\
Both erroneous tests, the 'Non-existent Start Node' and the 'unexpected input types', also passed this time because of the defensive checks I added at the start of the function to check for invalid input types and the existence of the start node in the adjacency list.\
\
#figure(
  image("images/dfs_pass_test.png", width: 100%),
  caption: [DFS Test Results - All Tests Passed Successfully],
)
#pagebreak()
=== Proof of Concept: Hashing
Hashing is a fundamental concept in blockchain technology, used to ensure data integrity and security. A hash function takes an input (or 'message') and returns a fixed-size string of bytes. The output appears random and is unique to the specific input. Even a small change in the input will produce a significantly different hash, a property known as the avalanche effect. In blockchain, hashing is used to link blocks together, verify transactions, and secure data against tampering.
BlockChain commonly uses the SHA-256 (Secure Hash Algorithm 256-bit) hashing algorithm. However, brute forcing SHA-256 is an incredibly computational heavy task. Instead, I will be creating a simplified version of a hashing function that captures the essence of how hashing works in blockchain.

==== Research on the SHA-256 algorithm
Summarising this article about cyber security from #link("https://www.simplilearn.com/tutorials/cyber-security-tutorial/sha-256-algorithm")[simplilearn] #footnote[https://www.simplilearn.com/tutorials/cyber-security-tutorial/sha-256-algorithm], the SHA-256 algorithm always hashes the results to 256 bits and the process is irreversible. This is done by:
+ Firstly padding bits (adding extra bits to the message so that the length is exactly 64 bits short of a multiple of 512)
+ Then add 64 bits of data now to make the final plaintet a multiple of 512. The added data is calculated by applying the modulus to the original cleartext
+ The padded message is then divided into 512-bit blocks, each processed through 64 rounds of bitwise operations such as AND, OR, XOR, and right rotations.
+ Each round uses predefined constants and functions to mix and compress the data, progressively transforming it into a unique 256-bit digest.
+ The final output, known as the message digest, is deterministic — the same input always produces the same hash — but infeasible to reverse or predict.
+ This structure ensures the avalanche effect, where even a one-bit change in the input drastically alters the output, making SHA-256 ideal for data integrity and blockchain security.


==== Design of algorithm: Hashing
I have to simplify the SHA-256 algorithm to create a basic hashing function that is computationally less intensive while still demonstrating the core principles of hashing.
Therefore I am coming up with my own simplified hashing algorithm:
Iterate over each character in the input string:
- Set hash = 0
- Multiply the current hash by 67; 67 is a prime number, chosen because multiplying by a prime reduces collisions and spreads the effect of each character across the final hash value.
- Add the character's ASCII code, ensuring each character uniquely influences the hash.
- Mask with 0xffffffff to keep the result within 32 bits, simulating integer overflow; 0xffffffff—which in binary is 32 ones—keeps only the lowest 32 bits of a number, ensuring the hash behaves like a real 32-bit hash, remains fixed-size, deterministic, and avoids large-number rounding errors in TypeScript.
- Convert the 32-bit integer to hexadecimal, producing a fixed-length string representation suitable for comparing against the difficulty target in the PoW simulation.
- Limitation of simplication: As the result is constrained to 32 bits, this can lead to collisions (different inputs producing the same hash), which is a limitation of this simplified approach.\
\
For example, if a string 'cat' is hashed using this algorithm, the steps would be:
+ The data is being split into individual characters 'c','a', and 't'
+ Initially the hash = 0, therefore the the updated hash will just be `0*67 + ASCII code 99 = 99`
+ Then the algorithm moves to the second character 'a' and multiply the current hash by 67 then add the ASCII code for 'a' which gives `new hash = 99 * 67 + 97 = 6730`
+ The algorithms repeats step 3 on the last character 't' (ASCII code of 116) giving `hash = 6730 * 67 + 116 = 451026`
+ Convert `451026` and `0xffffffff` (32 ones) into binary and apply a bitwise AND mask which doesnt make any difference since the hash of string `cat` doesn't exceed 32-bit
+ Convert `451026` into hexadecimal which gives `6e1d2`
+ Add 0's in front of `6e1d2` to form a 32 bit data which is 8 hexadecimal characters
This process cannot be reversed as you wouldn't know how many characters there are or what the characters are when you work backwards.
==== Unit Test
This time I will be using Bun for the unit test, testing the two main concepts of hashing:
+ Determinism: The same input always produces the same hash.
+ Avalanche Effect: A small change in input results in a significantly different hash.

I have also made an edge case test of empty string input to ensure that the hashing function is still producing a valid hash for an empty input.

```ts
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
test("fakeHash produces the same hash for the same input", () => {
  expect(fakeHash("hello")).toBe(fakeHash("hello"));
});
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
```

==== Development
To implement the simplified hashing algorithm, I created a function named `simpleHash()` that takes a string input and returns a fixed-size hexadecimal hash. The algorithm processes each character in the input string, updating the hash value through multiplication, addition of ASCII codes, and bitwise operations to ensure it remains within 32 bits. Finally, the hash is converted to a hexadecimal string, padded to ensure a consistent length.
Here is the implementation of the `simpleHash()` function:
```ts
function fakeHash(input: string): string {
  let hash = 0;
  for (let i = 0; i < input.length; i++) {
    hash = (hash * 67 + input.charCodeAt(i)) & 0xffffffff;
  }
  return hash.toString(16).padStart(8, "0");
}
```
During manual testing, certain inputs such as 'hello world' produced negative hash outputs (e.g. `-16dc11bc`). This occurred because TypeScript stores numbers as signed 32-bit integers when performing bitwise operations. When the intermediate hash value exceeded the signed integer limit ($2^31 - 1 = 2147483647$), it wrapped around to a negative number due to integer overflow.\

In the context of hashing, a negative hexadecimal output is invalid because hashes are intended to represent unsigned binary values. A valid hash should always consist of positive hexadecimal digits.\

To address this, I applied a zero-fill right shift (`>>> 0`) before converting the final hash value into hexadecimal. This operation reinterprets the number as an unsigned 32-bit integer, effectively discarding any sign bit and ensuring all outputs remain within the expected range (0 to 0xFFFFFFFF).\

This change guarantees that:
- The hash function consistently produces valid, non-negative hexadecimal outputs.
- The hashing process aligns conceptually with real cryptographic hash algorithms, which always yield fixed-length, unsigned binary values.\
The updated part of the code is as follows:
```ts
    hash = (hash * 67 + input.charCodeAt(i)) >>> 0;
```
Now the hashed value for 'hello world' is `e923ee44`, which is a valid positive hexadecimal string.
==== Testing Results
After implementing the simplified hashing algorithm, I ran the unit tests I designed earlier. The results were successful, with all tests passing as expected. The hashing function demonstrated determinism by consistently producing the same hash for identical inputs. Additionally, the avalanche effect was confirmed, as even minor changes in the input string resulted in significantly different hash outputs. The edge case test for an empty string also passed, confirming that the function can handle such inputs gracefully and produce a valid hash. Overall, the hashing function performed reliably across all test scenarios, validating its correctness and robustness.
#figure(
  image("images/hash_test_result.png", width: 49%),
  caption: [Hashing Test Results - All Tests Passed Successfully],
)
#pagebreak()
=== Proof of Concept: Proof of Work Mining
I have decided to implement a simplified version of the Proof of Work (PoW) mining algorithm to demonstrate the concept of mining in blockchain technology. The goal of PoW is to find a nonce (a number used once) such that when it is combined with the block's data and hashed, the resulting hash meets a specific difficulty target, typically defined by a certain number of leading zeros in its binary representation. This is probably the most computationally intensive part of blockchain technology, as it requires significant processing power to find a valid nonce through trial and error.
==== Research on Proof of Work Mining
After researching on Proof of Work (PoW) mining from Investopedia #footnote[https://www.investopedia.com/terms/p/proof-work.asp], Wikipedia #footnote[https://en.wikipedia.org/wiki/Proof_of_work], Medium #footnote[https://scryptplatform.medium.com/proof-of-work-in-bitcoin-043ff9fa0d2d] and Bitcoin StackExchange #footnote[https://bitcoin.stackexchange.com/questions/57684/proof-of-work-how-are-target-difficultly-and-number-of-leading-zeros-related-t], I have summarised the following key points about PoW mining:
- Proof of Work (PoW) is a consensus mechanism in blockchain technology where participants (miners) solve complex mathematical puzzles to validate transactions and secure the network.
- Leading Zeros in PoW: A key aspect of PoW is the requirement for a hash to meet a specific difficulty target, often expressed as a number of leading zeros in the hash output. This condition ensures that miners expend a significant amount of computational effort to find a valid hash.
- The exact hash value doesn't matter: The focus on leading zeros rather than the exact hash value allows for flexibility in the mining process. Miners adjust a nonce value and rehash the block's data repeatedly until they find a hash that meets the difficulty target. This approach makes the process probabilistic, ensuring that finding a valid hash requires substantial computational work, but the exact hash value is not predetermined.
==== Design of algorithm: Proof of Work Mining
To ensure the speed of mining and simulate the reality of mining rigs which uses multicore CPU/GPU to mine, I have decided to use *web workers* to implement the PoW mining algorithm. Web workers allow for running scripts in background threads, enabling parallel execution without blocking the main thread. This is particularly useful for computationally intensive tasks like mining, as it allows the user interface to remain responsive while the mining process is ongoing.\
\
Initially, I planned to use *WebGPU* for the parallel mining. This means that I will be able to use the GPU in the user's computer to mine the blocks. However, I decided that this wouldn't fit the blockchain simulator because the ultimate goal of the project is to demonstrate how blockchains work, not to max out hardware performance. WebGPU adds a ton of unnecessary complexity -- it's built for graphics and parallel vector math, not for small, iterative CPU tasks like Proof of Work. It is also not consistently supported across browsers and could easily cause crashes or overheating on student's devices, limiting the program's accessibility for the students (considering the students would have an average computer). Since my target audience is general A level students. This means that I need something that runs smoothly and safely in any browsers without setup issues. Web workers are a better fit as they allow the user to see realistic mining by simulating parallel computation across CPU threads, keeping the focus on the blockchain logic rather than GPU technicalities.
#pagebreak()
==== Algorithm Plan
The PoW mining algorithm works as follows:
+ The main thread initiates multiple web workers, each assigned a unique range of nonce values to test.
+ Each worker receives the block data, difficulty level, starting nonce, and chunk size (the range of nonces to test).
+ The worker iterates through its assigned nonce range, combining each nonce with the block data and computing the hash using the simplified hashing function.
+ The hash is converted to binary, and the number of leading zeros is counted.
+ If a hash meets or exceeds the difficulty target (i.e., has the required number of leading zeros), the worker sends a message back to the main thread with the valid nonce and hash.
+ The main thread listens for messages from workers. Upon receiving a valid nonce, it terminates all other workers to stop further computation.
+ The valid nonce and hash are then used to complete the block, which can be added to the blockchain.
This approach effectively simulates the distributed nature of mining in a real blockchain network, where multiple miners work in parallel to find a valid nonce. By leveraging web workers, the mining process can be parallel, significantly speeding up the search for a valid nonce.

I will have to split the PoW mining algorithm into two files:
+ `main.ts` - This file contains the main thread code that initiates web workers and handles communication with them.
+ `worker.ts` - This file contains the code that runs in each web worker, performing the nonce testing and hash computation.

`main.ts`
- Initialises web workers and assigns nonce ranges
- Listens for messages from workers
- Terminates workers upon finding a valid nonce
`worker.ts`
- Receives block data, difficulty, starting nonce, and chunk size
- Iterates through assigned nonce range
- Computes hash and checks for leading zeros
- Sends valid nonce and hash back to main thread

==== Development
`main.ts` - the controller of the mining simulation. It manages parallelism, allocates work, and handles termination, ensuring that mining can proceed in parallel without blocking the main thread.

Inputs:
- baseData: string - the base string for the proof-of-work computation.
- difficulty: number - the number of leading zeros required in the hash.

Outputs:
- Logs to the console whenever mining starts, a valid nonce is found, or mining stops.
- A valid nonce and its hash are reported when found.

Key Variables:
- `NUM_WORKERS` - number of parallel worker threads to use.
- `CHUNK_SIZE` - the number of nonces each worker processes per batch.
- `nonceOffset` - tracks the starting nonce for the next batch of work.
- running - a boolean flag to indicate if mining is active.
- workers - array storing all active Worker instances.

Functions:
- `startMining()` - initialises mining, creates workers, assigns work in chunks, and handles results.
  - Uses worker.postMessage() to send work chunks to workers.
  - Uses setTimeout(assignWork, 0) to schedule subsequent chunks asynchronously, allowing non-blocking operation.
- `stopMining()` - terminates all active workers and clears state.

The code for `main.ts` is as follows:
```ts
let NUM_WORKERS = 4;
let CHUNK_SIZE = 50000;

let nonceOffset = 0; // Tracks the starting nonce for the next batch
let running = false; // Indicates if mining is currently active
let workers: Worker[] = [];

function startMining(baseData: string, difficulty: number) {
  if (running) {
    console.log("Mining already in progress.");
    return;
  }

  nonceOffset = 0;
  running = true;
  console.log(
    `Starting mining with string="${baseData}", difficulty=${difficulty}, threads=${NUM_WORKERS}`
  );

  // Creating workers
  for (let i = 0; i < NUM_WORKERS; i++) {
    let worker = new Worker("worker.ts", { type: "module" });
    workers.push(worker);

    // Handle message from worker when a valid nonce is found
    worker.onmessage = (e) => {
      console.log(`=== HIT! nonce=${e.data.nonce}, hash=${e.data.hash}`);
      stopMining(); // Stop all workers when one finds a valid nonce
    };

    // Assign work to the worker in repeated chunks
    let assignWork = () => {
      if (!running) return;
      worker.postMessage({
        baseData,
        difficulty,
        startNonce: nonceOffset,
        chunkSize: CHUNK_SIZE,
      });
      nonceOffset += CHUNK_SIZE; // Increment nonce start for next batch
      setTimeout(assignWork, 0); // Schedule next batch asynchronously
    };

    assignWork(); // Start first batch
  }
}

// Terminate all workers when nonce is found or mining is stopped
function stopMining() {
  running = false;
  for (let w of workers) w.terminate();
  workers.length = 0;
  console.log("Mining stopped.");
}
```

The `worker.ts` file contains the code executed in each web worker. It processes a batch of nonces to attempt to find one that satisfies the proof-of-work requirement.\
\

Inputs (via MessageEvent):
- baseData: string - the same base string from main.ts.
- difficulty: number - required number of leading zeros in the hash.
- startNonce: number - the starting nonce for the current batch.
- chunkSize: number - number of nonces to process in this batch.

Outputs:
- Posts a message back to the main thread when a valid nonce is found: { nonce, hash }.

Key Variables & Functions:
- `fakeHash()` function from the hashing PoC
- prefix - a string of zeros equal to the difficulty, used to check if a hash satisfies the proof-of-work requirement.
- The main work loop iterates over the nonce batch, applies `fakeHash()` to each baseData + nonce string, and checks if the hash starts with the required number of zeros (`hash.startsWith(prefix)`).

Use of Web Worker:
- The worker runs independently of the main thread, allowing parallel computation without blocking UI or main execution.
- Recieves work chunks via onmessage and sends results back using postMessage.

The code for `worker.ts` is as follows:
```ts
export interface WorkerMessage {
  baseData: string;
  difficulty: number;
  startNonce: number;
  chunkSize: number;
}

// Simple fake hash function
function fakeHash(input: string): string {
  let hash = 0;
  for (let i = 0; i < input.length; i++) {
    hash = (hash * 67 + input.charCodeAt(i)) >>> 0;
  }
  return hash.toString(16).padStart(8, "0");
}

// Handle messages from the main thread
self.onmessage = (e: MessageEvent<WorkerMessage>) => {
  let { baseData, difficulty, startNonce, chunkSize } = e.data;
  let prefix = "0".repeat(difficulty);

  for (let i = 0; i < chunkSize; i++) {
    let nonce = startNonce + i;
    let hash = fakeHash(`${baseData}${nonce}`);

    // Log the attempt for debugging
    console.log(`Worker trying nonce=${nonce}, target=${prefix}, hash=${hash}`);

    // Check if hash meets difficulty
    if (hash.startsWith(prefix)) {
      self.postMessage({ nonce, hash });
      break; // stop once a valid nonce is found
    }
  }
};
```
==== Issues with Bun
While developing the PoW mining algorithm using web workers, I encountered an issue with Bun. As Bun only serves one file at a time, I was able to serve `main.ts` but not `worker.ts`. This limitation meant that when the main thread attempted to create a new worker with `new Worker("worker.ts", { type: "module" });`, it could not find the `worker.ts` file, leading to errors and preventing the workers from being created successfully.

==== Approach 1
This can be resolved by using a different environment that supports multiple file serving, such as a traditional web server or vite -- development server and build tool for web projects. However, with this approach, we will have to transpile the code into JavaScript and run it in a browser console. An html file will also be needed to load the `main.js` file. The functions `startMining` and `stopMining` has to be exposed to the global environment to be able to call them from the browser console. Therefore these two lines have to be added to `main.ts`:
```ts
// Expose functions to the global scope
(self as any).startMining = startMining;
(self as any).stopMining = stopMining;
```
This works but it is not ideal for my use case as I want to keep the code in TypeScript for better type safety and developer experience.
#figure(image("images/vite.png"), caption: [Vite Development Server Serving Multiple Files])
This is not the best approach since I want to keep the code in TypeScript for better type safety and developer experience.
==== Approach 2
Another approach to resolve this issue in Bun is to create a simple HTTP server that serves both `main.ts` and `worker.ts`. This way, when the main thread creates a new worker, it can successfully fetch the `worker.ts` file from the server. Here is how I implemented it:
```ts
// @ts-ignore
import { serve } from "bun";

serve({
  port: 3000,
  // Handle each incoming HTTP request
  fetch(req: Request) {
    let url = new URL(req.url);
    let path = `.${url.pathname}`;

    try {
      if (url.pathname === "/") {
        path = "./index.html";
      }
      // Respond with the requested file
      // @ts-ignore
      return new Response(Bun.file(path));
    } catch {
      return new Response("Not found", { status: 404 });
    }
  },
});

console.log("Server running at http://localhost:3000");
```
This works. However it also requires the code to be transpiled into JavaScript and run in a browser console. An html file will also be needed to load the `main.js` file. The functions `startMining` and `stopMining` has to be exposed to the global environment to be able to call them from the browser console. Therefore these two lines have to be added to `main.ts`.
#figure(image("images/bun.png"), caption: [Bun HTTP Server Serving Multiple Files])
N.B. The error for favicon indicates that the browser is trying to fetch a favicon.ico file which is not present on the server. This is a common behaviour of browsers to look for a favicon by default. This does not affect the functionality of the PoW mining simulation. However, this shows that I am using the Bun server to serve multiple files.
==== Approach 3
Since I will not need to use the worker code anywhere else in my blockchain simulator. Therefore I had another approach which is slightly less modular but works perfectly in Bun. I decided to inline the worker code as a Blob within `main.ts`. This way, the worker code is encapsulated within the main file, allowing me to create workers without needing to serve a separate file. Here is how I implemented it:
```ts
let NUM_WORKERS = 20;
let CHUNK_SIZE = 50000;

let nonceOffset = 0; // Tracks the starting nonce for the next batch
let running = false; // Indicates if mining is currently active
let workers: Worker[] = [];

function startMining(baseData: string, difficulty: number) {
  if (running) {
    console.log("Mining already in progress.");
    return;
  }

  nonceOffset = 0;
  running = true;
  console.log(
    `Starting mining with string="${baseData}", difficulty=${difficulty}, threads=${NUM_WORKERS}`
  );

  let workerCode:string = `
    function fakeHash(input) {
      let hash = 0;
      for (let i = 0; i < input.length; i++) {
        hash = (hash * 67 + input.charCodeAt(i)) >>> 0;
      }
      return hash.toString(16).padStart(8, "0");
    }

    self.onmessage = (e) => {
      let { baseData, difficulty, startNonce, chunkSize } = e.data;
      let prefix = "0".repeat(difficulty);
      for (let i = 0; i < chunkSize; i++) {
        let nonce = startNonce + i;
        let hash = fakeHash(baseData + nonce);
        if (hash.startsWith(prefix)) {
          self.postMessage({ nonce, hash });
          break;
        }
      }
    };
`;
  // Creating workers
  for (let i = 0; i < NUM_WORKERS; i++) {
    let blob = new Blob([workerCode], { type: "application/javascript" });
    let worker = new Worker(URL.createObjectURL(blob));

    workers.push(worker);

    // Handle message from worker when a valid nonce is found
    worker.onmessage = (e) => {
      console.log(`=== HIT! nonce=${e.data.nonce}, hash=${e.data.hash}`);
      stopMining(); // Stop all workers when one finds a valid nonce
    };

    // Assign work to the worker in repeated chunks
    let assignWork = () => {
      if (!running) return;
      worker.postMessage({
        baseData,
        difficulty,
        startNonce: nonceOffset,
        chunkSize: CHUNK_SIZE,
      });
      nonceOffset += CHUNK_SIZE; // Increment nonce start for next batch
      setTimeout(assignWork, 0); // Schedule next batch asynchronously
    };

    assignWork(); // Start first batch
  }
}

// Terminate all workers when nonce is found or mining is stopped
function stopMining() {
  running = false;
  for (let w of workers) w.terminate();
  workers.length = 0;
  console.log("Mining stopped.");
}
```
In this approach I don't have to serve multiple files and the code remains in TypeScript. The worker code is defined as a string within `main.ts`, and a Blob is created from this string to instantiate the workers. This allows the mining simulation to run entirely within Bun without the need for an external server or multiple files. Therefore this is the preferred approach for my PoW mining simulation in Bun.#pagebreak()
==== PoW Testing
I am using two different computers to test the PoW mining algorithm:
+ A high performance computer with Intel(R) Core(TM) i5-14500, 2.60 GHz, 32.0 GB DDR5 RAM, which has 14 cores and 20 threads#footnote[Spec sheet: https://www.intel.com/content/www/us/en/products/sku/236784/intel-core-i5-processor-14500-24m-cache-up-to-5-00-ghz/specifications.html]. Theoretically it should be able to handle 20 web workers at the same time.
+ A medium performance laptop with 13th Gen Intel(R) Core(TM) i5-1335U (1.30 GHz), DDR4 16GB RAM, which has 10 cores and 12 threads#footnote[spec sheet:https://www.intel.com/content/www/us/en/products/sku/232153/intel-core-i51335u-processor-12m-cache-up-to-4-60-ghz/specifications.html]. Therefore theoretically it should be able to handle 12 web workers at the same time.
I will use the `performance.now()` method to measure the run time for 10 times in each case and take the mean average of each results to make it accurate. Both computers will be tested with the same input string "Hello World" and difficulty level of 4 leading zeros. The number of web workers will be varied from 1 to 12 for the medium performance laptop, and from 1 to 20 for the high performance computer.
```ts
// Add this at the start of main.ts
let startTime: number;

// Adding this line at the start of the startMining function
startTime = performance.now();

// Adding these two lines at the end of the startMining function
let endTime = performance.now();
console.log(`Mining took ${(endTime - startTime).toFixed(2)} ms`);
```
I expect to see a decrease in run time as the number of web workers increases, indicating that the web workers are effectively utilising multiple threads for parallel processing.
#pagebreak()
==== Testing Results
After running the tests on both computers with the blockchain network (control variable) difficulty of 4. I have collected the results and recorded it in the following spreadsheet:
#figure(
  image("images/pow_test_result.png", width: 90%),
  caption: [proof of work test result -- [Note: All measurement results are in milliseconds (ms)]],
)

I have noticed a significant decrease in run time for mining from the first few core, however this decrease becomes less significant as the number of cores continue to increase. This means that there will be an optimal number of threads to be used to get a decent performance, and after that, the performance will still increase, but the performance gain will be trivial. \
\
// Standard Deviaiton Calculation
// large standard deviation = inconsistent performance
I have also calculated the standard deviation (s.d., denoted by $s^2$) for samples with $ s^2 = Sigma(x_i - overline(x))^2/(n-1) $ of both execution and found the mean for them. This tells us how far each data point is from the mean run time. Notice that the standard deviation for run time on the high performance computer is \u{223C}4.4\u{00D7} that of the medium performance. This means that the performance will be more inconsistent on lower spec computers. Hence, \
\
Interestingly, when I set the number of web workers to something extreme like 200 (this result is not included in any of the calculations for mean results), the runtime becomes unstable because I am massively oversubscribing the CPU. Each worker runs in its own thread, so having far more workers than CPU threads forces the system to constantly switch between them (called context switching). This burns up CPU time just managing threads instead of actually mining. On top of that, memory usage spikes and the browser or Bun runtime struggles to coordinate all those workers, causing delays, crashes, or inconsistent runtimes. Therefore I will have to find the optimal number of threads for the user not to oversubscribe their CPU or use up all their threads, so that other software cannot be run at the same time.\
#figure(image("images/desmos.png", width: 120%), caption: [pow test results plotted on desmos])
On this diagram, the x-axis represents the number of threads being used to run the simulation and the y-axis is the tested runtime. The green dots represents the performance for the high performance computer while the blue dots represents the performance for the medium performance computer. After trying every types of regression line on Desmos, I have found out that the power regression fits the best, with a *coefficient of determination* $r^2$ of 0.987 and 0.9837 on the high and medium performance computer respectively. This means that the result for runtime can be explained by the number of cores 98.7% and 98.37% of the time. This shows a really high association between x (no. of threads) and y (runtime).  \
\
To optimise the mining algorithm, I decide to do a mathematical analysis on the performance. I want the algorithm to use a number of threads that allows a very promising runtime, while not taking all the threads so that the user can run other programs at the same time. I decide to find a point on the graph where increasing the number of thread by 1 reduces the runtime by less than 7% as this is unlikely to affect the performance after that point (if you continue to increase the no. of threads). This can be represented mathematically by:
$ y(x+1) > 0.93 y(x) $
As the general formula for the runtime-threads graph takes in the form $y = A x^(-b)$, we can get that
$ y(x+1) / y(x) = ((x)/(x+1))^b > 0.93 $
If we take the natural log of both sides, we get:
$ b ln(x/(x+1)) > ln(0.93) $
$ ln(x/ (x+1)) = ln(0.93)/b $
And raising both sides by $e$:
$ x/(x+1) > e^ln(0.93^(1/b)) = 0.93^(1/b) $
And slightly rearrange the formula, we get:
$ x > 0.93^(1/b) (x+1) $
$ x - 0.93^(1/b)x > 0.93^(1/b) $
$ x > 0.93^(1/b)/(1-0.93^(1/b)) $

Plugging in the b value for our both functions $y = 6229.31698x^(-0.877645)$ where ($b = -0.877645$) and $y=12992.6705x^(-0.790351)$ where ($b = -0.790351$) from the high performance and the medium performance computer respectively, we get $x > 0.93^(1/(0.877645))/(1-0.93^(1/(0.877645)))$ and $x > 0.93^(1/(0.790351))/(1-0.93^(1/(0.790351)))$, which gives $x > 11.60$ (to 4 s.f.) and $x > 10.40$ (to 4 s.f.), which rounds to $x>12$ and $x>10$ as x can only take in positive integers.\
\
Assuming there are more students with the medium performance computer, I introduce a weighting factor to account for the distribution of users. Let $w_1$ be the fraction of high-performance users and $w_2$ the fraction of medium-performance users with $w_1 + w_2 = 1$. The weighted number of threads can then be calculated as $ x_("weight") = w_1 * x_1 + w_2 * x_2 $ where $x_1$ and $x_2$ are the optimal threads percentage calculated for the high-performance and medium-performance machines, respectively. For example, if 20% of students have high-performance computers ($w_1 = 0.2$) and 80% have medium-performance machines ($w_2 = 0.8)$, we get: $ x_("weight") = 0.2 * 12/20 + 0.8 * 10/12 = 0.7867 "(to 4 s.f.)" approx 0.8 $

Therefore, I can conclude that using around 80% of the stakeholder's CPU threads for web workers gives the best performance because it keeps most system stable while still using most of the cores for mining. If you max out all threads, the OS and main thread have no room to handle background tasks, causing thread contention, lag, and even slower results. Leaving a few threads free ensures smoother communication and better overall throughput.
#pagebreak()
I will use this value (80%) to decide the value of `NUM_WORKERS` in the algorithm. Therefore, I will have to use the `os` library to find the number of threads that the user has, and then use the 80% of that for the mining algorithm:
```ts
import os from "os";
let numThreads = os.cpus().length; // no. of threads
let eighty_percent_of_threads = Math.max(1, Math.floor(numThreads * 0.8));
let NUM_WORKERS = eighty_percent_of_threads;
```
\

#subpar.grid(
  move(
    figure(
      image("images/mid_cpu_not_running.png", width: 100%),
      caption: [Threads on medium performance laptop when the algorithm is not running],
    ),
    dx: 0em,
  ),
  <a>,

  figure(
    image("images/mid_cpu_running.png", width: 103%),
    caption: [Threads on medium performance laptop when 12 workers are being used],
  ),
  <b>,

  columns: (1fr, 1fr),
  label: <full>,
)
#figure(
  image("images/image.png", width: 50%),
  caption: [Threads on medium performance laptop when running with max (12) threads multiple times],
)

As you may see, there is clearly a spike in CPU usage in multiple cores throughout the test for 12 web workers. This can sufficiently proof that the workers are in action and improving the speed for the proof of work algorithm. This aligns with the results for the tests that I ran.\
\
Limitation - This test is only done on two computers, therefore the results may vary on different hardware configurations. However, the general trend of performance improvement with increased web workers should hold true across most systems.
Another Limitation - The result might not be accurate as there are other background processes running on the computer which might interfere with the mining process. However, by taking the average of multiple runs, I can mitigate some of this variability and get a more reliable measure of performance.
#pagebreak()
=== Iteration 1 Evaluation
In this iteration I have done the proof of concept for multiple parts of my blockchain simulator:
+ Breadth-First Search (BFS) algorithm for graph traversal to show the broadcast of new blocks and transactions across the network
+ Depth-First Search (DFS) algorithm for graph traversal also to show the broadcast of new blocks and transactions across the network
+ Simplified Hashing function to demonstrate the concept of hashing in blockchain
+ Proof of Work (PoW) mining algorithm using web workers to simulate the mining process in blockchain

In this iteration the stakeholder would be me - the developer of the simulator, as there isn't a Minimal Viable Product (MVP) yet for the external stakeholders to review.

Review:\
The proof of concept implementations for BFS, DFS, hashing, and PoW mining were successful. Each component functioned as intended, passing all unit tests and demonstrating the core concepts effectively. The BFS and DFS algorithms correctly traversed graphs, the hashing function produced consistent and unique hashes, confirming its suitability for block validation later, and the PoW mining algorithm successfully simulated the mining process using web workers.\
\
I have solved the issues for many blockchain simulators online -- which was the lack of realistic mining simulation -- by implementing a PoW mining algorithm that uses web workers for parallel processing. This approach effectively simulates the distributed nature of mining in real blockchain networks, allowing multiple threads to work in parallel to find a valid nonce. By leveraging web workers, the mining process can be significantly sped up, providing a more accurate representation of how mining operates in practice. I have also solved the issue for the lack of graph traversal algorithms in existing blockchain simulators by implementing both BFS and DFS algorithms. These algorithms allow for realistic simulation of how blocks and transactions propagate through a blockchain network, enhancing the educational value of the simulator. \
\
Despite the success of this iteration, there are a few problems. Firstly, there are not a lot of input validation. For example, unexpected results such as an empty string (doesn't mean anything as there are no transactions to be mined) could be input into the `startMining` or other types of data could be input. Luckily, since I am developing in TypeScript, the wrong type of output will be automatically rejected by the function if I have stated the expected type of input, which I have. Another problem is that I didn't set limit to the input of the functions. For example, you could add millions of nodes in the dfs algorithm, and since my dfs algorithm is recursive, the execution time would be really long. This is the same with the `startMining` function. If the difficulty of the network level is being set too high, the mining would take a really long run time and likely not to load.\
\
Looking forward, the next steps involve integrating these components into the larger blockchain simulator project. This includes creating the Block and Blockchain classes, developing a Command Line Interface (CLI) for user interaction, and eventually building a Graphical User Interface (GUI) for enhanced usability. The focus will be on ensuring that these components work seamlessly together to provide an educational and interactive experience for users learning about blockchain technology. One thing that I could do in the next iteration is to improve the readability of the output, showing at each stage what the code is doing.\
\
In Iteration 1, I have developed the different functions for proof of concept. These will be reused in further iterations. However, to adapt to the use of further use, the functions are highly likely to be altered before use.

#pagebreak()
== Iteration 2
In Iteration 2, I will be building the core blockchain structure. I will be focusing on creating the Block and Blockchain classes. The `Block` class will represent individual blocks in the blockchain, containing properties such as index, timestamp, transactions, previous hash, nonce, and hash. The `Blockchain` class will manage the chain of blocks, providing methods to add new blocks, validate the chain, and handle transactions.\
\
I will be using modular coding practices to ensure that the `Block` and `Blockchain` classes are well-encapsulated and can be easily maintained and extended in the future. The `Block` and `Blockchain` class will be developed in the files `block.ts` and `blockchain.ts` respectively. This approach will also facilitate testing and debugging, as each class can be developed and tested independently before integrating them into the larger simulator. This means that it can reduce the repetition in code, improve readability, and allow future developers to pick things up straight away. It is also a perfect fit for decomposed code as it makes it easier to code and debug, reducing the risk of cascading bugs throughout the application.
// transaction validation, block linking and immutability

// pow: startMining changed from being a procedure to a function
==== Decomposing Iteration 2
Iteration 2 will mainly be focusing on Object Oriented Programming (OOP) concepts to build the core blockchain structure. Therefore I can decompose the iteration with a class diagram which includes the `Block` and `Blockchain` classes along with their core attributes and methods.
#figure(
  image("images/class_diagram_for_block_and_blockchain.png"),
  caption: [Class Diagram for Block and Blockchain Classes, made with draw.io],
) <class_diagram>
#pagebreak()
=== Iteration 2 Tasks
1. Implement the `Block` class
Core attributes:
- index: number -- block's position in the chain
- timestamp: number -- when the block was created
- transactions: string[] (array of strings) -- list of transactions included
- previousHash: string -- hash of the previous block
- nonce: number -- for Proof of Work mining
- hash: string -- final hash of the block
Core methods:
- calculateHash() -- returns hash of the block using the hashing function (fakeHash)
- mineBlock(difficulty) -- repeatedly change nonce until hash starts with 0...0 (difficulty target)
\
2. Implement the Blockchain class
Goal: Manage the entire chain of blocks.
Core attributes:
- chain: Block[] -- list of all blocks
- mempool: string[] (array of strings) -- this will act as the mempool (unconfirmed transactions)
- difficulty: number -- mining difficulty
Core methods:
- createGenesisBlock() -- creates the first block manually
- getLatestBlock() -- returns the last block in the chain
- minePendingTransactions() -- mines all pending transactions into a new block, clears mempool after
- addTransaction(tx) -- pushes a new transaction into the mempool
- isChainValid() -- verifies the chain by checking hashes and links between blocks
\
3. Mempool
My mempool will just be the list of pending transactions waiting to be mined. This will be a simple array of transaction objects stored in the Blockchain class.\
The simulation can be done like this:
- Add a few dummy transactions
- Print the mempool to show unconfirmed transaction
- Call minePendingTransactions()
- Show that the mempool is now empty, and those transactions appear in the new block.
Proof of concept:
- New transactions are stored temporarily
- They get written into the blockchain when mined
- The chain integrity stays valid
- Before mining → mempool not empty
- After mining → new block added + mempool cleared

==== Summary for Iteration 2 Features
Features:
- Block with index, timestamp, transactions, previousHash, nonce, hash
- Blockchain with chain array and mempool array
- Simple PoW mining (mineBlock) with adjustable difficulty
- Ability to add transactions to mempool and mine them into a new block
- Chain validation (isChainValid())
- Modular code and OOP for testing and future implementation
#pagebreak()
=== Main Goal
+ Create Block and Blockchain classes with core attributes and methods.
+ Implement a simple mempool to hold unconfirmed transactions.
+ Ensure modular design for easy testing and future expansion.
+ Test by adding transactions, mining blocks, and validating the chain.

=== Interaction between Block and Blockchain classes
The `Block` class represents individual blocks in the blockchain, while the `Blockchain` class manages the entire chain of blocks. The interaction between these two classes is crucial for maintaining the integrity and functionality of the blockchain.
Despite their might be no links between the two classes in terms of inheritance shown in @class_diagram. However they interact closely in the following ways:

1. Block creation and mining
- The Blockchain class creates new Block instances when minePendingTransactions() is called.
- It passes necessary data such as transactions from the mempool and previousHash from the latest block.
- Blockchain then calls the block's mineBlock(difficulty) method to perform proof-of-work, which sets the block's nonce and hash.
2. Chain linking
- Each Block stores the previousHash of the block before it.
- This allows Blockchain to maintain the correct sequence of blocks and validate integrity through isChainValid().
3. Data flow
- Transactions flow from the Blockchain mempool into a Block when mined.
- Once mining is complete, the new block is added to the blockchain, and the mempool is cleared.
4. Validation
- The Blockchain uses each block's `calculateHash()` method to verify that the chain hasn't been tampered with.
- Blocks themselves are passive; they provide their hash and allow mining, but do not manage the chain.
Here is a flowchart to show how `Block` and `Blockchain` classes work together to form the blockchain structure:
#figure(
  image("images/block_and_blockchain.jpg", width: 47%),
  caption: [Interaction between Block and Blockchain Classes],
)

The whole Iteration 2 blockchain core structure will look like this:
#figure(
  move(dx: 5em, dy: 0em)[
    #diagram(
      node-stroke: 1pt,
      node((0, 0), [Start], corner-radius: 2pt, extrude: (0, 3)),
      edge("-|>"),
      node(
        (0, 1),
        align(left)[
          Initialse Blockchain \
          - chain = [Genisis Block] \
          - mempool = [] \
          - difficulty = 2 by default \
        ],
        shape: rect,
      ),
      edge("d", "-|>"),
      node(
        (0, 2),
        align(left)[
          Add Transactions to Mempool
          - Blockchain.addTransaction(tx)
          - mempool stores tx
        ],
        shape: rect,
      ),
      edge("d", "-|>"),
      node(
        (0, 3),
        align(left)[
          Print mempool
          - show unconfirmed tx
        ],
        shape: rect,
      ),
      edge("d", "-|>"),
      node(
        (0, 4),
        align(left)[
          Mine Pending Transactions
          - Blockchain creates a new \ Block with mempool tx
          - Set previousHash = latest
          - Call Block.mineBlock()
            - PoW updates nonce \ and hash
        ],
        shape: rect,
      ),
      edge("d", "-|>"),
      node(
        (0, 5),
        align(left)[
          Add Mined Block to Chain
          - Blockchain.chain.push()
          - Clear mempool
        ],
        shape: rect,
      ),
      edge("d", "-|>"),
      node(
        (0, 6),
        align(left)[
          Print BlockChain
          - Shows all blocks in chain
        ],
        shape: rect,
      ),
      edge("d", "-|>"),
      node(
        (0, 7),
        align(left)[
          Print BlockChain
          - Shows all blocks in chain
        ],
        shape: rect,
      ),
      edge("d", "-|>"),
      node(
        (0, 7.979),
        align(left)[
          Validate Chain
          - Blockchain.isChainValid()
          - Uses Block.calculateHash()
          - Checks previousHash links
        ],
        shape: rect,
      ),
      edge("r,u,u,u,u,u,u,l", "-|>"),
    )],
  caption: [Algorithm Flowchart for Iteration 2 Blockchain Core Structure],
)
=== Block Design
`Block` class methods:
+ `calculateHash()`\
  The `calculateHash()` procedure will compute the hash of the block by concatenating its index, timestamp, transactions, previousHash, and nonce into a single string. This string will then be passed into the simplified hashing function (`fakeHash`) to generate the block's hash. This ensures that any change to the block's data will result in a completely different hash, maintaining the integrity of the blockchain. This can be done by simply applying the formula: `hash = fakeHash(index + previousHash + timestamp + transactions + nonce)`. Since the transactions are in the form of array, they will also have to be converted into a string first before concatenating using the `JSON.stringify` method. Other attributes do not have to be converted as TypeScript will automatically convert them into strings when concatenating.\
\
2. `mineBlock(difficulty)`\
  The `mineBlock(difficulty)` function will use the proof of work algorithm that I made in Iteration 1. It will pass in the transactions which is an array of strings, and difficulty of the blockchain network as a number. then output the nonce and the updated hash of the block. As we are using the PoW mining `startMining` function from Iteration 1, however the `startMining` is a procedure and does not return any value. Therefore I will have to modify the `startMining` function to return a *Promise* and make it an `async` function. A Promise is a TypeScript construct that represents a value that will become available in the future. In this case, the value is the mined nonce and hash. Wrapping the mining logic in a Promise allows the program to continue running other tasks while the mining is happening asynchronously. The structure of the wrapping looks like this:
// TODO: Tell that this is an error encounted
```ts
return new Promise<{ nonce: number; hash: string }>((resolve) => {
  // start mining with web workers
  ...
  // when a worker finds a valid hash:
  resolve({ nonce, hash });
});
```
Inside the Promise, multiple web workers run in parallel to find a valid hash. When one of them finds a valid hash, it calls `resolve({ nonce, hash })`, which completes the Promise and provides the mining result.

The `startMining` function is marked `async` so that it can be used with the `await` keyword. This allows any function calling it, such as mineBlock, to pause execution until the Promise resolves, without blocking the main thread. Likewise, mineBlock itself is async because it uses `await startMining(...)` to retrieve the mined nonce and hash before updating the block's properties. By making both functions asynchronous, we can handle the computationally intensive mining process efficiently while ensuring the block's hash and nonce are correctly assigned before the block is added to the blockchain.\
\
#pagebreak()
=== Block Class implementation
The code for the `Block` class is as follows:
```ts
import { fakeHash } from "../pow/hash.ts";
import { startMining } from "../pow_with_blob/main.ts";

// Represents a single block in the blockchain
export class Block {
  index: number; // Position in the chain
  timestamp: number; // When the block was created
  transactions: string[]; // Transactions included in this block
  previousHash: string; // Hash of previous block
  nonce: number = 0; // Used for proof-of-work
  hash: string; // Hash of this block

  constructor(
    index: number,
    timestamp: number,
    transactions: string[],
    previousHash: string
  ) {
    this.index = index;
    this.timestamp = timestamp;
    this.transactions = transactions;
    this.previousHash = previousHash;
    this.hash = this.calculateHash(); // Initial hash
  }

  // Calculate hash based on block content and nonce
  calculateHash(): string {
    return fakeHash(
      this.index +
        this.previousHash +
        this.timestamp +
        JSON.stringify(this.transactions) +
        this.nonce
    );
  }

  // Mine the block using proof of work
  async mineBlock(difficulty: number) {
    // Pass the full block data to startMining
    let blockData =
      this.index +
      this.previousHash +
      this.timestamp +
      JSON.stringify(this.transactions);

    // Await mined result from workers
    let result = await startMining(blockData, difficulty);

    this.nonce = result.nonce; // store mined nonce
    this.hash = result.hash; // store mined hash
    console.log(`Block mined: hash=${this.hash}, nonce=${this.nonce}`);
  }
}
```
#pagebreak()
=== BlockChain Class Design
`Blockchain` class methods:
1. `createGenesisBlock()`\
  The `createGenesisBlock()` function creates a new block which acts as the first block in the blockchain. Therefore the `Block` class has to be imported into the `blockchain.ts` file. As this is the first block, it will be missing the `previousHash` parameter to create the first block. However, we could just assign the `previousHash` as '0' to bypass this problem, as long as the `isChainValid()` skips the check for the previous hash for the genesis block. The function doesn't take in any parameter and returns the new block which will be pushed into the chain in the `constructor`.\
\
2. `getLatestBlock()`
  The `getLatestBlock()` function is required because to add new blocks to the chain, we will have to get the hash of the previous block. Therefore this will be used in the `minePendingTransactions()` later on. The function doesn't take in any parameter and return the latest block.\
\
3. `addTransaction(tx)`
  The `addTransaction(tx)` function allows the users to add the transactions into the mempool. It takes in `tx` (transactions) as `string`. An example input would be `Alice pays Bob 10 coins`. This shows the concept of a mempool, which most of the simulators online did not show. The function doesn't return any output but only push the transactions into the mempool.\
\
4. `minePendingTransactions()`
  The `minePendingTransactions()` function is used to mine all pending transactions and add them as a new block to the blockchain. It ensures that pending transactions are confirmed and stored in the chain securely.\
  Algorithm:\
  ` 1. Check if mempool is empty
    - If yes, print "No transactions to mine" and exit
 2. Print current mempool (pending transactions)
 3. Create a new Block object with:
    - index = length of current chain
    - timestamp = current time
    - transactions = copy of mempool
    - previousHash = hash of latest block
 4. Call the async mineBlock() method on the new block
    - Wait until mining finishes
    - This sets the block's nonce and hash
 5. Push the mined block into the blockchain's chain array
 6. Clear the mempool to indicate transactions are now confirmed
 7. Print mempool cleared message`\
  \
  Since we will have to await the block for mining, the `minPendingTransactions()` will also have to be an asynchronous function.\
\
5. `isChainValid()`
  The `isChainValid()` function is used to validate the chain and make sure nothing is wrong in the blockchain. This can be done by verifying if the `previousHash` on each block actually matches the previous block. Therefore we can make a loop through the blocks checking the hashes. There will be no input for this function because the chain is already an attribute of the blockchain, therefore it can be accessed in the local class scope. The output of the function will be a true/false therefore it's a `boolean`.
#pagebreak()
=== Blockchain Class Implementation
The code for the `Blockchain` class is as follows:
```ts
import { Block } from "./block.ts";

// Represents the full blockchain
export class Blockchain {
  chain: Block[] = []; // Array of all blocks
  mempool: string[] = []; // Transactions waiting to be mined
  difficulty: number; // Mining difficulty (number of leading zeros)

  constructor(difficulty: number = 2) {
    this.difficulty = difficulty;
    this.chain.push(this.createGenesisBlock()); // Start chain with genesis block
  }

  // Create the first block in the chain
  createGenesisBlock(): Block {
    let genesis = new Block(0, Date.now(), ["Genesis Block"], "0");
    return genesis;
  }

  // Get the latest block in the chain
  getLatestBlock(): Block {
    let latest = this.chain[this.chain.length - 1];
    return latest;
  }

  // Add a transaction to the mempool
  addTransaction(tx: string) {
    this.mempool.push(tx);
  }

  // Mine all pending transactions and add as a new block
  async minePendingTransactions() {
    if (this.mempool.length === 0) {
      console.log("No transactions to mine.");
      return;
    }

    console.log("Current mempool:", this.mempool);

    let newBlock = new Block(
      this.chain.length,
      Date.now(),
      this.mempool,
      this.getLatestBlock().hash
    );

    await newBlock.mineBlock(this.difficulty);

    this.chain.push(newBlock);
    this.mempool = []; // Clear mempool after mining
    console.log("Mempool cleared after mining.\n");
  }


  // Check if blockchain is valid by comparing hashes
  isChainValid(): boolean {
    for (let i = 1; i < this.chain.length; i++) {
      let current = this.chain[i];
      let previous = this.chain[i - 1];

      if (current.hash !== current.calculateHash()) return false;
      if (current.previousHash !== previous.hash) return false;
    }
    return true;
  }
}
```

=== Testing
The testing for Iteration 2 will be manual and observational. The best tests for my blockchain core structure is to make a simple script that adds transactions, mine them into blocks and then validate the chain. Therefore I am creating a `main.ts` to demonstrate the functionality of the `Block` and `Blockchain` classes. This script will:
- Create a new Blockchain instance
- Add a few dummy transactions to the mempool
- Print the mempool to show unconfirmed transactions
- Call minePendingTransactions() to mine them into a new block
- Print the blockchain to show the new block added
- Validate the chain using isChainValid() and print the result
As the process of mining involves asynchronous functions I will wrap all my tests in an asynchronous function.\
I will be doing three types of tests:
1. *Normal Tests* to test the basic functionality of the simulator:
```ts
import { Blockchain } from "./blockchain.ts";

// Run blockchain demo
async function normalTest() {
  console.log("=== NORMAL TEST ===");
  let myChain = new Blockchain(3);

  // Add first batch of transactions
  console.log("Adding transactions...");
  myChain.addTransaction("Alice pays Bob 10 coins");
  myChain.addTransaction("Bob pays Charlie 5 coins");

  console.log("Mempool before mining:", myChain.mempool);
  console.log("Mining pending transactions...");
  await myChain.minePendingTransactions();
  console.log("Current Blockchain:");
  console.log(JSON.stringify(myChain.chain, null, 2));

  // Add second batch of transactions
  myChain.addTransaction("Charlie pays Dave 2 coins");
  myChain.addTransaction("Eve pays Frank 1 coin");

  console.log("Mempool before second mining:", myChain.mempool);
  console.log("Mining pending transactions again...");
  await myChain.minePendingTransactions();

  console.log("Blockchain after second mining:");
  console.log(JSON.stringify(myChain.chain, null, 2));

  // Validate chain
  console.log("Is blockchain valid?", myChain.isChainValid());
}
```
On this line:
```ts
console.log(JSON.stringify(myChain.chain, null, 2))
```
The ouptut has to be 'JSONified' since the attribute `myChain.chain` is an array consists of blocks, which contains the methods of `calculateHash()` and `mineBlock()`. Using a `JSONify` doesn't print the functions of the block, increasing the readability of the output. When printed directly, TypeScript doesn't automatically display the full object structure — it just shows `[object Object]`. \
\
Using JSON.stringify() #footnote[https://akshaymattoo.medium.com/what-is-null-in-json-stringify-obj-null-2-8282b2e4eee1] converts the object data (its properties and values) into a readable JSON string format that can be shown neatly in the console, making it easier to inspect the entire blockchain state. In `JSON.stringify(myChain.chain, null, 2)`:
- The first parameter (myChain.chain) is the object or array you want to convert into JSON
- The second parameter (null) is the replacer, which lets you filter or transform values before converting — null means “include everything as-is.”
- The third parameter (2) sets the indentation level, telling the output to use 2 spaces per level for readability.
2. *Boundary Tests*:
- Empty mempool to test what would happen when no transaction has to be mined into blocks but user tries to mine a block -- Expected Result: 'No transactions to mine':
```ts
async function emptyMempoolTest() {
  console.log("\n=== BOUNDARY TEST: Empty mempool ===");
  let myChain = new Blockchain(3);
  await myChain.minePendingTransactions();
}
```
- Large number of transactions to simulate a busy network with a lot of transactions happening -- Expected Result: handles it fine since hash will turn it into a fixed length hexamdecimal
```ts
async function largeBatchTest() {
  console.log("\n=== BOUNDARY TEST: Large batch of transactions ===");
  let myChain = new Blockchain(2);
  for (let i = 0; i < 100; i++) {
    myChain.addTransaction(`User${i} sends ${i} coins`);
  }
  console.log("Mining large batch...");
  await myChain.minePendingTransactions();
  console.log(
    "Transactions in last block:",
    myChain.getLatestBlock().transactions.length
  );
}
```
#pagebreak()
- Setting a high difficulty for the blockchain network to simulate a more complex blockchain network, just like in real life -- Expected: Might take a long time but will eventually mine
```ts
async function highDifficultyTest() {
  console.log("\n=== BOUNDARY TEST: High difficulty ===");
  let myChain = new Blockchain(5); // very hard to mine
  myChain.addTransaction("High difficulty test transaction");
  console.log("Mining with difficulty 5 (might take a while)...");
  await myChain.minePendingTransactions();
  console.log("Blockchain valid after mining?", myChain.isChainValid());
}
```

3. *Erroneous Tests*
- Invalid transaction type
```ts
async function invalidTransactionTest() {
  console.log("\n=== ERRONEOUS TEST: Invalid transaction type ===");
  let myChain = new Blockchain(2);
  try {
    myChain.addTransaction(12345); // Invalid, should be string
  } catch (err: any) {
    console.error("Caught error:", err.message);
  }
}

```
- Tampering with the chain: a blockchain network should not allow user to tamper with the chain
```ts
async function tamperedChainTest() {
  console.log("\n=== ERRONEOUS TEST: Tampered block ===");
  let myChain = new Blockchain(2);
  myChain.addTransaction("Alice pays Bob 1 coin");
  await myChain.minePendingTransactions();
  myChain.addTransaction("Charlie pays Dave 2 coins");
  await myChain.minePendingTransactions();

  // Tamper with first mined block
  myChain.chain[1].transactions.push("Hacked Transaction!");
  console.log("Blockchain valid after tampering?", myChain.isChainValid());
}
```
- Re-mining an already mined block. Expected: chain not valid
```ts
async function reMiningTest() {
  console.log("\n=== ERRONEOUS TEST: Re-mining block ===");
  let myChain = new Blockchain(2);
  myChain.addTransaction("Test transaction");
  await myChain.minePendingTransactions();

  console.log("Re-mining latest block...");
  let latestBlock = myChain.getLatestBlock();
  await latestBlock.mineBlock(myChain.difficulty);
  console.log("Blockchain valid after re-mining?", myChain.isChainValid());
}
```
#pagebreak()
==== Testing Results
The test is observational. This means that we will have to analyse the output to know if the code that we made actually function as it should. As expected, while the code isn't there, none of the tests passed. However once the code has been developed, this is the result of the tests:
===== Normal Tests Result
#figure(
  subpar.grid(
    figure(move(dx: -1em, dy: 0em, (image("images/I2_normal_test.png", width: 135.5%)))), <a>,
    figure(move(dx: 3em, dy: 0em, (image("images/I2_normal_test_cont.png", width: 115%)))), <b>,
    columns: (1fr, 1fr),
    label: <full>,
  ),
  caption: [Iteration 2 Normal Test Results],
)
Looking at the test result, I have shown that different functions working in action, and how they are successfully connected to each other. For example, with the block mining in `myChain.minePendingTransaction()`, there is some log from the console which tells how long the mining took, this is from the `startMining()` function from Iteration 2. The log showing also implies that when the `myChain.minePendingTransaction()` is called, it is sucessfully connected to `Block.getLatestBlock()` and `Block.mineBlock()` which calls the `startMining` function. The annotations show that how each functions are involved in the algorithm.

===== Boundary Tests Result
#figure(align(image("images/I2-boundary.png", width: 44%), center), caption: [Iteration 2 Boundary Tests Result])
I have truncated some of the transactions output and them after being turned into a string due to the space it's taking (this will not be showned in the GUI), denoted by my `...` in my annotations. The boundary tests have successfully shown that:
- The validation for empty mempool is correct
- The `fakeHash()` function working as the transaction length doesn't matter
- The more time taken by higher difficulty blockchain network level
===== Errorneous Tests Result
#figure(image("images/I2-error.png", width: 50%), caption: [Iteration 2 Errorneous Tests Result])
There are a few things going on here. Firstly, for my "Invalid Transaction type" test, there was no error being raised, which was what is expected. However, the error actually did raise, but not in runtime. TypeScript automatically highlights the invalid type in the IDE, which is shown like this:
#figure(image("images/I2-erroneous.png"), caption: [TypeScript raising type error])
This is good as I can spot the wrong input during development. However, at the end product, the code will not be shown to the users, therefore data has to be validated. This will be done in Iteration 5 where I improve the user experience.\
\
Another problem in this test is the `InvalidStateError` in the reMining tests. This error is sometimes raised and sometimes not. This is beacuse each worker runs `assignWork()` repeatedly with `setTimeout(assignwork, 0)` -- meaning it's in an infinite async loop, posting new work until mining stops. When `stopMining()` is called (after one worker finds a valid hash), it terminates all workers. The problem though is that some workers still have pending `setTimeout(assignWork,0)` callbacks queued. So they wake up, try to call `worker.postMessage()` again but the worker has already been terminated, causing the `InvalidStateError`. \
#pagebreak()
This only happens in the 'Re-mining Test' because the test that triggers this (reMiningTest) calls `mineBlock()` directly again after mining once. This means that the global worker pool and `running` flag from the previous mining session are still in use. The new workers are starting while the old ones are mid-termination. Therfore they're racing.\
\
To fix this, I will have to clear all the workers before the program being called again. This is easy to fix, I will just have to add one line to the start of the `startMining()` function:
```ts
workers = []
```
This fixes the issue of workers being terminated but still tries to do `postMessage`. However as the code is fixed, another problem is arised: The blockchain is valid after being remined. This shouldn't be the case as the blockchain shouldn't allow tampering, as this will invalidate the chain. This is because the `Block` class doesn't track whether it's already mined, so calling `mineBlock()` again just overwrites nonce and hash. Therefore I will have to add a `mined` flag (variable) to track if a block has been mined before.
```ts
mined: boolean = false;
```
This line is added to the start of the `Block` class and
```ts
this.mined = true;
```
this line is added to the end of `mineBlock()` function within the `Block` class. This flag allows the algorithm to know whether the block has been mined. If the block is mined, it shouldn't be able to be remined. Therefore this line is added before the mining action in the `mineBlock()` function:
```ts
if (this.mined) throw new Error("Block has already been mined!");
```
After these are added, the test successfully threw an error which states that the Block has already been mined. \
\
Therefore, the blockchain simulator can now:
- prevent tampering of blocks
- prevent remining of blocks
#pagebreak()
=== Iteration 2 Evaluation
I have invited one of my stakeholders, Ben, to review my prototype -- blockchain core structure. This is because Ben has some prior knowledge about blockchain technologies and he has also used some blockchain simulators and developed some proof of stake algorithm before. Therefore he would be able to understand what I have been doing and give me some feedback on my work, since there isn't a CLI for this iteration yet. He enjoys seeing the blockchain structures and the mining actually happening in web workers using multiple threads/logical processors in the CPU. This can give a more efficient mining speed. He also says the blockchain core structure has included everything about blockchain that he knows. He believes that with the structure, it gives a very full on introduction to students that have never been exposed to blockchain before.\
\
In this iteration, I have successfully delivered the core structure of blockchain technologies, they include all the necessary functions to allow me to continue to develop a whole network, which will contain users as nodes since I have made everything in an object oriented programming way. This is very helpful as the blockchain class can be used across different nodes in the network.\
\
===== Pure functions
In Iteration 2, most of the functions have been developed very specifically for one case. For example, the `minePendingTransactions()` function is way too tied with the blockchain's internal state -- it hard-coded `this.mempool` as the only source of transactions. In Iteration this can work because we are only doing everything in one user (node), which means that the only transactions are the ones in the local mempool. However, in Iteration 3 when I start to develop the CLI, I will have multiple users (nodes) in the network, each with their own mempool. Therefore I will have to modify the `minePendingTransactions()` functions to take in the transactions as a parameter, instead of directly accessing from `this.mempool`. This will make the function more reusable for different users (nodes) in the network. Although the functions in this Iteration were modular, they should be more pure to make it more reusable.\
\
In Iteration 3, I will fix the functions that have to be reused to be more pure functions. This means that the functions can be reused, especially between different users (nodes) in the network. This will make the code more maintainable and easier to test in the future.\
\
===== Data Validation
In Iteration 2, there is a lack of data validation before the data is being passed into the functions. For example, the transactions only take in the form of a string. This is not ideal as users might be adding invalid messages into the transactions. However, this doesn't get checked.\
\
In Iteration 3, I will spend more time focusing on the data validation for each function before doing processing. This will help my stakeholders to not accidentally/purposely enter invalid inputs and crashing the CLI.


#pagebreak()
== Iteration 3
In Iteration 3, I will start to code a Command Line Interface (CLI) for my simulator. This will be a Minimum Viable Product (MVP). In this iteration, I will be linking everything that I had in the proof of concepts in Iteration 1 and the core block structure in Iteration 2 into one command line interface. In addition, this will also include the demomstration of adding users to the blockchain network, connecting the users to each other, algorithm to prevent double spending and tracking users' balances, showing how the blocks are propagating through the network after being added to the network.

=== Decomposition for Iteration 3
#figure(image("images/I3-decomposition.png"), caption: [Iteration 3 Decomposition])
In the decomposition diagram, I have splitted this Iteration into 4 main categories:
+ Implementing the `Balances` class which validates if the transaction is correct, i.e. sufficient balance for sender before transactions, checking if user has double spend a coin
+ Implementing the `Node` class which represent users in nodes, and it will contain individual user data, such as name, local copy of blockchain and the user's neighbours (who they're connected to in the network)
+ Implementing the `Network` class which controls the whole blockchain, doing actions such as adding users into the network
+ Create a CLI which takes input from learners which allows them to manipulate the blockchain

I have decided to make 3 files for this Iteration, excluding the testing files. This includes the `balances.ts` which contains the transaction validation algorithm, `network.ts` which contains the algorihtms for each individual users and the entire network, and `cli.ts` which includes the interface and the menu of the CLI.
=== Iteration 3 Goal
- Create class `Balances` which tracks user balances and prevents double spending
- Create class `Node` which represents a user in the blockchain network
- Create class `Network` which manages multiple nodes and their connections, including functions for adding nodes, connecting nodes, broadcasting blocks
- Create a Command Line Interface (CLI) for the blockchain Simulator

=== Design for Balances class
I decide to track the user balances with a class. This is because it allows me to create functions to validate the transactions. In my research section (@research) under the transaction validity, I had an initial design as a flowchart. However, they are how real blockchain ones work, and without simplification. To allow my stakeholders -- A level students to understand the concept of blockchain, I will make some abstract the idea of blockchain and implement it differently. Here is the decomposition of the `Balances` class.
#figure(image("images/balances.png"), caption: [Decomposition for the Balances class])
Attributes:
- balances (Map\<string,number>): This is an array to track the users with the
- initialBalance (number): The amount of coins when users join the network, set to 100 by default
Methods:
- getBalances(username: string): number -- This function takes in the username as a string and return the balance of the user as a number. Validation: If the user doesn't exist, return 0
- addUser(username: string): string -- This function takes in the username as a string and add the user into the balances array (map) with the initial balance. It returns a string message of who is being added to the network. Validation: If the user already exists, a string message will be returned saying the user already exists
- applyTransaction(from: string, to: string, amount: number): void -- This is a function that applies the transaction to the balances map. It takes in the sender username, receiver username and the amount of coins to be transferred. Validation: If the sender doesn't have enough balance, an error will be thrown. This can be done by using the getBalances() function to get the sender's balance and compare it with the amount to be transferred. If the sender doesn't have enough balance, an error will be thrown. If the usernames don't exist, an error will also be thrown.
- printBalances(username?: string): string -- This function takes in an optional username as a string. If the username is provided, it will return the balance of the user. If not, it will return the balances of all users in the network. Validation: If the user doesn't exist, a message will be printed saying the user doesn't exist.
- hasFunds(username: string, amount: number): boolean -- This function takes in the username and the amount of coins to be transferred. It returns a boolean indicating whether the user has enough balance to make the transaction. Validation: If the user doesn't exist, return false.
Simplification that I have made:\
Initially, when each users join the network, they will be assigned 100 coins, this is obviously not the case in real world since they are not given free coins by joining a blockchain network. \
=== Design for Testing Balances class
I will be making unit tests for the `Balances` class. This is because the functions are pure functions and they don't depend on any other classes. Therefore I can test them individually without worrying about the other classes. The tests will be done in a separate file called `balances.test.ts`. The tests will include:
- Adding users to the blockchain network
- Check if user has got enough balances before transaction
- Checking the logic when transaction is applied
- testing the printBalances return the correct balances of users
+ Adding users to the blockchain network can be tested by the addUser() function and the getBalance() function. The addUser() perform the actual function to add the users into the network while the getBalance() verifies that the user is in the network and has the right amount of balances in the map.
```ts
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
```
2. Since the hasFunds() function only returns a boolean, this will be easy to test. I can make a few boundary tests and unexpected input.
```ts
// ======= hasFunds() ======
test("hasFunds()", () => {
  let balances = new Balances();
  balances.addUser("Alice");
  console.log(balances.getBalance("Alice"));
  expect(balances.hasFunds("Alice", 50)).toBe(true);
  expect(balances.hasFunds("Alice", 150)).toBe(false);
  expect(balances.hasFunds("Alice", 100)).toBe(true); // Boundary
  expect(balances.hasFunds("Bob", 10)).toBe(false); // Bob does not exist
});
```
3. To test the transaction logic, I will have to track the balances of the sender and the receiver.
```ts
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
```
4. The printBalances() function has two tests -- One to test when a specific user is passed in as a parameter, it returns the balance of that user. The other test is used when no specific user is passed in as a parameter, it should be able to return the balances of all users. Errorneous tests such as a invalid user could be used to test the validation I am going to make for the function.
```ts
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
```
=== Development for Balances class
It makes it a lot simpler to develop each functions after decomposing the work into small parts and setting goals of each functions by setting tests.\
\
Here is the code for the `Balances` class:
```ts
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
    if (this.balances.has(username)) {
      return this.getBalance(username) >= amount;
    }
    return false;
  }

  applyTransaction(from: string, to: string, amount: number): void {
    if (!this.balances.has(from) || !this.balances.has(to)) {
      throw new Error("Sender or receiver does not exist.");
    }
    let toBal = this.getBalance(to);
    this.balances.set(to, toBal + amount);
  }

  printBalances(username?: string): string {
    if (username && !this.balances.has(username)) {
      console.log(`User ${username} not found.`);
    }

    if (username) {
      let balance = this.balances.get(username);
      if (balance === undefined) {
        throw new Error(`User ${username} not found.`);
      } else {
        return `${username}: ${balance}`;
      }
    }

    if (this.balances.size === 0) {
      return "No users in network.";
    }
    let arr = "";
    for (let [user, balance] of this.balances.entries()) {
      arr += `${user}: ${balance}\n`;
    }
    return arr;
  }
}
```
A few special things in my code:
- All of the attributes in the code are private so that it cacn prevent the alteration of the balances by outside function accidentally, or user trying to hack the console by accessing the Balances and changing them.
- The nullish coalescing operator `??` is used in getBalance() to deal with possible invalid inputs in case `this.balances.get(username)` is null or undefined.\
\
=== Balances Tests Results
#figure(image("images/balances_test.png"), caption: [Test for Balances Class])
As expected, all of tests are passing without causing any issues. Therefore the Balances class is ready to be combined with other features of the simulator.
=== Design for Node Class
Similar to the Balance class, I start by decomposing the Node class:
#figure(image("images/node_decomp.jpeg", width: 80%))
The Node class should be simple and only has 1 method. However they have 3 attributes: username, a local copy of blockchain, and its neighbours. This is because the Node class is more of a container to store the data for every user in the network.\
\
Attributes:
- username: string -- The name of the new user being added to the network
- blockchain: Blockchain -- The local copy of the blockchain
- neighbours: Node[] -- This includes the users that the new user is connected to in the network
Method:
- addNeighbour(node: Node) -- connecting a user in the network to the new user

The implementation of neighbours store the connected nodes in an array. This is good as it looks like the adjacency list in Iteration 1. This allows me to propagate the local copy of blockchain across the whole network with the DFS/BFS algorithms that I have made in Iteration 1.
#pagebreak()
=== Design for Node Tests
To test for nodes, I just have to simply adding nodes/users into the network, and connect the users, then to check who is connected to who. This is very easy to do. We can test it by simple unit tests. I will simply do a test of adding only two users and a test for larger network being added.
```ts
test("Adding new node to the network", () => {
  let Dave = new Node("Dave");
  let Alice = new Node("Alice");
  Dave.addNeighbour(Alice);
  expect(Dave.neighbours.includes(Alice));
  expect(Alice.neighbours.includes(Dave));
});

test("Adding a whole network", () => {
  let nodes: string[] = ["A", "B", "C", "D", "E", "F", "G", "H"];
  let users: Node[] = [];
  for (let node of nodes) users.push(new Node(node));
  for (let i = 0; i < users.length - 1; i++) users[i].addNeighbour(users[i + 1]);
  for (let i = 0; i < users.length - 1; i++) expect(users[i].neighbours.includes(users[i + 1]));
});
```
=== Development for Node
A lot of the code for this part is just the constructor. Therefore there isn't a lot to talk about.
```ts
export class Node {
  username: string;
  blockchain: Blockchain;
  neighbours: Node[] = [];

  constructor(username: string, difficulty = 2) {
    this.username = username;
    this.blockchain = new Blockchain(difficulty);
  }

  addNeighbour(node: Node) {
    if (!this.neighbours.includes(node)) this.neighbours.push(node);
  }
}
```
=== Node Test Results
As expected, the node works completely fine, passing all the unit tests created
```ts
bun test v1.2.18 (0d4089ea)
network.test.ts:
Detected 12 logical CPU cores.
✓ Adding new node to the network [4.82ms]
✓ Adding a whole network [0.49ms]
 2 pass
 0 fail
Ran 2 tests across 1 file. [57.00ms]
```
=== Decomposing Network Class
The `Network` class should contains a lot of methods. This is because it should handle all the events within the blockchain network.

#figure(image("images/network_decomp.png"), caption: [Decomposition for network class])

The majority of the output of the functions are strings. This is because I want all the processing to be done in this class, with the help of the built functions from the previous Iterations. Therefore, only the state message will be returned. This can help me to make a cli a lot easier as it only has to console.log() the output of the functions to show the state of the network.

=== Design for Network Class
The `Network` class will be the main part of my Iteration 3. This is because it will allow my stakeholders to manipulate the network. This includes:
- Adding users
- Adding transactions between users
- Mining a new block and adding it to their local copy of blockchain
- Connect the users so that they will be able to share their local copy of blockchain
- Propagate the local blockchain to every users/nodes in the network
- Validate if a blockchain is consistent
To visualise the process, I will also have printing functions in the class to show the state of the network, these functions include:
- showing the local copy of blockchain for a specific user
- showing the users in the network
- showing the balances of users in the network
- showing the global mempool -- the transactions to be mined to become a block
- showing the neighbours of a specific user (who they are connected to)

Algorithms Plan:
- `addUser(username:string): string`
  - This function takes in a username as a string and create a new Node with the username. 
  It follows a basic logic:
    - Check if the username already exists in the network (for data validation)
    - If not, create a new Node with the username and add it to the nodes array
    - Add the user to the Balances class
    - Return a string message saying the user has been added\
    \
- `addTransaction(from:string, to:string, amount:number): string`
  - This function takes in the sender username, receiver username and the amount of coins to be transferred. It follows a basic logic:
    - Check if both usernames exist in the network (for data validation)
    - Check if the sender has enough balance to make the transaction using the Balances class
    - If both checks pass, add the transaction to the global mempool
    - Return a string message saying the transaction has been added\
    \
- `mine(username:string): Promise<string>`
  - This function takes in the username of the user who wants to mine a new block. It follows a basic logic:
    - Check if the username exists in the network (for data validation)
    - Check if the global mempool is not empty
    - If both checks pass, mine a new block with the transactions in the global mempool using the user's local copy of blockchain
    - Create a for loop that actually do the transactions in the mempool using the `applyTransaction()` function from the Balances class
    - Clear the global mempool after mining
    - Return a string message saying the block has been mined\
    \
- `connectUsers(user1:string, user2:string): string`
  - This function takes in two usernames and connect them in the network. It follows a basic logic:
    - Check if both usernames exist in the network (for data validation)
    - If both checks pass, connect the two users using the `addNeighbour()` function from the Node class
    - Return a string message saying the users have been connected\
    \
- `propagate(startUsername:string, method:"bfs" | "dfs"): string`
  - This function takes in the username of the user who wants to start the propagation and the method of traversal (BFS or DFS). It follows a basic logic:
    - Check if the username exists in the network (for data validation)
    - Get the latest block from the user's local copy of blockchain
    - Check if the latest block is mined (hash starts with required number of leading zeros)
    - If both checks pass, use the imported BFS/DFS traversal functions to get the order of users to propagate to
    - For each user in the order, update their local copy of blockchain with the latest block if they don't already have it
    - Return a string message showing the order of propagation\
    \
- `validate(username: string): string`
  - This is just a basic check if a user's local blockchain is valid. This means that it will be matching the hashes and see if previous hash actually match the hash of the previous block, and that the whole blockchain is connected. I will be using the `isChainValid()` from the Blockchain class to do that\
  \
- `getNode(username) : Node | undefined`
  - As the majority of the functions above require selecting nodes, it is better off to make a simple function which select the required nodes. This is a helper function that takes in a username and returns the corresponding Node object from the nodes map. If the username does not exist, it returns undefined. This function will be used in other methods to get the Node object for a given username.\

=== Network Class Development
Here is the code for:
- 
- `propagate(startUsername: string, method: "bfs" | "dfs"): string`
```ts
  // BFS/DFS propagation of latest block using imported traversals
  propagate(startUsername: string, method: "bfs" | "dfs"): string {
    let startNode = this.getNode(startUsername);
    if (!startNode) {
      return `Start user ${startUsername} not found.`;
    }

    let latestBlock = startNode.blockchain.getLatestBlock();
    let targetPrefix = "0".repeat(startNode.blockchain.difficulty);

    if (!latestBlock.hash.startsWith(targetPrefix)) {
      return `Cannot propagate: latest block by ${startUsername} is not mined yet.`;
    }

    // Build adjacency list for traversal
    let adjacencyList: Record<string, string[]> = {};
    for (let [username, node] of this.nodes.entries()) {
      adjacencyList[username] = node.neighbours.map((n) => n.username);
    }

    // Get traversal order
    let order =
      method === "dfs"
        ? dfs_traverse(adjacencyList, startUsername)
        : bfs_traverse(adjacencyList, startUsername);

    // Propagate block along traversal order
    for (let username of order) {
      let node = this.getNode(username)!;
      if (node.blockchain.chain.length <= latestBlock.index) {
        node.blockchain.chain.push(latestBlock);
      }
    }

    return `${method.toUpperCase()} propagation: ${order.join(" -> ")}`;
  }
  ```




=== Testing
Although unit tests can be awesome in terms of testing small parts of the code, it takes too much time to design and write. Therefore, I will be using manual testing for the Network class. This is also because a lot of the functions in the Network class are not pure functions, and they depend on the state of the network. 

When I finish developing the CLI, I will be using the CLI to test the functions in the Network class. This is because the CLI will be the main interface for my stakeholders to interact with the blockchain simulator. Therefore, I will be able to test the functions in the Network class through the CLI.


There is a few simplification that I have done in this network. For example, the stakeholder will be able to decide who they want to connect in the network. This is not true in real life. In a real blockchain network, the users will be connected in two cases:
+ When a user is transacting with another user, they will be connected
+ When two users are transacting with one user at the same time, the two users will also be connected
Although this shouldn't be too hard to implement, I believe that this will make my stakeholders a lot more confused on how the users are connected. This will not help them to understand blockchain technologies clearly.
=== Design for CLI
I quite like the menu from Sean CLI from @sean-cli due to the readability of the menu and easy to understand interface. When I start his simulator, there is a menu page which allows you to navigate to different sections such as the `blockchain` section and the `p2p` section. Therefore I am going to use this idea to create the menu page for my simulator. After research into different command line libraries, I have decided to choose `readline` API library. This is because the `readline` API provides a simple and built-in way to handle user input directly from the terminal, without needing to install any extra packages. It also works seamlessly with Bun, since Bun implements Node's core `readline` module by default. On top of that, it makes the cli look cleaner and more organised -- similar to Sean CLI -- allowing me to create a visually clear and intuitive menu system for navigating between different components of my blockchain simulator.\
\
=== Designing tests for CLI

=== Enhancing Features
In real world blockchain networks, miners are given rewards for mining new blocks. For example, in Bitcoin, miners are rewarded with newly created bitcoins and transaction fees for successfully mining a block. This gives miners an incentive to participate in the mining process and helps to secure the network.\
\
Therefore, to make the blockchain simulator more realistic, I will be adding a mining reward feature. This means that when a user mine a new block, they will be rewarded with a certain amount of coins by the system. Therefore, I will have to add a line in the `mineBlock()` function in the `Network` class. 

```ts
// Give miner a reward
this.balances.applyTransaction("system", username, 10);
```

However, to achieve this, I will have to add a special user called 'system' into the Balances class when the network is created. This is because the system will be the one that gives the reward to the miner. Therefore, I will add this line in the constructor of the `Network` class:
```ts
  constructor(initialBalance: number = 100) {
    this.initialBalance = initialBalance;
    this.balances.set("system", 10000000);
  }
```
This will create a user called 'system' with a large amount of coins to give rewards to miners.\
\
Some data validation will also be altered such as the applyTransaction() function in the Balance class to force stakeholders not to make transactions from the 'system' user. This is easy as I only have to wrap the function with an if statement:
```ts
if (from !== "system") {
  let fromBal = this.getBalance(from);
  this.balances.set(from, fromBal - amount);
}
```
Other validation changes include not allowing users to print 'system' balance in the printBalances() function, and returning true for hasFunds() function when the username is 'system'.
\
\
// TODO: making the functions more pure
As mention in the Analysis of Iteration 2, I will be modifying some functions to make them more pure and do not alter the global variables or state.
// TODO: adding `if (!transactions)` into the Blockchain.mineBlock() function
=== Testing
// TODO: Limit the length of input
// Testing for robustness
// BEN: export and import the state of network with json
// Since james hasnt propagated after mining, the other nodes will be able to mine it, but in my simulation it doesn't allow that to happen 
// James: Default inputs
// #image("/assets/image-1.png")

=== Post Testing Modifications
// TODO: add validation to prevent debt issues
One of the issues that I have found during the manual testing is that users can have negative balances. Although the Balances class prevents users from making transactions that exceed their balance, there is no check to prevent users having multiple transactions that together exceed their balance. This will happen because a transaction is only confirmed once the block is mined. Therefore, if a user makes multiple transactions before the block is mined, they can end up with a negative balance.\
\
Therefore, to solve this, 
=== Manual Testing
// Users shouldn't have debt

=== Userbility Test
// TODO: ask the stakeholder to try crash the code
=== Evaluation
I have invited x of my stakeholders
// TODO: data validation in the future
// TODO: conflicted blocks

=== Testing to inform evaluation
To increase usability, I have included clear error messages when invalid inputs are provided. For example, if a user tries to add a transaction with a sender that doesn't exist in the network, the CLI will display an error message indicating that the sender is not found. This helps users understand what went wrong and how to fix it.\
// TODO: image proof
== Iteration 4
In Iteration 4, I will be developing a Graphical User Interface (GUI) for my blockchain simulator. Due to the lack of time and experience in creating graphs visualisation tools. I am going to use a library called vis.js. This is because vis.js is a dynamic, browser-based visualisation library that is easy to use and has a lot of features that can help me to create a more visually appealing and interactive GUI for my blockchain simulator. For example, vis.js allows user to drag the nodes around, zoom in and out, and move the graph back to the centre by default. This will help my stakeholders to navigate the nodes/users structure more easily.\
\
However, since I am using a library to create the GUI, I will have to modify the requirement for the GUI. Since vis.js doesn't work in canvas but instead only HTML elements, the web app will no longer require canvas, which was mentioned in the initial GUI design (@Initial-GUI-Design).\

=== GUI Design
Over the 3 iterations that I have been through, I have gained more understanding on blockchain technologies and I realised that the @Initial-GUI-Design might not be a very accurate representation of the blockchain simulator that I expected. Therefore I will develop the GUI orienting the design for my CLI.
=== Testing
=== Evaluation
// TODO: stakeholders
// William
// Userbility features -- nice aesthetic of graph 
// likes the help box
// all fit on the screen, no need to scroll although he likes scrolling
// connecting users can be easier (Enter key)
// 
// 
// Everything is used and intuitive with the help box
== Iteration 5
// TODO: before unload
In Iteration 5, I will be focusing on the visualisation of the network propagation and the mining processes. This is because in Iteration 4, I have successfully created a GUI for my blockchain simulator. However, the mining and network propagation processes has not been visualised. Therefore, in this iteration, I will animate these two processes to help my stakeholders understand how blockchain works in a more intuitive way.\

To consider the mining process, I will also be thinking about the difficulty of the network. This is because to 

=== Testing to inform evaluation
=== End Product Evaluation
// Section 1: Usability
// 1. How easy is it to navigate the simulator interface?
// ☐ Very difficult
// ☐ Difficult
// ☐ Neutral
// ☐ Easy
// ☐ Very easy

// 2. Which features do you find most useful? (Select all that apply)
// ☐ Adding transactions
// ☐ Mining blocks
// ☐ Viewing block details
// ☐ Visualising blockchain structure
// ☐ Simulating network propagation (BFS/DFS)
// ☐ Checking chain validity

// Are there any features that are confusing or need improvement?
// Open ans

// How responsive is the simulator to your actions (e.g., adding blocks, expanding transactions)?
// ☐ Very slow
// ☐ Slow
// ☐ Neutral
// ☐ Fast
// ☐ Very fast

// Section 4: Educational Value
// 9. How much did you learn about blockchain by using the simulator?
// ☐ Nothing
// ☐ A little
// ☐ Some
// ☐ A lot
// ☐ A great deal

// Would you recommend this simulator to other students to learn blockchain concepts?
// ☐ Definitely not
// ☐ Probably not
// ☐ Neutral
// ☐ Probably yes
// ☐ Definitely yes

// Section 5: Additional Feedback
// 11. What improvements would make the simulator more useful or enjoyable?
// Open ans

// Any other comments or suggestions?
// Open ans

// How clear are the visual representations of:
// Blocks and transactions
// ☐ Very unclear ☐ Unclear ☐ Neutral ☐ Clear ☐ Very clear
// Blockchain structure (links between blocks)
// ☐ Very unclear ☐ Unclear ☐ Neutral ☐ Clear ☐ Very clear
// Network propagation
// ☐ Very unclear ☐ Unclear ☐ Neutral ☐ Clear ☐ Very clear
// Is the tutorial/help documentation clear enough to understand how to use the simulator?
// ☐ Not at all
// ☐ Slightly
// ☐ Moderately
// ☐ Mostly
// ☐ Completely`
// 
== Maintenance
Currently, my teacher Mr Gordon is hosting the website. When

// Comments across the whole code
== Test Data <test-data>
== Data Validation
= Evaluation <evaluation>
// Data Validation

== Decomposition <decomposition>
// TODO:Justify for decomposition

= Bibliography

= Appendix
Here I will attach all the code files that I have written for my blockchain simulator project. They are sorted in alphabetical order for easy navigation.
