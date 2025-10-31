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
Blockchain is a rapidly growing technology that powers cryptocurrencies, NFTs, and secure digital record-keeping. Blockchain and Cryptography area mong the most in-demand STEM skills in the post-web economy. According to a new report from the UK Parliament, nearly half of engineering and tech businesses are struggling to recruit skilled talent. The shortage for STEM skills are costing the UK economy £1.5 billion per year [#footnote[source: medium (https://britblockchain.medium.com/uk-faces-stem-talent-shortage-as-demand-for-blockchain-skills-surges-says-parliamentary-report-ca626c0f5928)]]. Despite its increasing importance in finance, computing, and data security, not a lot of students in the UK are learning it. In addition, understanding how blockchain works is conceptually challenging for most students, especially with the lack of the resources online. Key concepts such as blockchain being decentralised distributed ledgers, mining, proof of work, hashing, and peer to peer (p2p) networks are often abstract and difficult to visualise. This creates a barrier to learn, especially when students encounter blockchain only through media or cryptocurrency hype, without practical experience. Consequently, there is a need for an educational tool which allows students to interact with. This can help them to visualise blockchain mechanics in a safe, simplified, and engaging way.
#pagebreak()

== Research
Blockchain is a distributed ledger technology that keeps record of the transactions across a network of nodes. Each block is a container for multiple transactions, linked to the previous block using a cryptographic hash. New blocks are added to the BlockChain through mining -- a process where participants (miners) solve complex computational puzzles (proof of work). Once successfully adding a valid block to the chain, miners will be given rewards, such as cryptocurrency and transaction fees.


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
  Transactions are first broadcast to the network and stored in the mempool -- a collection of unconfirmed transactions awaiting inclusion in a block.
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
- Each block contains the hash of the previous block, forming a cryptographically linked chain
- Mutating a block makes all of its following blocks invalid -- This makes it infeasible to alter blocks
- Only blocks meeting the proof of work and containing valid transactions are accepted by the network

Conceptual Flowchart:\
I created the flowchart below to visualise the workflow of a blockchain:
#figure(
  image("images/blockchain_conceptual_flowchart.png", width: 100%),
  caption: [Conceptual flowchart of blockchain workflow.],
)
#pagebreak()
== Existing models
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
#pagebreak()
=== Usability Features
This is my initial rough sketch on the graphical user interface (GUI) design of my blockchain simulator. It shows shows the user interface design of different sections of the platform, including the Introduction Page, Main Page, Users Page, Chains Page, Mining Page, Transactions Page, and the Settings Page.

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
- Iteration 1: Proof of Concept for the technologies that I will be using in the simulator
- Iteration 2: Building the core blockchain structure (Block and Blockchain classes)
- Iteration 3: Developing a Command Line Interface (CLI)
- Iteration 4-5: Developing a Graphical User Interface (GUI) to visualise blockchain

