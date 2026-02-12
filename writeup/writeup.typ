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
Blockchain is a rapidly growing technology that powers cryptocurrencies, NFTs, and secure digital record-keeping. Blockchain and Cryptography are among the most in-demand STEM skills in the post web economy. According to a new report from the UK Parliament, nearly half of engineering and tech businesses are struggling to recruit skilled talent. The shortage for STEM skills are costing the UK economy £1.5 billion per year [#footnote[source: medium (https://britblockchain.medium.com/uk-faces-stem-talent-shortage-as-demand-for-blockchain-skills-surges-says-parliamentary-report-ca626c0f5928)]]. Despite its increasing importance in finance, computing, and data security, not a lot of students in the UK are learning it. In addition, understanding how blockchain works is conceptually challenging for most students, especially with the lack of the resources online. Key concepts such as blockchain being decentralised distributed ledgers, mining, proof of work, hashing, and peer to peer (p2p) networks are often abstract and difficult to visualise. This creates a barrier to learn, especially when students encounter blockchain only through media or cryptocurrency hype, without practical experience. Consequently, there is a need for an educational tool which allows students to interact with. This can help them to visualise blockchain mechanics in a safe, simplified, and engaging way.
#pagebreak()

== Research <research>
Blockchain is a distributed ledger technology that keeps record of the transactions across a network of nodes. Each block is a container for multiple transactions, linked to the previous block using a cryptographic hash. New blocks are added to the blockchain through mining -- a process where participants (miners) solve complex computational puzzles (proof of work). Once successfully adding a valid block to the chain, miners will be given rewards, such as cryptocurrency or transaction fees.\
\
Research in Blockchain Technology: \
I gained knowledge on the blockchain technologies after watching this #link("https://youtu.be/bBC-nXj3Ng4?si=7UgRxuPQdJOzkzG4")[YouTube video] [#footnote[https://youtu.be/bBC-nXj3Ng4?si=7UgRxuPQdJOzkzG4]] by #link("https://www.youtube.com/@3blue1brown")[3Blue1Brown] which explains how blockchain technologies work behind the scene and different algorithms to power it. I also confirmed my knowledge with the winner of award of distinction in the Hong Kong BlockChain Olympiad - Lester Chong by asking him questions to clearly understand the concepts behind blockchain technologies.

Here are my summary to some main concepts in Blockchain technology:

1. Transactions
A transaction represents a transfer of value or information between users. Each transaction typically includes:
- Sender and receiver addresses
- Amount or data being transferred
- Digital signature to verify authenticity
Transactions are first broadcast to the network and stored in the mempool (or global mempool) -- a collection of unconfirmed transactions awaiting inclusion in a block.

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

When a valid nonce (an arbitrary number that can be used only once in a cryptographic communication) is found, the block is 'mined' to the blockchain and broadcasted to the network. There are also other mining algorithms such as the proof of stake algorithm #footnote[https://www.investopedia.com/terms/p/proof-stake-pos.asp], which instead of mining the blocks, only validates them. This will save a lot more energy not requiring the mining rigs, but at the same time is less secure as they get attacked way more often than proof of work algorithms.
\
#pagebreak()

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
#pagebreak()
Conceptual Flowchart:\
I created the flowchart below to visualise the workflow of a blockchain:
#figure(
  image("images/blockchain_conceptual_flowchart.png", width: 80%),
  caption: [Conceptual flowchart of blockchain workflow],
)

A very broad summary of the blockchain network workflow is as follows:
- Users create transactions (note: the transactions will get checked for validity first; Invalid transactions include double spending the same coin/token, insuffiecient balance, invalid digital signature, etc.)
- Valid transactions are then added to the mempool (mempool is global and every node has the same mempool)
- Miners select transactions from the mempool to include in a new block
- Miners perform proof of work to find a valid nonce (a number that is added to the block data to be hashed that results in a hash that meets the network difficulty target, which means it should have a certain number of leading zeros in binary) and hash of the new block
- Once a valid nonce is found, the new block is added to the local copy of blockchain of the miner node and broadcasts to all nodes in the peer to peer network.
- Each node verifies the new block and appends it to their local copy of the blockchain if valid therefore everyone keeps a synchronised copy of the blockchain
- This process repeats for each new block being mined\
\
Note:
- The difficulty of mining is set by the network and cannot be changed by miners.
#pagebreak()
== Existing solutions
I have looked into two blockchain simulator. One of them is a Command Line Interface on GitHub while the other one is a Graphical User Interface with a few webpages.
=== Sean's Blockchain Simulator
I found this blockchain simulator Command Line Interface (CLI) #footnote[https://github.com/0xs34n/blockchain] on GitHub by Sean. I have forked the repository and ran it on my local machine using `node.js`. The simulator offers a basic understanding of blockchain technologies with features like possessing blockchains and connecting to peers in different networks. However, it doesn't contain features such as transactions of blockchains or the process of mining blockchains.
#figure(image("images/Sean_CLI.jpg"), caption: [Sean's CLI p2p]) <sean-cli>
Since Sean's Blockchain simulator allows connection between multiple devices, I opened two terminals to simulate two device running his program. In the first terminal (left of @sean-cli), I checked the initial state of the local copy of blockchain, then checked the initial state of the second terminal (right of @sean-cli). They both contain the same genesis block, which is an accurate representation of blockchain. Then, I mine a block on the second terminal with the data string of 'Ivan_gives_William_10_coins'. This updates the local copy of the blockchain, which is what we expected. Now, I opened port 2000 on the first terminal and allow my second terminal to connect. On the second terminal I used the command `peers` to show that the connection between the two terminals/devices is successful. Now, when I print the local copy of blockchain on the first terminal it shows that it has the updated version of blockchain as well. This is because when they are connected, the updated blockchain was propagated from the second terminal to the first one.\
\
In this image, Sean's Blockchain simulator has shown the connection between different ports in local host. This shows a peer to peer network between devices, and is an accurate representation. It also shows the basic core block structure of each block containing the index. previousHash, timestamp, data, hash, and nonce. The blocks are also shown to be connected with the previousHash attribute actually being the hash of the previous block. \
\
However, although listed in the help section, the discover feature actually does nothing. No matter which state of the network I am in, whenever I use the discover command, an error would pop up:
#figure(image("images/discover.png", width: 50%), caption: [Sean CLI's error while using discover])
Therefore, I don't believe that the simulator is capable of finding devices around me and so that I can connect with them. Another feature that has bug is the peers command which sometimes prints 'null' when it is clearly connected to another device as their blockchains are shared.\
\
The mining process took within 1 second, when the difficulty level of the network says 3. This means that he didn't actually use SHA-256 for his hashing function but maybe an easier function, or that the mining process might not actually happened and those hashes and nonces are randomly generated. This is because mining a block with SHA-256 hashed in a difficulty level of 3 network will take a really long time and a lot of processing power.\
\
Besides, due to the lack of explanation, I took a really long time to figure out what each command actually does and how it relates to the real blockchain, even after doing research in blockchain technologies. This means that the simulator is not intuitive and lacks explanation on what is going on. Only people who are experienced or have some prior knowledge of blockchain would know what is going on. There was no concepts of mempool where I can store my transactions involved.\
\
In addition, there are no representations of the balances of each user. It made it seems like someone could send infinite coins to someone for example in a cryptocurrency network. The data string in the mined block also seem to be able to take in any data and there isn't any data validation. Only 1 string without spaces can be added to the mine data. Or else, the parts after the space will be truncated.\
\
Moreover, the simulator lacks the feature to deal with a fork with two blockchains, this means that the blockchain can potentially diverges into two potential paths forward:
#figure(image("images/fork.png", width: 70%), caption: [forking blockchains])
As shown in the figure, the blockchain didn't change after connecting the two terminals. Therefore, there is no evidence of features handling forking blockchains. \
\
Lastly, it also lacks the GUI for non developer so they can navigate and learn about blockchain easily.\
\
=== Anders Brownworth Blockchain Simulator
Another blockchain simulator #footnote[https://andersbrownworth.com/blockchain/] I found is made by Anders Brownworth. This simulator has a graphical user interface (GUI). This helps visualises the process of mining blocks, the structure of a block, and showing how blockchain is connected. The overall simulator is being separated into a few tabs: hash, block, blockchain, distributed blockchain, tokens, and coinbase. Each tab explains a different concept in blockchain technology. \
#figure(image("images/ander-hash.png"), caption: [Anders Brownworth's Simulator Hashing Process])
This image shows the hashing process of Anders' simulator. It shows you that the block can take in any data, then the hash will automatically be recalculated. The hash is shown to be a fixed length of 64 hexadecmial characters, which is an accurate representation of SHA-256 hash. The avalanche effect is also shown here as changing one character will drastically change the hash output.
#subpar.grid(
  figure(image("images/ander-beforeMine.png"), caption: [Block with data before mining]), <a>,
  figure(image("images/ander-afterMine.png"), caption: [Block with data after mining]), <b>,

  columns: (1fr, 1fr),
  label: <normal-test>,
)
This clearly shows blockchain as ledgers where transactions could be recorded in the data. When you input the data you the hash will be automatically calculated based on the data input. Then when you click the 'mine' button, the nonce will be adjusted until the hash meets the difficulty target, and the block turns from red to green. Although this is good representation of mining, a lot of details has been hidden here. For example, the mine button just changes the hash but didn't show any nonce changing or the process of mining.\
\
Moreover, the mining here takes less than 1 second to complete, which is probably not actually using SHA-256 to hash the block but maybe a simpler hashing algorithm as mining a block with SHA-256 hash function will take a long time and a lot of processing power, usually requiring mining rigs with multiple high end GPUs. \
#figure(image("images/anders-blockchain.png"), caption: [Anders' simulator blockchain page])
The simulator also shows that blockchains are made by blocks being connected together using the previous hash attribute. This is an accurate representation of blockchain. However, there is no concept of mempool where transactions are stored before being mined into a block. Also you are able to change the data in a block that is already mined, and invalidate the block and the following blocks. This is not an accurate representation of blockchain as once a block is mined and added to the blockchain, it is immutable and cannot be changed. \
#figure(
  image("images/anders-peers.png", width: 60%),
  caption: [Anders' Simulator showing peers having different copies of blockchains],
)
The distributed page is just the same as the blockchain page but with multiple users in the network. Each user has their own copy of the blockchain. However, the simulator didn't show any process of propagating the blockchain through the network or how users in the network are connected at all. Instead I have to manually copy the blockchain data from one user to another user, which might not give me the same hash, nonce, and previous hash as the orignal blockchain. Therefore, this is a very inaccurate representation of blockchain network.
#figure(image("images/anders-tokens.png", width: 50%), caption: [Anders' Simulator Tokens page])
The tokens page provides a more structured data input, as it provides a template for user to input who is sending tokens to who and how many tokens are being sent. This is a good representation of transactions. However, this is just a repetition of the block page but with a more structured data input. This makes the block page being quite useless as the tokens page provides a better understanding for learners anyways.
#figure(image("images/anders-coinbase.png", width: 50%), caption: [Ander's Simulator Coinbase page])
Again, the coinbase page is just a repetition of the peers page which contains multiple blockchains which takes in the same data structure as the tokens page. Therefore, this makes the peers page being quite useless as the coinbase page provides a better understanding for learners as they know what goes into the data a block.\

Limitations:
- Anders' blockchain simulator allows users to mine a block before the previous block is mined. In real life, this is physically impossible because you will require the previous block's hash to calculate the current block's hash. Therefore, this is an inaccurate representation of blockchain.\
- The features in Anders' simulator is very redundant. For example, the block page and the tokens page are basically the same but with different data input structure. The same goes for the blockchain page and the distributed blockchain page. Therefore, this makes the simulator qutie confusing as they might think that those pages are showing different concepts in blockchain technology. The blockchain page is just a multiple of the hash page too. So only two pages are actually needed - the tokens page and the distributed blockchain page.\
- Anders' blockchain simulator allow users to remine an invalid block. In real life, this is not possible as once a block is invalid, all of its following blocks will also be invalid. Therefore, this is an inaccurate representation of blockchain.\

Both of the simulators allow you to change the content in a blockchain but this is not a realistic feature as in real life. Once a block is mined and added to the blockchain, it is immutable and cannot be changed. This is misleading for learners as they might think that blocks in a blockchain can be changed.
Features like mempool also isn't implemented onto the online simulators. This makes the idea of the process of converting transactions into blocks quite hard to understand. Therefore we could try to implement that. \

Although Sean's simulator provides a way for blockchain to be propagated through the network, both simulators do not actually show you how the blockchain is being propagated through the network visually. Therefore, I could try to implement a visualisation of the peer to peer network and how the blockchain is being propagated through the network. \
\
While Sean's CLI require you to control the blockchain using different devices, Anders' GUI only allows you to run on one computer. However, due to educational purpose, I believe that it would actually be better to simulate multiple nodes on one computer instead of requiring multiple devices which learners might not have. Therefore, my blockchain simulator will target to simulate multiple nodes on one computer. \
#pagebreak()
== Initial Features
In this BlockChain Simulator project, I will build a simplified model of blockchain and mainly focusing on visualisation of different technologies, so that learners would be able\ to easily understand them. There will be one blockchain running.\

The final project will be running on a browser and has a Graphical User Interface (GUI). The project will be developed in HTML, CSS, and TypeScript with web workers. This allows the nonce to be rendered faster and also better simulate how blockchains are being mined as this is usually being done by a crypto mining rig - a customised personal computer that uses multicore CPU/GPU to solve cryptographic equations and verify transactions on a blockchain.\
\
Features/Rules:
1. Core Blockchain Mechanics
- Block structure \u{27F6} index, timestamp, list of transactions, previous hash, nonce, and current hash, implemented by Object Oriented Programming (OOP)
- Hashing algorithm \u{27F6} a simplified SHA-256 function
- Mining algorithm \u{27F6} find a nonce such that block hash starts with N zeros (difficulty)
- Transaction system \u{27F6} sender, receiver, amount stored in a mempool before being mined, also implemented by OOP
- Chain validation \u{27F6} check each block's `previous_hash` matches the last block's hash


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
- No forked chains (always extend the longest chain)
- Assume honest nodes (no attackers)

Controls (buttons for inputs):
- "Add Transaction" \u{27F6} enter sender, receiver, amount
- "Mine Block" \u{27F6} mines transactions into a block
- "Propagate Transaction" \u{27F6} spreads it across nodes
- Network view \u{27F6} graph of nodes (circles), with edges showing connections (Output)

Limitations:
- This is a simplified model of the blockchain, which means that I will abstract the idea of blockchain and ignore a few details. For example, there will not be a handler for colliding blocks (forks) in the blockchain. This is because handling forks requires more complex consensus algorithms and network communication, which is beyond the scope of this project. Instead, I will assume that all nodes are honest and always extend the longest chain. Besides, I will also assume that there will be no attackers in the network, so I will not be implementing any security measures against malicious nodes. This is because implementing security measures would require more complex cryptographic techniques and network protocols, which are beyond the scope of this project.
#pagebreak()
=== Usability Features
This is my initial rough sketch on the graphical user interface (GUI) design of my blockchain simulator. It shows shows the user interface design of different sections of the platform, including the Introduction Page, Main Page, Users Page, Chains Page, Mining Page, Transactions Page, and the Settings Page.

#figure(image("images/ui.jpeg", width: 110%), caption: [
  Intial Design for User interface of the blockchain simulator.
]) <Initial-GUI-Design>

The usability features of the blockchain simulator includes multi page user interface and interactive visualisation for the simulator. Settings can be changed such as the dark mode to adapt users preferences. The blocks are colour coded so that users can easily identify the network flow.
=== Project Management Methodology
The solution will be developed in an agile way. This means that it will be developed in iterations. The analysis of requirements has been done in this section (Section 1).
In each iterations I will
- Design the prototype for that iteration
- Design tests for that prototype
- Build the prototype
- Test the prototype
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
In the project, all the algorithms will be developed using the following computational methods:
- Decomposition
  - At the start of each iteration, I will decompose the iteration, analyse what has to be done in that iteration and setting goals. This allows a more efficient development as I only have to think about each small goal while developing, including the targets and requirements. This also means that the code overall will be more modular, making it easier for future development and increasing maintainability.
  - Decomposition is suitable for my project as blockchain technology is a complex system with many components and processes. By breaking down the system into smaller, manageable parts, I can focus on developing and testing each component individually before integrating them into the larger system.
- Abstraction
  - I will focus on essential features rather than unnecessary details before developing. This can help me to achieve the overall goal quicker in each development stage. I will be using different methods such as writing psuedocode or drawing flowchart diagrams before development.
  - Abstraction is suitable for my project as it allows me to simplify complex blockchain concepts and focus ont he core functionalities needed for the simulator. This helps in managing complexity and ensuring that the development process remains efficient and focused.
- Thinking parallel
  - I will think about what is happening at the same time. For example, in my proof of work algorithm, I will require multiple threads of the CPU to mine blocks faster. Therefore, I will have to think about how to split the workload into different threads and how they will communicate with each other. This can help me to develop more efficient algorithms that can take advantage of modern multi-core processors.
  - Thinking parallel is suitable for my project since blockchain mining is a parallelisable task. By leveraging parallel processing, I can significantly speed up the mining process, making the simulator more responsive and realistic.
- Thinking Ahead
  - I will think about the future development of the project while developing. This means that I will have to think about how the code can be extended in the future and how new features can be added without breaking the existing code. This can help me to write more maintainable and extensible code. To achieve this, I will be thinking about the input and output of functions before developing them.
  - Thinking ahead is suitable for my project because I will be developing the same algorithms for firstly a CLI, then a GUI at the end to visualise the blockchain for my stakeholders. Therefore, I will have to think about how to code can be reused and extended for different interfaces. This can save me a lot of time to make redundant code to do the same thing.
#pagebreak()
- Problem solving using
  - Visualisation
    - Visualisation is an essential part of my project as the main goal of the entire simulator is to help learners to visualise how blockchain works. Therefore, I will have to think about how to represent different components of the blockchain visually, such as blocks, transactions, and the network. This can help me to develop a more effective and engaging simulator.
    - Performance modelling is also an important part of my project as I will have to control the performance of the simulator to ensure that it runs smoothly and efficiently, especially when mining a block with multiple threads. Therefore, I will have to think about how to model the performance of the simulator and find the best way to optimise it, e.g. using different number of web workers on different devices to mine blocks in parallel. The computers are processing this far more quickly than humans can visualise it.
=== Technology <technology>
The simulator will run purely on client side code to reduce server costs and workload, and create a more interactive and responsive user experience\
Frontend: HTML + CSS + TypeScript \
Graph visualisation: canvas
=== Device Compatibility (Software/Hardware requirements)
The blockchain simulator is designed to run entirely in the browser. Therefore a JavaScript supporting browser is required. The simulator will be optimised for modern desktop and laptop environments using Chromium browsers (Google Chrome, Microsoft Edge, Opera). Mobile browsers may support basic interactios, but visualisation features are best experienced on computer systems. The device running to program should have at least a refresh rate of 60Hz to run the `requestAnimationFrame()` function in canvas to visualise blockchain workflow. Since the code for mining will be using multiple threads (>10 logical processors) in the CPU, a computer of a better specification will be more optimised. The device should also have basic input and output devices, such as monitor which supports 60fps, keyboard and mouse.
==== TypeScript
I will be using TypeScript to develop my blockchain simulator. TypeScript is a superset of JavaScript that adds types, interfaces, and other features to enhance code quality and maintainability. Here are some reasons why TypeScript is a good choice for this project:
+ Type Safety: TypeScript's static typing helps catch errors at compile time, reducing bugs in runtime. This is  important in a complex project like a blockchain simulator where data structures and algorithms need to be precise. It also helps me to think about the input and output of the functions while doing modular coding
+ Sustainability: TypeScript's type makes it easier to understand and maintain code over time. This is important because it allows other developers to look at the code and understand it to develop new features and improvements\
\
However, when the website gets online, the TypeScript code will be transpiled (convert between two high-level languages) into JavaScript, so that it can be run on all Chromium browsers. Therefore, users do not have to install TypeScript on their devices to run the Blockchain Simulator. Their browsers only have to support JavaScript. Since I will be developing in Bun, the TypeScript will be automatically transpiled into JavaScript and I could just plug the file into the html file.
#pagebreak()
== Stakeholders <stakeholders>
External Stakeholders:
+ Students: My blockchain simulator is aimed at A level student who would like to go beyond the standard A level . This will serve as a great resource for them to gain an insight of what blockchain is and how a blockchain network will be looking like. They should then be able to apply this knowledge into real life technologies like cryptocurrencies
+ Teachers: They could use it as a teaching tool in lessons or demonstrations.
\
Internal Stakeholders
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

