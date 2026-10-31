# Zero to Architect

### The Python → DSA → System Design Masterclass

> One book. Read it front to back and you go from never having written a line of code to solving interview-level algorithm problems and designing systems that serve millions of users.

> 🇮🇳 **Hinglish edition available:** the same book retold in Hinglish, with desi analogies, doubt-clearing boxes, English interview lines and memory tricks added to every chapter. Start at [hinglish/README.md](hinglish/README.md).
>
> 📖 **Read it as a website:** [Zero to Architect reader](https://claude.ai/artifact/XkCWmqf5irVUeYNz1N6qBG) (private to you). It has an English/Hinglish switch, search, progress tracking and runnable Python examples.

---

## How this book works

Every chapter follows the same shape, so your brain always knows where it is:

| Section | What it gives you |
|---|---|
| **The Big Idea** | The concept explained with a picture or story before any code. |
| **Building it up** | The topic from zero, one small step at a time, with runnable code and its output. |
| **Under the Hood** | What *really* happens inside Python / the machine. This is what makes knowledge stick. |
| **Pattern Decoder** | How to *recognise* when to use this idea: signal words, a template, and variations. |
| **Traps** | The mistakes almost everyone makes, so you don't. |
| **Tips & Tricks** | Shortcuts and habits strong engineers use. |
| **Interview Questions** | The questions that actually get asked, with full answers. 🔥 marks how often. |
| **Practice** | Graded exercises with hidden solutions. Try first, then peek. |
| **Never-Forget Summary** | A one-screen recap with memory hooks. Re-read these for revision. |

### How to read it

1. **Go in order.** Every chapter only uses ideas from earlier chapters.
2. **Type the code yourself.** Don't copy-paste. Run it, then change something and predict what happens.
3. **Do the practice before opening solutions.** Struggling for 15 minutes is where the learning happens.
4. **Revise with the summaries.** Re-read a chapter's *Never-Forget Summary* after 1, 3, 7 and 21 days (the schedule in [Chapter 05 of Part 4](part-4-interview-arsenal/05-roadmap-and-revision.md)). That spacing is how things move into long-term memory.
5. Follow the [12-week roadmap](part-4-interview-arsenal/05-roadmap-and-revision.md) if you want a schedule.

### Setup

Install Python 3.11+ from [python.org](https://www.python.org/downloads/) and [VS Code](https://code.visualstudio.com/) with the Python extension. Chapter 1 walks through it step by step.

Code blocks marked `python` are complete programs you can run as-is. Blocks marked `py` are fragments or show errors on purpose.

---

## Table of Contents

### Part 1 · Python from Scratch

| # | Chapter |
|---|---|
| 01 | [Getting Started: How Computers Run Your Code](part-1-python/01-getting-started.md) |
| 02 | [Variables, Data Types & Memory](part-1-python/02-variables-types-memory.md) |
| 03 | [Operators & Expressions](part-1-python/03-operators-expressions.md) |
| 04 | [Strings Deep Dive](part-1-python/04-strings.md) |
| 05 | [Conditionals & Truthiness](part-1-python/05-conditionals.md) |
| 06 | [Loops & Iteration](part-1-python/06-loops.md) |
| 07 | [Lists](part-1-python/07-lists.md) |
| 08 | [Tuples & Sets](part-1-python/08-tuples-sets.md) |
| 09 | [Dictionaries & Hashing](part-1-python/09-dictionaries.md) |
| 10 | [Functions](part-1-python/10-functions.md) |
| 11 | [Comprehensions & Functional Tools](part-1-python/11-comprehensions-functional.md) |
| 12 | [Recursion](part-1-python/12-recursion.md) |
| 13 | [Errors, Exceptions & Files](part-1-python/13-exceptions-files.md) |
| 14 | [OOP I: Classes & Objects](part-1-python/14-oop-classes-objects.md) |
| 15 | [OOP II: Inheritance, Polymorphism & Magic Methods](part-1-python/15-oop-inheritance-magic.md) |
| 16 | [Iterators, Generators, Decorators & Context Managers](part-1-python/16-iterators-generators-decorators.md) |
| 17 | [Modules, Packages & the Standard Library](part-1-python/17-modules-stdlib.md) |
| 18 | [Python Internals & Concurrency](part-1-python/18-internals-concurrency.md) |

### Part 2 · Data Structures & Algorithms

| # | Chapter |
|---|---|
| 01 | [Thinking in Algorithms & Big-O](part-2-dsa/01-big-o-complexity.md) |
| 02 | [Arrays & Strings Fundamentals](part-2-dsa/02-arrays-strings.md) |
| 03 | [Two Pointers](part-2-dsa/03-two-pointers.md) |
| 04 | [Sliding Window](part-2-dsa/04-sliding-window.md) |
| 05 | [Hashing Patterns](part-2-dsa/05-hashing.md) |
| 06 | [Prefix Sums & Difference Arrays](part-2-dsa/06-prefix-sums.md) |
| 07 | [Sorting Algorithms](part-2-dsa/07-sorting.md) |
| 08 | [Binary Search](part-2-dsa/08-binary-search.md) |
| 09 | [Recursion & Backtracking](part-2-dsa/09-backtracking.md) |
| 10 | [Linked Lists](part-2-dsa/10-linked-lists.md) |
| 11 | [Stacks & Monotonic Stacks](part-2-dsa/11-stacks.md) |
| 12 | [Queues, Deques & Monotonic Queues](part-2-dsa/12-queues-deques.md) |
| 13 | [Binary Trees](part-2-dsa/13-binary-trees.md) |
| 14 | [Binary Search Trees](part-2-dsa/14-binary-search-trees.md) |
| 15 | [Heaps & Priority Queues](part-2-dsa/15-heaps.md) |
| 16 | [Graphs I: BFS, DFS & Grids](part-2-dsa/16-graphs-bfs-dfs.md) |
| 17 | [Graphs II: Topological Sort, Shortest Paths & MST](part-2-dsa/17-graphs-advanced.md) |
| 18 | [Union-Find (Disjoint Set Union)](part-2-dsa/18-union-find.md) |
| 19 | [Tries](part-2-dsa/19-tries.md) |
| 20 | [Dynamic Programming I: The Framework & 1D DP](part-2-dsa/20-dp-1d.md) |
| 21 | [Dynamic Programming II: 2D, Knapsack, Strings & Beyond](part-2-dsa/21-dp-2d-advanced.md) |
| 22 | [Greedy Algorithms & Intervals](part-2-dsa/22-greedy-intervals.md) |
| 23 | [Bit Manipulation & Math](part-2-dsa/23-bits-math.md) |
| 24 | [Advanced: Segment Trees, Fenwick Trees & String Algorithms](part-2-dsa/24-advanced-structures.md) |

### Part 3 · System Design

| # | Chapter |
|---|---|
| 01 | [What System Design Is & How the Internet Works](part-3-system-design/01-foundations-internet.md) |
| 02 | [Scalability & Load Balancing](part-3-system-design/02-scalability-load-balancing.md) |
| 03 | [Databases: SQL, NoSQL, Indexes & Transactions](part-3-system-design/03-databases.md) |
| 04 | [Caching & CDNs](part-3-system-design/04-caching-cdn.md) |
| 05 | [Replication, Sharding & Consistent Hashing](part-3-system-design/05-replication-sharding.md) |
| 06 | [CAP, Consistency Models & Consensus](part-3-system-design/06-cap-consistency.md) |
| 07 | [APIs & Communication Protocols](part-3-system-design/07-apis-communication.md) |
| 08 | [Message Queues & Event-Driven Architecture](part-3-system-design/08-queues-events.md) |
| 09 | [Microservices, Reliability & Observability](part-3-system-design/09-microservices-reliability.md) |
| 10 | [Storage, Search & Unique IDs](part-3-system-design/10-storage-search-ids.md) |
| 11 | [Estimation & The Interview Framework](part-3-system-design/11-estimation-framework.md) |
| 12 | [Case Studies I: URL Shortener, Rate Limiter, Notifications, KV Store](part-3-system-design/12-case-studies-1.md) |
| 13 | [Case Studies II: Chat, News Feed, Video, Ride-Hailing, Crawler, Autocomplete](part-3-system-design/13-case-studies-2.md) |
| 14 | [Low-Level Design: SOLID, Patterns & Machine Coding](part-3-system-design/14-low-level-design.md) |

### Part 4 · Interview Arsenal

| # | Chapter |
|---|---|
| 01 | [Pattern Recognition Cheatsheet](part-4-interview-arsenal/01-pattern-recognition.md) |
| 02 | [Python Interview Questions](part-4-interview-arsenal/02-python-interview-questions.md) |
| 03 | [The Must-Do Problem List](part-4-interview-arsenal/03-must-do-problems.md) |
| 04 | [System Design Cheatsheet](part-4-interview-arsenal/04-system-design-cheatsheet.md) |
| 05 | [12-Week Roadmap & Revision System](part-4-interview-arsenal/05-roadmap-and-revision.md) |

---

*Learn one chapter at a time, and don't move on until the summary at the end makes sense to you.*