=== Technology
The simulator will run purely on client side code to reduce server costs and workload, improve scalability, and create a more interactive and responsive user experience\
Frontend: HTML + CSS + JavaScript \
Graph visualisation: canvas
=== Device Compatibility
The blockchain simulator is designed to run entirely in the browser. Therefore a JavaScript supporting browser is required. The simulator will be optimised for modern desktop and laptop environments using Chromium browsers (Google Chrome, Microsoft Edge, Opera). Mobile browsers may support basic interactios, but visualisation features are best experienced on computer systems. The device running to program should have at least a refresh rate of 60Hz to run the `requestAnimationFrame()` function in canvas to visualise blockchain workflow.
==== TypeScript
I will be using TypeScript to develop my blockchain simulator. TypeScript is a superset of JavaScript that adds types, interfaces, and other features to enhance code quality and maintainability. Here are some reasons why TypeScript is a good choice for this project:
+ Type Safety: TypeScript's static typing helps catch errors at compile time, reducing bugs in runtime. This is  important in a complex project like a blockchain simulator where data structures and algorithms need to be precise. It also helps me to think about the input and output of the functions while doing modular coding
+ Sustainability: TypeScript's type makes it easier to understand and maintain code over time. This is important because it allows other developers to look at the code and understand it to develop new features and improvements
However, when the website gets online, the TypeScript code will be transpiled (convert between two high-level languages) into JavaScript, so that it can be run on all Chromium browsers. Therefore, users do not have to install TypeScript on their devices to run the Blockchain Simulator. Their browsers only have to support JavaScript

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
  [Click “Add Block” and verify `block.previousHash === previousBlock.hash` and block.hash calculated correctly],

  $ 1.2 $,
  [Users can add up to 10 transactions per block before mining],
  [Ensures multiple transactions can be stored and tested; 10 transactions chosen as a reasonable limit for a small-scale simulator without overloading memory or UI],
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
#pagebreak()
== Stakeholders <stakeholders>
Primary Stakeholders:
+ Students: My blockchain simulator is aimed at A level student who would like to go beyond the standard A level . This will serve as a great resource for them to gain an insight of what blockchain is, how they can propagate
+ Teachers: They could use it as a teaching tool in lessons or demonstrations.
\
Secondary Stakeholders
+ Developer: As a developer myself, I will be a stakeholder myself. This means that I will be responsible for design, coding, testing, and documentation.
\
// ☐ How transactions are added to blocks
// ☐ How mining works
// ☐ How blocks are linked to form a chain
// ☐ How network updates propagate (e.g., BFS/DFS)
// ☐ How to validate a blockchain
// ☐ Other: (Open text box)
=== Interview
I have selected a few A level students to represent my target users to interview them about their expectations of blockchain simulator. Here are the questions that I have prepared for the interview:
`Section 1: Background and Experience
1. How familiar are you with blockchain concepts such as blocks, mining, and transactions?
2. Have you ever used any blockchain simulator or visualization tool before? If yes, which ones and what did you like/dislike about them?

Section 2: Learning Goals
3. What would you like to learn or understand better about blockchain through a simulator?

4. Are there specific concepts (e.g., network propagation, mining difficulty) that you find difficult and would like the simulator to explain visually?

Section 3: Features and Usability
5. Which features would you consider essential in a blockchain simulator?
6. How should the simulator allow you to interact with the blockchain (e.g., add transactions, mine blocks, view the network)?
7. Do you prefer a simple interface for learning or more detailed technical controls? Why?

Section 4: Performance and Limits
8. How fast or responsive do you expect the simulator to be when adding blocks or mining blocks?
9. Would you like the simulator to simulate multiple nodes on one computer, or is a single-node demonstration sufficient?

Section 5: Expectations and Concerns
10. What potential difficulties or frustrations do you anticipate when using a blockchain simulator?
11. How important is it for the simulator to be visually engaging (e.g., showing block links, network paths)?
12. If you could suggest one unique feature for this simulator, what would it be?`

I have interviewed 4 A level students, in which 3 of them takes Computer Science as their A level subject while 1 of them doesn't. Here are some key points that I have gathered from the interview:
// TODO

I have also interviewed a Maths and Physics teacher at my school who is //TODO
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

