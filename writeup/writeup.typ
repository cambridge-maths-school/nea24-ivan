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
  ] + line(length:100%),
footer: line(length:100%) + context[
  H446
  #h(1fr)
  Page #counter(page).display("1 of 1", both: true)
  #h(1fr)
  2026
])

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
  *IvanChain*\
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


// Reference a figure such as @thingy by its name, which generates a dynamic figure number.

// #figure(
//   image("image.png", width: 60%),
//   caption: [A cute looking dog],
// )<thingy> // notice the <thingy> referenced as @thingy and appears as "Figure x"

// a 2nd level heading

= Footnotes

// add footnotes easily
I researched collision detection[#footnote[http://www.mathsuniverse.com/particles]] and the papers[#footnote[http://www.mathsuniverse.com/x]][#footnote[http://www.mathsuniverse.com/y]] show up in footnotes...

= Maths

Add maths like this:

$ 7.32 beta + sum_(i=0)^nabla Q_i / 2 $

$ v := vec(x_1, x_2, x_3) $

$ y = 2x^2 + 4x + 5 $

And you can put them in a figure:

#figure($ y = 2x^2 + 4x + 5 $, caption: [_A quadratic equation_])

This should be after a page break. Yes

/*
  You can break your writeup into one file per section/iteration then include them into a master document with:

  #include "iteration-1.typ"
  #include "iteration=2.typ"

  ... etc
*/


= Analysis <sec:introduction>
== The Problem <the-problem>
Despite many people are investing in cryptocurrency markets, most of them do not understand how blockchain technology (the technology which powers cryptocurrencies) works, and there is a lack of educational resources available to help them learn. The goal is to create a platform where users can learn about blockchain technology, how it works, and how to use it.

== Stakeholders <stakeholders>
People who will be using the system, including developers, users, and administrators. This also includes the people who would like to invest in cryptocurrencies, allowing them to learn about the technology and how it works. By understanding the underlying principles of blockchain

== Research <research>
Blockchain is a distributed ledger technology that allows secure and transparent transactions without the need for a central authority. This creates a secure, members-only network, ensuring accurate and timely data access. It is often used in technologies such as cryptocurrencies, supply chain management, and digital identity verification. Blockchains are decentralized, meaning that they are not controlled by a single entity, and they are immutable, meaning that once data is added to the blockchain, it cannot be changed or deleted. This also means it can only be stored in a peer to peer network, which is a network of computers that are connected to each other and can communicate with each other.

Mining is the process of adding transactions to the blockchain, and it is done by solving complex mathematical problems. This process is known as Proof of Work (PoW), and it is used to secure the blockchain and prevent double spending. In PoW, miners compete to solve a mathematical problem, and the first miner to solve the problem gets to add the next block to the blockchain and is rewarded with a certain amount of cryptocurrency. This process is resource-intensive and requires a lot of computational power, which is why it is often done by specialized hardware known as ASICs (Application-Specific Integrated Circuits). This algorithm is used in many cryptocurrencies, such as Bitcoin and Litecoin, to secure the blockchain and prevent double spending. Proof of Stake (PoS) is an alternative to PoW, where miners are chosen to add the next block to the blockchain based on the amount of cryptocurrency they hold. This means that the more cryptocurrency a miner holds, the more likely they are to be chosen to add the next block to the blockchain. This process is less resource-intensive and does not require specialized hardware, making it more accessible to a wider range of users. This algorithm is used in many newer cryptocurrencies, such as Ethereum 2.0, which is transitioning from PoW to PoS.


Research in Blockchain Technology: \
This #link("https://youtu.be/bBC-nXj3Ng4?si=7UgRxuPQdJOzkzG4")[video] by #link("https://www.youtube.com/@3blue1brown")[3Blue1Brown]

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

= Design <design>
== Structure <structure>
== User Interface <user-interface>
The figure below shows the user interface design of different sections of the platform, including the Introduction Page, Main Page, Users Page, Chains Page, Mining Page, Transactions Page, and the Settings Page.

#figure(image("images/ui.jpeg", width: 110%), caption: [
  User interface of the blockchain simulator.
])
<fig:user-interface>

== Decomposition <decomposition>
== Algorithms <algorithms>
== Test Data <test-data>
= Development <development>
= Evaluation <evaluation>