Most of them are very unfamiliar with the blockchain technology. However, Ben did some research in the blockchain in his free time. The majority of my stakeholders have never used a blockchain simulator or any visualisation tools before, except from Ben who has used the Ethereum Virtual Machine (EVM) to learn about proof of stake algorithm (one of the algorithm to mine blocks in the blockchain). However, the EVM doesn't provide any graphical visualisation of any blockchain concepts. \
\
Most of them have different aims that they would like to achieve from using a blockchain simulator. However, there are some common themes that they would like to learn about mining and how blocks are connected together. They also find network propagation quite difficult to understand. \
\
All of them would like to see visualisation of the mining process, as this is a completely new concept to them. They believe that visualisation can help them to understand the abstract concepts better. They would also like to interact with the blockchain by adding transactions and propagating blocks through the network. Most of them prefer a simple interface for learning as they are new to blockchain concepts.\
\
They would like the simulator to be responsive within 5 to 10 seconds while processing blockchain actions. This is because they have a short attention span and would like to see the results quickly. All of them would like the simulator to simulate multiple users/nodes on one computer, as they do not have access to multiple computers to run the simulator on a network. \
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
\
Unfortunately, due to time constrains, I wasn't able to find a teacher who is interested in teaching blockchain to interview.
#pagebreak()
== Intital Sucess Criteria
These are the initial Success Criteria (SC) which is what I am aiming for while developing a MVP (Minimum Viable Product). As I am developing in an agile methodology, the Success Critea might be ammended or new Success Criteria might be added in the process of iterations. In further on in this document, I will refer my Success Criteria with SC.

=== Success Criteria
#table(
  columns: (64pt, 33pt, 100pt, auto, auto),
  inset: 5pt,
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
  [Mining a block produces a hash satisfying difficulty (1 leading zero) and completes \u{003C}5s],
  [Demonstrates mining process works correctly and efficiently; 1 zero chosen as low difficulty for demonstration, 5s ensures responsiveness for users],
  [Mine a block and check hash meets difficulty; measure mining time],

  $ 1.4 $,
  [Each block has a sequential index automatically assigned],
  [Ensures proper ordering of blocks for clarity and prevents confusion; automatic indexing prevents user errors],
  [Add multiple blocks and check if block.index === previousBlock.index + 1 visually],

  $ 1.5 $,
  [Simulator handles unexpected user behaviour (keyboard smashing/spamming)],
  [Ensures robustness against accidental or malicious user actions; protects simulator from crashes and freezes],
  [Rapidly click input buttons or type random keys; confirm simulator does not crash],

  $ 1.6 $,
  [Simulator can broadcast a newly mined block to all connected nodes using BFS traversal within 2 seconds],
  [Ensures updates propagate efficiently across the network; 2s chosen for real-time demonstration],
  [Mine a block on one node and verify all connected nodes receive it within 2 seconds],

  $ 1.7 $,
  [Simulator can broadcast a newly mined block to all connected nodes using DFS traversal within 2 seconds],
  [Ensures correctness of alternative traversal method; 2s chosen for real-time demonstration],
  [Mine a block on one node and verify all connected nodes receive it within 2 seconds],

  table.cell(
    rowspan: 6,
    align: center,
    rotate(-90deg, reflow: true)[
      *Graphical User Interface (GUI)*
    ],
  ),
  $ 2.1 $,
  [Blocks visually display index, hash, previous hash, transactions],
  [Ensures learners understand the content in blocks],
  [Observe GUI; verify visibility of all block data],

  $ 2.2 $,
  [Transaction input form accepts strings ≤100 characters; longer inputs rejected],
  [Prevents invalid transaction data entry; 100 character limit chosen for readability and UI layout],
  [Enter valid and invalid strings; confirm validation works],

  $ 2.3 $,
  [Chain validity visually indicated],
  [Gives immediate feedback on blockchain integrity],
  [Create a block and visually check if the previous hash matches last block's hash],

  $ 2.4 $,
  [Users can expand blocks to view transactions; expansion completes \u{003C}0.5s],
  [Ensures users can inspect block details quickly; 0.5s chosen for fast but noticeable animation],
  [Click block and verify transactions displayed; measure expansion time],

  $ 2.5 $,
  [GUI updates within \u{003C}1s after any user action (add transaction, connect node) except mine block],
  [Ensures responsiveness and smooth interaction; 1 second ensures users to see updates promptly without lag],
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
  [Ensures post mining immutability; maintains trust in the blockchain],
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
    rowspan: 6,
    align: center,
    rotate(-90deg, reflow: true)[
      *Performance and reliability*
    ],
  ),

  $ 4.1 $,
  [Blockchain state persists while simulator runs; saving/loading \u{003C}1s],
  [Ensures reliability; 1s chosen as fast enough for user to continue interaction without noticeable delay],
  [Perform user actions and verify blockchain doesn't change visually],

  $ 4.2 $,
  [Memory usage \u{003C}100MB for 100 blocks],
  [Ensures efficient resource usage; prevents crashes and allows multiple sessions],
  [Monitor memory usage during simulation],

  $ 4.3 $,
  [Simulator and GUI running when window unfocused],
  [increases efficiency of the simulator, especially the mining blocks],
  [Switch window focus; observe simulation continues running],

  $ 4.4 $,
  [Memory usage \u{003C}50MB for 100 blocks stored in local storage],
  [Ensures efficient resource usage on a single computer; prevents crashes],
  [Monitor memory usage during simulation with 100 blocks in local storage],

  $ 4.5 $,
  [The simulator should have no server side code (except the one serving the static files)],
  [Reduces server costs and workload, and create a more interactive and responsive user experience],
  [Visually check the repository for any server side code],

  $ 4.6 $,
  [The simulator should be able to run on Bun without using any framework],
  [Bun allows fast development and testing of TypeScript code. Not using any framework reduces complexity and increases maintainability],
  [Try to run the simulator on Bun and check for any errors],
)
= Iterations
== Iteration 1
In Interation 1, I will be focusing on the proof of concept for the technologies that I will be using in my blockchain simulator. These includes the Breadth First Search (BFS) and Depth First Search (DFS) algorithms to simulate the propagation of blockchain within a peer-to-peer network. I will also be implementing a simplified SHA-256 hash function called `fakeHash()` function to generate hashes for blocks. Finally, I will be building a mining algorithm that uses the concept of nonce to find the hash of a block using web workers to improve performance.
=== Decomposing Iteration 1
#figure(image("images/iteration1_decompose.jpg"), caption: [Decomposing iteration 1])
Here I have a brief decompostion of what I am going to do in iteration 1. Each leaf nodes of my diagram represents an algorithm or files that I have to work on. Further on in the iteration 1, each algorithms will be decomposed further and carefully designed.
=== Main Goal
+ Proof of concept for Breadth First Search (BFS) and Depth First Search (DFS) so that I can later use them for visualising the broadcast of blockchain within the network.
+ Simplifying the SHA-256 hash function and implement it called the `fakeHash()` function.
+ Using web workers, build a mining algorithm that uses the concept of nonce to find the hash of a block.

==== BFS and DFS
To simulate the blockchain propagation along the network, I have decided to use the Breadth First Search and Depth First Search (DFS) algorithms. This is because both algorithms are in the A level Computer Science specifications across multiple exam boards. This can help students to understand the blockchain technology easily by applying their prior knowledge in traversing/searching a graph to a new problem - blockchain network propagation, fulfilling the main goal of this project, education.
#pagebreak()
=== Proof of Concept: BFS <BFS-unit-test>
Breadth First Search is an algorithm to traverse an undirected graph. A BFS algorithm starts at a selected node (often referred to as the 'root' node in tree structures) and explores all its neighbouring nodes at the present depth prior to moving on to nodes at the next depth level. This approach ensures that all nodes at the current level are visited before any nodes at the next level are explored, making BFS particularly useful for finding the shortest path in unweighted graphs.

==== Design of algorithm: BFS
The idea of layers in BFS refers to how nodes are explored based on their distance from the starting node. The first layer contains the starting node itself, the second layer includes all nodes directly connected to it, and each subsequent layer contains nodes that are one step further away. This structure means BFS explores the graph moving outward one layer at a time. Each node is therefore assigned to a specific layer according to how many edges it takes to reach it from the start.

I will use a queue data structure in my BFS algorithm to keep track of nodes to be explored. The algorithm begins by enqueuing the starting node and marking it as visited. It then enters a loop where it dequeues a node and enqueues all its unvisited neighbours, marking them as visited. This process continues until the queue is empty, meaning all reachable nodes have been visited. To store the data, I will use an adjacency list -- a data structure used to store a collection of unordered lists which is used to represent a finite graph.

==== Unit Test for BFS
For the unit test, I am making a new file `bfs.test.ts` and testing it using Bun. This allows me to test individual functions from the `bfs.ts` file by importing them into the test file.\ \
To make a unit test for my BFS algorithm, I have to firstly design some graphs and traversing them by hand, then convert them into adjacency list where I input the neighbouring nodes for each node so that the graph can be 'understood' by the algorithm.
===== Normal Test
I have designed the following basic tree (an abstract data type that is a graph that has a hierarchial structure) graph to test my algorithm (left). While traversing the graph with a BFS algorithm, I will start at node A (layer 1) and visit its neighbours C and B (layer 2). Then I will move on to layer 3 and visit F, D, and E. Therefore one of the ways to traverse the graph with the BFS algorithms is with the order: A \u{2192} C \u{2192} B \u{2192} F \u{2192} D \u{2192} E (right).
#subpar.grid(
  figure(image("images/basic_tree_graph.png", width: 100%), caption: [basic tree graph]), <a>,
  figure(image("images/bfs_tree_graph.png", width: 60%), caption: [BFS traversal of the basic tree graph]), <b>,

  columns: (1fr, 1fr),
  label: <normal-test>,
)

#pagebreak()
Since I am developing in TypeScript, I have to declare the type of my adjacency list. Therefore I have to create an interface for my adjacency lists. Considering my input being the nodes and its neighbours in an array of strings, I will require a key-value pair #footnote[https://experienceleague.adobe.com/en/docs/audience-manager/user-guide/reference/key-value-pairs-explained#:~:text=A%20key%2Dvalue%20pair%20consists,color%20%3D%20green] (a basic data structure that stores data as a collection of unique, constant keys and their corresponding, variable values). Therefore my type AList (adjancency list) takes in 2 parameters, the key as a string --- this will be the nodes and the values as an array of strings --- this will be the neighbours in arrays of strings. The interface can be defined as following:
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
  let result = bfs_traverse(200, 400);
  expect(result).toEqual([null]);
});
```

==== Development of BFS
To implement the Breadth-First Search (BFS) algorithm, I developed a function named `bfs_traverse()` that accepts two parameters: an adjacency list (`adjacencyList`) with the `AList` interface and a starting node (`startNode`) as a string. The adjacency list provides an efficient way to represent the structure of a graph, where each key corresponds to a node and each value is a list of its directly connected neighbours. The output of the function should be the traversal order of nodes as an array of strings.\
\
The algorithm begins by initialising a queue with the starting node. The queue follows the *First-In-First-Out (FIFO)* principle, ensuring that nodes are explored in the order they are discovered. This structure allows the algorithm to process the graph in layers, visiting all nodes that are one edge away before progressing to nodes further out. A separate visited array is also initialised to keep track of nodes that have already been explored, preventing repetition and infinite loops.\
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
```
#pagebreak()
This part of the code:
```ts
for (let neighbour of adjacencyList[node]) {
  if (!visited.includes(neighbour)) {
    visited.push(neighbour);
    queue.push(neighbour); // Enqueue neighbour for later exploration
  }
}
```
determines how the algorithm traverses the graph. For each node dequeued from the queue, it iterates through all its neighbours as defined in the adjacency list. If a neighbour has not been visited yet, it is marked as visited by adding it to the visited array and enqueued for future exploration. By adding neighbours to the end of the queue, the algorithm ensures a First In First  Out (FIFO) traversal order, meaning that nodes closer to the starting node are fully explored before moving on to nodes that are further away. This is what creates the layered property of BFS, allowing it to visit nodes level by level.\
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