#figure(image("images/bfs_fail_test_result.png", width: 42%), caption: [BFS Test Results - Some Boundary and Erroneous Test Failing])

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
#figure(image("/writeup/images/dfs_pass_test.png", width:100%), caption: [DFS Test Results - All Tests Passed Successfully])
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
#figure(image("images/hash_test_result.png", width: 49%), caption: [Hashing Test Results - All Tests Passed Successfully])
#pagebreak()
=== Proof of Concept: Proof of Work Mining
I have decided to implement a simplified version of the Proof of Work (PoW) mining algorithm to demonstrate the concept of mining in blockchain technology. The goal of PoW is to find a nonce (a number used once) such that when it is combined with the block's data and hashed, the resulting hash meets a specific difficulty target, typically defined by a certain number of leading zeros in its binary representation. This is probably the most computationally intensive part of blockchain technology, as it requires significant processing power to find a valid nonce through trial and error.
==== Research on Proof of Work Mining
After researching on Proof of Work (PoW) mining from Investopedia #footnote[https://www.investopedia.com/terms/p/proof-work.asp], Wikipedia #footnote[https://en.wikipedia.org/wiki/Proof_of_work], Medium #footnote[https://scryptplatform.medium.com/proof-of-work-in-bitcoin-043ff9fa0d2d] and Bitcoin StackExchange #footnote[https://bitcoin.stackexchange.com/questions/57684/proof-of-work-how-are-target-difficultly-and-number-of-leading-zeros-related-t], I have summarised the following key points about PoW mining:
- Proof of Work (PoW) is a consensus mechanism in blockchain technology where participants (miners) solve complex mathematical puzzles to validate transactions and secure the network. 
- Leading Zeros in PoW: A key aspect of PoW is the requirement for a hash to meet a specific difficulty target, often expressed as a number of leading zeros in the hash output. This condition ensures that miners expend a significant amount of computational effort to find a valid hash. 
- The exact hash value doesn't matter: The focus on leading zeros rather than the exact hash value allows for flexibility in the mining process. Miners adjust a nonce value and rehash the block's data repeatedly until they find a hash that meets the difficulty target. This approach makes the process probabilistic, ensuring that finding a valid hash requires substantial computational work, but the exact hash value is not predetermined.
==== Design of algorithm: Proof of Work Mining
To ensure the speed of mining and simulate the reality of mining rigs which uses multicore CPU/GPU to mine, I have decided to use *web workers* to implement the PoW mining algorithm. Web workers allow for running scripts in background threads, enabling parallel execution without blocking the main thread. This is particularly useful for computationally intensive tasks like mining, as it allows the user interface to remain responsive while the mining process is ongoing.
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
#figure( image("images/vite.png"), caption: [Vite Development Server Serving Multiple Files])
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
=== Testing
I am using two different computers to test the PoW mining algorithm:
+ A high performance computer with Intel(R) Core(TM) i5-14500, 2.60 GHz, 32.0 GB DDR5 RAM, which has 14 cores and 20 threads#footnote[Spec sheet: https://www.intel.com/content/www/us/en/products/sku/236784/intel-core-i5-processor-14500-24m-cache-up-to-5-00-ghz/specifications.html]. Theoretically it should be able to handle 20 web workers at the same time.
+ A medium performance laptop with 13th Gen Intel(R) Core(TM) i5-1335U (1.30 GHz), DDR4 16GB RAM, which has 10 cores and 12 threads#footnote[spec sheet:https://www.intel.com/content/www/us/en/products/sku/232153/intel-core-i51335u-processor-12m-cache-up-to-4-60-ghz/specifications.html]. Therefore theoretically it should be able to handle 12 web workers at the same time.
I will use the `performance.now()` method to measure the run time for 10 times in each case and take the mean average of each results to make it accurate. Both computers will be tested with the same input string "Hello World" and difficulty level of 4 leading zeros. The number of web workers will be varied from 1 to 12 for the medium performance aptop, and from 1 to 20 for the high performance computer.
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
==== Testing Results
[All measurement results are in milliseconds (ms)]
// Differentiate the curve?
// large standard deviation = inconsistent performance
#figure(image("images/mid_cpu_not_running.png"), caption:[Logical processors on medium performance laptop when the algorithm is not running])
#figure(image("images/mid_cpu_running.png"), caption: [Logical processors on medium performance laptop when 12 workers is used])
#image("images/image.png")

As you may see, there is clearly a spike in CPU usage in multiple cores throughout the test for 12 web workers. This can sufficiently proof that the workers are in action and improving the speed for the proof of work algorithm. This algn wiith the results for the tests that I ran.

// Standard Deviaiton Calculation

Interestingly, when I set the number of Web Workers to something extreme like 200, the runtime becomes unstable because I am massively oversubscribing the CPU. Each worker runs in its own thread, so having far more workers than CPU threads forces the system to constantly switch between them (called context switching). This burns up CPU time just managing threads instead of actually mining. On top of that, memory usage spikes and the browser or Bun runtime struggles to coordinate all those workers, causing delays, crashes, or inconsistent runtimes.
// Desmos Graph excludes the 200 workers data point
// Explain x and y
// Highest coefficient of determination for power regression

Limitation - This test is only done on two computers, therefore the results may vary on different hardware configurations. However, the general trend of performance improvement with increased web workers should hold true across most systems. 
Another Limitation - The result might not be accurate as there are other background processes running on the computer which might interfere with the mining process. However, by taking the average of multiple runs, I can mitigate some of this variability and get a more reliable measure of performance.
// To optimise the algorithm, ...
Using around 80% of the stakholder's CPU threads for Web Workers gives the best performance because it keeps most system stable while still using most of the cores for mining. If you max out all threads, the OS and main thread have no room to handle background tasks, causing thread contention, lag, and even slower results. Leaving a few threads free ensures smoother communication and better overall throughput.
=== Evaluating Iteration 1
In this iteration I have done the proof of concept for multiple parts of my blockchain simulator:
+ Breadth-First Search (BFS) algorithm for graph traversal to show the broadcast of new blocks and transactions across the network
+ Depth-First Search (DFS) algorithm for graph traversal also to show the broadcast of new blocks and transactions across the network
+ Simplified Hashing function to demonstrate the concept of hashing in blockchain
+ Proof of Work (PoW) mining algorithm using web workers to simulate the mining process in blockchain

