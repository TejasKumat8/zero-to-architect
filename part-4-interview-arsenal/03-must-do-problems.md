# Chapter 03 · The Must-Do Problem List

> There are over 3,000 problems on LeetCode. You don't need them. You need about 180 well-chosen ones, solved properly and **re-solved** until the patterns live in your fingers. This is that list, in the same order as Part 2, so every problem lands right after you learn its pattern.

**How to use this chapter:**
- Problems are grouped by pattern, in the order of the Part 2 chapters. Finish a chapter, then do its problems.
- ⭐ marks the **Core 75**: if you only have a few weeks, do these first. They cover every major pattern.
- Each row gives the **one-line key idea**. Don't read it before trying! Cover the column, attempt the problem, then check.
- "LC" is the LeetCode problem number. Search the name on LeetCode (or any judge) to practise it.
- 🟢 Easy · 🟡 Medium · 🔴 Hard (LeetCode's own labels). 🔒 = LeetCode Premium; free copies of these exist on LintCode and NeetCode.

**Before this:** the matching Part 2 chapter for each section. Keep the [Pattern Recognition Cheatsheet](01-pattern-recognition.md) open while you practise.

---

## 1. How to Solve One Problem (the 45-minute protocol)

Grinding without a method gives you a big number and a weak memory. Do this for **every** problem:

| Step | Time | What you do |
|---|---|---|
| 1. Read & restate | 2 min | Restate it, note the constraints, write one example and one edge case. |
| 2. Think | up to 15 min | Brute force first, then look for signals. Write the plan in comments. |
| 3. Code | up to 20 min | Type it yourself. No autocomplete tricks, no copy-paste. |
| 4. Test | 5 min | Dry-run your example and the edge cases *before* pressing Submit. |
| 5. Learn | 5–10 min | Read the best solutions even if yours passed. Write the key idea in your log. |

**Stuck after 20–25 minutes of honest effort?** Read the key idea in the table (only that), and try again for 10 minutes. Still stuck? Read a full solution, understand every line, close it, and **write it from scratch**. Mark the problem 🔁 in your log: it comes back on the review schedule below. Looking at a solution is not failure. Not re-solving it later is.

---

## 2. The List

### 02 · Arrays & Strings · [Chapter](../part-2-dsa/02-arrays-strings.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 1 | ⭐ Best Time to Buy and Sell Stock | 121 | 🟢 | Track the lowest price so far; profit = today − lowest. | O(n) · O(1) | [02](../part-2-dsa/02-arrays-strings.md) |
| 2 | ⭐ Maximum Subarray | 53 | 🟡 | Kadane: at each element, extend the current run or start fresh. | O(n) · O(1) | [02](../part-2-dsa/02-arrays-strings.md) |
| 3 | ⭐ Product of Array Except Self | 238 | 🟡 | Prefix products from the left × suffix products from the right, no division. | O(n) · O(1) extra | [02](../part-2-dsa/02-arrays-strings.md) |
| 4 | Rotate Image | 48 | 🟡 | Transpose the matrix, then reverse each row. | O(n²) · O(1) | [02](../part-2-dsa/02-arrays-strings.md) |
| 5 | Spiral Matrix | 54 | 🟡 | Keep four boundaries (top, bottom, left, right) and shrink after each side. | O(m·n) · O(1) extra | [02](../part-2-dsa/02-arrays-strings.md) |
| 6 | Set Matrix Zeroes | 73 | 🟡 | Use the first row and column as marker storage; handle them last. | O(m·n) · O(1) | [02](../part-2-dsa/02-arrays-strings.md) |
| 7 | Majority Element | 169 | 🟢 | Boyer–Moore voting: a candidate and a counter that cancels against others. | O(n) · O(1) | [02](../part-2-dsa/02-arrays-strings.md) |
| 8 | Next Permutation | 31 | 🟡 | Find the rightmost ascent, swap with the next-larger element to its right, reverse the suffix. | O(n) · O(1) | [02](../part-2-dsa/02-arrays-strings.md) |

### 03 · Two Pointers · [Chapter](../part-2-dsa/03-two-pointers.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 9 | ⭐ Valid Palindrome | 125 | 🟢 | Pointers from both ends, skipping non-alphanumeric characters. | O(n) · O(1) | [03](../part-2-dsa/03-two-pointers.md) |
| 10 | ⭐ Two Sum II – Input Array Is Sorted | 167 | 🟡 | Sum too big → move right in; too small → move left in. | O(n) · O(1) | [03](../part-2-dsa/03-two-pointers.md) |
| 11 | ⭐ 3Sum | 15 | 🟡 | Sort, fix one number, two-pointer the rest, skip duplicates. | O(n²) · O(1) extra | [03](../part-2-dsa/03-two-pointers.md) |
| 12 | ⭐ Container With Most Water | 11 | 🟡 | Start widest; always move the shorter line inward. | O(n) · O(1) | [03](../part-2-dsa/03-two-pointers.md) |
| 13 | ⭐ Trapping Rain Water | 42 | 🔴 | Process the side with the smaller wall; its water is decided by its own running max. | O(n) · O(1) | [03](../part-2-dsa/03-two-pointers.md) |
| 14 | Move Zeroes | 283 | 🟢 | Reader/writer: swap each non-zero into the write slot. | O(n) · O(1) | [03](../part-2-dsa/03-two-pointers.md) |
| 15 | Remove Duplicates from Sorted Array | 26 | 🟢 | Keep a value only if it differs from the last kept value. | O(n) · O(1) | [03](../part-2-dsa/03-two-pointers.md) |
| 16 | Sort Colors | 75 | 🟡 | Dutch national flag: low / mid / high regions; don't advance mid after swapping with high. | O(n) · O(1) | [03](../part-2-dsa/03-two-pointers.md) |
| 17 | Merge Sorted Array | 88 | 🟢 | Fill `nums1` from the back so nothing unread is overwritten. | O(m+n) · O(1) | [03](../part-2-dsa/03-two-pointers.md) |

### 04 · Sliding Window · [Chapter](../part-2-dsa/04-sliding-window.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 18 | ⭐ Longest Substring Without Repeating Characters | 3 | 🟡 | Window + last-seen index; jump `left` past the previous copy. | O(n) · O(min(n, alphabet)) | [04](../part-2-dsa/04-sliding-window.md) |
| 19 | ⭐ Longest Repeating Character Replacement | 424 | 🟡 | Window is valid while `length − max_freq ≤ k`. | O(n) · O(26) | [04](../part-2-dsa/04-sliding-window.md) |
| 20 | Permutation in String | 567 | 🟡 | Fixed window of `len(s1)`; compare letter counts as it slides. | O(n) · O(26) | [04](../part-2-dsa/04-sliding-window.md) |
| 21 | Find All Anagrams in a String | 438 | 🟡 | Same fixed window as above; record every matching start. | O(n) · O(26) | [04](../part-2-dsa/04-sliding-window.md) |
| 22 | ⭐ Minimum Window Substring | 76 | 🔴 | Expand until every needed char is covered, then shrink while still covered. | O(m+n) · O(alphabet) | [04](../part-2-dsa/04-sliding-window.md) |
| 23 | Minimum Size Subarray Sum | 209 | 🟡 | All positive: shrink while `sum ≥ target`, recording the length. | O(n) · O(1) | [04](../part-2-dsa/04-sliding-window.md) |
| 24 | Max Consecutive Ones III | 1004 | 🟡 | Longest window containing at most k zeros. | O(n) · O(1) | [04](../part-2-dsa/04-sliding-window.md) |

### 05 · Hashing · [Chapter](../part-2-dsa/05-hashing.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 25 | ⭐ Two Sum | 1 | 🟢 | Map value → index; check for `target − x` before inserting x. | O(n) · O(n) | [05](../part-2-dsa/05-hashing.md) |
| 26 | Contains Duplicate | 217 | 🟢 | Add to a set; seen already → duplicate. | O(n) · O(n) | [05](../part-2-dsa/05-hashing.md) |
| 27 | ⭐ Valid Anagram | 242 | 🟢 | Equal letter counts (`Counter` or an array of 26). | O(n) · O(1) | [05](../part-2-dsa/05-hashing.md) |
| 28 | ⭐ Group Anagrams | 49 | 🟡 | Key = sorted word (or a 26-count tuple) → list of words. | O(n·k log k) · O(n·k) | [05](../part-2-dsa/05-hashing.md) |
| 29 | ⭐ Longest Consecutive Sequence | 128 | 🟡 | Put all in a set; only start counting at x when x−1 is absent. | O(n) · O(n) | [05](../part-2-dsa/05-hashing.md) |
| 30 | Valid Sudoku | 36 | 🟡 | One set per row, column and 3×3 box (box id = `r//3*3 + c//3`). | O(81) · O(81) | [05](../part-2-dsa/05-hashing.md) |
| 31 | Encode and Decode Strings 🔒 | 271 | 🟡 | Length-prefix each string (`"5#hello"`) so any character is safe. | O(total) · O(total) | [05](../part-2-dsa/05-hashing.md) |
| 32 | Insert Delete GetRandom O(1) | 380 | 🟡 | List + value→index map; delete by swapping with the last element. | O(1) avg · O(n) | [05](../part-2-dsa/05-hashing.md) |

### 06 · Prefix Sums & Difference Arrays · [Chapter](../part-2-dsa/06-prefix-sums.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 33 | Range Sum Query – Immutable | 303 | 🟢 | `prefix[j+1] − prefix[i]`. | O(n) build, O(1) query · O(n) | [06](../part-2-dsa/06-prefix-sums.md) |
| 34 | ⭐ Subarray Sum Equals K | 560 | 🟡 | Count earlier prefixes equal to `prefix − k` with a hash map (seed `{0: 1}`). | O(n) · O(n) | [06](../part-2-dsa/06-prefix-sums.md) |
| 35 | Contiguous Array | 525 | 🟡 | Treat 0 as −1; longest gap between two equal prefix sums (store first index). | O(n) · O(n) | [06](../part-2-dsa/06-prefix-sums.md) |
| 36 | Continuous Subarray Sum | 523 | 🟡 | Equal `prefix % k` at least 2 apart means a multiple of k between them. | O(n) · O(min(n, k)) | [06](../part-2-dsa/06-prefix-sums.md) |
| 37 | Subarray Sums Divisible by K | 974 | 🟡 | Count pairs of equal `prefix % k` (Python's `%` is already non-negative). | O(n) · O(k) | [06](../part-2-dsa/06-prefix-sums.md) |
| 38 | Range Sum Query 2D – Immutable | 304 | 🟡 | 2D prefix with inclusion–exclusion of the four corners. | O(m·n) build, O(1) query · O(m·n) | [06](../part-2-dsa/06-prefix-sums.md) |
| 39 | Car Pooling | 1094 | 🟡 | Difference array: +p at pickup, −p at drop-off, then a running sum. | O(n + S) · O(S), S = last stop | [06](../part-2-dsa/06-prefix-sums.md) |

### 07 · Sorting · [Chapter](../part-2-dsa/07-sorting.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 40 | Sort an Array | 912 | 🟡 | Implement merge sort (or heap sort) without the built-in. | O(n log n) · O(n) | [07](../part-2-dsa/07-sorting.md) |
| 41 | Largest Number | 179 | 🟡 | Sort strings with the comparator "a before b if a+b > b+a". | O(n log n · k) · O(n·k) | [07](../part-2-dsa/07-sorting.md) |
| 42 | Sort Characters By Frequency | 451 | 🟡 | Count, then sort by count (or bucket by count). | O(n log n) · O(n) | [07](../part-2-dsa/07-sorting.md) |
| 43 | Count of Smaller Numbers After Self | 315 | 🔴 | During merge sort, count how many right-half elements jump ahead of each left element. | O(n log n) · O(n) | [07](../part-2-dsa/07-sorting.md) |

### 08 · Binary Search · [Chapter](../part-2-dsa/08-binary-search.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 44 | ⭐ Binary Search | 704 | 🟢 | Classic `lo ≤ hi` search, or lower bound then check. | O(log n) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 45 | Find First and Last Position of Element in Sorted Array | 34 | 🟡 | Lower bound of x and lower bound of x+1 (minus one). | O(log n) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 46 | ⭐ Search in Rotated Sorted Array | 33 | 🟡 | One half is always sorted; check if the target lies inside that half. | O(log n) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 47 | ⭐ Find Minimum in Rotated Sorted Array | 153 | 🟡 | Compare `mid` with the right end to know which side holds the drop. | O(log n) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 48 | Search a 2D Matrix | 74 | 🟡 | Treat it as one sorted array of m·n: `row, col = divmod(mid, n)`. | O(log(m·n)) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 49 | ⭐ Koko Eating Bananas | 875 | 🟡 | Binary search on speed; check total hours with ceiling division. | O(n log max) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 50 | Capacity To Ship Packages Within D Days | 1011 | 🟡 | Binary search capacity in `[max, sum]`; greedy day count as the check. | O(n log sum) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 51 | Find Peak Element | 162 | 🟡 | Move toward the higher neighbour; a peak must exist that way. | O(log n) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 52 | Time Based Key-Value Store | 981 | 🟡 | Per key, a list of (timestamp, value) in order; `bisect` for the latest ≤ t. | O(log n) get · O(n) | [08](../part-2-dsa/08-binary-search.md) |
| 53 | Split Array Largest Sum | 410 | 🔴 | Binary search the largest allowed sum; greedily count pieces. | O(n log sum) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 54 | ⭐ Median of Two Sorted Arrays | 4 | 🔴 | Binary search the cut in the shorter array so left halves ≤ right halves. | O(log min(m, n)) · O(1) | [08](../part-2-dsa/08-binary-search.md) |

### 09 · Recursion & Backtracking · [Chapter](../part-2-dsa/09-backtracking.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 55 | ⭐ Subsets | 78 | 🟡 | Choose / explore / un-choose with a `start` index; record every node. | O(n·2ⁿ) · O(n) | [09](../part-2-dsa/09-backtracking.md) |
| 56 | Subsets II | 90 | 🟡 | Sort; skip `nums[i] == nums[i−1]` when `i > start`. | O(n·2ⁿ) · O(n) | [09](../part-2-dsa/09-backtracking.md) |
| 57 | ⭐ Permutations | 46 | 🟡 | `used[]` array; record at depth n. | O(n·n!) · O(n) | [09](../part-2-dsa/09-backtracking.md) |
| 58 | ⭐ Combination Sum | 39 | 🟡 | Recurse with `i` (not `i+1`) to allow reuse; prune when the candidate exceeds what's left. | exponential · O(target / min) depth | [09](../part-2-dsa/09-backtracking.md) |
| 59 | Combination Sum II | 40 | 🟡 | Each number once (`i+1`), skip duplicate siblings after sorting. | O(n·2ⁿ) · O(n) | [09](../part-2-dsa/09-backtracking.md) |
| 60 | Letter Combinations of a Phone Number | 17 | 🟡 | One digit per level, branch over its letters. | O(4ⁿ·n) · O(n) | [09](../part-2-dsa/09-backtracking.md) |
| 61 | ⭐ Generate Parentheses | 22 | 🟡 | Add `(` while open < n; add `)` while close < open. | O(4ⁿ/√n) · O(n) | [09](../part-2-dsa/09-backtracking.md) |
| 62 | ⭐ Word Search | 79 | 🟡 | DFS from each cell; mark visited on the way in, unmark on the way out. | O(m·n·3ᴸ) · O(L) | [09](../part-2-dsa/09-backtracking.md) |
| 63 | Palindrome Partitioning | 131 | 🟡 | At each position, cut after every palindromic prefix and recurse. | O(n·2ⁿ) · O(n) | [09](../part-2-dsa/09-backtracking.md) |
| 64 | N-Queens | 51 | 🔴 | Place row by row; sets for columns, `r−c` and `r+c` diagonals. | O(n!) · O(n) | [09](../part-2-dsa/09-backtracking.md) |

### 10 · Linked Lists · [Chapter](../part-2-dsa/10-linked-lists.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 65 | ⭐ Reverse Linked List | 206 | 🟢 | `prev`, `cur`, `nxt`: flip one arrow at a time. | O(n) · O(1) | [10](../part-2-dsa/10-linked-lists.md) |
| 66 | ⭐ Merge Two Sorted Lists | 21 | 🟢 | Dummy head; attach the smaller node each step. | O(m+n) · O(1) | [10](../part-2-dsa/10-linked-lists.md) |
| 67 | ⭐ Linked List Cycle | 141 | 🟢 | Floyd: slow 1 step, fast 2 steps; they meet iff there's a cycle. | O(n) · O(1) | [10](../part-2-dsa/10-linked-lists.md) |
| 68 | Linked List Cycle II | 142 | 🟡 | After they meet, restart one pointer at head; move both 1 step to meet at the start. | O(n) · O(1) | [10](../part-2-dsa/10-linked-lists.md) |
| 69 | ⭐ Remove Nth Node From End of List | 19 | 🟡 | Dummy head; move fast n+1 ahead, then move both until fast is None. | O(n) · O(1) | [10](../part-2-dsa/10-linked-lists.md) |
| 70 | Reorder List | 143 | 🟡 | Find the middle, reverse the second half, merge alternately. | O(n) · O(1) | [10](../part-2-dsa/10-linked-lists.md) |
| 71 | Add Two Numbers | 2 | 🟡 | Digit-by-digit addition with a carry, using a dummy head. | O(max(m, n)) · O(1) extra | [10](../part-2-dsa/10-linked-lists.md) |
| 72 | Copy List with Random Pointer | 138 | 🟡 | Map old node → new node (or interleave copies, then split). | O(n) · O(n) | [10](../part-2-dsa/10-linked-lists.md) |
| 73 | ⭐ LRU Cache | 146 | 🟡 | Hash map + doubly linked list (move to front on use, evict the tail). | O(1) per op · O(capacity) | [10](../part-2-dsa/10-linked-lists.md) |
| 74 | Reverse Nodes in k-Group | 25 | 🔴 | Check k nodes exist, reverse them, reconnect, repeat. | O(n) · O(1) | [10](../part-2-dsa/10-linked-lists.md) |
| 75 | Find the Duplicate Number | 287 | 🟡 | Treat `i → nums[i]` as a linked list; Floyd finds the cycle entrance. | O(n) · O(1) | [10](../part-2-dsa/10-linked-lists.md) |

### 11 · Stacks & Monotonic Stacks · [Chapter](../part-2-dsa/11-stacks.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 76 | ⭐ Valid Parentheses | 20 | 🟢 | Push openers; a closer must match the top. Stack empty at the end. | O(n) · O(n) | [11](../part-2-dsa/11-stacks.md) |
| 77 | ⭐ Min Stack | 155 | 🟡 | Push `(value, min_so_far)` pairs. | O(1) per op · O(n) | [11](../part-2-dsa/11-stacks.md) |
| 78 | Evaluate Reverse Polish Notation | 150 | 🟡 | Operand stack; division truncates toward zero: `int(a / b)`. | O(n) · O(n) | [11](../part-2-dsa/11-stacks.md) |
| 79 | ⭐ Daily Temperatures | 739 | 🟡 | Decreasing stack of indexes; a warmer day pops and answers them. | O(n) · O(n) | [11](../part-2-dsa/11-stacks.md) |
| 80 | ⭐ Largest Rectangle in Histogram | 84 | 🔴 | Increasing stack; when a bar pops, its width runs from the new top to i. | O(n) · O(n) | [11](../part-2-dsa/11-stacks.md) |
| 81 | Car Fleet | 853 | 🟡 | Sort by position descending; a car that arrives no later than the fleet ahead joins it. | O(n log n) · O(n) | [11](../part-2-dsa/11-stacks.md) |
| 82 | Decode String | 394 | 🟡 | On `[` push (current string, count); on `]` pop and repeat. | O(output) · O(output) | [11](../part-2-dsa/11-stacks.md) |
| 83 | Asteroid Collision | 735 | 🟡 | Collide only when top moves right and the current moves left. | O(n) · O(n) | [11](../part-2-dsa/11-stacks.md) |
| 84 | Remove K Digits | 402 | 🟡 | Increasing stack; pop a bigger previous digit while k > 0. | O(n) · O(n) | [11](../part-2-dsa/11-stacks.md) |

### 12 · Queues, Deques & Monotonic Queues · [Chapter](../part-2-dsa/12-queues-deques.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 85 | Implement Queue using Stacks | 232 | 🟢 | In-stack and out-stack; pour in → out only when out is empty. | O(1) amortised · O(n) | [12](../part-2-dsa/12-queues-deques.md) |
| 86 | ⭐ Sliding Window Maximum | 239 | 🔴 | Deque of indexes with decreasing values; the front is the max. | O(n) · O(k) | [12](../part-2-dsa/12-queues-deques.md) |
| 87 | Shortest Subarray with Sum at Least K | 862 | 🔴 | Prefix sums + increasing deque (negatives break the plain window). | O(n) · O(n) | [12](../part-2-dsa/12-queues-deques.md) |
| 88 | Jump Game VI | 1696 | 🟡 | `dp[i] = nums[i] + max(dp[i−k..i−1])`, max kept by a monotonic deque. | O(n) · O(k) | [12](../part-2-dsa/12-queues-deques.md) |

### 13 · Binary Trees · [Chapter](../part-2-dsa/13-binary-trees.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 89 | ⭐ Maximum Depth of Binary Tree | 104 | 🟢 | `1 + max(depth(left), depth(right))`. | O(n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |
| 90 | ⭐ Invert Binary Tree | 226 | 🟢 | Swap the children, recurse on both. | O(n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |
| 91 | ⭐ Same Tree | 100 | 🟢 | Both None → True; values equal and both subtrees same. | O(n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |
| 92 | Subtree of Another Tree | 572 | 🟢 | Run "same tree" from every node of the big tree. | O(m·n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |
| 93 | ⭐ Diameter of Binary Tree | 543 | 🟢 | Return height; record `left + right` as a global best. | O(n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |
| 94 | Balanced Binary Tree | 110 | 🟢 | Return the height, or −1 as soon as any subtree is unbalanced. | O(n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |
| 95 | ⭐ Binary Tree Level Order Traversal | 102 | 🟡 | BFS; process `len(queue)` nodes per level. | O(n) · O(w) | [13](../part-2-dsa/13-binary-trees.md) |
| 96 | Binary Tree Right Side View | 199 | 🟡 | BFS; take the last node of each level. | O(n) · O(w) | [13](../part-2-dsa/13-binary-trees.md) |
| 97 | ⭐ Lowest Common Ancestor of a Binary Tree | 236 | 🟡 | Return the node if it's p or q; if both sides return non-null, this node is the LCA. | O(n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |
| 98 | ⭐ Construct Binary Tree from Preorder and Inorder Traversal | 105 | 🟡 | Preorder gives the root; its inorder index (from a map) splits left and right. | O(n) · O(n) | [13](../part-2-dsa/13-binary-trees.md) |
| 99 | ⭐ Binary Tree Maximum Path Sum | 124 | 🔴 | Return the best one-sided gain (≥ 0); record the two-sided sum through the node. | O(n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |
| 100 | Serialize and Deserialize Binary Tree | 297 | 🔴 | Preorder with null markers; rebuild with an iterator over the tokens. | O(n) · O(n) | [13](../part-2-dsa/13-binary-trees.md) |
| 101 | Path Sum III | 437 | 🟡 | Prefix sums along the root-to-node path + a count map (undo on the way back). | O(n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |

### 14 · Binary Search Trees · [Chapter](../part-2-dsa/14-binary-search-trees.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 102 | ⭐ Validate Binary Search Tree | 98 | 🟡 | Pass `(low, high)` bounds down; every node must be strictly inside. | O(n) · O(h) | [14](../part-2-dsa/14-binary-search-trees.md) |
| 103 | ⭐ Kth Smallest Element in a BST | 230 | 🟡 | In-order traversal is sorted; stop at the kth node. | O(h + k) · O(h) | [14](../part-2-dsa/14-binary-search-trees.md) |
| 104 | Lowest Common Ancestor of a Binary Search Tree | 235 | 🟡 | Both smaller → go left; both bigger → go right; otherwise this is it. | O(h) · O(1) | [14](../part-2-dsa/14-binary-search-trees.md) |
| 105 | Delete Node in a BST | 450 | 🟡 | Two children → copy the in-order successor's value, delete it from the right subtree. | O(h) · O(h) | [14](../part-2-dsa/14-binary-search-trees.md) |
| 106 | Binary Search Tree Iterator | 173 | 🟡 | A stack holding the left spine: in-order traversal paused between calls. | O(1) amortised · O(h) | [14](../part-2-dsa/14-binary-search-trees.md) |

### 15 · Heaps & Priority Queues · [Chapter](../part-2-dsa/15-heaps.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 107 | ⭐ Kth Largest Element in an Array | 215 | 🟡 | Min-heap of size k (or quickselect for O(n) average). | O(n log k) · O(k) | [15](../part-2-dsa/15-heaps.md) |
| 108 | ⭐ Top K Frequent Elements | 347 | 🟡 | Count, then a heap of size k (or bucket sort by frequency for O(n)). | O(n log k) · O(n) | [15](../part-2-dsa/15-heaps.md) |
| 109 | K Closest Points to Origin | 973 | 🟡 | Max-heap of size k on squared distance (no `sqrt` needed). | O(n log k) · O(k) | [15](../part-2-dsa/15-heaps.md) |
| 110 | ⭐ Merge k Sorted Lists | 23 | 🔴 | Min-heap of the k current heads; pop the smallest, push its next. | O(N log k) · O(k) | [15](../part-2-dsa/15-heaps.md) |
| 111 | ⭐ Find Median from Data Stream | 295 | 🔴 | Max-heap for the low half, min-heap for the high half, sizes within 1. | O(log n) add, O(1) median · O(n) | [15](../part-2-dsa/15-heaps.md) |
| 112 | Task Scheduler | 621 | 🟡 | Total slots (idle included) from the most frequent task: `(maxf − 1)·(n + 1) + count_of_maxf`, at least `len(tasks)`. | O(N) · O(26) | [15](../part-2-dsa/15-heaps.md) |
| 113 | Reorganize String | 767 | 🟡 | Max-heap: always place the most frequent char that differs from the previous one. | O(n log 26) · O(26) | [15](../part-2-dsa/15-heaps.md) |

### 16 · Graphs I: BFS, DFS & Grids · [Chapter](../part-2-dsa/16-graphs-bfs-dfs.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 114 | ⭐ Number of Islands | 200 | 🟡 | For each unvisited land cell: count it, then flood-fill (DFS/BFS) the whole island. | O(m·n) · O(m·n) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |
| 115 | Max Area of Island | 695 | 🟡 | Same flood fill, return the size. | O(m·n) · O(m·n) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |
| 116 | ⭐ Clone Graph | 133 | 🟡 | DFS/BFS with an old → new map, which also acts as the visited set. | O(V+E) · O(V) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |
| 117 | ⭐ Rotting Oranges | 994 | 🟡 | Multi-source BFS from all rotten oranges; count levels; check for leftovers. | O(m·n) · O(m·n) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |
| 118 | ⭐ Pacific Atlantic Water Flow | 417 | 🟡 | Reverse the flow: search uphill from each ocean's border, intersect the two sets. | O(m·n) · O(m·n) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |
| 119 | Surrounded Regions | 130 | 🟡 | Mark the `O`s connected to the border first; flip all the others. | O(m·n) · O(m·n) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |
| 120 | 01 Matrix | 542 | 🟡 | Multi-source BFS starting from every 0. | O(m·n) · O(m·n) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |
| 121 | Word Ladder | 127 | 🔴 | BFS over words; neighbours via wildcard patterns like `h*t`. | O(N·L²) · O(N·L²) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |
| 122 | Is Graph Bipartite? | 785 | 🟡 | Two-colour each component with BFS/DFS; a same-colour edge means no. | O(V+E) · O(V) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |

### 17 · Graphs II: Topological Sort, Shortest Paths & MST · [Chapter](../part-2-dsa/17-graphs-advanced.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 123 | ⭐ Course Schedule | 207 | 🟡 | Kahn's algorithm: possible iff every course gets processed (no cycle). | O(V+E) · O(V+E) | [17](../part-2-dsa/17-graphs-advanced.md) |
| 124 | ⭐ Course Schedule II | 210 | 🟡 | Same, but return the processing order. | O(V+E) · O(V+E) | [17](../part-2-dsa/17-graphs-advanced.md) |
| 125 | Alien Dictionary 🔒 | 269 | 🔴 | First differing letter of adjacent words gives an edge; topo sort. Prefix trap: "abc" before "ab" is invalid. | O(C) · O(1) for 26 letters, C = total chars | [17](../part-2-dsa/17-graphs-advanced.md) |
| 126 | ⭐ Network Delay Time | 743 | 🟡 | Dijkstra from k; answer = the largest distance (or −1). | O(E log V) · O(V+E) | [17](../part-2-dsa/17-graphs-advanced.md) |
| 127 | Cheapest Flights Within K Stops | 787 | 🟡 | Bellman-Ford for K+1 rounds, relaxing from a copy of last round's costs. | O(K·E) · O(V) | [17](../part-2-dsa/17-graphs-advanced.md) |
| 128 | Path With Minimum Effort | 1631 | 🟡 | Dijkstra where a path's cost is its maximum step, not the sum. | O(m·n·log(m·n)) · O(m·n) | [17](../part-2-dsa/17-graphs-advanced.md) |
| 129 | Min Cost to Connect All Points | 1584 | 🟡 | Prim's MST on the complete graph (O(n²) version, no heap needed). | O(n²) · O(n) | [17](../part-2-dsa/17-graphs-advanced.md) |
| 130 | Swim in Rising Water | 778 | 🔴 | Dijkstra on "max elevation seen so far" (or binary search + BFS). | O(n² log n) · O(n²) | [17](../part-2-dsa/17-graphs-advanced.md) |

### 18 · Union-Find · [Chapter](../part-2-dsa/18-union-find.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 131 | ⭐ Redundant Connection | 684 | 🟡 | The first edge whose endpoints are already connected is the answer. | O(n·α(n)) · O(n) | [18](../part-2-dsa/18-union-find.md) |
| 132 | Graph Valid Tree 🔒 | 261 | 🟡 | Exactly n−1 edges and no union fails (no cycle). | O(n·α(n)) · O(n) | [18](../part-2-dsa/18-union-find.md) |
| 133 | Number of Connected Components in an Undirected Graph 🔒 | 323 | 🟡 | Start with n components; each successful union subtracts one. | O(V + E·α(V)) · O(V) | [18](../part-2-dsa/18-union-find.md) |
| 134 | Accounts Merge | 721 | 🟡 | Union all emails of one account; group emails by root, sort each group. | O(N log N) · O(N) | [18](../part-2-dsa/18-union-find.md) |
| 135 | Most Stones Removed with Same Row or Column | 947 | 🟡 | Union each stone's row with its column; answer = stones − components. | O(n·α(n)) · O(n) | [18](../part-2-dsa/18-union-find.md) |

### 19 · Tries · [Chapter](../part-2-dsa/19-tries.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 136 | ⭐ Implement Trie (Prefix Tree) | 208 | 🟡 | Node = dict of children + `is_word` flag. | O(L) per op · O(total chars) | [19](../part-2-dsa/19-tries.md) |
| 137 | Design Add and Search Words Data Structure | 211 | 🟡 | Trie; on `.` try every child with DFS. | O(L) add; search up to O(26ᵈ·L) with d dots · O(total chars) | [19](../part-2-dsa/19-tries.md) |
| 138 | ⭐ Word Search II | 212 | 🔴 | Trie of all words + one grid DFS; prune trie nodes once their words are found. | O(m·n·4·3ᴸ⁻¹) · O(total chars) | [19](../part-2-dsa/19-tries.md) |
| 139 | Search Suggestions System | 1268 | 🟡 | Sort products; for each prefix, `bisect` and take up to 3 matches (or a trie storing top 3). | O((n + m)·L·log n) · O(n) | [19](../part-2-dsa/19-tries.md) |
| 140 | Maximum XOR of Two Numbers in an Array | 421 | 🟡 | Bitwise trie from the highest bit; greedily go to the opposite bit. | O(32·n) · O(32·n) | [19](../part-2-dsa/19-tries.md) |

### 20 · Dynamic Programming I: 1D · [Chapter](../part-2-dsa/20-dp-1d.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 141 | ⭐ Climbing Stairs | 70 | 🟢 | `ways[i] = ways[i−1] + ways[i−2]` (Fibonacci). | O(n) · O(1) | [20](../part-2-dsa/20-dp-1d.md) |
| 142 | ⭐ House Robber | 198 | 🟡 | `best[i] = max(best[i−1], best[i−2] + nums[i])`. | O(n) · O(1) | [20](../part-2-dsa/20-dp-1d.md) |
| 143 | House Robber II | 213 | 🟡 | Circle: run House Robber on `[0..n−2]` and `[1..n−1]`, take the max. | O(n) · O(1) | [20](../part-2-dsa/20-dp-1d.md) |
| 144 | Decode Ways | 91 | 🟡 | Add `dp[i−1]` if the last digit is 1–9, `dp[i−2]` if the last two are 10–26. | O(n) · O(1) | [20](../part-2-dsa/20-dp-1d.md) |
| 145 | ⭐ Coin Change | 322 | 🟡 | `dp[a] = 1 + min(dp[a − coin])` over coins (unbounded). | O(amount·coins) · O(amount) | [20](../part-2-dsa/20-dp-1d.md) |
| 146 | ⭐ Longest Increasing Subsequence | 300 | 🟡 | O(n²) DP, or "tails" array + `bisect_left` for O(n log n). | O(n log n) · O(n) | [20](../part-2-dsa/20-dp-1d.md) |
| 147 | ⭐ Word Break | 139 | 🟡 | `dp[i]` = prefix of length i can be split; try each dictionary word ending at i. | O(n·W·L) · O(n) | [20](../part-2-dsa/20-dp-1d.md) |
| 148 | Maximum Product Subarray | 152 | 🟡 | Track both the max and min product ending here (a negative flips them). | O(n) · O(1) | [20](../part-2-dsa/20-dp-1d.md) |
| 149 | Palindromic Substrings | 647 | 🟡 | Expand around all 2n−1 centres, counting palindromes. | O(n²) · O(1) | [20](../part-2-dsa/20-dp-1d.md) |
| 150 | ⭐ Longest Palindromic Substring | 5 | 🟡 | Expand around each centre (odd and even), keep the longest. | O(n²) · O(1) | [20](../part-2-dsa/20-dp-1d.md) |
| 151 | Combination Sum IV | 377 | 🟡 | Amount in the outer loop → counts ordered sequences. | O(target·n) · O(target) | [20](../part-2-dsa/20-dp-1d.md) |

### 21 · Dynamic Programming II: 2D, Knapsack & Strings · [Chapter](../part-2-dsa/21-dp-2d-advanced.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 152 | ⭐ Unique Paths | 62 | 🟡 | `dp[r][c] = dp[r−1][c] + dp[r][c−1]`; one rolling row is enough. | O(m·n) · O(n) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 153 | Minimum Path Sum | 64 | 🟡 | `grid[r][c] + min(top, left)`. | O(m·n) · O(n) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 154 | ⭐ Longest Common Subsequence | 1143 | 🟡 | Match → diagonal + 1; else max(top, left). | O(m·n) · O(min(m, n)) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 155 | ⭐ Edit Distance | 72 | 🟡 | Match → diagonal; else 1 + min(insert, delete, replace). | O(m·n) · O(n) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 156 | Partition Equal Subset Sum | 416 | 🟡 | 0/1 knapsack: can a subset reach `total / 2`? Loop capacity backwards. | O(n·sum) · O(sum) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 157 | Coin Change II | 518 | 🟡 | Coins in the outer loop → combinations, not orders. | O(n·amount) · O(amount) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 158 | Target Sum | 494 | 🟡 | Count subsets summing to `(total + target) / 2` (0/1 knapsack count). | O(n·sum) · O(sum) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 159 | Interleaving String | 97 | 🟡 | `dp[i][j]`: can `s1[:i]` and `s2[:j]` form `s3[:i+j]`? | O(m·n) · O(n) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 160 | Best Time to Buy and Sell Stock with Cooldown | 309 | 🟡 | State machine: hold / sold / rest, updated each day. | O(n) · O(1) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 161 | Maximal Square | 221 | 🟡 | `side = 1 + min(top, left, diagonal)` for each 1-cell. | O(m·n) · O(n) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 162 | Longest Increasing Path in a Matrix | 329 | 🔴 | DFS + memo; strictly increasing moves form a DAG, so no visited set needed. | O(m·n) · O(m·n) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 163 | Burst Balloons | 312 | 🔴 | Interval DP: choose the **last** balloon k to burst inside (i, j). | O(n³) · O(n²) | [21](../part-2-dsa/21-dp-2d-advanced.md) |

### 22 · Greedy Algorithms & Intervals · [Chapter](../part-2-dsa/22-greedy-intervals.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 164 | ⭐ Merge Intervals | 56 | 🟡 | Sort by start; extend the last interval while they overlap. | O(n log n) · O(n) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 165 | ⭐ Insert Interval | 57 | 🟡 | Copy the ones ending before; merge the overlapping ones; copy the rest. | O(n) · O(n) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 166 | ⭐ Non-overlapping Intervals | 435 | 🟡 | Sort by end; keep every interval that starts at or after the last kept end. | O(n log n) · O(1) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 167 | Meeting Rooms 🔒 | 252 | 🟢 | Sort by start; any overlap between neighbours → False. | O(n log n) · O(1) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 168 | Meeting Rooms II 🔒 | 253 | 🟡 | Min-heap of end times; reuse a room when the earliest end ≤ start. | O(n log n) · O(n) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 169 | Minimum Number of Arrows to Burst Balloons | 452 | 🟡 | Sort by end; shoot at an end, new arrow only when a balloon starts after it. | O(n log n) · O(1) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 170 | ⭐ Jump Game | 55 | 🟡 | Track the farthest reachable index; fail if i ever exceeds it. | O(n) · O(1) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 171 | Jump Game II | 45 | 🟡 | BFS-like levels: count a jump each time i passes the current reach. | O(n) · O(1) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 172 | Gas Station | 134 | 🟡 | If total gas ≥ total cost, an answer exists: restart after any negative tank. | O(n) · O(1) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 173 | Partition Labels | 763 | 🟡 | Record each char's last index; cut when i reaches the farthest last index. | O(n) · O(26) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 174 | Candy | 135 | 🔴 | Left-to-right pass, then right-to-left pass, take the max of both. | O(n) · O(n) | [22](../part-2-dsa/22-greedy-intervals.md) |

### 23 · Bit Manipulation & Math · [Chapter](../part-2-dsa/23-bits-math.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 175 | ⭐ Single Number | 136 | 🟢 | XOR everything; pairs cancel. | O(n) · O(1) | [23](../part-2-dsa/23-bits-math.md) |
| 176 | Number of 1 Bits | 191 | 🟢 | `x &= x − 1` removes one set bit per step. | O(set bits) · O(1) | [23](../part-2-dsa/23-bits-math.md) |
| 177 | Counting Bits | 338 | 🟢 | `bits[i] = bits[i >> 1] + (i & 1)`. | O(n) · O(n) | [23](../part-2-dsa/23-bits-math.md) |
| 178 | ⭐ Missing Number | 268 | 🟢 | XOR all indexes and values (or `n(n+1)/2 − sum`). | O(n) · O(1) | [23](../part-2-dsa/23-bits-math.md) |
| 179 | Sum of Two Integers | 371 | 🟡 | XOR = sum without carry, `(a & b) << 1` = carry; mask to 32 bits in Python. | O(32) · O(1) | [23](../part-2-dsa/23-bits-math.md) |
| 180 | Pow(x, n) | 50 | 🟡 | Exponentiation by squaring; handle negative n with 1/x. | O(log n) · O(1) | [23](../part-2-dsa/23-bits-math.md) |
| 181 | Count Primes | 204 | 🟡 | Sieve of Eratosthenes, starting each crossing-out at p². | O(n log log n) · O(n) | [23](../part-2-dsa/23-bits-math.md) |

### 24 · Advanced: Segment Trees, Fenwick Trees & String Algorithms · [Chapter](../part-2-dsa/24-advanced-structures.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 182 | Range Sum Query – Mutable | 307 | 🟡 | Fenwick tree or segment tree: point update + prefix/range query. | O(log n) per op · O(n) | [24](../part-2-dsa/24-advanced-structures.md) |
| 183 | Find the Index of the First Occurrence in a String | 28 | 🟢 | Built-in is fine; know KMP for a guaranteed O(n + m). | O(n + m) · O(m) | [24](../part-2-dsa/24-advanced-structures.md) |
| 184 | Shortest Palindrome | 214 | 🔴 | KMP prefix function on `s + "#" + reversed(s)` finds the longest palindromic prefix. | O(n) · O(n) | [24](../part-2-dsa/24-advanced-structures.md) |
| 185 | The Skyline Problem | 218 | 🔴 | Sweep the x-coordinates with a max-heap of active heights (lazy deletion). | O(n log n) · O(n) | [24](../part-2-dsa/24-advanced-structures.md) |

---

## 3. The Core 75 in Solving Order

Short on time? Do exactly these, in this order. It follows the Part 2 chapters, so each problem uses only patterns you've already learned. Numbers in brackets are the row numbers in the list above.

1. Best Time to Buy and Sell Stock 🟢 (LC 121) [#1]
2. Maximum Subarray 🟡 (LC 53) [#2]
3. Product of Array Except Self 🟡 (LC 238) [#3]
4. Valid Palindrome 🟢 (LC 125) [#9]
5. Two Sum II – Input Array Is Sorted 🟡 (LC 167) [#10]
6. 3Sum 🟡 (LC 15) [#11]
7. Container With Most Water 🟡 (LC 11) [#12]
8. Trapping Rain Water 🔴 (LC 42) [#13]
9. Longest Substring Without Repeating Characters 🟡 (LC 3) [#18]
10. Longest Repeating Character Replacement 🟡 (LC 424) [#19]
11. Minimum Window Substring 🔴 (LC 76) [#22]
12. Two Sum 🟢 (LC 1) [#25]
13. Valid Anagram 🟢 (LC 242) [#27]
14. Group Anagrams 🟡 (LC 49) [#28]
15. Longest Consecutive Sequence 🟡 (LC 128) [#29]
16. Subarray Sum Equals K 🟡 (LC 560) [#34]
17. Binary Search 🟢 (LC 704) [#44]
18. Search in Rotated Sorted Array 🟡 (LC 33) [#46]
19. Find Minimum in Rotated Sorted Array 🟡 (LC 153) [#47]
20. Koko Eating Bananas 🟡 (LC 875) [#49]
21. Median of Two Sorted Arrays 🔴 (LC 4) [#54]
22. Subsets 🟡 (LC 78) [#55]
23. Permutations 🟡 (LC 46) [#57]
24. Combination Sum 🟡 (LC 39) [#58]
25. Generate Parentheses 🟡 (LC 22) [#61]
26. Word Search 🟡 (LC 79) [#62]
27. Reverse Linked List 🟢 (LC 206) [#65]
28. Merge Two Sorted Lists 🟢 (LC 21) [#66]
29. Linked List Cycle 🟢 (LC 141) [#67]
30. Remove Nth Node From End of List 🟡 (LC 19) [#69]
31. LRU Cache 🟡 (LC 146) [#73]
32. Valid Parentheses 🟢 (LC 20) [#76]
33. Min Stack 🟡 (LC 155) [#77]
34. Daily Temperatures 🟡 (LC 739) [#79]
35. Largest Rectangle in Histogram 🔴 (LC 84) [#80]
36. Sliding Window Maximum 🔴 (LC 239) [#86]
37. Maximum Depth of Binary Tree 🟢 (LC 104) [#89]
38. Invert Binary Tree 🟢 (LC 226) [#90]
39. Same Tree 🟢 (LC 100) [#91]
40. Diameter of Binary Tree 🟢 (LC 543) [#93]
41. Binary Tree Level Order Traversal 🟡 (LC 102) [#95]
42. Lowest Common Ancestor of a Binary Tree 🟡 (LC 236) [#97]
43. Construct Binary Tree from Preorder and Inorder Traversal 🟡 (LC 105) [#98]
44. Binary Tree Maximum Path Sum 🔴 (LC 124) [#99]
45. Validate Binary Search Tree 🟡 (LC 98) [#102]
46. Kth Smallest Element in a BST 🟡 (LC 230) [#103]
47. Kth Largest Element in an Array 🟡 (LC 215) [#107]
48. Top K Frequent Elements 🟡 (LC 347) [#108]
49. Merge k Sorted Lists 🔴 (LC 23) [#110]
50. Find Median from Data Stream 🔴 (LC 295) [#111]
51. Number of Islands 🟡 (LC 200) [#114]
52. Clone Graph 🟡 (LC 133) [#116]
53. Rotting Oranges 🟡 (LC 994) [#117]
54. Pacific Atlantic Water Flow 🟡 (LC 417) [#118]
55. Course Schedule 🟡 (LC 207) [#123]
56. Course Schedule II 🟡 (LC 210) [#124]
57. Network Delay Time 🟡 (LC 743) [#126]
58. Redundant Connection 🟡 (LC 684) [#131]
59. Implement Trie (Prefix Tree) 🟡 (LC 208) [#136]
60. Word Search II 🔴 (LC 212) [#138]
61. Climbing Stairs 🟢 (LC 70) [#141]
62. House Robber 🟡 (LC 198) [#142]
63. Coin Change 🟡 (LC 322) [#145]
64. Longest Increasing Subsequence 🟡 (LC 300) [#146]
65. Word Break 🟡 (LC 139) [#147]
66. Longest Palindromic Substring 🟡 (LC 5) [#150]
67. Unique Paths 🟡 (LC 62) [#152]
68. Longest Common Subsequence 🟡 (LC 1143) [#154]
69. Edit Distance 🟡 (LC 72) [#155]
70. Merge Intervals 🟡 (LC 56) [#164]
71. Insert Interval 🟡 (LC 57) [#165]
72. Non-overlapping Intervals 🟡 (LC 435) [#166]
73. Jump Game 🟡 (LC 55) [#170]
74. Single Number 🟢 (LC 136) [#175]
75. Missing Number 🟢 (LC 268) [#178]

---

## 4. Suggested Order for the Whole List

You don't have to finish a section before moving on. A good rhythm:

| Phase | What to solve | Why |
|---|---|---|
| **Phase 1 · Learn** | The ⭐ problems of each chapter right after reading it | Patterns stick when you use them the same day. |
| **Phase 2 · Widen** | The non-⭐ 🟢 and 🟡 problems of each chapter | Variations train you to spot the pattern in disguise. |
| **Phase 3 · Mix** | 3 random problems a day from *different* chapters, without looking at the section name | In interviews nobody tells you the pattern. This is the skill that matters most. |
| **Phase 4 · Stretch** | The 🔴 problems | Hard problems are usually two patterns combined. Do them after the basics are automatic. |

> 💡 **Mixing is the secret.** Solving ten sliding-window problems in a row feels great but mostly trains "I know it's a sliding window because I'm in the sliding-window section". Phase 3 trains the real skill: recognising the pattern cold. To mix, pick row numbers at random (a dice app works), or ask a friend to pick for you.

**Rough difficulty mix to aim for:** about 25% Easy, 60% Medium, 15% Hard. Most real interview questions are Medium.

---

## 5. How to Review: Spaced Repetition

You will forget most problems within a week unless you **re-solve** them. Not re-read: re-solve, from a blank editor.

### The schedule

| When | What |
|---|---|
| **Day 0** | Solve it (or learn it from a solution). Write the key idea in one line in your log. |
| **Day 3** | Re-solve **from scratch**, timed. No peeking at your old code. |
| **Day 10** | Re-solve again. If it took under 15 minutes and was bug-free, mark it ✅ "owned". |
| **Day 30** | Quick re-solve, or just explain the approach out loud in 2 minutes for owned problems. |

If a re-solve fails, the clock resets: the problem goes back to "Day 3".

### The problem log (copy this table into a notebook or spreadsheet)

| # | Problem | Pattern | Key idea in my own words | Date solved | Needed help? | Day 3 | Day 10 | Day 30 |
|---|---|---|---|---|---|---|---|---|
| 11 | 3Sum | Two pointers | sort, fix i, squeeze the rest, skip dup values | 03-Jun | 🔁 yes | ✅ 06-Jun | ✅ 13-Jun | |
| 18 | Longest Substring Without Repeating Characters | Sliding window | last-seen map, jump left past repeat | 05-Jun | no | ✅ 08-Jun | | |

**Each day, start with reviews, then do new problems.** A typical day: 1–2 reviews (20–30 minutes) + 2–3 new problems.

### What to do when re-solving goes badly

- **Forgot the idea completely?** The key idea in your log was too vague. Rewrite it as a "because" sentence: "move the shorter line *because* the taller line can't improve the area."
- **Knew the idea, got stuck in code?** Re-type the template from [Pattern Recognition](01-pattern-recognition.md) for that pattern three times. Muscle memory is real.
- **Same bug every time** (off-by-one, forgetting the visited set)? Add it to a personal "my bugs" list and read the list before every session.

---

## 6. Never-Forget Summary

- About 180 problems, in Part 2 order. **⭐ Core 75 first.**
- One problem = **read, think (brute force → pattern), code, test, learn**. Max ~25 minutes stuck before taking a hint.
- **Re-solve on day 3, 10 and 30.** Failed re-solve → back to day 3.
- **Mix sections** once the basics are done: recognising the pattern cold is the actual interview skill.
- Keep a **log** with the key idea in your own words. That log becomes your revision notes.

**Memory hook: "SOLVE, RE-SOLVE, MIX"**: solve it once, re-solve it from scratch on a schedule, then mix it with everything else.

> **If you remember only one thing:** 100 problems re-solved three times beat 300 problems solved once.

---
**Next:** [Chapter 04 · System Design Cheatsheet](04-system-design-cheatsheet.md)  ·  **Back to** [Contents](../README.md)