To fix these issues, I added a defensive check before iterating over neighbours. If a node does not exist in the adjacency list, the algorithm simply skips the neighbour loop, allowing it to safely return the starting node as visited. Additionally, a type check can be added at the start to handle completely invalid inputs gracefully, returning `[null]` if the input types are incorrect.\
\
To fix this, I added a defensive check at the start of the function before iterating over neighbours:
```ts
  // Defensive type check for completely invalid inputs
  if (typeof adjacencyList !== "object" || typeof startNode !== "string") {
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
In future iterations, I can reuse these sets of testing data and set network to test if the BFS algorithm successfully broadcast a blockchain to the whole network. This will be done in Iteration 4 and 5 where the GUI and the visualisation of the simulator is developed.
#pagebreak()
=== Proof of Concept: DFS
Depth First Serch is another algorithm to traverse an undirected graph. A DFS algorithm also starts at a selected node (the 'root' node) and explores as far as possible along each branch before backtracking. This means that DFS goes deep into the graph, visiting a node and then recursively visiting one of its unvisited neighbours until it reaches a node with no unvisited neighbours. At this point, the algorithm backtracks to the most recent node that has unvisited neighbours and continues the process until all nodes have been visited.

==== Design of algorithm: DFS
Depth First search (DFS) explores a graph by moving as far as possible along each branch before backtracking. The algorithm conceptually follows a single path from the starting node, exploring one neighbour at a time until it reaches a node with no unvisited neighbours, at which point it backtracks to the previous node to explore other paths.\
\
I will use a stack data structure in my DFS algorithm to keep track of nodes to be explored. The algorithm begins by pushing the starting node onto the stack and marking it as visited. It then enters a loop where it pops a node from the stack, and pushes all its unvisited neighbours onto the stack, marking them as visited. This process continues until the stack is empty, meaning all reachable nodes have been visited.\
\
I decided to make use of the call stack and implement the DFS algorithm recursively. The algorithm starts at the root node, marks it as visited, and then recursively visits each unvisited neighbour. This continues until all nodes have been visited. Using recursion in DFS is justified because it naturally mirrors the algorithm's logic of exploring 'as deep as possible' along a branch before backtracking. The call stack inherently acts as the stack needed to keep track of nodes yet to be explored, so recursion simplifies the code and avoids manually managing a separate stack. It also makes the algorithm easier to read and understand, especially for complex graphs, since each recursive call represents the exploration of a node and its subtree. Recursion is particularly suitable for small to medium sized graphs, like the ones in my simulator, because the depth of recursion is limited and won't cause stack overflow on a typical machine.\
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
Similarly to BFS, to implement the Depth First Search (DFS) algorithm, I developed a function named `dfs_traverse()` that accepts two parameters: an adjacency list (`adjacencyList`) with the `AList` interface and a starting node (`startNode`) as a string. The adjacency list efficiently represents the graph structure, where each key corresponds to a node and each value is a list of its directly connected neighbours. The output of the function is an array of strings representing the order in which the nodes were visited during traversal.\
\
The algorithm begins by marking the starting node as visited. It then recursively explores each of the starting node's unvisited neighbours, applying the same process at each subsequent node. This recursive approach leverages the call stack, which behaves as a *Last In First Out (LIFO)* structure, to keep track of nodes that still have unvisited neighbours. Each recursive call pushes the current node onto the stack, so the most recently discovered node is explored first, while nodes visited earlier wait in the stack to be resumed later. Once a node has no more unvisited neighbours, the function returns, popping the previous node from the stack and backtracking to explore any remaining neighbours. This LIFO behavior naturally implements depth first traversal without needing an explicit stack data structure.\
\
During traversal, a visited array is maintained to record which nodes have already been explored. This prevents revisiting nodes and avoids infinite loops in cyclic graphs. The recursion continues until all nodes reachable from the starting node have been visited, at which point the function returns the visited array, representing the traversal order.\
\
This implementation adopts a recursive approach rather than an iterative one with a manual stack, which simplifies the code and clearly shows the conceptual idea of DFS -- exploring one branch as deeply as possible before backtracking. Since at the end product there will be a low maximum number of nodes (to simulate users), the run time of the DFS algorithm will not massively increase comparing to the iterative approach.\
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
recursion and the call stack is used to track nodes with unvisited neighbours. Each recursive call pushes the current node's state onto the stack, explores its neighbours, and backtracks automatically when there are no more nodes to visit. This allows depth first traversal without an explicit stack, ensuring all reachable nodes are visited.
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
Hashing is a fundamental concept in blockchain technology, used to ensure data integrity and security. A hash function takes an input (or 'message') and returns a fixed size string of bytes. The output appears random and is unique to the specific input. Even a small change in the input will produce a significantly different hash, a property known as the avalanche effect. In blockchain, hashing is used to link blocks together, verify transactions, and secure data against tampering.
Blockchain commonly uses the SHA-256 (Secure Hash Algorithm 256 bit) hashing algorithm. However, brute forcing SHA-256 is an incredibly computational heavy task. Instead, I will be creating a simplified version of a hashing function that captures the essence of how hashing works in blockchain.

==== Research on the SHA-256 algorithm
Summarising this article about cyber security from #link("https://www.simplilearn.com/tutorials/cyber-security-tutorial/sha-256-algorithm")[simplilearn] #footnote[https://www.simplilearn.com/tutorials/cyber-security-tutorial/sha-256-algorithm], the SHA-256 algorithm always hashes the results to 256 bits and the process is irreversible. This is done by:
+ Firstly padding bits (adding extra bits to the message so that the length is exactly 64 bits short of a multiple of 512)
+ Then add 64 bits of data now to make the final plaintet a multiple of 512. The added data is calculated by applying the modulus to the original cleartext
+ The padded message is then divided into 512 bit blocks, each processed through 64 rounds of bitwise operations such as AND, OR, XOR, and right rotations.
+ Each round uses predefined constants and functions to mix and compress the data, progressively transforming it into a unique 256 bit digest.
+ The final output, known as the message digest, is deterministic -- the same input always produces the same hash -- but infeasible to reverse or predict.
+ This structure ensures the avalanche effect, where even a one-bit change in the input drastically alters the output, making SHA-256 ideal for data integrity and blockchain security.


==== Design of algorithm: Hashing
I have to simplify the SHA-256 algorithm to create a basic hashing function that is computationally less intensive while still demonstrating the core principles of hashing.
Therefore I am coming up with my own simplified hashing algorithm:
Iterate over each character in the input string:
- Set hash = 0
- Multiply the current hash by 67; 67 is a prime number, chosen because multiplying by a prime reduces collisions and spreads the effect of each character across the final hash value.
- Add the character's ASCII code, ensuring each character uniquely influences the hash.
- Mask with 0xffffffff to keep the result within 32 bits, simulating integer overflow; 0xffffffff--which in binary is 32 ones--keeps only the lowest 32 bits of a number, ensuring the hash behaves like a real 32-bit hash, remains fixed-size, deterministic, and avoids large-number rounding errors in TypeScript.
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
To implement the simplified hashing algorithm, I created a function named `simpleHash()` that takes a string input and returns a fixed size hexadecimal hash. The algorithm processes each character in the input string, updating the hash value through multiplication, addition of ASCII codes, and bitwise operations to ensure it remains within 32 bits. Finally, the hash is converted to a hexadecimal string, padded to ensure a consistent length.
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
After implementing the simplified hashing algorithm, I ran the unit tests I designed earlier. The results were successful, with all tests passing as expected. The hashing function demonstrated determinism by consistently producing the same hash for identical inputs. Additionally, the avalanche effect was confirmed, as even minor changes in the input string resulted in significantly different hash outputs. The edge case test for an empty string also passed, confirming that the function can handle such inputs gracefully and produce a valid hash. Overall, the hashing function performed reliably across all test scenarios, validating its correctness and robustness. The same input returns the same output fulfills SC 3.1.
#figure(
  image("images/hash_test_result.png", width: 43%),
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
Initially, I planned to use *WebGPU* for the parallel mining. This means that I will be able to use the GPU in the user's computer to mine the blocks. However, I decided that this wouldn't fit the blockchain simulator because the ultimate goal of the project is to demonstrate how blockchains work, not to max out hardware performance. WebGPU adds a ton of unnecessary complexity -- it's built for graphics and parallel vector math, not for small, iterative CPU tasks like Proof of Work. It is also not consistently supported across browsers and could easily cause crashes or overheating on student's devices, limiting the program's accessibility for the students (considering the students would have an average computer). Since my target audience is general A level students. This means that I need something that runs smoothly and safely in any browsers without setup issues. Web workers are a better fit as they allow the user to see realistic mining by simulating parallel computation across CPU threads, keeping the focus on the blockchain logic rather than GPU technicalities.\
\
A mistake that I made while decomposing the PoW mining algorithm in the decomposing Iteration 1 is that I mentioned I require a website in order to use web workers. However, after researching more about web workers, I found out that web workers can be used in TypeScript files directly without the need of a website. This is because Bun (the runtime I am using) supports web workers natively in TypeScript files. Therefore I can directly create web workers in my TypeScript files without needing to set up a website or a server. This simplifies the implementation and allows me to focus on the mining logic itself (abstraction).\
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
- baseData: string - the base string for the proof of work computation.
- difficulty: number - the number of leading zeros required in the hash.

Outputs:
- Logs to the console whenever mining starts, a valid nonce is found, or mining stops.
- A valid nonce and its hash are reported when found.

Key Variables:
- NUM_WORKERS - number of parallel worker threads to use.
- CHUNK_SIZE - the number of nonces each worker processes per batch.
- nonceOffset - tracks the starting nonce for the next batch of work.
- running - a boolean flag to indicate if mining is active.
- workers - array storing all active Worker instances.

Functions:
- `startMining()` - initialises mining, creates workers, assigns work in chunks, and handles results.
  - Uses `worker.postMessage()` to send work chunks to workers.
  - Uses `setTimeout(assignWork, 0)` to schedule subsequent chunks asynchronously, allowing non-blocking operation.
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
This can be resolved by using a different environment that supports multiple file serving, such as a traditional web server or vite#footnote[https://vite.dev/] -- development server and build tool for web projects. However, with this approach, I will have to transpile the code into JavaScript and run it in a browser console. An html file will also be needed to load the `main.js` file. The functions `startMining` and `stopMining` has to be exposed to the global environment to be able to call them from the browser console. Therefore these two lines have to be added to `main.ts`:
```ts
// Expose functions to the global scope
(self as any).startMining = startMining;
(self as any).stopMining = stopMining;
```
This works but it is not ideal for my use case as I want to keep the code in TypeScript for better type safety and developer experience.
#figure(image("images/vite.png"), caption: [Vite Development Server Serving Multiple Files])
This is not the best approach since I want to keep the code in TypeScript for better type safety and developer experience.
==== Approach 2
Another approach to resolve this issue in Bun is to create a simple HTTP server that serves both `main.ts` and `worker.ts`. This way, when the main thread creates a new worker, it can successfully fetch the `worker.ts` file from the server. Here is how I implemented it:\
-- See next page
#pagebreak()
```ts
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
Since I will not need to use the worker code anywhere else in my blockchain simulator. Therefore I had another approach which is slightly less modular but works perfectly in Bun. I decided to inline the worker code as a Blob#footnote[https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers] within `main.ts`. This way, the worker code is encapsulated within the main file, allowing me to create workers without needing to serve a separate file. Here is how I implemented it:
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
In this approach I don't have to serve multiple files and the code remains in TypeScript. The worker code is defined as a string within `main.ts`, and a Blob is created from this string to instantiate the workers. This allows the mining simulation to run entirely within Bun without the need for an external server or multiple files. Therefore this is the preferred approach for my PoW mining simulation in Bun. This fulfills SC 4.5 and SC4.6.
==== PoW Testing
I am using two different computers to test the PoW mining algorithm:
+ A high performance self built custom pc with Intel(R) Core(TM) i5-14500, 2.60 GHz, 32.0 GB DDR5 RAM, which has 14 cores and 20 threads#footnote[Spec sheet: https://www.intel.com/content/www/us/en/products/sku/236784/intel-core-i5-processor-14500-24m-cache-up-to-5-00-ghz/specifications.html]. Theoretically it should be able to handle 20 web workers at the same time.
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
Notice that if we are using more than 3 cores, both computers runtime will drop under 5 seconds, satisfying the SC1.3.\
\
I have noticed a significant decrease in run time for mining from the first few core, however this decrease becomes less significant as the number of cores continue to increase. This means that there will be an optimal number of threads to be used to get a decent performance, and after that, the performance will still increase, but the performance gain will be trivial. \
\
// Standard Deviaiton Calculation
// large standard deviation = inconsistent performance
I have also calculated the standard deviation (s.d., denoted by $s^2$) for samples with $ s^2 = Sigma(x_i - overline(x))^2/(n-1) $ of both execution and found the mean for them. This tells us how far each data point is from the mean run time. Notice that the standard deviation for run time on the high performance computer is \u{223C}4.4\u{00D7} that of the medium performance. This means that the performance will be more inconsistent on lower spec computers. Hence, giving a lower standard deviation. \
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
Limitation - This test is only done on two computers, therefore the results may vary on different hardware configurations. However, the general trend of performance improvement with increased web workers should hold true across most systems.\
\
Another Limitation - The result might not be accurate as there are other background processes running on the computer which might interfere with the mining process. However, by taking the average of multiple runs, I can mitigate some of this variability and get a more reliable measure of performance.
#pagebreak()
=== Iteration 1 Evaluation
In this iteration I have done the proof of concept for multiple parts of my blockchain simulator:
+ Breadth First Search (BFS) algorithm for graph traversal to show the broadcast of new blocks and transactions across the network
+ Depth First Search (DFS) algorithm for graph traversal also to show the broadcast of new blocks and transactions across the network
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
I will be using modular coding practices to ensure that the `Block` and `Blockchain` classes are well encapsulated and can be easily maintained and extended in the future. The `Block` and `Blockchain` class will be developed in the files `block.ts` and `blockchain.ts` respectively. This approach will also facilitate testing and debugging, as each class can be developed and tested independently before integrating them into the larger simulator. This means that it can reduce the repetition in code, improve readability, and allow future developers to pick things up straight away. It is also a perfect fit for decomposed code as it makes it easier to code and debug, reducing the risk of cascading bugs throughout the application.
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
- Call `minePendingTransactions()`
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
- Chain validation (`isChainValid()`)
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
- The Blockchain class creates new `Block` instances when `minePendingTransactions()` is called.
- It passes necessary data such as transactions from the mempool and `previousHash` from the latest block.
- Blockchain then calls the block's `mineBlock(difficulty)` method to perform proof of work, which sets the block's nonce and hash.
2. Chain linking
- Each Block stores the previousHash of the block before it.
- This allows Blockchain to maintain the correct sequence of blocks and validate integrity through `isChainValid()`.
3. Data flow
- Transactions flow from the Blockchain mempool into a Block when mined.
- Once mining is complete, the new block is added to the blockchain, and the mempool is cleared.
4. Validation
- The Blockchain uses each block's `calculateHash()` method to verify that the chain hasn't been tampered with.
- Blocks themselves are passive; they provide their hash and allow mining, but do not manage the chain.
Here is a flowchart to show how `Block` and `Blockchain` classes work together to form the blockchain structure:
#figure(
  image("images/block_and_blockchain.jpg", width: 44%),
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
2. `getLatestBlock()`\
  The `getLatestBlock()` function is required because to add new blocks to the chain, we will have to get the hash of the previous block. Therefore this will be used in the `minePendingTransactions()` later on. The function doesn't take in any parameter and return the latest block.\
\
3. `addTransaction(tx)`\
  The `addTransaction(tx)` function allows the users to add the transactions into the mempool. It takes in `tx` (transactions) as `string`. An example input would be `Alice pays Bob 10 coins`. This shows the concept of a mempool, which most of the simulators online did not show. The function doesn't return any output but only push the transactions into the mempool.\
\
4. `minePendingTransactions()`\
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
5. `isChainValid()`\
  The `isChainValid()` function is used to validate the chain and make sure nothing is wrong in the blockchain. This can be done by verifying if the `previousHash` on each block actually matches the previous block. Therefore we can make a loop through the blocks checking the hashes. There will be no input for this function because the chain is already an attribute of the blockchain, therefore it can be accessed in the local class scope. The output of the function will be a true/false therefore it's a `boolean`.
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
- Call `minePendingTransactions()` to mine them into a new block
- Print the blockchain to show the new block added
- Validate the chain using `isChainValid()` and print the result
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
The ouptut has to be 'JSONified' since the attribute `myChain.chain` is an array consists of blocks, which contains the methods of `calculateHash()` and `mineBlock()`. Using a `JSONify` doesn't print the functions of the block, increasing the readability of the output. When printed directly, TypeScript doesn't automatically display the full object structure -- it just shows `[object Object]`. \
\
Using JSON.stringify() #footnote[https://akshaymattoo.medium.com/what-is-null-in-json-stringify-obj-null-2-8282b2e4eee1] converts the object data (its properties and values) into a readable JSON string format that can be shown neatly in the console, making it easier to inspect the entire blockchain state. In `JSON.stringify(myChain.chain, null, 2)`:
- The first parameter (myChain.chain) is the object or array you want to convert into JSON
- The second parameter (null) is the replacer, which lets you filter or transform values before converting -- null means “include everything as-is.”
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
#pagebreak()
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
- The `fakeHash()` function working as the transaction length doesn't matter. This means that SC1.2 will be satisfied
- The more time taken by higher difficulty blockchain network level
===== Errorneous Tests Result
#figure(image("images/I2-error.png", width: 50%), caption: [Iteration 2 Errorneous Tests Result])
There are a few things going on here. Firstly, for my "Invalid Transaction type" test, there was no error being raised, which was what is expected. However, the error actually did raise, but not in runtime. TypeScript automatically highlights the invalid type in the IDE, which is shown like this:
#figure(image("images/I2-erroneous.png"), caption: [TypeScript raising type error])
This is good as I can spot the wrong input during development. However, at the end product, the code will not be shown to the users, therefore data has to be validated. This will be done in further iterations where I improve the user experience.\
\
Another problem in this test is the `InvalidStateError` in the reMining tests. This error is sometimes raised and sometimes not. This is beacuse each worker runs `assignWork()` repeatedly with `setTimeout(assignwork, 0)` -- meaning it's in an infinite async loop, posting new work until mining stops. When `stopMining()` is called (after one worker finds a valid hash), it terminates all workers. The problem though is that some workers still have pending `setTimeout(assignWork,0)` callbacks queued. So they wake up, try to call `worker.postMessage()` again but the worker has already been terminated, causing the `InvalidStateError`. \
\
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
#pagebreak()
Therefore, the blockchain simulator can now:
- prevent tampering of blocks
- prevent remining of blocks

In future iterations, the same test data can be used to test the same features, which includes the reMining test. This will allow me to make sure that the features are still working after I have added more features in the future iterations.
=== Iteration 2 Evaluation
I have invited one of my stakeholders, Ben, to review my prototype -- blockchain core structure. This is because Ben has some prior knowledge about blockchain technologies and he has also used some blockchain simulators and developed some proof of stake algorithm before. Therefore he would be able to understand what I have been doing and give me some feedback on my work, since there isn't a CLI for this iteration yet. He enjoys seeing the blockchain structures and the mining actually happening in web workers using multiple threads/logical processors in the CPU. This can give a more efficient mining speed. He also says the blockchain core structure has included everything about blockchain that he knows. He believes that with the structure, it gives a very full on introduction to students that have never been exposed to blockchain before.\
\
In this iteration, I have successfully delivered the core structure of blockchain technologies, they include all the necessary functions to allow me to continue to develop a whole network, which will contain users as nodes since I have made everything in an object oriented programming way. This is very helpful as the blockchain class can be used across different nodes in the network.\
\
The block generates instantaneously, showing the details of the block. This fulfills the requirements for SC1.1.
===== Pure functions
In Iteration 2, most of the functions have been developed very specifically for one case. For example, the `minePendingTransactions()` function is way too tied with the blockchain's internal state -- it hard-coded `this.mempool` as the only source of transactions. In this iteration this can work because we are only doing everything in one user (node), which means that the only transactions are the ones in the local mempool. However, in Iteration 3 when I start to develop the CLI, I will have multiple users (nodes) in the network, each with their own mempool. Therefore I will have to modify the `minePendingTransactions()` functions to take in the transactions as a parameter, instead of directly accessing from `this.mempool`. This will make the function more reusable for different users (nodes) in the network. Although the functions in this Iteration were modular, they should be more pure to make it more reusable.\
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
I decide to track the user balances with a class. This is because it allows me to create functions to validate the transactions. In my research section (@research) under the transaction validity, I had an initial design as a flowchart. However, they are how real blockchain ones work, and without simplification. To allow my stakeholders -- A level students to understand the concept of blockchain, I will make some abstraction to the idea of blockchain and implement it differently. Here is the decomposition of the `Balances` class.
#figure(image("images/balances.png"), caption: [Decomposition for the Balances class])
Attributes:
- balances (Map\<string,number>): This is an array to track the users with the
- initialBalance (number): The amount of coins when users join the network, set to 100 by default
Methods:
- `getBalances(username: string)`: number -- This function takes in the username as a string and return the balance of the user as a number. Validation: If the user doesn't exist, return 0
- `addUser(username: string)`: string -- This function takes in the username as a string and add the user into the balances array (map) with the initial balance. It returns a string message of who is being added to the network. Validation: If the user already exists, a string message will be returned saying the user already exists
- `applyTransaction(from: string, to: string, amount: number)`: void -- This is a function that applies the transaction to the balances map. It takes in the sender username, receiver username and the amount of coins to be transferred. Validation: If the sender doesn't have enough balance, an error will be thrown. This can be done by using the `getBalances()` function to get the sender's balance and compare it with the amount to be transferred. If the sender doesn't have enough balance, an error will be thrown. If the usernames don't exist, an error will also be thrown.
- `printBalances(username?: string)`: string -- This function takes in an optional username as a string. If the username is provided, it will return the balance of the user. If not, it will return the balances of all users in the network. Validation: If the user doesn't exist, a message will be printed saying the user doesn't exist.
- `hasFunds(username: string, amount: number)`: boolean -- This function takes in the username and the amount of coins to be transferred. It returns a boolean indicating whether the user has enough balance to make the transaction. Validation: If the user doesn't exist, return false.
Simplification that I have made:\
Initially, when each users join the network, they will be assigned 100 coins, this is obviously not the case in real world since they are not given free coins by joining a blockchain network. \
=== Design for Testing Balances class
I will be making unit tests for the `Balances` class. This is because the functions are pure functions and they don't depend on any other classes. Therefore I can test them individually without worrying about the other classes. The tests will be done in a separate file called `balances.test.ts`. The tests will include:
- Adding users to the blockchain network
- Check if user has got enough balances before transaction
- Checking the logic when transaction is applied
- testing the printBalances return the correct balances of users
+ Adding users to the blockchain network can be tested by the `addUser()` function and the `getBalance()` function. The `addUser()` perform the actual function to add the users into the network while the `getBalance()` verifies that the user is in the network and has the right amount of balances in the map.
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
2. Since the `hasFunds()` function only returns a boolean, this will be easy to test. I can make a few boundary tests and unexpected input.
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
4. The `printBalances()` function has two tests -- One to test when a specific user is passed in as a parameter, it returns the balance of that user. The other test is used when no specific user is passed in as a parameter, it should be able to return the balances of all users. Errorneous tests such as a invalid user could be used to test the validation I am going to make for the function.
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
- The nullish coalescing operator `??`#footnote[https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Nullish_coalescing] is used in getBalance() to deal with possible invalid inputs in case `this.balances.get(username)` is null or undefined.
- The functions `set()`, `get()`, `has()`,`.entries()` were used instead of functions like `push()`, `includes()`, etc. because this.balances takes in the form of a Map #footnote[https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map], instead of an array.\
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
- `addNeighbour(node: Node)` -- connecting a user in the network to the new user

The implementation of neighbours store the connected nodes in an array. This is good as it looks like the adjacency list in Iteration 1. This allows me to propagate the local copy of blockchain across the whole network with the DFS/BFS algorithms that I have made in Iteration 1.
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

The majority of the output of the functions are strings. This is because I want all the processing to be done in this class, with the help of the built functions from the previous Iterations. Therefore, only the state message will be returned. This can help me to make a cli a lot easier as it only has to `console.log()` the output of the functions to show the state of the network.

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
  \
  \
- `getNode(username) : Node | undefined`
  - As the majority of the functions above require selecting nodes, it is better off to make a simple function which select the required nodes. This is a helper function that takes in a username and returns the corresponding Node object from the nodes map. If the username does not exist, it returns undefined. This function will be used in other methods to get the Node object for a given username.\

=== Network Class Development
Here is the code for:
- `addUser()`
```ts
  addUser(username: string): string {
    if (this.nodes.has(username)) {
      return `User ${username} already exists.`;
    }
    let node = new Node(username);
    this.nodes.set(username, node);
    this.balances.addUser(username);
    return `User ${username} added.`;
  }
```
I used `set()` instead of `push()` to append the new node into the nodes. This is because I am interacting with this.balances, which is a Map.\

- `getNode(username:string): Node| undefined`
```ts
  getNode(username: string): Node | undefined {
    return this.nodes.get(username);
  }
```
By the same reason that this.balances is a Map, I am using `get()`.\
\
- `addTransaction(from: string, to: string, amount: number): string`
```ts
// Add transaction to global mempool
addTransaction(from: string, to: string, amount: number): string {
  let sender = this.getNode(from);
  let receiver = this.getNode(to);
  if (!sender || !receiver) {
    return "Sender or receiver not found.";
  }

  if (!this.balances.hasFunds(from, amount)) {
    return `${from} does not have enough coins.`;
  }

  let tx = `${from} pays ${to} ${amount} coins`;
  this.mempool.push(tx);
  return `Transaction added to global mempool: ${tx}`;
}
```
A few validations had been made, e.g., the check for enough balances and existing receiver/sender.\
\
\
\
\
- `mine(username: string): Promise<string>`
```ts
// Mine transactions for a given node
async mine(username: string): Promise<string> {
  let node = this.getNode(username);
  if (!node) {
    return `User ${username} not found.`;
  }
  if (this.mempool.length === 0) {
    return "No transactions to mine.";
  }
  let transactionsToMine = [...this.mempool];
  let newBlock = await node.blockchain.minePendingTransactions(
    transactionsToMine
  );
  node.blockchain.chain.push(newBlock);

  // apply transactions
  for (let tx of transactionsToMine) {
    let parts = tx.split(" ");
    let from = parts[0];
    let to = parts[2];
    let amount = parseInt(parts[3]);
    this.balances.applyTransaction(from, to, amount);
  }

  // Clear mempool after mining
  this.mempool = [];

  let latestBlock = node.blockchain.getLatestBlock();
  return `Block mined by ${username}: Index=${latestBlock.index}, Hash=${latestBlock.hash}, nonce=${latestBlock.nonce}`;
}
```
Since my `minePendingTransactions()` function connects to `startMining` function which has a resolve function, I will have to return a Promise #footnote[https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise] of string instead of pure strings.\
\
Another point to mention is that since each transaction takes in a form of ```ts tx = ${from} pays ${to} ${amount} coins`;```, therefore I will have to split them back up into parts to extract the sender/receiver and amount to apply the transaction.\
\
The index of the block is automatically assigned to the block, fulfilling SC1.4 \
\
- `connectUsers(user1: string, user2: string): string`
```ts
// Connect two users as neighbours
connectUsers(user1: string, user2: string): string {
  let n1 = this.getNode(user1);
  let n2 = this.getNode(user2);
  if (!n1 || !n2) return ``;
  n1.addNeighbour(n2);
  n2.addNeighbour(n1);
  return `${user1} and ${user2} are now neighbours.`;
}
```
This is a basic function to just use the `addNeighbour` function from the Nodes class.\
\
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
I am building the adjacencyList to fit the program which I have done in Iteration 1 for bfs and dfs which takes input in the form of an adjacencyList. This is done by setting the key of the adjacencyList as the username from each node, and add their neighbours into the value of that key. This adjacencyList is passed into the dfs/bfs function to get a traversal order over the nodes/users in the network. \
\
The local blockchain is then copied to all connected nodes within the network by the order of bfs/dfs returned by the traversal functions.\
\
The following are the code for printing the state of the blockchain:
```ts
// Display a user's blockchain
showChain(username: string): string {
  let node = this.getNode(username);
  if (!node) return `User ${username} not found.`;
  let output_str = `===== ${username}'s Blockchain =====`;
  node.blockchain.chain.forEach((block) => {
    output_str += `\n\nIndex: ${block.index}, Hash: ${block.hash}, Nonce: ${
      block.nonce
    }\n Transactions: ${block.transactions.join(", ")}`;
  });
  return output_str;
}