In this iteration the stakeholder would be me - the developer of the simulator, as there isn't a Minimal Viable Product (MVP) yet for the external stakeholders to review.

Review:\
The proof of concept implementations for BFS, DFS, hashing, and PoW mining were successful. Each component functioned as intended, passing all unit tests and demonstrating the core concepts effectively. The BFS and DFS algorithms correctly traversed graphs, the hashing function produced consistent and unique hashes, and the PoW mining algorithm successfully simulated the mining process using web workers.
I have solved the issues for many blockchain simulators online -- which was the lack of realistic mining simulation -- by implementing a PoW mining algorithm that uses web workers for parallel processing. This approach effectively simulates the distributed nature of mining in real blockchain networks, allowing multiple threads to work concurrently to find a valid nonce. By leveraging web workers, the mining process can be significantly sped up, providing a more accurate representation of how mining operates in practice. I have also solved the issue for the lack of graph traversal algorithms in existing blockchain simulators by implementing both BFS and DFS algorithms. These algorithms allow for realistic simulation of how blocks and transactions propagate through a blockchain network, enhancing the educational value of the simulator. 
Looking forward, the next steps involve integrating these components into the larger blockchain simulator project. This includes creating the Block and Blockchain classes, developing a Command Line Interface (CLI) for user interaction, and eventually building a Graphical User Interface (GUI) for enhanced usability. The focus will be on ensuring that these components work seamlessly together to provide an educational and interactive experience for users learning about blockchain technology.
// WWW, EBI
#pagebreak()
== Iteration 2
In Iteration 2, I will be building the core blockchain structure. I will be focusing on creating the Block and Blockchain classes. The `Block` class will represent individual blocks in the blockchain, containing properties such as index, timestamp, transactions, previous hash, nonce, and hash. The `Blockchain` class will manage the chain of blocks, providing methods to add new blocks, validate the chain, and handle transactions.\
\
I will be using modular coding practices to ensure that the `Block` and `Blockchain` classes are well-encapsulated and can be easily maintained and extended in the future. The `Block` and `Blockchain` class will be developed in the files `block.ts` and `blockchain.ts` respectively. This approach will also facilitate testing and debugging, as each class can be developed and tested independently before integrating them into the larger simulator. This means that it can reduce the repetition in code, improve readability, and allow future developers to pick things up straight away. It is also a perfect fit for decomposed code as it makes it easier to code and debug, reducing the risk of cascading bugs throughout the application.
// transaction validation, block linking and immutability

// pow: startMining changed from being a procedure to a function
==== Decomposing Iteration 2
Iteration 2 will mainly be focusing on Object Oriented Programming (OOP) concepts to build the core blockchain structure. Therefore I can decompose the iteration with a class diagram which includes the `Block` and `Blockchain` classes along with their core attributes and methods.
#figure(image("images/class_diagram_for_block_and_blockchain.png"),caption: [Class Diagram for Block and Blockchain Classes, made with draw.io]) <class_diagram>
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
#figure(image("images/block_and_blockchain.jpg", width:47%),caption: [Interaction between Block and Blockchain Classes])

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
        edge("r,u,u,u,u,u,u,l","-|>"),
      )],
  caption: [Algorithm Flowchart for Iteration 2 Blockchain Core Structure],
)
=== Block Design
`Block` class methods:
+ `calculateHash()`\
  The `calculateHash()` procedure will compute the hash of the block by concatenating its index, timestamp, transactions, previousHash, and nonce into a single string. This string will then be passed into the simplified hashing function (`fakeHash`) to generate the block's hash. This ensures that any change to the block's data will result in a completely different hash, maintaining the integrity of the blockchain. This can be done by simply applying the formula: `hash = fakeHash(index + previousHash + timestamp + transactions + nonce)`. Since the transactions are in the form of array, they will also have to be converted into a string first before concatenating using the `JSON.stringify` method. Other attributes do not have to be converted as TypeScript will automatically convert them into strings when concatenating.\
