# Zero to Architect

### The Python → DSA → System Design Masterclass

> Ek kitaab. Shuru se end tak padho, aur tum us jagah se, jahan tumne kabhi code ki ek line bhi nahi likhi, us jagah pahunchoge jahan tum interview-level algorithm problems solve karte ho aur aise systems design karte ho jo millions of users ko serve karte hain.

> 🇮🇳 **Ye "Zero to Architect" ka Hinglish edition hai.** Wahi poori kitaab, wahi code, wahi chapters, lekin samjhaaya gaya hai jaise ek senior bhaiya/didi chai pe samjhaate hain: Roman script mein Hindi, aur har technical term English mein (kyunki interview English mein hi hoga). Upar se har chapter mein desi analogies, "mann mein sawaal" wale doubt-clearing boxes, interview mein bolne layak English lines, aur yaad rakhne ke jugaad bhi jode gaye hain. English edition padhna hai? Yahan jao: [English edition](../README.md).
>
> 📖 **Website pe padho:** [Zero to Architect reader](https://claude.ai/artifact/XkCWmqf5irVUeYNz1N6qBG) (sirf tumhare liye private). Hinglish/English switch, search, progress tracking aur browser mein Run hone wale Python examples ke saath.

---

## How this book works · Ye kitaab kaise kaam karti hai

Har chapter ka shape ek jaisa hai, taaki tumhare dimaag ko hamesha pata rahe ki woh kahan hai:

| Section | Tumhe kya deta hai |
|---|---|
| **The Big Idea** · Asli Baat | Kisi bhi code se pehle, concept ek picture ya kahani se samjhaaya gaya. |
| **Building it up** · Zero Se Shuru | Topic zero se, ek ek chhota step, chalne wale code aur uske output ke saath. |
| **Under the Hood** · Andar Ki Kahani | Python / machine ke andar *asal mein* kya hota hai. Yahi cheez knowledge ko pakka karti hai. |
| **Pattern Decoder** · Pattern Pakdo | Kaise *pehchaano* ki ye idea kab use karna hai: signal words, ek template, aur variations. |
| **Traps** · Yahan Sab Phisalte Hain | Woh galtiyaan jo lagbhag sab karte hain, taaki tum na karo. |
| **Tips & Tricks** · Pro Wale Moves | Shortcuts aur aadatein jo strong engineers use karte hain. |
| **Interview Questions** · Interview Mein Yahi Poochenge | Woh sawaal jo sach mein poochhe jaate hain, poore answers ke saath. 🔥 batata hai kitni baar poochhe jaate hain. |
| **Practice** · Ab Tumhari Baari | Level-wise exercises, chhupe hue solutions ke saath. Pehle khud try karo, phir jhaanko. |
| **Never-Forget Summary** · Kabhi Mat Bhoolna | Ek screen ka recap, memory hooks ke saath. Revision ke liye inhe dobara padho. |

**Sirf Hinglish edition mein:** ye chaar markers har chapter mein milenge. Inhe pehchaan lo, ye is edition ki asli taaqat hain:

| Marker | Kya hai | Kaise use karo |
|---|---|---|
| 🇮🇳 **Desi Analogy** | Concept ko roz ki Indian zindagi se jodta hai: chai tapri, cricket, Mumbai local, IRCTC Tatkal, UPI, Swiggy, dabbawalas, shaadi ka buffet. Har analogy batati hai ki kaunsa hissa kis cheez se match karta hai. | Jab koi concept dry lage, analogy pe ruko. Picture dimaag mein bana lo; technical detail baad mein usi picture pe taang do. |
| 🤔 **Mann mein sawaal** | Woh doubt jo beginner ke dimaag mein theek us jagah aata hai (jaise "`left < right` ya `left <= right`?"), aur uske neeche ek saaf **Jawab**. | Jawab padhne se pehle 10 second khud socho. Agar tumhara bhi yahi sawaal tha, toh tum sahi raaste pe ho. |
| 🗣️ **Interview mein aise bolo** | 2–4 crisp English sentences jo tum interview mein zor se bol sakte ho: approach, key insight, complexity. | Tum Hinglish mein seekh rahe ho, lekin interview English mein hoga. In lines ko zor se bol ke practice karo, ratta mat maaro, apne shabdon mein dhaalo. |
| 🪝 **Yaad rakhne ka jugaad** | Never-Forget Summary mein ek Hinglish mnemonic, tukbandi ya chatpati picture, original memory hook ke saath. | Revision ke time sabse pehle yahi padho. Ek line yaad aayi, toh poora chapter peeche peeche aa jaata hai. |

### How to read it · Kaise padhein

1. **Order mein chalo.** Har chapter sirf pichhle chapters ke ideas use karta hai.
2. **Code khud type karo.** Copy-paste mat karo. Chalao, phir kuch badlo aur predict karo ki kya hoga.
3. **Solutions kholne se pehle practice karo.** 15 minute jhoojhna hi woh jagah hai jahan seekhna hota hai.
4. **Summaries se revise karo.** Kisi chapter ka *Never-Forget Summary* 1, 3, 7 aur 21 din baad dobara padho (poora schedule [Part 4 ke Chapter 05](part-4-interview-arsenal/05-roadmap-and-revision.md) mein hai). Yahi faasla cheezon ko long-term memory mein le jaata hai.
5. Agar schedule chahiye, toh [12-week roadmap](part-4-interview-arsenal/05-roadmap-and-revision.md) follow karo.

### Setup

[python.org](https://www.python.org/downloads/) se Python 3.11+ install karo, aur Python extension ke saath [VS Code](https://code.visualstudio.com/). Chapter 1 ye sab step by step karwata hai.

Jin code blocks pe `python` likha hai, woh poore programs hain jo jaise hain waise chal jaate hain. Jin pe `py` likha hai, woh tukde (fragments) hain ya jaan-boojh ke error dikhate hain.

Ek baat aur: code blocks dono editions mein ekdum same hain (sirf `#` comments Hinglish mein ho sakte hain). Toh output bhi same aayega, aur tum kabhi bhi English edition se milaan kar sakte ho.

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

*Ek baar mein ek chapter seekho, aur tab tak aage mat badho jab tak end wala summary tumhe poori tarah samajh na aa jaaye.*