// Show all users
showUsers(): IterableIterator<string> | string {
  if (this.nodes.size === 0) {
    return "No users in the network.";
  }
  console.log(this.nodes.keys());
  return this.nodes.keys();
}
// Show user balances
showBalances(username?: string) {
  return "=== Balances ===\n" + this.balances.printBalances(username);
}

// Show a user's neighbours
showneighbours(username: string) {
  let node = this.getNode(username);
  if (!node) {
    console.log(`User ${username} not found.`);
    return;
  }
  if (node.neighbours.length === 0) {
    console.log(`${username} has no neighbours.`);
    return;
  }
  console.log(
    `neighbours of ${username}: ${node.neighbours
      .map((n) => n.username)
      .join(", ")}`
  );
}

// Show global mempool or per-user mempool
showMempool(): string[] {
  return this.mempool;
}
```
For some of the print functions, for example, the `showBalances(username?: string)`, I had to use an optional paramter to either show everyone's balances when nothing is passed in and show a specific user's balances when a specific user is being input.\
\
The `showUsers()` function actually returns an `IterableIterator<string>`#footnote[ https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Iteration_protocols]. This is because I want to do the count for the number of the users in the cli.ts. Thinking ahead, I also believe that this will help the future me to develop the GUI when I want to just get all the users in the network.\
\
=== Testing
Although unit tests can be awesome in terms of testing small parts of the code, it takes too much time to design and write. Therefore, I will be using manual testing for the Network class. This is also because a lot of the functions in the Network class are not pure functions, and they depend on the entire state of a network.\
\
When I finish developing the CLI, I will be using the CLI to test the functions in the Network class. This is because the CLI will be the main interface for my stakeholders to interact with the blockchain simulator. Therefore, I will be able to test the functions in the Network class through the CLI.\
\
=== Abstraction made
There is a few simplification that I have done in this network. For example, the stakeholder will be able to decide who they want to connect in the network. This is not true in real life. In a real blockchain network, the users will be connected in two cases:
+ When a user is transacting with another user, they will be connected
+ When two users are transacting with one user at the same time, the two users will also be connected
Although this shouldn't be too hard to implement, I believe that this will make my stakeholders a lot more confused on how the users are connected. This will not help them to understand blockchain technologies clearly.

=== Design for CLI
I quite like the menu from Sean CLI from @sean-cli due to the readability of the menu and easy to understand interface. When I started his simulator, there was a menu page which allows you to navigate to different sections such as the `blockchain` section and the `p2p` section. Therefore I am going to use this idea to create the menu page for my simulator. After researching into different command line libraries, I have decided to choose `readline` API library#footnote[https://nodejs.org/api/readline.html]. This is because the `readline` API provides a simple and built-in way to handle user input directly from the terminal, without needing to install any extra packages. It also works seamlessly with Bun, since Bun implements Node's core `readline` module by default. On top of that, it makes the cli look cleaner and more organised -- similar to Sean CLI -- allowing me to create a visually clear and intuitive menu system for navigating between different components of my blockchain simulator.\
\
=== Designing tests for CLI
I want a menu for my CLI which shows all the commands available to use, just like the one in Sean CLI. I can do this by making a string of menu and printing it at the start.\
\ Since all the features have already been developed in the Network class, the `cli.ts` just has to import those.

=== Implementing CLI
To setup the readline library it is actually very easy. I will just have to make a function which takes in prompts from the users, which is where user can perform actions.
```ts
import readline from "readline";

let rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

function prompt(): Promise<string> {
  return new Promise((resolve) => rl.question("> ", resolve));
}
```
This is the only code required to setup the basic command line interface.\
\
The main part of `cli.ts` is actually to connect the functions from the Network class, which is not that hard to do. For the `main` function of the CLI, I decided to do it with `switch` and `case` #footnote[https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/switch]instead of `if` functions just because it looks cleaner in the code, but doesn't actually increase performance of the cli:
```ts
async function main() {
  console.log("=== Blockchain Network Simulator ===");
  console.log(MENU);
  while (true) {
    let input = (await prompt()).trim();
    let [cmd, ...args] = input.split(" ");
    switch (cmd) {
      case "help":
        console.log(MENU);
      case "add_user":
        console.log(network.addUser(args[0]));
        break;
      case "add_tx":
        console.log(
          network.addTransaction(args[0], args[1], parseInt(args[2]))
        );
        break;
      case "mine":
        console.log(await network.mine(args[0]));
        break;
      case "propagate":
        if (args.length != 2) {
          console.log("Usage: propagate <username> <bfs|dfs>");
          break;
        }
        console.log(network.propagate(args[0], args[1] as "bfs" | "dfs"));
        break;
      case "show_chain":
        console.log(network.showChain(args[0]));
        break;
      case "validate":
        network.validate(args[0]);
        break;
      case "connect":
        console.log(network.connectUsers(args[0], args[1]));
        break;
      case "exit":
        rl.close();
        return;
      case "show_users":
        console.log("Users in network:");
        let user_num = 0;
        for (let username of network.nodes.keys()) {
          user_num += 1;
          console.log(`${user_num}. ${username}`);
        }
        console.log(`There are ${user_num} users in the network.`);
        break;
      case "show_neighbours":
        network.showneighbours(args[0]);
        break;
      case "show_mempool":
        for (let tx of network.showMempool()) console.log(`- ${tx}`);
        break;
      case "show_balances":
        args[0]
          ? console.log(network.showBalances(args[0]))
          : console.log(network.showBalances());
        break;

      default:
        console.log("Unknown command. Type 'help' for menu.");
    }
  }
}
```
Majority of the functions takes in input, therefore I had to split their arguments `args` that they input into the console and input them to the correct functions respectively.


=== Manual Testing
I have tested the CLI and Network class by actually using each features in the CLI one by one and trying to break them by inputting erroneous data. \
\
A logical error that I have found during the manual testing is that users can have negative balances. Although the Balances class prevents users from making transactions that exceed their balance, there is no check to prevent users having multiple transactions that together exceed their balance. This will happen because a transaction is only confirmed once the block is mined. Therefore, if a user makes multiple transactions before the block is mined, they can end up with a negative balance.\
\
Therefore, to fix this issue, I decided to do a check before adding each transaction. This following code is added to the `Network.addTransaction(from: string, to: string, amount: number)` before pushing the transaction to the mempool.
```ts
    // Fix Debt Issues
    let pendingBalance = this.balances.getBalance(from);
    for (let tx of this.mempool) {
      let [f, , , amtStr] = tx.split(" ");
      let a = parseInt(amtStr);
      if (f === from) pendingBalance -= a;
    }
    if (pendingBalance < amount) {
      return `${from} does not have enough coins after pending transactions.`;
    }
```\
The `[f, , , amtStr]` splits the transaction up and takes in the sender and the transaction amount to validate if the sender has the amount to transfer.
\

After adding this new validation, I reconsidered about the logic of the validation and this part of the code can also be deleted:
```ts
    if (!this.balances.hasFunds(from, amount)) {
      return `${from} does not have enough coins.`;
    }
```
This is beacuse `hasFunds()` only checks the sender's confirmed on-chain balance. Before a block is mined, the sender might have already received coins from other users through pending transactions, meaning their actual spendable balance could be higher than what `hasFunds()` sees. Since transactions are only applied during block mining, `hasFunds()` ends up checking the wrong state -- it looks at the balance right after the previous block was mined, not the balance that reflects the current pending activity.

=== Enhancing Features
After the manual testing, I decided to add a few more features to simulate the blockchain network more realistically. In real world blockchain networks, miners are given rewards for mining new blocks. For example, in Bitcoin, miners are rewarded with newly created bitcoins and transaction fees for successfully mining a block. This gives miners an incentive to participate in the mining process and helps to secure the network.\
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
Some data validation will also be altered such as the `applyTransaction()` function in the Balance class to force stakeholders not to make transactions from the 'system' user. This is easy as I only have to wrap the function with an if statement:
```ts
if (from !== "system") {
  let fromBal = this.getBalance(from);
  this.balances.set(from, fromBal - amount);
}
```
Other validation changes include not allowing users to print 'system' balance in the `printBalances()` function, and returning true for `hasFunds()` function when the username is 'system'.\
\
As mentioned in the evaluation of Iteration 2, I will be modifying some functions to make them more pure and do not alter the global variables or state. In this Iteration I have made the majority of them to return the state of the blockchain, as messages printing what they are. \
\
Another example that I have made previous functions more pure is that I have made `Blockchain.mineBlock()` to take in the state of the mempool as a parameter (further data) instead of saving the mempool as an attribute within the Blockchain class. This is because the mempool is a global state of the entire network, therefore it shouldn't be saved within each local copy of blockchian. With this change, the Blockchain class is more pure and can be shared across different nodes without worrying about forked mempools.\
\
Besides, as mentioned in the Iteration 2 Evaluation under data validation, I have mentioned that transactions take in the form of a string, as in `A gives B 3 coins`. This is not ideal for checking if the user exist or if the transaction is valid. Therefore in this iteration, I have changed the function to take in a sender, a receiver, and an amount of transaction, which helps a lot in terms of checking the validity of input.
=== Stakeholders review
I have invited all of my stakeholders to review this CLI.\
James suggested me to add a feature to export and import the state of the network with JSON files. I think that this is an amazing idea as it allows user to save their progress and load it later, or it can be saved in local storage of a webpage when I am developing the GUI. He also suggested that I can have some default templates for learners so that they don't have to add users one by one. However, to achieve this, I will have to refactor a lot of the code to make the classes take in JSON files. This is not ideal since I should be focusing on developing the GUI in Iteration 4. Therefore, I might be adding this feature in future iterations/maintenance.\
\
Ben was suggesting what if the chains are forking and how does the network react to that. I answered that the simulator abstracted that idea which was what I did in the Analysis section.\
\
William and Jeremy, after reviewing start to partly understand some concepts of blockchain. I had to explain each features to all four of them, which is quite tedious. Therefore, in the actual GUI, I will have to include some sort of introduction to each features, explaining what the features actually do.\
\
Limitations:\
As mentioned in Analysis section, the simulator is incapable to deal with forked chains, similar to Sean's CLI. This is because to deal with forked chain, I will have to implement a consensus algorithm to decide which chain is the valid one. This will be really hard to implement in my current design of the simulator, since each node only has a local copy of blockchain and there is no global state of the blockchain.\
\
Therefore, I will have to redesign the entire simulator to add a global state of the blockchain, which is not in the scope of the simulator, as I have mentioned that this will be ignored in the Analysis section due to abstracting the complexity of blockchain networks. For really passionate learners, I will introduce that a fork chain might happen in real life blockchain networks, including how they work and how consensus algorithms can be used to solve this problem in a descriptive box as a usability feature when developing a GUI.

=== Robustness Test
To test the robustness of the code, I have asked my stakeholders to try crashing my CLI by smashing my keyboard and adding unexpected inputs (penetration testing). This can help me to potentially spot some missing validations in the code. William and James have tried to add in different inputs to try crash it, but my code still manages to work perfectly and output the expected outputs.\
\
However, Jeremy has successfully 'crashed' the CLI by adding an extremely long username input. The terminal stops working and he wasn't able to exit the program. Therefore, in the future, except from the input data type, I will also have to validate the length of the input data.\
\
This is simple to validate, I just have to add
```ts
if (username.length > 100) {
  return `Username is too long.`
}
```
in the `network.addUser()` function. This also helps me to fulfill my SC2.2 about data validation regarding the length of input.\
\
Ben tried to crash my code by code injection #footnote[https://en.wikipedia.org/wiki/Code_injection]. This is a type of attack where an attacker tries to inject malicious code into a program to alter its behaviour. Ben tried to see if this will work and simply made an anonymous function to print `hello world` when adding a new user:
#figure(image("images/xss.png", width: 61%), caption: [code injection attempt by Ben])
However, this failed since my code treats the input as a string, therefore the code just took the first part of the injection as the username and ignored the rest.\
\
In a webpage, which my GUI will be, this kind of attack can become cross-site scripting (XSS) #footnote[https://developer.mozilla.org/en-US/docs/Web/Security/Attacks/XSS]. This means to inject malicious scripts into webpages viewed by other users. However this can be prevented by my simulator since my end product will not have any server side code or shared state, therefore there is no way for an attacker to inject malicious code into my simulator and affect other learners. Additionally, user input is not dynamically evaluated or executed, which further prevents such attacks.\
\
William and James also tried to smash random keys or giving unexpected inputs to try crash the program, however the program still managed to work perfectly fine. This shows that my data validation is quite robust and can handle unexpected inputs.\
\
Now that the code is more robust, it is fulfilling SC1.5.
=== Testing to inform evaluation
Since this is one of the main prototypes, I will be able to do a manual test to inform evaluation. This means that I will be able to film a screen recording of me manipulating the CLI.\
\
Please check the 'Iteration 3 CLI test to inform evaluation' video for the following time stamps:\
- 0:00 - 0:15 -- Adding users to the network\
- 0:16 - 0:18 -- Printing users\
- 0:20 - 0:32 -- Connecting the users/nodes in the graph\
- 0:33 - 0:46 -- Printing all the neighbours of all users, showing that the network is connected correctly\
- 0:47 - 0:50 -- Printing the initial balances of the users\
- 0:51 - 1:08 -- Printing the local copy of blockchain on different nodes\
- 1:09 - 1:47 -- Adding transactions between different nodes and add them to the mempool\
- 1:16 -- 'A' doesn't have enough money\
- 1:48 - 1:50 -- Printing the global mempool which prints all the transactions that has been done\
- 1:51 - 1:57 -- Printing all the balances, confirming that the balances will not be changed before the transactions are confirmed by mining the block\
- 1:58 - 2:04 -- user 'A' mines the block\
- 2:05 - 2:17 -- printing the local copy of blockchain, showing that only A has the updated blockchain as they are the one who mined the block\
- 2:18 - 2:33 -- Showing that if I propagate from user 'B', it would do nothing. This is because user 'B' doesn't have the latest version of the mined blockchain\
- 2:34 - 2:57 -- If I propagate the local copy of blockchain by 'A', then everyone will copy that blockchain to their local copy of blockchain, since it is the longest chain in the network.\
- 2:58 - 3:03 -- Adding another transaction after mining the first block\
- 3:04 - 3:07 -- Showing that the mempool now only contains the new transaction\
- 3:08 - 3:18 -- Mining a second block with the new mempool\
- 3:19 - 3:38 -- Propagating the second block to every node, and checking if every nodes receives it. It also shows that the second block with be connected to the first block by the previousHash attribute within the block.\
- 3:39 - 3:43 -- Exiting the simulator
This video shows all the features in my CLI. The video shows that the CLI is capable of handling all the features that I have mentioned in the Analysis section, including adding users, adding transactions, mining blocks, propagating the blockchain, checking balances, and even validation of a transaction if any double spending happens. The video shows the consistency of blockchain state at each node after propagation, fulfilling SC3.5 and 3.6.\
\
In this video, the two minings took 14 and 5 seconds at a difficulty level of 2. This is quite fast compared to real life mining, and to be expected for my simulator. In SC 1.3, I have mentioned that the mining time for diffuclty level 1 should be less than 5 seconds, therefore this is looking promising that my simulator can fulfill this requirement when I set the difficulty level to 1.\
\
At 1:16, when user 'A' tries to add a transaction while not having enough balance, the CLI shows an error message indicating that 'A' does not have enough coins. This shows that the data validation at the Balances class is working as expected as it is preventing from double spending.\
\
At 2:18, when I try to propagate the blockchain from user 'B', the CLI did not propagate anything since in blockchain only the longest chain in the network is considered valid. Since user 'B' doesn't have the latest version of the blockchain, the propagation does nothing. This shows that the propagation function is working as expected and only propagates valid blockchains.\
\
\
I have traversed the first block using bfs and the second block using dfs. This shows that both traversal algorithms are working as expected and can propagate the blockchain correctly through the network. Notice that the network that I have set up is actually the same one from Iteration 1 when I developed and tested the bfs and dfs algorithms. This shows that the traversal algorithms are working correctly within the context of the blockchain simulator.\
\
To increase usability, I have included clear error messages when invalid inputs are provided. For example, if a user tries to add a transaction with a sender that doesn't exist in the network, the CLI will display an error message indicating that the sender is not found. This helps users understand what went wrong while running the code and know how to fix it.\
#figure(
  image("images/no_sender.png", width: 70%),
  caption: [Error message when adding a transaction with a non-existing sender and receiver],
)
=== Evaluation
Overall, this iteration is quite successful. I have created a CLI linking everything that I have done so far, and adding features like checking balances of each users in the network. All the goals in this Iteration has been met, and the CLI is working as expected. The data validation is quite robust, and the code is able to handle unexpected inputs without crashing.\
\
In the testing section, my stakeholders have suggested some new features that I could add, such as exporting and importing the state of the network with JSON files. However, I have decided to stay on track and continue developing the GUI in the next iterations, as this is more important for helping learners to understand blockchain technologies through visualisation.\
\
Performance considerations were not a major focus during this iteration. While the simulator performs well with a small number of users and actions, I did not test or optimise for larger scale usage or longer running sessions. In future iterations, especially when developing the GUI, I may need to revisit the performance aspects to ensure smooth operation as the complexity of the simulation increases.\
\
While explaining how to use the CLI to William, I drew out the graph that he was actually making on a whiteboard and added the transactions that he is making below the graph:
#figure(image("images/whiteboard.jpg", width: 40%), caption: [Whiteboard explanation to William])
This has sparked my idea of how I am going to make my GUI. My idea is to make a graph of the users/nodes in the network, and you can click on them to show details or the state of the network. This replaces the complex interface that I have made in the Analysis section. This will be better since the majority of my stakeholders prefer a simpler user interface rather than a more complex one during the interview in stakeholder section. More designs of this interface will be continued in Iteration 4. \
#pagebreak()
== Iteration 4
In Iteration 4, I will be developing a Graphical User Interface (GUI) for my blockchain simulator. Due to the lack of time and experience in creating graphs visualisation tools, I am going to use a library which allows creating graphs with nodes and edges. I found one called vis.js. vis.js is a dynamic, browser-based visualisation library that is easy to use and has a lot of features that can help me to create a more visually appealing and interactive GUI for my blockchain simulator. For example, vis.js allows user to drag the nodes around, zoom in and out, and move the graph back to the centre by default. This will help my stakeholders to navigate the nodes/users structure more easily. In this iteration, I will not be dealing with the logic and animation of mining and the propagation of blocks yet, as this will be handled in iteration 5 due to the complexity of those two functions.\
\
Since I am using a library to create the GUI, I will have to modify the requirement for the GUI. As vis.js doesn't work in canvas but instead only HTML elements, the web app will no longer require canvas, which was previously mentioned in the initial GUI design (@Initial-GUI-Design).\

=== Goals
The goals for Iteration 4 are as follows:
- Research into vis.js and its features
- Design a GUI layout
- Implementing the GUI using vis.js
=== Decomposing Iteration 4
In Iteration 4, I decomposed the iteration by their files based on their functionalities:
#figure(image("images/I4-decompose.png"), caption: [Decomposition of Iteration 4])
Again, the files will be further decomposed into smaller functions within the design of each file later on.\
\
\
The GUI contains the basic trio of files, index.html, index.css, and app.ts. However, to make the code more organised and modular, I have decided to split the app.ts file into three different files: backend.ts, ui.ts, and visManager.ts.\
\
The backend.ts file will be responsible for handling the logic of the blockchain simulator, including managing the network, nodes, transactions, and mining processes. This file will be a lot of imports from previous iterations especially from the Network class in Iteration 3. This file will be serving as the 'new' network.ts file, but with some modifications to fit the GUI.\
\
The ui.ts file will be responsible for handling the user interface of the blockchain simulator. This file will take all the html elements and link them to the backend.ts file. It mainly takes care of the input/output of the GUI, and updating the visualisation of the network with the logic from backend.ts with the help of visManager.ts.\
\
The visManager.ts file will be responsible for managing the vis.js library. This file will take care of creating the graph, adding nodes and edges, selecting and highlighting nodes, and updating the visualisation of the network. The ui.ts file will then be using the functions from this file to update the visualisation of the network based on the logic from backend.ts.
=== GUI Design
Over the 3 iterations that I have been through, I have gained more understanding on blockchain technologies and I realised that the @Initial-GUI-Design might not be the most accurate representation of the blockchain simulator that I expected. Therefore I will develop the GUI orienting the design for my CLI. The following image shows the design of my GUI which is inspired from stakeholder review in Iteration 3:
#figure(image("images/gui-design-default.png"), caption: [GUI design default]) <GUI-default>
There will be two states of the GUI, the default state where no nodes are selected and the top part of the sidebar shows the details of the entire network, including the balances for all users in the netowrk, and the global mempool. However, the blockchain tab would show nothing because users might have different local copies of blockchain before propagating the latest version of blockchain throughout the network. The bottom part of the sidebar will contain all the user actions that can be done, including adding users, adding transactions, mining blocks, and propagating the blockchain using bfs/dfs.
#figure(image("images/gui-design-selected.png"), caption: [GUI design selected]) <GUI-selected>
The above image shows the state when a node is selected. On the top right of the sidebar, the details of the selected node will be shown, including their username, balance, local copy of blockchain, but also the global mempool. The bottom right of the side bar will remains the same as the default state, which contains the user actions that can be done.\
\
Instead of having a webpage with multiple pages, which was my orignal idea from Iteration 1, I have decided to make a single page webpage. This is because during the interview with my stakeholders, all of them prefer a simpler user interface rather than a more complex one. Another reason is that an introduction page may make the simulator looks more like a documentation page rather than a simulator. This is not ideal as my goal is to make an interactive simulator for learners instead of reading a lot of text. \
\
Therefore, I have decided to replace the introduction page from the original design with a tool tip box next to each features of my simulator. This will help learners to understand how to use the simulator without overwhelming them with too much text. While hovering over the tool tip icon, a box on the bottom left of the simulator will appear explaining that feature. This will help learners to understand the feature as they are using them. This is a simpler, yet elegant approach to the problem.\
\
The graphs in the simulator are undirected graphs. This is because in a blockchain network, the connections between nodes/users are bidrectional. This means that if user A is connected to user B, then user B must also be connected to user A. Therefore, the edges in the graph are undirected. This is also more visually appealing as the graph looks cleaner without arrows on the edges.\
#pagebreak()
=== HTML and CSS
The HTML and CSS files #footnote[HTML and CSS code can be found in Appendix at the end of this document] are fairly straightforward to write. This is the interface that I have built:\
#figure(image("images/GUI.png"), caption: [GUI layout]) <gui>
The GUI contains a graph on the left side, which shows the users/nodes in the network. On the right side, there is a sidebar which contains the details of the node/network on the top, and user actions on the bottom. In the future, when ui.ts is developed, when a user clicks on a node in the graph, the details of that node will be shown on the top of the sidebar instead of the network details, and the network details will be shown when no node is selected.\
\
Currently, the GUI doesn't react to any input yet, as this will be handled in the ui.ts file, which has not been developed yet. However, the layout of the GUI is complete and ready for the next step of development. It also doesn't have a graph as the visManager.ts file has not been implemented yet.\
\
===== Usability features
Usability features that I have included in the GUI:
- Tool tips for each feature, allowing learners to understand how to use the simulator without reading a lot of text
- Buttons for each action that can be done
- Clear layout, with users/nodes graph on the left, and within the sidebar, the details of the node/network on the top, and user actions on the bottom
- Responsive design, allowing the simulator to be used on different scren sizes
- A dark mode theme, as requested by most stakeholders during a survey regarding their preferences on light/dark mode themes

When hovering over the tool tip icon, a box on the bottom left of the simulator will appear explaining that feature. In @gui, my mouse is hovered over the tool tip box next to the 'Balances' title, therefore showing the introduction to the concepts of balances in a blockchain network. This is done by some css and simple JavaScript
```ts
    <script>
      let tooltipCircle = document.getElementById("tooltip-circle");
      let tooltipText = document.getElementById("tooltip-text");

      document.querySelectorAll(".tooltip-icon").forEach((e) => {
        e.addEventListener("mouseenter", () => {
          tooltipText.textContent = e.dataset.tooltip;
          tooltipCircle.style.opacity = "1";
        });
        e.addEventListener("mouseleave", () => {
          tooltipCircle.style.opacity = "0";
        });
      });
    </script>