\
2.  `mineBlock(difficulty)`\
  The `mineBlock(difficulty)` function will use the proof of work algorithm that I made in Iteration 1. It will pass in the transactions which is an array of strings, and difficulty of the blockchain network as a number. then output the nonce and the updated hash of the block. As we are using the PoW mining `startMining` function from Iteration 1, however the `startMining` is a procedure and does not return any value. Therefore I will have to modify the `startMining` function to return a *Promise* and make it an `async` function. A Promise is a TypeScript construct that represents a value that will become available in the future. In this case, the value is the mined nonce and hash. Wrapping the mining logic in a Promise allows the program to continue running other tasks while the mining is happening asynchronously. The structure of the wrapping looks like this:
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
        this.nonce // make sure nonce is included
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
 7. Print mempool cleared message`
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
1. Normal Tests to test the basic functionality of the simulator:
```ts
import { Blockchain } from "./blockchain.ts";

// Run blockchain demo
async function run() {
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

run();
```
2. Boundary Tests: 
- Empty mempool -- Expected Result: 'No transactions to mine'
- Large number of transactions -- Expected Result: handles it fine since hash will turn it into a fixed length hexamdecimal
- Setting a high difficulty for the blockchain network -- Expected: Might take a long time but will eventually mine

3. Erroneous Tests
- Invalid transaction type
- Tampering with the chain
- Re-mining an already mined block

==== Testing Results


=== Evaluation
I have invited some of my stakeholders, ..., to review my command line interface code. 
#pagebreak()
== Iteration 3
In Iteration 3, I will start to code a Command Line Interface (CLI) for my simulator. This will be a Minimum Viable Product (MVP). In this iteration, I will be linking everything that I had in the proof of concepts into one command line interface. This includes the 
=== Testing
=== Evaluation
== Iteration 4
In Iteration 4, I will be developing a Graphical User Interface (GUI) for my blockchain simulator.
=== Testing
=== Evaluation
== Iteration 5
In Iteration 5, I will be continuing developing and enhancing the features of my blockchain simulator after getting feedback from my external stakeholders.
=== Testing
=== Evaluation
`Section 1: Participant Background
What is your familiarity with blockchain concepts?
☐ None
☐ Basic (heard of blockchain/Bitcoin)
☐ Intermediate (know about mining, blocks, transactions)
☐ Advanced (have coded or studied blockchain before)

How comfortable are you with using web-based or desktop software simulations?
☐ Not comfortable
☐ Somewhat comfortable
☐ Comfortable
☐ Very comfortable

Section 2: Usability
3. How easy is it to navigate the simulator interface?
☐ Very difficult
☐ Difficult
☐ Neutral
☐ Easy
☐ Very easy

Section 3: Functionality and Features
6. Which features do you find most useful? (Select all that apply)
☐ Adding transactions
☐ Mining blocks
☐ Viewing block details
☐ Visualising blockchain structure
☐ Simulating network propagation (BFS/DFS)
☐ Checking chain validity

Are there any features that are confusing or need improvement?
Open ans

How responsive is the simulator to your actions (e.g., adding blocks, expanding transactions)?
☐ Very slow
☐ Slow
☐ Neutral
☐ Fast
☐ Very fast

Section 4: Educational Value
9. How much did you learn about blockchain by using the simulator?
☐ Nothing
☐ A little
☐ Some
☐ A lot
☐ A great deal

Would you recommend this simulator to other students to learn blockchain concepts?
☐ Definitely not
☐ Probably not
☐ Neutral
☐ Probably yes
☐ Definitely yes

Section 5: Additional Feedback
11. What improvements would make the simulator more useful or enjoyable?
Open ans

Any other comments or suggestions?
Open ans

How clear are the visual representations of:
Blocks and transactions
☐ Very unclear ☐ Unclear ☐ Neutral ☐ Clear ☐ Very clear
Blockchain structure (links between blocks)
☐ Very unclear ☐ Unclear ☐ Neutral ☐ Clear ☐ Very clear
Network propagation
☐ Very unclear ☐ Unclear ☐ Neutral ☐ Clear ☐ Very clear
Is the tutorial/help documentation clear enough to understand how to use the simulator?
☐ Not at all
☐ Slightly
☐ Moderately
☐ Mostly
☐ Completely`
== Test Data <test-data>
== Data Validation
= Evaluation <evaluation>
// Data Validation

== Decomposition <decomposition>
TODO:Justify for decomposition

== Appendix
Here I will attach all the code files that I have written for my blockchain simulator project. They are sorted in alphabetical order for easy navigation.