```
This changes the content in tooltip and adjust the visibility (opacity) of the tip box when the mouse is hovering/leaving the tool tip circle.

=== Connecting all parts
Before developing the three files, I will have to connect all the parts together into the main file: app.ts. The app.ts file will be responsible for importing all the other files and connecting them together. This helps me to easily test the code if it is working as I can see it graphically.\
```ts
import { initVisNetwork } from "../code/gui/visManager.ts";
import { initUI } from "../code/gui/ui.ts";

initVisNetwork("network");
initUI();
```
The 'network' is the id of the div element in the HTML file where the graph will be renedered. The `initVisNetwork()` function from visManager.ts will create the vis.js network and render it in the div element. The `initUI()` function from ui.ts will setup all the input/output elements in the GUI using the functions from backend.ts and visManager.ts.
=== Design and Development of visManager.ts
The visManager has to handle all the visual stuff on the graph. This includes:
- adding nodes
- adding edges
- highlighting nodes
- 'unhighlighting' nodes
==== vis.js Proof of Concept
To test if vis.js is suitable for my blockchain simulator, I have created a simple proof of concept website which shows a simple undirected graphs.\
\
Using the template from the vis.js website on network, with some modifications, I have created a simple graph with 3 nodes and 2 edges. After 3 seconds, I added 2 more nodes and 2 more edges to the graph. This shows that vis.js is capable of handling dynamic graphs, which is what I need for my blockchain simulator.\
\
The code for my proof of work testing is as follows:
```ts
import { DataSet, Network } from "vis-network/standalone";

let container = document.getElementById("network")!;
export let nodes: any;
export let edges: any;

// Initial graph
nodes = new DataSet([
  { id: "A", label: "A" },
  { id: "B", label: "B" },
  { id: "C", label: "C" },
]);

edges = new DataSet([
  { from: "A", to: "B" },
  { from: "B", to: "C" },
  { from: "A", to: "C" },
]);

// Graph setup
let network = new Network(
  container,
  { nodes, edges },
  {
    physics: {
      enabled: true,
    },
    interaction: {
      dragNodes: true,
      dragView: true,
      hover: true,
      selectConnectedEdges: true,
    },
  }
);

// Dynamic Testing
setTimeout(() => {
  nodes.add({ id: "D", label: "D" });
  edges.add({ from: "A", to: "D" });

  nodes.add({ id: "E", label: "E" });
  edges.add({ from: "E", to: "C" });
}, 2000);
```
With a basic index.html#footnote[HTML file can be found in Appendix at the end of this document] importing the vis.js library, I am able to then create an initial graph with 3 nodes, then adding 2 nodes with edges connected to A and C in 2 seconds after the initial graph. This shows that I will be able to add nodes and edges to the graph after creation, which is what I needed as I will be adding new users into the blockchain network.
#subpar.grid(
  figure(image("images/three-nodes.png", width: 60%), caption: [Initial graph]), <a>,
  figure(image("images/5-nodes.png", width: 100%), caption: [Dynamic Test]), <b>,
  columns: (1fr, 1fr),
  label: <normal-test>,
)
\
The reason I chose vis.js over other graph visualisation libraries is because of its simplicity and ease of use. The library is well-documented and has a lot of examples that I can refer to. Additionally, vis.js gives a very smooth and interactive experience when manipulating the graph comparing to other libraries that I have researched. For example, it allows the dragging the nodes around, zooming in and out, and moving the graph back to the centre with the right setting. This will help my stakeholders to navigate the nodes/users structure more easily as they would have experience similar to Google Maps #footnote[https://www.google.com/maps], which has very similar features.\
\
\
With physics enabled, the nodes will repel each other and the edges will act like springs, creating a more natural and visually appealing layout. They also can create curves so that a bigger graph will not look as cluttered. They also readjust their positions so that the edges do not get entangled. After surveying my stakeholders, most of them prefer this layout as it looks more organic and less rigid than a fixed layout. They all agreed that this is a very nice usability features.\
#figure(image("images/physics.png"), caption: [Graph with physics enabled])
Now that I have tried out vis.js, I can start designing visManager.ts. Since the visManager's purpose is to display graph, it should not have any output and all functions are procedures.
===== initVisNetwork(containerId: string)
This will be the main function as it was the one imported into app.ts. It is used to setup the properties of the graph and the appearance of nodes and edges. It will take in the HTML div to render the graph. The only logic part of this function is to selecting/deselecting node by highlighting/'unhighlighting' them. Node selection is managed using a shared state variable (selectedUser) which stores the currently selected node ID. This state is used to ensure that only one node is highlighted at a time.
#pagebreak()
Algorithm (pseudocode) Design for selecting/deselecting node:
- on click:
- if click hits a node:
  - unhighlight previous node
  - selectedUser = current node
  - highlight the current node
- else:
  - unhighlight current node
  - selectedUser = null
The code for `initVisNetwork()` is as follows:
```ts
export let selectedUser: string | null = null;

export function initVisNetwork(containerId: string) {
  nodes = new vis.DataSet([]);
  edges = new vis.DataSet([]);
  let container = document.getElementById(containerId)!;

  // Graph properties
  visNetwork = new vis.Network(
    container,
    { nodes, edges },
    {
      physics: { enabled: true },
      interaction: {
        dragNodes: true,
        dragView: true,
        zoomView: true,
        hover: true,
      },
      nodes: {
        shape: "circle",
        size: 30,
        font: { color: "#fff", face: "Arial", multi: false },
        borderWidth: 2,
        color: {
          background: "#0077ff",
          border: "#fff",
          highlight: { background: "#0af", border: "#ff0" },
        },
        labelHighlightBold: true,
      },
      edges: { color: "#777", width: 2, smooth: { type: "dynamic" } },
    }
  );

  // Selecting/Deselecting node
  visNetwork.on("click", (params: any) => {
    if (params.nodes.length > 0) {
      if (selectedUser) resetNodeColor(selectedUser);
      selectedUser = params.nodes[0];
      if (selectedUser) highlightNode(selectedUser);
    } else if (selectedUser) {
      resetNodeColor(selectedUser);
      selectedUser = null;
    }
  });
}
```
The non-null assertion operator (!) after line 4 tells TypeScript that the type of container is not null.
Data validation that I have done:
- checking whether the click event references any nodes with `(params.nodes.length > 0)`
- checking whether a node ID is currently stored as selected `if (selectedUser)`
===== addNode(id: string, label: string)
Should add a new node to the graph:
```ts
export function addNode(id: string, label: string) {
  nodes.add({ id, label });
}
```
===== addEdge(from: string, to: string)
Should add a new edge connecting 2 nodes in a graph:
```ts
export function addEdge(from: string, to: string) {
  edges.add({ id: `${from}-${to}`, from, to, color: "#777" });
}
```
===== highlightNode(id: string)
`highlightNode()` and `resetNode()` is essential in order for the `initVisNetwork()` to work since they rely on these two functions to highlight/'unhighlight' nodes to select/deselect nodes.\
Changing the border colour of the node to yellow to highlight the node:
```ts
export function highlightNode(id: string) {
  nodes.update({ id, color: { background: "#0077ff", border: "#ff0" } });
}
```
===== resetNodeColor(id: string)
Set the colour of node back to default colours:
```ts
export function resetNodeColor(id: string) {
  nodes.update({ id, color: { background: "#0077ff", border: "#fff" } });
}
```
=== visManager.ts testing
After development, I did some manual testing by adding a few nodes by adding addNodes and addEdges within the `initVisNetwork()` function and set it as the base graph for now, so that I am able to see the nodes on the graph on the GUI.

===== Normal Test
For normal testing, I made a very simple linear graph and connected them:
```ts
  addNode("A", "A");
  addEdge("A", "B");
  addNode("B", "B");
  addNode("C", "C");
  addEdge("B", "C");
```
#figure(image("images/gui-basic.png"), caption: [visManager normal test])
With this, I also tested the highlight feature, which when I click on C, the node has highlighted with yellow border. When I click on the side of the graph or other nodes in the graph, the yellow border turns back into a white border, which is as expected.

===== Boundary Test
For boundary test, I have decided to try if self loop or two same nodes connecting with two different edges, which worked as expected:
```ts
  addNode("A", "A");
  addEdge("A", "B");
  addNode("B", "B");
  addNode("C", "C");
  addEdge("B", "C");
  addNode("D", "D");
  addEdge("B", "D");
  addEdge("D", "B");
  addEdge("C", "C");
```
#figure(image("images/gui-boundary.png", width: 70%), caption: [Boundary test for visManager])
To test more extreme cases with a larger network which I didn't do in Iteration 3, I added 1000 nodes into the network with a for loop (with the original boundary test being there):
```ts
  for (let i = 0; i < 1000; i++) {
    addNode(i.toString(), i.toString());
  }
  for (let i = 0; i < 900; i++) {
    addEdge(i.toString(), (i + 1).toString());
  }
```
#figure(image("images/1000nodes.png"), caption: [Adding 1000 nodes])
This is the zoomed out interface. When it is zoomed in, each nodes and edges remain as clear as the ones with the normal graph:
#figure(image("images/1000nodes-zoom.png"), caption: [Zoomed in graph with 1000 nodes])
To test if the edges can still be used to connect the graph, I added another for loop to connect part of them:
```ts
  for (let i = 0; i < 900; i++) {
    addEdge(i.toString(), (i + 1).toString());
  }
```
#figure(image("images/1000-connected.png"), caption: [1000 nodes partly connected])
I have only connected 900 nodes in the for loop, leaving the other 100 nodes on the side floating around. This is as expected and the visManager has passed every tests.
=== Design and Development of backend.ts
The purpose of backend.ts is to connect the functions from network.ts into the GUI. Therefore, this is easy to build as all I have to do is to setup a new network class in this file and add the features from the CLI. \
\
The backend.ts will contain all the essential features for my blockchain simulator, except from mining and propagating which will be done in Iteration 5.
```ts
import { Network as BlockchainNetwork } from "../network/network.ts";

// Default network difficulty as 2
export let backend = new BlockchainNetwork(2);

export function addUser(username: string): string {
  return backend.addUser(username);
}

export function connectUsers(from: string, to: string): string {
  return backend.connectUsers(from, to);
}

export function sendTransaction(from: string, to: string, amount: number): string {
  return backend.addTransaction(from, to, amount);
}

export function getBalances(username?: string) {
  return backend.showBalances(username);
}

export function getBlockchain(username: string): string {
  return backend.showChain(username);
}
```
This wrapper file around the Network class allows me to simplify and standardise how the rest of my app interacts with the blockchain backend. By using a single shared instance (backend as a global variable in this module) and providing functions like addUser, sendTransaction, I make sure that all parts of the app are working with the same state, avoiding the risk of accidentally creating multiple network instances that could get out of sync (for data validation). It also means I don't have to expose the internal details of the Network class -- other modules just call the high level functions. On top of that, it makes my code more maintainable and flexible: if I want to add logging, validation, or change how transactions propagate, I can do it all in one place without touching the core network logic. Essentially, it's about keeping the state centralised, my app modular and easier to manage.
=== Design and Development of ui.ts
Now I have to combine all of the above work, allowing them to show up on the GUI. Everything here will be wrapped in the `initUI()` function which was imported into the app.ts as the main TypeScript file serving my website. Therefore all the code from this file will essentially be in app.ts without modifications. This makes the code more modular as app.ts will not contain a lot of lines of code which do lots of different stuff.\
\
In this ui.ts file, I will
- connect all the html elements to the backend
- adding users when the add user button is clicked
- connect two existing users when connect button is clicked with two users input
- make a transaction when send transaction button is clicked with a from, to, and value input
- update sidebar
  - update balance div to global balance when no nodes are selected
  - update balance div to selected user's balance when a node is selected
  - update blockchain div to 'Select a node to see its blockchain' when no nodes are selected
  - update blockchain div to selected user's local copy of blockchain when a node is selected
  - update mempool when transactions are made

==== Connect HTML elements
To connect elements, it is easy to do, since I will just have to declare lots of variable from the HTML using document.getElementById or document.querySelector for each element I need to interact with, such as buttons, input fields, and display divs, so that I can attach event listeners and update the UI dynamically based on user actions and backend data.\
All the variables are declared here:
```ts
  let usernameInput = document.getElementById(
    "usernameInput"
  ) as HTMLInputElement;
  let addUserBtn = document.getElementById("addUserBtn")!;
  let connectFromInput = document.getElementById(
    "connectFrom"
  ) as HTMLInputElement;
  let connectToInput = document.getElementById("connectTo") as HTMLInputElement;
  let connectBtn = document.getElementById("connectBtn")!;
  let txFrom = document.getElementById("txFrom") as HTMLInputElement;
  let txTo = document.getElementById("txTo") as HTMLInputElement;
  let txAmount = document.getElementById("txAmount") as HTMLInputElement;
  let sendTxBtn = document.getElementById("sendTxBtn")!;
  let mineBtn = document.getElementById("mineBtn")!;
  let mineStatus = document.getElementById("mineStatus")!;
  let propagateBFSBtn = document.getElementById("propagateBFS")!;
  let propagateDFSBtn = document.getElementById("propagateDFS")!;
  let balancesDiv = document.getElementById("balances")!;
  let blockchainDiv = document.getElementById("blockchain")!;
  let mempoolDiv = document.getElementById("mempool")!;
```
The non-null assertion operator (!)#footnote[https://www.typescriptlang.org/docs/handbook/release-notes/typescript-2-0.html] is used quite often in these declaration. This is because I have to tell TypeScript that the variables are not in the type of null.
==== Updating sidebar
This part of ui.ts deals with printing all the details of network/users in the network, and this will depend on the selectedUser variable, which was being assigned in visManager.ts for highlighting/unhighlighting nodes. \
The algorithm design is as follow:\

When no user has been selected (default GUI; see @GUI-default):
- update global balance in balance div
- update blockchain div to show no blockchains
- update mempool
When a user has been selected (selected GUI ; see @GUI-selected):
- update balance div to selected user's balance when a node is selected
- update blockchain div to selected user's local copy of blockchain when a node is selected
- update mempool
A lot of the functions at the CLI phase development returns a string message stating the network state, e.g., global mempool. This is due to the change of normal functions to pure functions in Iteration 3. This will be very ideal as I can just put that text into the div sections, with a little modification.\
\
To update the sidebar, I will have to do an infinite loop that starts when the webpage loads. This ensures the dynamic update as the simulator is running. Therefore I will have to do a `setInterval` to run the `updateSidebar` function. In the updateSidebar function, I will firstly have to consider the output of the functions from network.ts, then put them into HTML friendly style strings.\
\
Looking back at network.ts:
- Balances
  - The print balances functions ```ts return "=== Balances ===\n" + this.balances.printBalances(username);```, where username is optional. This allows the same function to be reused to display either all users' balances (when no username is provided) or a specific user's balance (when a username is given). If there are no users in the network, it returns "No users in network". As a result, the balance-handling logic is already encapsulated within the backend, meaning the UI does not need to duplicate this logic.
  - pseudocode ```
    if (!selectedUser) {
      balancesDiv = "Global Balances" + Backend.backend.showBalances()
    } else {
      balancesDiv = `${selectedUser}'s Balance` + Backend.backend.showBalances(selectedUser)
    }
    ```
  - The selected username is displayed in the Balances div so that learners can clearly see which user they are currently interacting with.
  - In `Backend.backend.showBalances()`, the first 'Backend' refers to the imported module from backend.ts, while the second 'backend' refers to the exported singleton instance of the blockchain network created within that module.\
  - Another thing to note that is an example of output from Backend.backend.showBalances is```
    === Balances ===
    A: 100
    B: 100
    ```
  - This will not work in the GUI since the HTML will not be able to read the newline character and instead will have all the users on one line. I can use a very simple regex to deal with this situation `/\n/g` which checks if there are any new lines in the output, and I can use replace() to \<br> which is the standard format for HTML for a new line.
- Blockchain
  - In network.ts, the showChain(username) function must take in a username, which makes sense. Therefore I am going to give a default warning string if no username is being input. Pseudocode```
      if (!selectedUser) {
      blockchainDiv = "Select a node to see its blockchain"
    } else {
      blockchainDiv = Backend.backend.showChain(selectedUser)
    }
    ```
  - In network.ts, the showChain(username) function returns a string in the form of ```
    ===== A's Blockchain =====

    Index: 0, Hash: 36a6625a, Nonce: 0
    Transactions: Genesis Block

    Index: 1, Hash: 00c912ee, Nonce: 2490000
    Transactions: A pays B 21 coins
    ...
    ```
    Therefore, again I will have to use the same regex `/\n/g` to replace the new lines into \<br>s.
- mempool
  - The mempool should update no matter whether a node is selected
  - Although there will be no if statements, I will still have to consider about the output from network.ts
  - In network.ts, the mempool doesn't return a string but an array instead. The array stores every transactions in a separate entry, therefore to make it look more organised in the GUI, I can use the `join(<br>)` function to be in a string which has a transaction in each line.
#pagebreak()
This is the code for updating the sidebar dynamically as the simulator runs:
```ts
  // Sidebar
  function updateSidebar() {
    if (!Vis.selectedUser) {
      balancesDiv.innerHTML =
        "<h3>Global Balances</h3>" +
        Backend.backend.showBalances().replace(/\n/g, "<br>");
      blockchainDiv.innerHTML = "<i>Select a node to see its blockchain</i>";
    } else {
      balancesDiv.innerHTML =
        `<h3>${Vis.selectedUser}</h3>` +
        Backend.backend.showBalances(Vis.selectedUser).replace(/\n/g, "<br>");
      blockchainDiv.innerHTML =
        `<h3>Blockchain</h3>` +
        Backend.backend.showChain(Vis.selectedUser).replace(/\n/g, "<br>");
    }
    mempoolDiv.innerHTML = Backend.backend.showMempool().join("<br>");
  }
```
Except from the \<br>s that are replaced, the blockchainDiv is default to be italic as a usability feature to let user easily distinguish between the reminder text and the content when a node is selected.
=== Testing
Before developing the code for siderbar, I have made a two tests to try checking if the sidebar will work after development which uses `Vis.addNode()` (Vis is imported from visManager.ts). They are very quick and simple. The first one is a normal test by just adding a node so that I can select it and check for updates on the sidebar.
```ts
  Vis.addNode("A", "A");
  Vis.addNode("B", "B");
  Vis.addEdge("A", "B");
```
Another test is a boundary test where I create more nodes:
```ts
  for (let i = 0; i < 100; i++) {
    Vis.addNode(i.toString(), i.toString());
  }
```
After development, I tried it out. The user A successfully rendered on the graph. However, when I select node A, it didn't work. Instead a runtime error is returned:
#figure(image("images/A_not_found.png", width: 38%))
This is weird. It says that user A is not found when I clearly declared and visually showing on the screen. However, I came to realise that although the node is being created, it is not being added to the network class, therefore balances aren't being tracked. This can be done by ```ts
Backend.addUser("A")
```
Therefore this is just a mistake in the test code. After adding this line, both the normal test and the boundary test has passed perfectly. This is a good spot of mistake as I will also need to consider adding user to the network to track their balances and process other actions.
#subpar.grid(
  figure(image("images/default_gui.png"), caption: [Balances and Blockchain div updates in default GUI]), <a>,
  figure(image("images/selected_GUI.png", width: 93%), caption: [Balances and Blockchain div updates in selected GUI]),
  <b>,

  columns: (1fr, 1fr),
  label: <gui-balances>,
)
The left figure shows that the balance div becomes global and the blockchain div becomes the default reminder string. The right figure shows that the balance div becomes the balance of the selected node and the blockchain becomes the local copy of blockchain of the selected node.
#figure(image("images/multiplenodes.png", width: 50%), caption: [Larger network])
With a larger network, the balances and blockchain divs work the same way. I can scroll down on the global balance div to see all user's balances. it is easier to click on a specific user on the graph to check for specific user's balance.\
\
However, since there isn't a function dealing with transaction yet, I am not able to test if the tranasactions are being dealt properly and mempool is being updated. This will be tested further when the transaction feature has been added to the simulator
=== Adding users
Aim: From the HTML, take the new user's username and add it to the graph, and tracking its balance.
To achieve this, I will need an event handler that deal with `addUserBtn` when its clicked.\
\
When adding a user into the network, the user should be attached to someone, so that the blockchain network will all be linked and no disconnected nodes appearing so that the blockchain will be able to propagate to every single node.
- Algorithm design (in pseudocode):
```
addUserBtn.onlick = () => {
  if (Vis.nodes.length > 0 && !Vis.selectedUser) {
    print("Select a user first to attach the new user!")
    return
  }
  Vis.addNode(username, username)
  if (Vis.selectedUser) {
    Backend.connectUsers(Vis.selectedUser, username)
    Vis.addEdge(Vis.selectedUser, username)
  }
}
```
I have done a data validation: ```ts
if (Vis.nodes.length > 0 && !Vis.selectedUser)
```
in the pseudocode. This is because I want the new user to be attached to a user in the network initially, therefore (!Vis.selectedUser) checks if a user from the graph is selected before adding the new user. However, when I consider about the first node, it cannot be connected to a node initially, therefore I will have to make an exception with (Vis.nodes.length > 0) so that first node can be added without connecting to others.
```ts
  // add user to the network
    addUserBtn.onclick = () => {
    let username = usernameInput.value.trim();
    if (!username) return;

    if (Vis.nodes.length > 0 && !Vis.selectedUser) {
      alert("Select a user first to attach the new user!");
      return;
    }

    let res = Backend.addUser(username);
    alert(res);
    Vis.addNode(username, username);

    // Connect to existing user
    if (Vis.selectedUser) {
      Backend.connectUsers(Vis.selectedUser, username);
      Vis.addEdge(Vis.selectedUser, username);
    }
    usernameInput.value = "";
  };
```
I have done more data validations here with exiting if there isn't a username, trimming the username to prevent whitespaces on sides to make long usernames, and resetting the input text box at the end for better usability experience. The alert is to show the action performed.
==== addUser test
This test will be manually inputting new usernames into the username input box. Then clicking the add user button to add them onto the graph. The check is visual. This is a basic graph I created using this feature:
#figure(image("images/addUser.png"), caption: [Adding users to the GUI])
This shows that the add user feature has been successfully developed.\
\
However, while manual testing, I found out that if I add two users with the same username, the website crashes and gives this simple error:
#figure(image("images/null_error.png"), caption: [Website crashes when I add two users with exactly the same username])
To enhance robustness, I have to add a data validation on repeated usernames:
```ts
if (Vis.nodes.getIds().includes(username)) {
  alert("That username already exists.");
  return;
}
```
Now that the addUser is fully validating input data, it is bulletproof and will not crash the website.
#pagebreak()
=== Connecting Users
This should be a function which connects two users in the graph. This is very simple since we already have all the tools for it from previous iterations or visManager.ts to visualise the connection.\
Algorithm design:
```
When connect button is clicked:
Take the input from connect from input text box and connect to input text box
Connect the users in the backend
Add edge between the two nodes
Reset the input boxes to be empty
```
The code for connecting two nodes are as follow:
```ts
connectBtn.onclick = () => {
    let from = connectFromInput.value.trim();
    let to = connectToInput.value.trim();
  if (!from || !to) return alert("Fill both fields");
  Backend.connectUsers(from, to);
  Vis.addEdge(from, to);
  connectFromInput.value = "";
  connectToInput.value = "";
};
```
I have validated the input data with an alert message if either the connect from or connect to user doesn't exist.
=== Connecting users test
With this features being added, now I can make graphs more than a tree. I can now make circular graphs. For example, when I was testing by manually creating different graphs, I can now create:
#figure(image("images/circular.png", width: 40%), caption: [Circular graph])
A circular graph between A, B and C, with a self loop at C. This has opened infinite possibilities as it can now take in any graphs.
=== Transactions
To add a transaction within the network:\
- Firstly, I will have to take in the input from 'to' (sender), 'from' (receiver), 'amount' (amount of transaction)\
- Then, I then validate the inputs by checking that both users exist and that the amount is positive.\
- Before allowing the transaction, I check whether the sender has sufficient balance after accounting for pending transactions in the mempool, which prevents overspending and double-spending.\
- If the transaction is valid, it is added to the mempool, but balances are not updated immediately. They should only update after the block being mined.\
- Lastly, I will clear the input boxes.\
\
Luckily most of these logics have been solved in previous Iterations with ```ts Backend.sendTransaction(from, to, amount)```. Therefore at the stage we can ignore these details.\
Therefore, the algorithm design for this function is as follow:
```
When sendTXBtn is clicked:
  if (!from || !to || !amount) alert("Fill all fields");
  if (amount<0) alert("Amount has to be positive")
  Backend.sendTransaction(from, to, amount)
  mempoolDiv = Backend.backend.showMempool()
  from, to, amount = ''
```
The majority of this part of code is doing data validation and visualising with mempool.\
Therefore the code for sendTxBtn is as follow:
```ts
sendTxBtn.onclick = () => {
  let from = txFrom.value.trim();
  let to = txTo.value.trim();
  let amount = parseInt(txAmount.value);
  if (!from || !to || !amount) return alert("Fill all fields");
  if (amount < 0) return alert("Amount has to be positive")
  alert(Backend.sendTransaction(from, to, amount));
  mempoolDiv.innerHTML = Backend.backend.showMempool().join("<br>");
  txFrom.value = "";
  txTo.value = "";
  txAmount.value = "";
  };
};
```
The input data, again is being validated by its existence. There will be no type issues since my 'to' and 'from' are only taking in strings whereas my transaction amount is being flagged as an integer in the HTML check, with the TypeScript annotations, there is no way to input other types of data. The existence of user in the graph is being checked within `Backend.sendTransaction()`.
==== Transaction testing
By manually adding transactions into the mempool from the GUI, it shows that the transactions are successful, and that the
#subpar.grid(
  figure(image("images/mempool.png", width: 100%), caption: [Transactions successfully added to mempool]), <a>,
  figure(image("images/side.png"), caption: [sidebar zoomed in]), <b>,
  columns: (1fr, 1fr),
  label: <normal-test>,
)
With this test, it doesn't only proof that the sendTxBtn work, but also the mempool successfully showing the correct transaction. The balances are also correct as they have not been changed before the mining process. I have also tested with overspending and double spending by sending coins which exceeds the sender's balance, and this got successfully alerted and disallowed. This is all from the check in `Backend.sendTransaction()` from previous Iterations.
#pagebreak()
=== Evaluation
==== Stakeholders' feedback
I have let all my stakeholders to try out my GUI and give feedbacks.:\
- Ben, with some prior knowledge of blockchain, says that my GUI accurately represents the users in a network in the real world. He said he has never seen a blockchain simulator which a graph as a GUI, therefore he is looking forward to the animation of mining and propagation which I mentioned to him will be done in Iteration 5.\
- Jeremy and James said that they really like the tool tip features. This is because they didn't understand blockchain technologies. With the aid of some instructions, they are able to figure out how the simulator works and how this is working in the real world. James mentioned that he likes the fact that everything fits on the screen, therefore there is no need for him to scroll just to see all the features.\
- William also mentioned that he likes the aesthetic of the graph as he initially requested for a graph in the stakeholders interview in the Analysis section. He mentioned that this is a really good usability feature. However, he said that clicking the add user, connect, and send transaction button is quite inconvenience, especially with setting up large networks. Instead, he would like to hit the enter key and the actions can be performed.\
- All of them really like the fact that the simulator brings you a step by step hands on experience to introduce blockchain technologies, they mentioned that every features is being used and intuitive with the help of the tool tips. \
\
Taking William's advice and to create a better user experience, I have decided to implement a new usability feature of submitting form by hitting the enter key. This requires me to introduce new variables and removing variables from ui.ts. Firstly, I wrapped all the input and button elements with a form. Then, I add an id for the form which can link to my ts file with ```ts   let addUserForm = document.getElementById("addUserForm")!;```. For the functions, instead of doing onclick , I do ```ts
  addUserForm.addEventListener("submit", (e) => {
  e.preventDefault();
  ...
  })
```
The ```ts   let addUserBtn = document.getElementById("addUserBtn")!;``` can then be deleted as the form will handle the click or enter rather than only click. This gives a smoother experience as you can control the simulator with keyboard only.\
\
This process is repeated throughout the functions made in this iterations so that they can be submitted with the enter key. \
==== Testing for robustness
In this iteration, again, I invited my stakeholders to try crashing my code (penetration testing). \
- Jeremy: again tried to enter really long usernames, however, this got patched after the evaluation from the next iteration. After trying that, he has no idea how to break my website, fulfilling SC3.4.\
- Ben: Tried to do Cross Site Scripting attack. However, this has failed as I have specified from every type of my input. This helps blocking weird syntax, including a script tag.\
- William and James: Attempted to break my simulator, but didn't manage to do it.\
All the attempts for breaking failed, which means my code is very robust, satisfying SC1.5.
#pagebreak()
==== Summary
In this iteration, I have successfully developed a Graphical User Interface for my simulator. This is getting close to my overall goal: to educate about blockchain technologies through visualisation. The GUI allows me to visualise users in the blockchain network as graphs. Learners can also click on different nodes to investigate how blockchains differ on different nodes.  All the goals from this iterations have been met, including creating a GUI with vis.js, making a wrapper file to create an overall network, delivering features like add users, connect users, and add transaction, etc.\
\
In this iteration, I have been trying to test the simulator with larger networks refelecting Iteration 3. This ensures that when the learners try to simulate a more realistic blockchain network with more nodes, the simulator will not crash. All of the tests in this Iteration with a larger network passes. In this Iteration, I have also focused more on data validation for robustness and usability features so that learners will get a smoother and a more effective experience on my simulator.\
\
However, this Iteration is missing some 'cool stuff', for example, the balances or mempool do not move or animate although they update every second. This might lose the learners' interest. To grab their attention, in the next iteration, I aim to add some animations and changing colours so that learners will be kept interested, and would like to learn more about it. This allows the learners to be more engaging and fun.

#pagebreak()
== Iteration 5
In Iteration 5, I will be focusing on the visualisation of the network propagation and the mining processes. This is because in Iteration 4, I have successfully created a GUI for my blockchain simulator. However, the mining and network propagation processes has not been developed and visualised. Therefore, in this iteration, I will animate these two processes to help my stakeholders understand how blockchain works in a more intuitive way.\
=== Goal
Iteration 5 has two simple goals:
- Visualising the mining process
- Visualising the network propagation process
=== Decomposing Iteration 5
#figure(image("images/I5_decomposition.png", width: 80%), caption: [Iteration 5 decomposition])
In this Iteration, The two main tasks:
- Mining
  - Implement a difficulty slider that can change the difficulty of the network
  - Implement a progress status which visualises the mining in action
- Propagation
  - Adjust previous code to output the correct data
  - Animate the propagating process for visualisation
These two features both require a lot of readjustment from previous iterations and new code.
=== Mining
The reason that I left mining to Iteration 5 instead of doing it in Iteration 4 is because mining is implemented with more structure than other functions as it represents the point at which the blockchain's global state changes. Transactions are only proposals placed into the mempool and have no effect on balances or consensus until they are included in a block. As a result, they can be created instantly without modelling computation or delay.\
\
In contrast, mining is responsible for selecting transactions, linking a new block to the existing chain, and enforcing difficulty. Modelling the nonce search and time delay allows the system to demonstrate why blocks do not appear instantly and why block creation is a costly and competitive process. This makes the distinction between unconfirmed transactions and confirmed blocks explicit, and reflects the role of proof-of-work in regulating block production rather than simply appending blocks on demand.\
==== Design for mining
The idea for my design is very simple. I am going to show the different nonces that are being tried to match the network difficulty for visualisation.
#figure(image("images/mining-design.png"), caption: [Mining GUI design])
These will be in the sidebar under all the features made in the Iteration 4. At the top is the 'Mine Block' button with the tool tip circle next to it explaining how mining features work.\
\
At the start of the simulator when nothing is being mined. The section below the button will be empty. When the transactions are added and the block is being mined, the section will update into text to display 'Mining...', along with the nonce currently being tested. Because mining runs across multiple worker threads, the nonce updates extremely quickly internally, but the interface only refreshes at around 60 times per second, so the displayed nonce represents the most recent value rather than every individual attempt.\
\
When a valid nonce is found and the block is successfully mined, the mining status is replaced with the index of the block in the chain, final nonce, hash, and the time taken for the mining process indicating that the block has been added to the chain.
==== Difficulty
To adjust the difficulty in ui.ts, I will have to firstly connect to backend.ts where I process all the backend stuff. This will then be connected to the network.ts where I established the network. The setup for difficulty affecting the number of leading zeros in the target is already implemented from Iteration 2.\
\
In ui.ts, I will have to pass the value of difficulty to backend.ts:
```ts
  // Difficulty slider
  difficultyValue.textContent = Backend.backend.difficulty.toString();
  difficultySlider.oninput = () => {
    let newDifficulty = parseInt(difficultySlider.value);
    Backend.setDifficulty(newDifficulty);
    difficultyValue.textContent = newDifficulty.toString();
  };
```
The range of that the slider can take is between 1 and 6. This is being validated. It also only takes integers value instead which makes sense as it is the number of leading zeros in the target.\
\
This is then passed to Backend (network) to process:
```ts
export function setDifficulty(newDifficulty: number) {
  backend.difficulty = newDifficulty;
  console.log(newDifficulty);
}
```
When changing the will not create a new network. This is because the `difficulty` variable is only used in the mining process throughout the whole simulator. Therefore, it will not cause any issues in the overall network.
==== Progress
In previous iterations, I did not consider visualisation when developing the mining algorithm, as the focus was on functionality and efficiency. To visualise the mining progress, I decided to display the nonce currently being tested in real time, allowing the learners to see how proof of work operates rather than treating it as a black box. Achieving this requires access to the nonces being attempted by the worker threads, which means changes must be made at the core of the mining algorithm itself.\
\
As a result, I am going to revisit the original `startMining()` proof of work algorithm developed in Iteration 1 and introduce an `onProgress` callback #footnote[https://developer.mozilla.org/en-US/docs/Glossary/Callback_function], which is a function passed into another function so it can be executed later when a specific event occurs, in this case allowing the mining algorithm to report progress back to the interface while it is running. Each worker periodically sends the nonce it is currently testing, and the main thread forwards this value to the user interface for display.\
\
This approach preserves the original parallel mining behaviour while adding a lightweight mechanism for real time visual feedback.\
\
Each worker has to post a message of the nonce that they're trying.
```ts
export async function startMining(
  baseData: string,
  difficulty: number,
  onProgress?: (nonce: number) => void
) {
...
return new Promise<{ nonce: number; hash: string; time: number }>(
    (resolve) => {
      let workerCode = `
      ...
      self.onmessage = (e) => {
          ...
          self.postMessage({ nonce }); // live progress
          if(hash.startsWith(prefix)){
            self.postMessage({ nonce, hash, found: true });
            break;
          }
        }
      };
    `;
      for (let i = 0; i < NUM_WORKERS; i++) {
        let blob = new Blob([workerCode], { type: "application/javascript" });
        let worker = new Worker(URL.createObjectURL(blob));
        workers.push(worker);

        worker.onmessage = (e) => {
          ...
            let runtime = parseInt((endTime - startTime).toFixed(2));
            stopMining();
            resolve({ nonce: e.data.nonce, hash: e.data.hash, time: runtime });
          } else if (onProgress) {
            onProgress(e.data.nonce);
          }
        };
...
}
```
Another thing that I have changed when revisiting the proof of work code is that I have added the processing time as a variable to be ouput with the nonce and hash. This is because this will be easier for future me to take the processing time into the print message, as currently it's being wrapped in a string message for the CLI.\
\
Another file to change so that the progress can be reflected on the GUI is the block.ts mineBlock function. This is because to connect to the GUI, it has to be done through network.ts which takes this function to mine blocks. Therefore, the same callback has to be added in the mineBlock function.\
```ts
  async mineBlock(difficulty: number, onProgress?: (nonce: number) => void) {
    ...
    let result = await startMining(blockData, difficulty, onProgress);
    ...
  }
}
```
==== Initial idea for mining
My initial idea for developing the mining algorithm is to connect the mining function just like other features, like adding users, using the function from network.ts. This will work as the only issue is to change the output type of the mining function in network.ts from the string message into an object which contains the username, index, hash and nonce:
```ts
    let latestBlock = node.blockchain.getLatestBlock();
    let index = latestBlock.index;
    let hash = latestBlock.hash;
    let nonce = latestBlock.nonce;
    return [{ username }, { index }, { hash }, { nonce }];
```
#figure(image("images/mine.png"), caption: [CLI after changing mining output])
Although this works, it will not display the progress that I have just made. This is because in a CLI, it will be very chaotic to print the nonces in real time and flooding the console.\
\
However, I still do want to preserve the functionality of the CLI. Therefore, I will have to redesign the function specifically for the GUI.
==== Mining GUI
To design the mining GUI, I will have to consider what actually happens starting from the frontend button. When I press the button, what do I expect the simulator to do?\
Algorithm deesign:
- When the 'Mine' Button is clicked, the algorithm checks if there is anything in the mempool:
  - If there isn't:
    - return with an error message
  - If there is:
    - Take the transactions in the mempol and all the required data (index, previousHash, timestamp, transactions) and start mining a block with those inputs
    - After mining, construct a block with the output of mining function and add it to the end of the user's blockchain.
    - update the balances of users after transactions
    - print the empty mempool
Pseducode design:
```
mineBtn.onClick = () => {
  if (!Vis.selectedUser) return alert("Select a node first!")

  mineStatusDiv = 'Mining...'
  try {
    node = Backend.backend.getNode(vis.selectedUser)
    if (!node) {
      alert('User not found')
      return;
    }

    let mempool = Backend.backend.showMempool()
    if (mempool.length === 0) {
      alert('No transactions to mine')
      mineStatusDiv = ''
    }

    // Passing inputs to mine block
    index = node.blockchain.length
    previousHash = node.blockchain.getLatestBlock().hash
    timestamp = Date.now()
    transactions = [...mempool]
    baseData = index + previousHash + timeStamp + transactions
    lastNonce = 0
    result = await startMining(
      baseData,
      Backend.backend.difficulty,
      (nonce: number) => {
        // Updating progress
        mineStatusDiv = `Mining... Nonce: ${lastNonce}`
        lastNonce = nonce;
      }
    )

    Vis.resetNodeColor(Vis.selectedUser)
    mempoolDiv = Backend.backend.showMempool()
  } catch (err) {
    alert('Mining error' + err)
  }

}
```
I have added a few validation, including validating if a user is selected for mining, doing a try and catch in case the mining takes too long and causing errors, checking if mempool is empty.\
\
Besides, this time, I have included a function called the `finalisMinedBlock()`. This will be developed in the backend which connects to the network.ts so that the block can be added to the user's local copy of blockchain.\
\
The code for mining in ui.ts is as follows:
```ts
  // Mining a block
  mineBtn.onclick = async () => {
    if (!Vis.selectedUser) return alert("Select a node first!");

    mineStatus.innerHTML = `Mining...`;
    Vis.highlightNode(Vis.selectedUser!);

    try {
      let node = Backend.backend.getNode(Vis.selectedUser!);
      if (!node) {
        alert(`User ${Vis.selectedUser} not found.`);
        Vis.resetNodeColor(Vis.selectedUser!);
        return;
      }

      let mempool = Backend.backend.showMempool();
      if (!mempool || mempool.length === 0) {
        alert("No transactions to mine.");
        Vis.resetNodeColor(Vis.selectedUser!);
        mineStatus.innerHTML = "";
        return;
      }

      // Passing inputs to mine block
      let index = node.blockchain.chain.length;
      let previousHash = node.blockchain.getLatestBlock().hash;
      let timestamp = Date.now();
      let transactions = [...mempool];
      let baseData =
        index + previousHash + timestamp + JSON.stringify(transactions);

      let lastNonce = 0;

      let result = await startMining(
        baseData,
        Backend.backend.difficulty,
        (nonce: number) => {
          // Updating Progress
          mineStatus.innerHTML = `Mining... Nonce: ${lastNonce}`;
          lastNonce = nonce;
        }
      );

      // finalise the mined block in the backend using the produced nonce/hash
      let finaliseMsg = Backend.finaliseMinedBlock(
        Vis.selectedUser!,
        result.nonce,
        result.hash,
        timestamp,
        transactions
      );

      mineStatus.innerHTML = `${finaliseMsg.replace(/\n/g, "<br>")}<br>
      Nonce: ${result.nonce}, Mining took ${result.time}ms`;

      setTimeout(() => Vis.resetNodeColor(Vis.selectedUser!), 500);

      mempoolDiv.innerHTML = Backend.backend.showMempool().join("<br>");
    } catch (err) {
      alert("Mining error: " + err);
    }
  };
```
As usability features, I have added some responses from the ui while a user is chosen to be mining:
- When a user is chosed to be mining, they will be highlighted.
- After mining, the user will be reset back to the default colour
This helps the user to identify which user is currently mining the blockchain.\
\
Now I will have to actually add the blockchain into the network by defining the `Backend.finaliseMinedBlock()` in backend.ts. I want to leave all the adding blocks within the network.ts. Therefore, this will serve as a wrapper function which connects to network.ts to get all the output:
```ts
// Finalise a mined block
export function finaliseMinedBlock(
  username: string,
  nonce: number,
  hash: string,
  timestamp: number,
  transactions: string[]
) {
  return backend.finaliseMinedBlock(
    username,
    nonce,
    hash,
    timestamp,
    transactions
  );
}
```
The reason for this function is to exist is that in future maintenance, all the backend code for the GUI can be found in the backend.ts. Therefore, me or other development won't have to spend a lot of time just to find each functions in different files.\
\
In network.ts, I will then have to process the new data to put them in a block. The new block should be put under a user in the network, with the essential attributes of a block: nonce, hash, timestamp, and transactions. The majority of this function will be the same with the `network.mine()` function which handles the mining and wrapping data into blocks for my CLI. The only difference for the GUI is that I am processing the mining and the wrapping separately in different modules. \
\
Algorithm design: \
This function should
- Create a new block by using the `new Block()` function and adding all the
- Apply the transactions so that the transactions in mempool are actually processed
- Clear the mempool after transactions are being done
Implementation:
```ts
  // GUI: Finalise a mined block using externally computed nonce and hash
  finaliseMinedBlock(
    username: string,
    nonce: number,
    hash: string,
    timestamp: number,
    transactions: string[]
  ): string {
    let node = this.getNode(username);
    if (!node) return `User ${username} not found.`;
    if (this.mempool.length === 0) return "No transactions to mine.";

    let transactionsToMine = transactions;

    let newBlock = new Block(
      node.blockchain.chain.length,
      timestamp,
      transactionsToMine,
      node.blockchain.getLatestBlock().hash
    );

    newBlock.nonce = nonce;
    newBlock.hash = hash;
    newBlock.mined = true;

    node.blockchain.chain.push(newBlock);

    // apply transactions
    for (let tx of transactionsToMine) {
      let parts = tx.split(" ");
      let from = parts[0];
      let to = parts[2];
      let amount = parseInt(parts[3]);
      this.balances.applyTransaction(from, to, amount);
    }

    // miner reward
    this.balances.applyTransaction("system", username, 10);
    // clear mempool
    this.mempool = [];

    return `Block mined by ${username}: Index=${newBlock.index}, Hash=${newBlock.hash}`;
  }
}
```
Similar with the CLI, I have kept the miner reward as a more realistic feature. This is a good usability feature since it will help learners to learn how new coins can be added into the system.

=== Mining Test
To test the mining feature in the GUI, I have created a simple network which only contains two nodes, A and B. I made a few example transactions between them and these updated the mempool. Therefore we have transactions in the mempool to mine.
#figure(image("images/Mining.png"), caption: [Mining in progress])
The above image shows that mining is in progress, as shown by the nonce being a changing number. This suggests that the onProgress callback that I have made has successfully connected to the frontend and is able to display the nonce that they are trying.

#figure(image("images/Finish-Mining.png"), caption: [Bloick successfully mined])
When block is successfully mined, the mineStatus div has successfully updated with the details of the block, confirming that the connection from backend to frontend is successful. The blockchain tab for user A (miner) has also been updated with an extra block, showing that it has successfully mined the data using proof of work and added the block with the correct data into the local copy of blockchain. \
\
To test the how the difficulty level of the network affect the mining speed, I have tried if the network slider actually affect the mining speed. Firstly, when changing the difficulty, I logged the number of difficulty in the console by adding `console.log(difficulty)`, which has shown properly.
#figure(image("images/difficulty_slider.png"), caption: [Difficulty in action])
To further test if the difficulty has actually changed the mining speed, I added some other transactions after adjusting the difficulty level to 1 from 2. I used the mine button which the mining time decreased from 3310ms to 20ms (shown in console in above image), which shows the network difficulty in action.\
\
Erroneous Test:\
To test invalid block data, I have tried to mine a block when there is no transactions in the mempool:
#figure(image("images/no_trans.png"), caption: [Mining with no transactions])
The webpage has successfully validate this and gave me an alert message 'No tranasctions to mine'. Therefore all the data validation for mining is done.
=== Propagation
There is a few reasons that I left propagation in Iteration 5 instead of doing it in Iteration 4. One of the reason is that I need the blocks to be mined into the blockchain before propagating them throughout the network. The other reason is that implementing propagation feature isn't as easy as the others like adding users. This is because in Iteration 3, although the I have already built the propagation for the CLI, it doesn't output the correct data type. Therefore a data change is required.
==== Output from network.ts
The output of the function for propagation from network.ts returns a string like "DFS/BFS propagation: A -> B -> C -> D" due to the return function being ```ts return `${method.toUpperCase()} propagation: ${order.join(" -> ")}`; ```. This form is very readable for the CLI. However, in order to animate the propagation function, I will have to actually get the list as the output. Therefore the function has to instead ```ts return output``` which is a list rather than a string.\
\
However, this change of output of the propagate function will invalid the cli. In order to keep both the CLI and GUI working, I have to slightly adjust the code in cli.ts as well. Since I have deleted the part where the order list is joined within the propagate function, I will have to do that in the cli.ts instead:
```ts
// Propagate for both CLI/GUI
let order = network.propagate(args[0], args[1] as "bfs" | "dfs");
console.log("Propagation order:", order.join(" -> "));
```
Now the propagation function will work for both CLI and GUI.\
This is a simple manual test for CLI still working fine:
#figure(image("images/propagation.png", width: 70%), caption: [CLI still working])

==== Animating propagation
Firstly, with a graph, it is much easier to develop a visualisation tool for propagations. I made a sketch of how I am imagining it to look like:
#figure(image("images/animation_design.png"), caption: [Propagation animation design])
This diagram is actually taken from Iteration 1 when I developed the BFS and DFS algorithms.\
After the propagate button is being clicked, the graph will be traversed by either BFS/DFS depending on the input. For each 0.4 seconds, one node will light up until all nodes have been traversed. 1 second after the graph is traversed, the network will goes back to the original state where nothing is highlighted. This animation design fits the evaluation from Iteration 4 where I mentioned that the simulator is not interactive enough.\
\
Although the animation is taking time to show lighted up nodes, the actual block should be sent to all connected nodes instantly. The animation is purely for visualisation purpose.\
\
To implement this, propagation animation is handled entirely in ui.ts. This is a deliberate choice: animation is a frontend concern, not a backend one. The network logic computes the traversal order instantly, then passes that order to the UI purely for visualisation.\
\
The `animatePropagation()` function takes the traversal order of the graph (input) and highlights nodes sequentially (output). Previously highlighted nodes stay lit to show cumulative propagation. Once the animation finishes, all affected nodes are reset back to their default state.\
\
Algorithm Design:\
+ The algorithm begins by checking whether a valid traversal order is provided. If the order is empty or undefined, it exits immediately to prevent unnecessary UI updates and potential runtime errors. (For data validation)
+ The animation advances using a step based function triggered by a timer rather than a loop. This is necessary because TypeScript is single threaded without web workers: a loop would block rendering, while a timed step function allows the browser to repaint between steps and keeps the UI responsive. Each step highlights exactly one node, while previously highlighted nodes remain active to represent cumulative propagation.
+ Once all nodes in the traversal order have been highlighted, the algorithm pauses briefly so the user can observe the completed propagation, then resets only the affected nodes. This avoids persistent visual clutter and ensures the graph is ready for subsequent animations.\
Here is the code for `animatePropagation(order:string[])`:
```ts
function animatePropagation(order: string[]) {
  if (!order || order.length === 0) return;

  let i = 0;

  function step() {
    if (i < order.length) {
      // Highlight current node, leave previous highlighted nodes as they are
      Vis.highlightNodes([order[i]], {
        background: "#12bd1bff",
        border: "rgba(8, 222, 230, 1)",
      });
      i++;
      setTimeout(step, 400);
    } else {
      // After all nodes are highlighted, wait a bit then reset everything
      setTimeout(() => {
        Vis.resetNodes(order);
      }, 1000); // Reset all the nodes back to default colour
    }
  }

  step();
}
```
This will allow me to change each nodes background and border colour.\
\
Then, to connect my two prebuilt dfs/bfs function, I will connect to backend.ts which can use the propagate function from network.ts which will be the same as the one used in my CLI, which earlier in this Iteration has been proven to be working.\
\
Algorithm Design:\
When clicked on the `propagate BFS` or `propagate DFS` function:\
- Check if a user is selected for mining (For data validation)
- Connect to backend.ts to get the order of traversal (requires propagation function in backend.ts)
- Ensure that the correct output type in case it kept the format from CLI (For data validation)
- Pass the order into the animation function
The code to this algorithm is as follows:
```ts
// Propagating a block through the network by BFS or DFS
propagateBFSBtn.onclick = () => {
  if (!Vis.selectedUser) return alert("Select a node first!");

  let result = Backend.propagate(Vis.selectedUser, "bfs");

  if (typeof result === "string") {
    alert(result);
    return;
  }

  animatePropagation(result);
};

propagateDFSBtn.onclick = () => {
  if (!Vis.selectedUser) return alert("Select a node first!");

  let result = Backend.propagate(Vis.selectedUser, "dfs");

  if (typeof result === "string") {
    alert(result);
    return;
  }

  animatePropagation(result);
};
```
In backend.ts, to develop the required function, a simple link to the main network will be done by:
```ts
export function propagate(username: string, method: "bfs" | "dfs") {
  return backend.propagate(username, method);
}
```
Now, the propagate function can be linked back to the predesigned propagate function from the CLI. Therefore it should work.
=== Testing for propagation
To test if the propagation animation work, I decided to just input a large network. This is because if it works on a larger network, it will work on a smaller network. Another reason is that this saves me time from creating lots of networks, which is not easy to setup.\
\
Therefore, I took the large network from Iteration 1. Please check the 'Blockchain Propagation Demonstration' video for the following time stamps: \
0:00 - 0:04 -- Showing that 'M' node has just mined a block which updated the its local blockchain\
0:05 - 0:07 -- Shwoing that all the balances have been updated after mining \
0:08 - 0:17 -- Clicking on all the nodes to check their local blockchain to verify that only node 'M' has the most updated one\
0:18 - 0:34 -- Attempt to start the propagation from B. However, it isn't the longest chain, therefore nothing has been propagated although the animation has been shown to traverse the graph and compare with each node. This shows that the validation for the longest chain has been working\
0:35 - 0:42 -- Attempt to start propagtion from M using BFS. The animation shows the correct traversal order and each node's local blockchain has been updated as expected\
0:43 - 1:08 -- Adding another transaction to mine the second block and checking that all users' blockchain state has been updated to the first block added\
1:09 - 1:17 -- Starting the propagation from 'M' using DFS. The animation shows the correct order of traversal therefore all the algorithms have been shown working\
\
To decrease the length of the video, I have used a network difficulty of 1. This means that mining should take less time. This is true because the first mine took 20ms and the second mine also took the same time. Showing that it doesn't take very long to mine a block on a low difficulty level. In terms of propagation, the propagation order and animation has all been correct and nothing has to be changed.

=== Iteration 5 Evaluation
This is the last iteration in this project. I have invited all my stakeholders to do a final review on the simulator. All of them really enjoyed using the simulator, and they all mention that they have learnt some concepts of blockchain. This allows them to understand further on technologies based on them like cryptocurrencies. They really enjoy the animations made in this iterations and how the mining feature are dealing with real numbers being used as trial to the proof of work algorithm. All of them really like the propagation feature as it shows how the block is going in a very vivid way.\
\
Meanwhile, Ben is more interested in the mining algorithm where he is very interested in the mining feature as it shows the nonce that the miners are trying in real time, this visualise the proof of work algorithm.\
\
In the development in Iteration 5, I realised that I could do transactions with myself. Although this is technically not a bug, as it is not prohibited, it doesn't really make sense to send money to yourself on the same account in a real blockchain network. Therefore, I have added another data validation in the addTransaction function ```ts     if (to === from) return alert("You cannot do transactions with yourself");```. This removes the confusion for learners when they're trying to transact with themselves.

=== Robustenss Test
I have attempted on each feature to click random keys rapidly, try clicking on different spaces of the webpage, but none seems to actually break the webpage. Therefore, again, I invited my stakeholders to try 'hack' me. However, none of the attempts were successful due to the validations of each functions. Therefore, I believe that the blockchain simulator overall is quite robust.
= Evaluation <evaluation>
== End Product Evaluation
To evaluate the whole project, I decided to record a video of the whole working process of the simulator and explain it step by step, with my attempt of breaking it, showing the validations in work. Please check 'Blockchain Simulator Demo' video. Here is the timestamp:\
0:00 - 0:50 -- Demonstrating functionality of add user feature. Includes validation for too long usernames and repeated usernames.\
0:51 - 0:57 -- Demonstrating functionality of connect user\
0:58 - 1:50 -- Demonstrating functionality of send transactions, including validations for double spending and insufficient balance. Balances are not updated but tracked as they should be
1:51 - 1:57 -- Mining at difficulty 1, with a runtime of 99ms, within the 5 seconds range from SC1.3, showing that balances are updated after the mining\
1:58 - 2:13 -- Propagating the block through the network by BFS, showing that all nodes have updated their local chain, fulfilling SC3.5\
2:14 - 2:34 -- Creating a new batch of transaction, ready for second mining\
2:35 - 3:11 -- Mining second block with a difficulty level of 2, including the validation of not selecting a node before mining, also showing the significantly longer time for mining (21650ms)\
3:12 - 3:22 -- Showing that only the miner node has the updated blockchain.\
3:23 - 3:28 -- Showing the correct traversal order with DFS, fulfilling SC3.5\


I believe that this simulator could give a beginner some knowledge of how a blockchain network work. Therefore the problem is being solved. However, a lot more features could be added to further enhance their knowledge and user experience.\
\

To test SC1.3, I have created a spreadsheet and ran the simulator at different difficulty level and finding the mean.
#figure(image("images/mine-time.png"), caption: [time taken for mining])
The simulator shows a great range of value but increasing mean runtime as the difficulty increases. This means that it has shown that a mining nonce is found randomly, but the average runtime will go up. The mean of the simulator at difficulty level 1 is 1752.5ms, which is less than 5 seconds, satisfying SC1.3. While running these tests, due to their long period of runtime at higher difficulties, I unfocused the tab and the simulator still runs, fulfilling SC 4.3.\
\
To test SC4.2, I have coded a loop for mining for 100 times and looked at its storage in the Memory page of the website. This is the code for testing it:
```ts
  (async () => {
    Backend.setDifficulty(1);
    Vis.visNetwork.selectNodes(["A"]);

    for (let i = 0; i < 100; i++) {
      mineBtn.click();
      await new Promise((r) => setTimeout(r, 10)); // let async mining finish
    }

    console.log("Mined 100 empty blocks");
  })();
```
It is an async loop which creates 100 blocks by mining them one by one. I removed the empty validation for mining temporarily to prevent the mining to cause issues.
#figure(image("images/memory.png", width: 50%), caption: [SC4.2 Test])
It shows that there is no storage being used. Although this seems odd. However, this is completely normal because I am not storing any blocks in the server, which means if you refresh the page, all the blocks wil be gone. Therefore it will be passing SC4.2.
== Stakeholder Final Review
To take feedbacks from users for the final time in this project, I am going to interview each of them to give me comments about the simulator. These are the questions that I am asking them:

1. Is it easy and intuitive to navigate the simulator interface?
2. Which features do you find most useful?
3. Are there any features that are confusing or need improvement?
4. Are you satisfied with the responsiveness of the simulator to your actions (e.g., adding blocks, expanding transactions)?
5. How much did you learn about blockchain by using the simulator?
6. Would you recommend this simulator to other students to learn blockchain concepts?
7. What improvements would make the simulator more useful or enjoyable?\
After interviewing them, here is a summary of what they have said:\
All of them agreed that the blockchain simulator is easy and intuitive to navigate simulator. James quite likes idea of the user actions being in order. He said that this is a very good usability feature. All of them have gained more understanding of blockchain technologies from my simulator. \
\
Ben really likes the graph being combined into the idea of blockchain as there are no existing simulator with graphs showing how an actual network would be looking like. Most of them find the mining blocks most useful because they always hear about crypto mining but don't actually know what is going on. With the help of the description in the tool tip box, they are able to fully understand it. Ben also find showing block details quite useful as he knew how blockchain work but not what actually is stored in each block. However, most of them find simulating network propagation as the 'coolest' feature since it has nodes flashing on and off and overall this also reminded them of the computer science lesson on BFS/DFS. Most of them didn't include a feature to improve on. \
#pagebreak()
However, Ben suggested that in the proof of work mining, I could implement another feature showing how the CPU threads are working in order to show how the work is being splitted up for each web workers. This might be something that I can develop after this project (a potential feature).\
\
Overall, they all seem to agree that the user experience is well as the actions are processed instantaneous without any delays. This seems to give them a smooth experience, especially with no bugs encountered. They also think that it is very nice to be able to use all the features in the simulator from the top to the bottom of the sidebar. They would also like to share this simulator to those who wants to learn about blockchain, but don't know where to start.
== SC Review
I am reviewing which success criterias I have met/unmet and justifying them in the following table. I will refer Iteration X by IX (e.g. Iteration 2 is I2).
#table(
  columns: (64pt, 33pt, auto, auto),
  inset: 5pt,
  align: horizon,
  fill: (x, y) => {
    if (y == 13) or (y == 23) { red } else if (
      (y == 2 and x == 1)
        or (y == 1 and x == 1)
        or (y == 1 and x == 2)
        or (y == 1 and x == 3)
        or (y == 2)
        or (y == 3)
        or (y == 4)
        or (y == 5)
        or (y == 6)
        or (y == 7)
        or (x == 1 and y == 8)
        or (x == 2 and y == 8)
        or (x == 3 and y == 8)
        or (y == 9)
        or (y == 11)
        or (y == 12)
        or (x == 1 and y == 14)
        or (x == 2 and y == 14)
        or (x == 3 and y == 14)
        or (y == 16)
        or (y == 17)
        or (y == 18)
        or (y == 19)
        or (x == 1 and y == 20)
        or (x == 2 and y == 20)
        or (x == 3 and y == 20)
        or (y == 21)
        or (y == 22)
        or (y == 24)
        or (y == 25)
    ) { green } else if (y == 10) or (y == 15) { gray } else { white }
  },
  table.header([*Category*], [*SC*], [*Target*], [*SC Met?*]),
  table.cell(
    rowspan: 7,
    align: center,
    rotate(-90deg, reflow: true)[
      *Functionality*
    ],
  ),
  $ 1.1 $,
  [Users can create a new block with a hash linked to the previous block within 1 second],
  [Firstly shown in I2 when developing the block structure, also showin in I3 in the CLI, and the Blockchain Demonstration video],

  $ 1.2 $,
  [Users can at least 10 transactions per block before mining],
  [I have proved that the length of transaction doesn't actually affect the mining as they are all concatenated into a string in I1, therefore I can add as many transactions as I want],

  $ 1.3 $,
  [Mining a block produces a hash satisfying difficulty (1 leading zero) and completes \u{003C}5s],
  [With the spreadsheet from both I3 and Testing to Inform Evaluation, I have tested the mining speed for difficulty level 1 to be less than 5 seconds],

  $ 1.4 $,
  [Each block has a sequential index automatically assigned],
  [From Iteration 3, I have automatically assigned an automatically incremented index for each block],

  $ 1.5 $,
  [Simulator handles unexpected user behaviour (keyboard smashing/spamming)],
  [Throughout Iterations 3 to 5, I have attempted to break my own code and also invited my stakeholders to give unexpected inputs and the simulator manages to handle all of them],

  $ 1.6 $,
  [Simulator can broadcast a newly mined block to all connected nodes using BFS traversal within 2 seconds],
  [Shown in Iteration 3 with the CLI, however the animation makes the process last longer in Iteration 5 depending on the network size],

  $ 1.7 $,
  [Simulator can broadcast a newly mined block to all connected nodes using DFS traversal within 2 seconds],
  [Shown in Iteration 3 with the CLI, however the animation makes the process last longer in Iteration 5 depending on the network size],

  table.cell(
    rowspan: 6,
    align: center,
    rotate(-90deg, reflow: true)[
      *Graphical User Interface (GUI)*
    ],
  ),
  $ 2.1 $,
  [Blocks visually display index, hash, previous hash, transactions],
  [Shown in Iteration 2-5 with printing blcoks],

  $ 2.2 $,
  [Transaction input form accepts strings ≤100 characters; longer inputs rejected],
  [This success criteria has been invalid past Iteration 2, as the transactions doesn't take in a single string anymore past that point],

  $ 2.3 $,
  [Chain validity visually indicated],
  [This is partly met, although the chain shows the previousHash linking the chain, it doesn't have features like showing red/green depending on the chain validity],

  $ 2.4 $,
  [Users can expand blocks to view transactions; expansion completes \u{003C}0.5s],
  [The blocks are not expandable, you instead just scroll through them within the blocks/mempool div, which takes even less than 0.5s as all of them are already rendered],

  $ 2.5 $,
  [GUI updates within \u{003C}1s after any user action (add transaction, connect node) except mine block],
  [All GUI actions have been updated instantly, shown in the Testing to Inform Evaluation video],

  $ 2.6 $,
  [GUI prevents spamming (>5 transactions/sec not allowed)],
  [There is no validations for lots of transactions in a short period of time, however this is usaully impossible to do unless learner is trying to add the transactions through the console],

  table.cell(
    rowspan: 6,
    align: center,
    rotate(-90deg, reflow: true)[
      *Security and Integrity*
    ],
  ),

  $ 3.1 $,
  [Block hash matches its data exactly],
  [This is shown in the fakeHash function where if you hash a string it will become the same data again],

  $ 3.2 $,
  [Tampering invalidates the chain],
  [There is no features for tampering block which shows a more accurate representation to a real blockchain network. Therefore, this SC shouldn't be a valid one.],

  $ 3.3 $,
  [Mined blocks cannot have transactions altered],
  [There is no feature for altering mined blocks anywhere, shown in I1-5],

  $ 3.4 $,
  [Input validation prevents invalid characters or excessively long strings],
  [In I4 after Jeremy broke the simulator with a very long username, I started to add length checks to validate data before processing],

  $ 3.5 $,
  [Nodes maintain consistent blockchain state after BFS broadcast],
  [Every nodes ends up with the same blockchain after traversal, shown in I3 and Test to Inform Evaluation],

  $ 3.6 $,
  [Nodes maintain consistent blockchain state after DFS broadcast],
  [Every nodes ends up with the same blockchain after traversal, shown in I3 and Test to Inform Evaluation],

  table.cell(
    rowspan: 6,
    align: center,
    rotate(-90deg, reflow: true)[
      *Performance and reliability*
    ],
  ),

  $ 4.1 $,
  [Blockchain state persists while simulator runs; saving/loading \u{003C}1s],
  [The save and laod of blockchain is instantaneous, shown in both CLI and GUI videos],

  $ 4.2 $,
  [Memory usage \u{003C}100MB for 100 blocks],
  [Test passed in End Product Evaluation],
  $ 4.3 $,
  [Simulator and GUI running when window unfocused],
  [Test passed in End Product Evaluation],

  $ 4.4 $,
  [Memory usage \u{003C}50MB for 100 blocks stored in local storage],
  [Not met; I have not used local storage for storing blockchains],

  $ 4.5 $,
  [The simulator should have no server side code (except the one serving the static files)],
  [In Iteration 1, the blob method is used instead of the server for proof of work, there is no server side code now in the project],

  $ 4.6 $,
  [The simulator should be able to run on Bun without using any framework],
  [There are no framework anywhere in my code],
)
A main unmet criteria is about the chain validity, I can develop a feature to show if the chain is valid using colour coding (green for valid; red for invalid). This will help understanding forked chains and how the network will decide what to do with it.\
\
Another main unmet criteria is about storing blockchains. I can refactor my code into inputting and outputting JSON files so that it be saved in the localStorage and used later even after refreshing the page.\
\
Another main unmet criteria is about spamming requests, although me and my stakeholders tested rapid spamming requests and none of us have successfully caused any issues. There might be someone with quicker speed in doing these. Therefore, to prevent this, I can make an algorithm to track how often requests are being made and stop them in making too many requests in a short period of time.
=== Robustness Test
In later on iterations, I tried to break my own code by inputting invalid data into the input boxes and different unexpected inputs. I have also invited my stakeholders to try break the simulator while trying it out (penetration testing). This can help be raise possible unexpected inputs values so that I can fix them as soon as possible. For example, when Jeremy tried to break my simulator by adding users with very long usernames, my simulator crashed. This is quickly fixed and when he tried it again in Iteration 4, he did not succeed to break my simulator. I have tested that the blockchain simulator works on every chromium based browsers mentioned in the Analysis section.
=== Maintenance
Currently, my teacher Mr Gordon is hosting the website on https://ivan-nea.2024.compsci.me/. All the code has been pushed to a repository on GitHub and the webpage changes automatically when I push the code to the repository within a few seconds. Therefore, if Mr Gordon stops hosting the website, me or other developers with the repository will be able to host it on a different web server. This makes sure that the simulator is sustainable and can be used by future learners.\
#pagebreak()
The code of every features included in the Blockchain simulator has been commented, stating what the functions do. This is useful for sustainability of my code as other developers or me in the future will still be able to understand what is going on with the code. They will then be able to pick up where I left off and add more features or fix bugs in the code.\
\
I have adapted modular coding throughout the whole project, for example, the BFS folder contains the BFS algorithm
== Limitations
- Hardware Limitation: Insufficient testing devices
I have only done the mining speed test on my two computers, however this might not be representative of all the computers that my stakeholders are using. Therefore, the mining speed might vary on different computers with different hardware specifications. But in general, with an average computer, the mining speed should be around the same as my test results.\
\
- Import/Export JSON
Another unmet usability feature is that I left my stakeholder James idea of exporting and importing the state of the network with JSON files as he suggested in Iteration 3. This is because to implement this feature, instead of strings that my simulator is currently outputting, I will have to refactor a lot of the code to make the classes take in JSON files. This was not ideal since I should be focusing on developing the GUI in Iteration 4 and 5. Therefore, I can consider adding this feature in future maintenance.\
\
- Dynamic difficulty level
In real life blockchain, the network difficulty cannot be adjusted by users, but instead dynamically by the system. When less people are mining, the difficulty will decrease and vice versa.\
\
- Blockchain forks
It real life blockchain networks, it is quite often to see more than one blockchain within a network. This is beacuse there might be two miners mining a different block at the same time causing collisions. Although my simulator decides based on the longest chain, which is what the majority blockchain network do, it is not sufficient for a more advanced blockchain network as they will have other algorithms to decide which chain is the correct one.
\
- No further guidance (unmet usability feature)
For passionate learners that want to learn more about blockchain, I will not have the features for them as my simulator might not be 100% accurate in real world. They will have to find other resources or to read articles as some of the concepts are not fully explained, for example how the users are connected together by transactions, etc.\
\
- Software Limitation
Since I am using only client side code which increases the performance and the security of the website. The tradeoff is that user will be able to bypass some validations through the console. This is inevitable with client side code only project. The only way to solve this is to implement server side validations.
#pagebreak()
== Future Maintenance/Development
How can I tackle with the limitations for future maintenance/development:
- Hardware Limitation: Insufficient testing devices
I can collect more data of how the simulator is performing on different devices when more learners are using it. Therefore the performance can be enhanced by adjusting values in the code.\
\
- Import/Export JSON
This can be implemented in future development. Another idea is that I can save the JSON files in the localStorage, this allows learners to not lose progress when they refresh their page.\
\
- Dynamic difficulty level
I can remove the slider in further development and try dynamically change the difficulty level based on how often the blocks are being mined. To achieve this, I can introduce a timer and a list of the times that blocks are mined and increase/decrease the difficulty level based on the last mining session.\
\
- Blockchain forks
I can do some more research on different algorithms on how blockchain networks decide on which chains to proceed with and attempt to code them. However, these algorithms will likely be very complex and beyond my knowledge, therefore requiring lots of time to learn.\
\
- No further guidance
I can include links for the learners to articles which explain each algorithms. This will encourage them to read more about it and maybe contribute to the community. This is the same for some features that I have purposedly abstracted from the start, like digital signatures.\
\
- Software Limitation
Develop server side code for validation. However, this might cause security issues if not well maintained and performance issues. Therefore, I believe that it is better to stick with the current solution.\
\
=== Decomposition
The decomposition method is used throughout the whole project from breaking down the blockchain technologies from the start, to breaking down the iterations into smaller tasks. This helps me to manage my time and resources effectively, as I can focus on one task at a time and complete it before moving on to the next task. It also helps me to identify any potential issues or challenges that may arise during the development process, allowing me to address them early on. I can also test each component individually before integrating them into the larger system, ensuring that each part functions correctly and meets the project requirements. Thinking ahead was also a key part in this as I was thinking of how each module can be reused in the future. Thinking parallel also helped a lot in Iteration 1 while developing web workers working together to find a suitable nonce.
#pagebreak()
== What went well (WWW)
Overall, I am quite satisfied with this project, especially with the fact that it helped my stakeholders to understand blockchain technologies and solving the main problem. I believe that passionate learners and teacher could use this as a great tool to demonstrate how blockchain works and how they can be adapted into the world with other technologies. It also provides a robust and quite good user experience which would encourage students to be staying longer on the website. The solution has met the majority of my success criterias. I have learnt a lot, not only about blockchain technologies, but also different TypeScript syntaxes such as Promise and resolve.
== Even Better If (EBI)
I wish that my simulator has more features and detailed explanation of what actually is happening inside each algorithm. However, I would like to do this in an interactive way to interest the students and hoping that they can get something out of it. Some coding challenges could be made to passionate learners so that they can also understand deep in code, how it would look like. A database can be used in the future as well to maintain a sustainable network. To enhance user experience, I could also make a fully keyboard mode, so that user doesn't have to move their mouse around while adding a large network by clicking on nodes to connect them, making it more convenient.

#set page(columns: 3, margin: (x: 8pt))
// format code blocks with a background and margin
= Appendix
Here I will attach all the code files that I have written for my blockchain simulator project. They are sorted in alphabetical order for easy navigation.
#show raw.where(block: true): block.with(inset: 0em)

#set columns(gutter: 5pt)
#set text(size: 5pt)

File `bfs/bfs.ts`:
#raw(read("../code/bfs/bfs.ts"), lang: "ts", block: true)

File `bfs/bfs.test.ts`:
#raw(read("../code/bfs/bfs.test.ts"), lang: "ts", block: true)

File `block/block.ts`:
#raw(read("../code/block/block.ts"), lang: "ts", block: true)

File `block/blockchain.ts`:
#raw(read("../code/block/blockchain.ts"), lang: "ts", block: true)

File `block/main.ts`:
#raw(read("../code/block/main.ts"), lang: "ts", block: true)

File `cli/cli.ts`:
#raw(read("../code/cli/cli.ts"), lang: "ts", block: true)

File `dfs/dfs.ts`:
#raw(read("../code/dfs/dfs.ts"), lang: "ts", block: true)

File `dfs/dfs.test.ts`:
#raw(read("../code/dfs/dfs.test.ts"), lang: "ts", block: true)

File `gui/poc/index.html`:
#raw(read("../code/gui/poc/index.html"), lang: "html", block: true)

File `gui/poc/main.ts`:
#raw(read("../code/gui/poc/main.ts"), lang: "ts", block: true)

File `gui/backend.ts`:
#raw(read("../code/gui/backend.ts"), lang: "ts", block: true)

File `gui/ui.ts`:
#raw(read("../code/gui/ui.ts"), lang: "ts", block: true)

File `gui/visManager.ts`:
#raw(read("../code/gui/visManager.ts"), lang: "ts", block: true)

File `network/balances.ts`:
#raw(read("../code/network/balances.ts"), lang: "ts", block: true)

File `network/balances.test.ts`:
#raw(read("../code/network/balances.test.ts"), lang: "ts", block: true)

File `network/network.ts`:
#raw(read("../code/network/network.ts"), lang: "ts", block: true)

File `network/network.test.ts`:
#raw(read("../code/network/network.test.ts"), lang: "ts", block: true)

File `pow/hash.ts`:
#raw(read("../code/pow/hash.ts"), lang: "ts", block: true)

File `pow/hash.test.ts`:
#raw(read("../code/pow/hash.test.ts"), lang: "ts", block: true)

File `pow/index.html`:
#raw(read("../code/pow/index.html"), lang: "html", block: true)

File `pow/main.ts`:
#raw(read("../code/pow/main.ts"), lang: "ts", block: true)

File `pow/server.ts`:
#raw(read("../code/pow/server.ts"), lang: "ts", block: true)

File `pow/worker.ts`:
#raw(read("../code/pow/worker.ts"), lang: "ts", block: true)

File `pow_with_blob/main.ts`:
#raw(read("../code/pow_with_blob/main.ts"), lang: "ts", block: true)

File `app.ts`:
#raw(read("../code/app.ts"), lang: "ts", block: true)

File `index.css`:
#raw(read("../code/index.css"), lang: "css", block: true)

File `index.html`:
#raw(read("../code/index.html"), lang: "html", block: true)
