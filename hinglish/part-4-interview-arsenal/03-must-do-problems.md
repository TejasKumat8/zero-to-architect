# Chapter 03 · The Must-Do Problem List

> LeetCode pe 3,000 se zyada problems hain. Tumhe wo sab nahi chahiye. Tumhe chahiye lagbhag 180 soch-samajh ke chune hue problems, jo theek se solve kiye gaye hon aur tab tak **dobara solve** kiye gaye hon jab tak patterns tumhari ungliyon mein na bas jaayein. Ye wahi list hai, Part 2 ke order mein hi, taaki har problem tumhare saamne theek us waqt aaye jab tumne uska pattern abhi abhi seekha ho.

**Is chapter ko kaise use karo:**
- Problems pattern ke hisaab se group kiye gaye hain, Part 2 ke chapters ke order mein. Chapter khatam karo, phir uske problems karo.
- ⭐ ka matlab hai **Core 75**: agar tumhare paas bas kuch hafte hain, toh pehle ye karo. Ye har bade pattern ko cover karte hain.
- Har row mein **ek line ka key idea** hai. Try karne se pehle mat padhna! Column ko haath ya kaagaz se dhak do, problem try karo, phir check karo.
- "LC" LeetCode ka problem number hai. Naam LeetCode (ya kisi bhi judge) pe search karo aur practise karo.
- 🟢 Easy · 🟡 Medium · 🔴 Hard (LeetCode ke apne labels). 🔒 = LeetCode Premium; inki free copies LintCode aur NeetCode pe milti hain.

**Isse pehle padho:** har section ke liye uska matching Part 2 chapter. Practise karte waqt [Pattern Recognition Cheatsheet](01-pattern-recognition.md) khula rakho.

> 🇮🇳 **Desi Analogy:** Board exam ki taiyaari yaad karo. Topper bacche poori guide book ke 3,000 sawaal nahi karte. Wo pichhle 10 saal ke papers ke chune hue sawaal karte hain, aur unhe **baar baar** karte hain, jab tak haath khud chalne na lage. Jo baccha ek baar padh ke "haan aata hai" bol deta hai, wo exam hall mein atak jaata hai. Ye list tumhara "previous year papers ka chuna hua set" hai, aur neeche wala revision schedule tumhara "baar baar karna".

---

## 1. How to Solve One Problem (the 45-minute protocol) · Ek problem kaise solve karein

Bina tareeke ke grind karoge toh ginti badi ho jaayegi aur yaad kamzor rahegi. **Har** problem ke liye ye karo:

| Step | Time | Kya karna hai |
|---|---|---|
| 1. Read & restate | 2 min | Problem apne shabdon mein dobara bolo, constraints note karo, ek example aur ek edge case likho. |
| 2. Think | 15 min tak | Pehle brute force, phir signals dhoondho. Plan comments mein likho. |
| 3. Code | 20 min tak | Khud type karo. Koi autocomplete jugaad nahi, koi copy-paste nahi. |
| 4. Test | 5 min | Submit dabane se *pehle* apna example aur edge cases dry-run karo. |
| 5. Learn | 5–10 min | Tumhara pass ho gaya tab bhi best solutions padho. Key idea apne log mein likho. |

**Imaandaari se 20–25 minute koshish ke baad bhi atke ho?** Table mein key idea padho (sirf wahi), aur 10 minute phir try karo. Ab bhi atke? Poora solution padho, har line samjho, use band karo, aur **zero se khud likho**. Apne log mein problem ko 🔁 mark karo: wo neeche wale review schedule pe wapas aayegi. Solution dekhna failure nahi hai. Baad mein use dobara solve na karna failure hai.

> 🤔 **Mann mein sawaal:** 25 minute mein solution dekh liya toh kya main "cheat" nahi kar raha? Ghanton tak khud sochna zyada achha nahi?
>
> **Jawab:** Nahi. Ek problem pe 3 ghante phase rehne se tum ek pattern seekhte ho; un 3 ghanton mein 5 problems ka pattern seekh sakte the. Asli seekh solution dekhne se nahi, use **band karke zero se likhne** aur 3 din baad **dobara solve** karne se aati hai. 25 minute ka limit tumhe atakne se bachata hai; re-solve wala rule tumhe dhokha khaane se.

> 🗣️ **Interview mein aise bolo:** "Let me restate the problem and confirm the constraints first. The brute force would be to check every pair, which is O(n²). Since we need something faster, I'll look for a pattern: here a hash map lets me find the complement in O(1), so the whole thing becomes O(n) time and O(n) space. Let me code that and then dry-run it on the example and an edge case."

Interview mein bhi wahi 5 steps zor se bolte hue karo: restate → brute force → better pattern → code → dry-run. Interviewer ko tumhari *soch* sunni hai, sirf final code nahi.

---

## 2. The List · Poori List

### 02 · Arrays & Strings · [Chapter](../part-2-dsa/02-arrays-strings.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 1 | ⭐ Best Time to Buy and Sell Stock | 121 | 🟢 | Ab tak ka sabse kam price yaad rakho; profit = aaj ka price − sabse kam. | O(n) · O(1) | [02](../part-2-dsa/02-arrays-strings.md) |
| 2 | ⭐ Maximum Subarray | 53 | 🟡 | Kadane: har element pe ya toh current run ko aage badhao ya naye sire se shuru karo. | O(n) · O(1) | [02](../part-2-dsa/02-arrays-strings.md) |
| 3 | ⭐ Product of Array Except Self | 238 | 🟡 | Left se prefix products × right se suffix products, division ke bina. | O(n) · O(1) extra | [02](../part-2-dsa/02-arrays-strings.md) |
| 4 | Rotate Image | 48 | 🟡 | Matrix ko transpose karo, phir har row ko reverse karo. | O(n²) · O(1) | [02](../part-2-dsa/02-arrays-strings.md) |
| 5 | Spiral Matrix | 54 | 🟡 | Chaar boundaries rakho (top, bottom, left, right) aur har side ke baad unhe andar sikodo. | O(m·n) · O(1) extra | [02](../part-2-dsa/02-arrays-strings.md) |
| 6 | Set Matrix Zeroes | 73 | 🟡 | Pehli row aur pehle column ko marker storage ki tarah use karo; unhe sabse aakhir mein handle karo. | O(m·n) · O(1) | [02](../part-2-dsa/02-arrays-strings.md) |
| 7 | Majority Element | 169 | 🟢 | Boyer–Moore voting: ek candidate aur ek counter jo doosron se cancel hota rehta hai. | O(n) · O(1) | [02](../part-2-dsa/02-arrays-strings.md) |
| 8 | Next Permutation | 31 | 🟡 | Sabse right wali ascent dhoondho, use apne right mein usse bade agle element se swap karo, phir suffix reverse karo. | O(n) · O(1) | [02](../part-2-dsa/02-arrays-strings.md) |

### 03 · Two Pointers · [Chapter](../part-2-dsa/03-two-pointers.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 9 | ⭐ Valid Palindrome | 125 | 🟢 | Dono sire se pointers, non-alphanumeric characters ko skip karte hue. | O(n) · O(1) | [03](../part-2-dsa/03-two-pointers.md) |
| 10 | ⭐ Two Sum II – Input Array Is Sorted | 167 | 🟡 | Sum bahut bada → right ko andar laao; bahut chhota → left ko andar laao. | O(n) · O(1) | [03](../part-2-dsa/03-two-pointers.md) |
| 11 | ⭐ 3Sum | 15 | 🟡 | Sort karo, ek number fix karo, baaki pe two-pointer chalao, duplicates skip karo. | O(n²) · O(1) extra | [03](../part-2-dsa/03-two-pointers.md) |
| 12 | ⭐ Container With Most Water | 11 | 🟡 | Sabse chaude se shuru karo; hamesha chhoti line ko andar le jaao. | O(n) · O(1) | [03](../part-2-dsa/03-two-pointers.md) |
| 13 | ⭐ Trapping Rain Water | 42 | 🔴 | Jis taraf ki deewar chhoti hai, wo side process karo; uska paani uske apne running max se tay hota hai. | O(n) · O(1) | [03](../part-2-dsa/03-two-pointers.md) |
| 14 | Move Zeroes | 283 | 🟢 | Reader/writer: har non-zero ko write slot mein swap karo. | O(n) · O(1) | [03](../part-2-dsa/03-two-pointers.md) |
| 15 | Remove Duplicates from Sorted Array | 26 | 🟢 | Value tabhi rakho jab wo pichhli rakhi hui value se alag ho. | O(n) · O(1) | [03](../part-2-dsa/03-two-pointers.md) |
| 16 | Sort Colors | 75 | 🟡 | Dutch national flag: low / mid / high regions; high ke saath swap ke baad mid ko aage mat badhao. | O(n) · O(1) | [03](../part-2-dsa/03-two-pointers.md) |
| 17 | Merge Sorted Array | 88 | 🟢 | `nums1` ko peeche se bharo, taaki koi bina padha element overwrite na ho. | O(m+n) · O(1) | [03](../part-2-dsa/03-two-pointers.md) |

### 04 · Sliding Window · [Chapter](../part-2-dsa/04-sliding-window.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 18 | ⭐ Longest Substring Without Repeating Characters | 3 | 🟡 | Window + last-seen index; `left` ko pichhli copy ke aage kooda do. | O(n) · O(min(n, alphabet)) | [04](../part-2-dsa/04-sliding-window.md) |
| 19 | ⭐ Longest Repeating Character Replacement | 424 | 🟡 | Window tab tak valid hai jab tak `length − max_freq ≤ k`. | O(n) · O(26) | [04](../part-2-dsa/04-sliding-window.md) |
| 20 | Permutation in String | 567 | 🟡 | `len(s1)` ki fixed window; slide karte hue letter counts compare karo. | O(n) · O(26) | [04](../part-2-dsa/04-sliding-window.md) |
| 21 | Find All Anagrams in a String | 438 | 🟡 | Upar wali hi fixed window; har matching start ko record karo. | O(n) · O(26) | [04](../part-2-dsa/04-sliding-window.md) |
| 22 | ⭐ Minimum Window Substring | 76 | 🔴 | Tab tak phailao jab tak har zaroori char cover na ho jaaye, phir cover rehte hue sikodo. | O(m+n) · O(alphabet) | [04](../part-2-dsa/04-sliding-window.md) |
| 23 | Minimum Size Subarray Sum | 209 | 🟡 | Sab positive hain: jab tak `sum ≥ target` hai sikodo, aur length record karte raho. | O(n) · O(1) | [04](../part-2-dsa/04-sliding-window.md) |
| 24 | Max Consecutive Ones III | 1004 | 🟡 | Sabse lambi window jismein zyada se zyada k zeros hon. | O(n) · O(1) | [04](../part-2-dsa/04-sliding-window.md) |

### 05 · Hashing · [Chapter](../part-2-dsa/05-hashing.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 25 | ⭐ Two Sum | 1 | 🟢 | Map value → index; x ko daalne se *pehle* `target − x` check karo. | O(n) · O(n) | [05](../part-2-dsa/05-hashing.md) |
| 26 | Contains Duplicate | 217 | 🟢 | Set mein daalo; pehle se hai → duplicate. | O(n) · O(n) | [05](../part-2-dsa/05-hashing.md) |
| 27 | ⭐ Valid Anagram | 242 | 🟢 | Letter counts barabar (`Counter` ya 26 ka array). | O(n) · O(1) | [05](../part-2-dsa/05-hashing.md) |
| 28 | ⭐ Group Anagrams | 49 | 🟡 | Key = sorted word (ya 26-count tuple) → words ki list. | O(n·k log k) · O(n·k) | [05](../part-2-dsa/05-hashing.md) |
| 29 | ⭐ Longest Consecutive Sequence | 128 | 🟡 | Sab ko set mein daalo; x se ginti tabhi shuru karo jab x−1 set mein na ho. | O(n) · O(n) | [05](../part-2-dsa/05-hashing.md) |
| 30 | Valid Sudoku | 36 | 🟡 | Har row, column aur 3×3 box ka ek set (box id = `r//3*3 + c//3`). | O(81) · O(81) | [05](../part-2-dsa/05-hashing.md) |
| 31 | Encode and Decode Strings 🔒 | 271 | 🟡 | Har string ke aage uski length lagao (`"5#hello"`), taaki koi bhi character safe rahe. | O(total) · O(total) | [05](../part-2-dsa/05-hashing.md) |
| 32 | Insert Delete GetRandom O(1) | 380 | 🟡 | List + value→index map; delete ke liye element ko last element se swap karke pop karo. | O(1) avg · O(n) | [05](../part-2-dsa/05-hashing.md) |

### 06 · Prefix Sums & Difference Arrays · [Chapter](../part-2-dsa/06-prefix-sums.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 33 | Range Sum Query – Immutable | 303 | 🟢 | `prefix[j+1] − prefix[i]`. | O(n) build, O(1) query · O(n) | [06](../part-2-dsa/06-prefix-sums.md) |
| 34 | ⭐ Subarray Sum Equals K | 560 | 🟡 | Hash map se gino ki pehle kitne prefixes `prefix − k` ke barabar the (seed `{0: 1}`). | O(n) · O(n) | [06](../part-2-dsa/06-prefix-sums.md) |
| 35 | Contiguous Array | 525 | 🟡 | 0 ko −1 maano; do barabar prefix sums ke beech ka sabse lamba gap (pehla index store karo). | O(n) · O(n) | [06](../part-2-dsa/06-prefix-sums.md) |
| 36 | Continuous Subarray Sum | 523 | 🟡 | Kam se kam 2 door barabar `prefix % k` ka matlab beech mein k ka multiple hai. | O(n) · O(min(n, k)) | [06](../part-2-dsa/06-prefix-sums.md) |
| 37 | Subarray Sums Divisible by K | 974 | 🟡 | Barabar `prefix % k` ke pairs gino (Python ka `%` already non-negative deta hai). | O(n) · O(k) | [06](../part-2-dsa/06-prefix-sums.md) |
| 38 | Range Sum Query 2D – Immutable | 304 | 🟡 | 2D prefix, chaaron corners ke inclusion–exclusion ke saath. | O(m·n) build, O(1) query · O(m·n) | [06](../part-2-dsa/06-prefix-sums.md) |
| 39 | Car Pooling | 1094 | 🟡 | Difference array: pickup pe +p, drop-off pe −p, phir running sum. | O(n + S) · O(S), S = last stop | [06](../part-2-dsa/06-prefix-sums.md) |

### 07 · Sorting · [Chapter](../part-2-dsa/07-sorting.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 40 | Sort an Array | 912 | 🟡 | Built-in ke bina merge sort (ya heap sort) khud implement karo. | O(n log n) · O(n) | [07](../part-2-dsa/07-sorting.md) |
| 41 | Largest Number | 179 | 🟡 | Strings ko is comparator se sort karo: "a pehle b se, agar a+b > b+a". | O(n log n · k) · O(n·k) | [07](../part-2-dsa/07-sorting.md) |
| 42 | Sort Characters By Frequency | 451 | 🟡 | Gino, phir count se sort karo (ya count ke hisaab se buckets). | O(n log n) · O(n) | [07](../part-2-dsa/07-sorting.md) |
| 43 | Count of Smaller Numbers After Self | 315 | 🔴 | Merge sort ke dauraan gino ki right-half ke kitne elements har left element se aage kood gaye. | O(n log n) · O(n) | [07](../part-2-dsa/07-sorting.md) |

### 08 · Binary Search · [Chapter](../part-2-dsa/08-binary-search.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 44 | ⭐ Binary Search | 704 | 🟢 | Classic `lo ≤ hi` search, ya lower bound nikaal ke check. | O(log n) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 45 | Find First and Last Position of Element in Sorted Array | 34 | 🟡 | x ka lower bound, aur x+1 ka lower bound (minus one). | O(log n) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 46 | ⭐ Search in Rotated Sorted Array | 33 | 🟡 | Ek half hamesha sorted hota hai; check karo target us half ke andar aata hai ya nahi. | O(log n) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 47 | ⭐ Find Minimum in Rotated Sorted Array | 153 | 🟡 | `mid` ko right end se compare karo, pata chal jaayega drop kis side hai. | O(log n) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 48 | Search a 2D Matrix | 74 | 🟡 | Ise m·n ka ek sorted array samjho: `row, col = divmod(mid, n)`. | O(log(m·n)) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 49 | ⭐ Koko Eating Bananas | 875 | 🟡 | Speed pe binary search; ceiling division se total ghante check karo. | O(n log max) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 50 | Capacity To Ship Packages Within D Days | 1011 | 🟡 | `[max, sum]` mein capacity pe binary search; check ke liye greedy se din gino. | O(n log sum) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 51 | Find Peak Element | 162 | 🟡 | Bade padosi ki taraf chalo; us taraf peak hona hi hai. | O(log n) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 52 | Time Based Key-Value Store | 981 | 🟡 | Har key ke liye (timestamp, value) ki ordered list; latest ≤ t ke liye `bisect`. | O(log n) get · O(n) | [08](../part-2-dsa/08-binary-search.md) |
| 53 | Split Array Largest Sum | 410 | 🔴 | Sabse bade allowed sum pe binary search; greedy se tukde gino. | O(n log sum) · O(1) | [08](../part-2-dsa/08-binary-search.md) |
| 54 | ⭐ Median of Two Sorted Arrays | 4 | 🔴 | Chhote array mein cut pe binary search, taaki left halves ≤ right halves rahein. | O(log min(m, n)) · O(1) | [08](../part-2-dsa/08-binary-search.md) |

### 09 · Recursion & Backtracking · [Chapter](../part-2-dsa/09-backtracking.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 55 | ⭐ Subsets | 78 | 🟡 | `start` index ke saath choose / explore / un-choose; har node record karo. | O(n·2ⁿ) · O(n) | [09](../part-2-dsa/09-backtracking.md) |
| 56 | Subsets II | 90 | 🟡 | Sort karo; `i > start` ho toh `nums[i] == nums[i−1]` wale ko skip karo. | O(n·2ⁿ) · O(n) | [09](../part-2-dsa/09-backtracking.md) |
| 57 | ⭐ Permutations | 46 | 🟡 | `used[]` array; depth n pe record karo. | O(n·n!) · O(n) | [09](../part-2-dsa/09-backtracking.md) |
| 58 | ⭐ Combination Sum | 39 | 🟡 | Reuse allow karne ke liye `i` ke saath recurse karo (`i+1` nahi); candidate bache hue se bada ho toh prune. | exponential · O(target / min) depth | [09](../part-2-dsa/09-backtracking.md) |
| 59 | Combination Sum II | 40 | 🟡 | Har number ek baar (`i+1`), sort ke baad duplicate siblings skip karo. | O(n·2ⁿ) · O(n) | [09](../part-2-dsa/09-backtracking.md) |
| 60 | Letter Combinations of a Phone Number | 17 | 🟡 | Har level pe ek digit, uske letters pe branch karo. | O(4ⁿ·n) · O(n) | [09](../part-2-dsa/09-backtracking.md) |
| 61 | ⭐ Generate Parentheses | 22 | 🟡 | `(` lagao jab tak open < n; `)` lagao jab tak close < open. | O(4ⁿ/√n) · O(n) | [09](../part-2-dsa/09-backtracking.md) |
| 62 | ⭐ Word Search | 79 | 🟡 | Har cell se DFS; andar jaate waqt visited mark karo, bahar aate waqt unmark. | O(m·n·3ᴸ) · O(L) | [09](../part-2-dsa/09-backtracking.md) |
| 63 | Palindrome Partitioning | 131 | 🟡 | Har position pe, har palindromic prefix ke baad cut lagao aur recurse karo. | O(n·2ⁿ) · O(n) | [09](../part-2-dsa/09-backtracking.md) |
| 64 | N-Queens | 51 | 🔴 | Row by row rakho; columns, `r−c` aur `r+c` diagonals ke liye sets. | O(n!) · O(n) | [09](../part-2-dsa/09-backtracking.md) |

### 10 · Linked Lists · [Chapter](../part-2-dsa/10-linked-lists.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 65 | ⭐ Reverse Linked List | 206 | 🟢 | `prev`, `cur`, `nxt`: ek baar mein ek arrow palto. | O(n) · O(1) | [10](../part-2-dsa/10-linked-lists.md) |
| 66 | ⭐ Merge Two Sorted Lists | 21 | 🟢 | Dummy head; har step pe chhota node jodo. | O(m+n) · O(1) | [10](../part-2-dsa/10-linked-lists.md) |
| 67 | ⭐ Linked List Cycle | 141 | 🟢 | Floyd: slow 1 step, fast 2 steps; milte hain tabhi jab cycle ho. | O(n) · O(1) | [10](../part-2-dsa/10-linked-lists.md) |
| 68 | Linked List Cycle II | 142 | 🟡 | Milne ke baad ek pointer ko head pe wapas rakho; dono ko 1-1 step chalao, cycle ke start pe milenge. | O(n) · O(1) | [10](../part-2-dsa/10-linked-lists.md) |
| 69 | ⭐ Remove Nth Node From End of List | 19 | 🟡 | Dummy head; fast ko n+1 aage bhejo, phir dono ko chalao jab tak fast None na ho. | O(n) · O(1) | [10](../part-2-dsa/10-linked-lists.md) |
| 70 | Reorder List | 143 | 🟡 | Middle dhoondho, doosra half reverse karo, baari baari merge karo. | O(n) · O(1) | [10](../part-2-dsa/10-linked-lists.md) |
| 71 | Add Two Numbers | 2 | 🟡 | Carry ke saath digit-by-digit jod, dummy head use karke. | O(max(m, n)) · O(1) extra | [10](../part-2-dsa/10-linked-lists.md) |
| 72 | Copy List with Random Pointer | 138 | 🟡 | Old node → new node ka map (ya copies ko beech mein ghusaao, phir alag karo). | O(n) · O(n) | [10](../part-2-dsa/10-linked-lists.md) |
| 73 | ⭐ LRU Cache | 146 | 🟡 | Hash map + doubly linked list (use hone pe front pe le jaao, tail ko nikaalo). | O(1) per op · O(capacity) | [10](../part-2-dsa/10-linked-lists.md) |
| 74 | Reverse Nodes in k-Group | 25 | 🔴 | Check karo k nodes hain, unhe reverse karo, dobara jodo, repeat. | O(n) · O(1) | [10](../part-2-dsa/10-linked-lists.md) |
| 75 | Find the Duplicate Number | 287 | 🟡 | `i → nums[i]` ko linked list samjho; Floyd cycle ka entrance dhoondh leta hai. | O(n) · O(1) | [10](../part-2-dsa/10-linked-lists.md) |

### 11 · Stacks & Monotonic Stacks · [Chapter](../part-2-dsa/11-stacks.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 76 | ⭐ Valid Parentheses | 20 | 🟢 | Openers push karo; closer ko top se match karna hi chahiye. End mein stack khaali. | O(n) · O(n) | [11](../part-2-dsa/11-stacks.md) |
| 77 | ⭐ Min Stack | 155 | 🟡 | `(value, min_so_far)` ke pairs push karo. | O(1) per op · O(n) | [11](../part-2-dsa/11-stacks.md) |
| 78 | Evaluate Reverse Polish Notation | 150 | 🟡 | Operand stack; division zero ki taraf truncate hota hai: `int(a / b)`. | O(n) · O(n) | [11](../part-2-dsa/11-stacks.md) |
| 79 | ⭐ Daily Temperatures | 739 | 🟡 | Indexes ka decreasing stack; garam din aata hai toh unhe pop karke jawab de deta hai. | O(n) · O(n) | [11](../part-2-dsa/11-stacks.md) |
| 80 | ⭐ Largest Rectangle in Histogram | 84 | 🔴 | Increasing stack; jab bar pop hota hai, uski width naye top se i tak hoti hai. | O(n) · O(n) | [11](../part-2-dsa/11-stacks.md) |
| 81 | Car Fleet | 853 | 🟡 | Position ke hisaab se descending sort; jo car aage wale fleet se pehle ya saath pahunche, wo usi mein jud jaati hai. | O(n log n) · O(n) | [11](../part-2-dsa/11-stacks.md) |
| 82 | Decode String | 394 | 🟡 | `[` pe (current string, count) push karo; `]` pe pop karke repeat karo. | O(output) · O(output) | [11](../part-2-dsa/11-stacks.md) |
| 83 | Asteroid Collision | 735 | 🟡 | Takkar tabhi jab top right ja raha ho aur current left. | O(n) · O(n) | [11](../part-2-dsa/11-stacks.md) |
| 84 | Remove K Digits | 402 | 🟡 | Increasing stack; jab tak k > 0 hai, pichhla bada digit pop karo. | O(n) · O(n) | [11](../part-2-dsa/11-stacks.md) |

### 12 · Queues, Deques & Monotonic Queues · [Chapter](../part-2-dsa/12-queues-deques.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 85 | Implement Queue using Stacks | 232 | 🟢 | In-stack aur out-stack; in → out tabhi udelo jab out khaali ho. | O(1) amortised · O(n) | [12](../part-2-dsa/12-queues-deques.md) |
| 86 | ⭐ Sliding Window Maximum | 239 | 🔴 | Decreasing values wale indexes ka deque; front hi max hai. | O(n) · O(k) | [12](../part-2-dsa/12-queues-deques.md) |
| 87 | Shortest Subarray with Sum at Least K | 862 | 🔴 | Prefix sums + increasing deque (negatives plain window ko tod dete hain). | O(n) · O(n) | [12](../part-2-dsa/12-queues-deques.md) |
| 88 | Jump Game VI | 1696 | 🟡 | `dp[i] = nums[i] + max(dp[i−k..i−1])`, max ek monotonic deque se rakho. | O(n) · O(k) | [12](../part-2-dsa/12-queues-deques.md) |

### 13 · Binary Trees · [Chapter](../part-2-dsa/13-binary-trees.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 89 | ⭐ Maximum Depth of Binary Tree | 104 | 🟢 | `1 + max(depth(left), depth(right))`. | O(n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |
| 90 | ⭐ Invert Binary Tree | 226 | 🟢 | Children swap karo, dono pe recurse. | O(n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |
| 91 | ⭐ Same Tree | 100 | 🟢 | Dono None → True; values barabar aur dono subtrees same. | O(n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |
| 92 | Subtree of Another Tree | 572 | 🟢 | Bade tree ke har node se "same tree" chalao. | O(m·n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |
| 93 | ⭐ Diameter of Binary Tree | 543 | 🟢 | Height return karo; `left + right` ko global best mein record karo. | O(n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |
| 94 | Balanced Binary Tree | 110 | 🟢 | Height return karo, ya jaise hi koi subtree unbalanced mile, −1. | O(n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |
| 95 | ⭐ Binary Tree Level Order Traversal | 102 | 🟡 | BFS; har level pe `len(queue)` nodes process karo. | O(n) · O(w) | [13](../part-2-dsa/13-binary-trees.md) |
| 96 | Binary Tree Right Side View | 199 | 🟡 | BFS; har level ka aakhri node lo. | O(n) · O(w) | [13](../part-2-dsa/13-binary-trees.md) |
| 97 | ⭐ Lowest Common Ancestor of a Binary Tree | 236 | 🟡 | Node p ya q hai toh wahi return karo; dono sides non-null lautaayein toh yahi node LCA hai. | O(n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |
| 98 | ⭐ Construct Binary Tree from Preorder and Inorder Traversal | 105 | 🟡 | Preorder root deta hai; inorder mein uska index (map se) left aur right ko alag karta hai. | O(n) · O(n) | [13](../part-2-dsa/13-binary-trees.md) |
| 99 | ⭐ Binary Tree Maximum Path Sum | 124 | 🔴 | Best one-sided gain (≥ 0) return karo; node se guzarne wala two-sided sum record karo. | O(n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |
| 100 | Serialize and Deserialize Binary Tree | 297 | 🔴 | Null markers ke saath preorder; tokens pe iterator chala ke dobara banao. | O(n) · O(n) | [13](../part-2-dsa/13-binary-trees.md) |
| 101 | Path Sum III | 437 | 🟡 | Root-to-node path pe prefix sums + count map (wapas aate waqt undo karo). | O(n) · O(h) | [13](../part-2-dsa/13-binary-trees.md) |

### 14 · Binary Search Trees · [Chapter](../part-2-dsa/14-binary-search-trees.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 102 | ⭐ Validate Binary Search Tree | 98 | 🟡 | `(low, high)` bounds neeche bhejo; har node strictly unke andar honi chahiye. | O(n) · O(h) | [14](../part-2-dsa/14-binary-search-trees.md) |
| 103 | ⭐ Kth Smallest Element in a BST | 230 | 🟡 | In-order traversal sorted hota hai; kth node pe ruk jaao. | O(h + k) · O(h) | [14](../part-2-dsa/14-binary-search-trees.md) |
| 104 | Lowest Common Ancestor of a Binary Search Tree | 235 | 🟡 | Dono chhote → left jaao; dono bade → right jaao; warna yahi jawab hai. | O(h) · O(1) | [14](../part-2-dsa/14-binary-search-trees.md) |
| 105 | Delete Node in a BST | 450 | 🟡 | Do children → in-order successor ki value copy karo, phir use right subtree se delete karo. | O(h) · O(h) | [14](../part-2-dsa/14-binary-search-trees.md) |
| 106 | Binary Search Tree Iterator | 173 | 🟡 | Left spine rakhne wala stack: calls ke beech pause kiya hua in-order traversal. | O(1) amortised · O(h) | [14](../part-2-dsa/14-binary-search-trees.md) |

### 15 · Heaps & Priority Queues · [Chapter](../part-2-dsa/15-heaps.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 107 | ⭐ Kth Largest Element in an Array | 215 | 🟡 | Size k ka min-heap (ya O(n) average ke liye quickselect). | O(n log k) · O(k) | [15](../part-2-dsa/15-heaps.md) |
| 108 | ⭐ Top K Frequent Elements | 347 | 🟡 | Gino, phir size k ka heap (ya O(n) ke liye frequency se bucket sort). | O(n log k) · O(n) | [15](../part-2-dsa/15-heaps.md) |
| 109 | K Closest Points to Origin | 973 | 🟡 | Squared distance pe size k ka max-heap (`sqrt` ki zaroorat nahi). | O(n log k) · O(k) | [15](../part-2-dsa/15-heaps.md) |
| 110 | ⭐ Merge k Sorted Lists | 23 | 🔴 | k current heads ka min-heap; sabse chhota pop karo, uska next push karo. | O(N log k) · O(k) | [15](../part-2-dsa/15-heaps.md) |
| 111 | ⭐ Find Median from Data Stream | 295 | 🔴 | Neeche wale half ke liye max-heap, upar wale ke liye min-heap, sizes mein 1 se zyada farak nahi. | O(log n) add, O(1) median · O(n) | [15](../part-2-dsa/15-heaps.md) |
| 112 | Task Scheduler | 621 | 🟡 | Sabse frequent task se total slots (idle samet): `(maxf − 1)·(n + 1) + count_of_maxf`, kam se kam `len(tasks)`. | O(N) · O(26) | [15](../part-2-dsa/15-heaps.md) |
| 113 | Reorganize String | 767 | 🟡 | Max-heap: hamesha wo sabse frequent char rakho jo pichhle wale se alag ho. | O(n log 26) · O(26) | [15](../part-2-dsa/15-heaps.md) |

### 16 · Graphs I: BFS, DFS & Grids · [Chapter](../part-2-dsa/16-graphs-bfs-dfs.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 114 | ⭐ Number of Islands | 200 | 🟡 | Har unvisited land cell pe: use gino, phir poore island ko flood-fill (DFS/BFS) karo. | O(m·n) · O(m·n) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |
| 115 | Max Area of Island | 695 | 🟡 | Wahi flood fill, size return karo. | O(m·n) · O(m·n) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |
| 116 | ⭐ Clone Graph | 133 | 🟡 | Old → new map ke saath DFS/BFS; wahi map visited set ka kaam bhi karta hai. | O(V+E) · O(V) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |
| 117 | ⭐ Rotting Oranges | 994 | 🟡 | Saare rotten oranges se multi-source BFS; levels gino; bache hue fresh check karo. | O(m·n) · O(m·n) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |
| 118 | ⭐ Pacific Atlantic Water Flow | 417 | 🟡 | Flow ulta karo: har ocean ke border se upar ki taraf search karo, dono sets ka intersection. | O(m·n) · O(m·n) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |
| 119 | Surrounded Regions | 130 | 🟡 | Pehle border se jude `O`s mark karo; baaki sab flip kar do. | O(m·n) · O(m·n) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |
| 120 | 01 Matrix | 542 | 🟡 | Har 0 se shuru hone wala multi-source BFS. | O(m·n) · O(m·n) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |
| 121 | Word Ladder | 127 | 🔴 | Words pe BFS; neighbours `h*t` jaise wildcard patterns se. | O(N·L²) · O(N·L²) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |
| 122 | Is Graph Bipartite? | 785 | 🟡 | Har component ko BFS/DFS se do rang do; same rang wala edge matlab nahi. | O(V+E) · O(V) | [16](../part-2-dsa/16-graphs-bfs-dfs.md) |

### 17 · Graphs II: Topological Sort, Shortest Paths & MST · [Chapter](../part-2-dsa/17-graphs-advanced.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 123 | ⭐ Course Schedule | 207 | 🟡 | Kahn's algorithm: possible tabhi jab har course process ho jaaye (koi cycle nahi). | O(V+E) · O(V+E) | [17](../part-2-dsa/17-graphs-advanced.md) |
| 124 | ⭐ Course Schedule II | 210 | 🟡 | Wahi, bas processing order return karo. | O(V+E) · O(V+E) | [17](../part-2-dsa/17-graphs-advanced.md) |
| 125 | Alien Dictionary 🔒 | 269 | 🔴 | Paas paas ke words ka pehla alag letter ek edge deta hai; topo sort. Prefix trap: "abc" ka "ab" se pehle aana invalid hai. | O(C) · O(1) for 26 letters, C = total chars | [17](../part-2-dsa/17-graphs-advanced.md) |
| 126 | ⭐ Network Delay Time | 743 | 🟡 | k se Dijkstra; jawab = sabse badi distance (ya −1). | O(E log V) · O(V+E) | [17](../part-2-dsa/17-graphs-advanced.md) |
| 127 | Cheapest Flights Within K Stops | 787 | 🟡 | K+1 rounds ka Bellman-Ford, pichhle round ke costs ki copy se relax karte hue. | O(K·E) · O(V) | [17](../part-2-dsa/17-graphs-advanced.md) |
| 128 | Path With Minimum Effort | 1631 | 🟡 | Dijkstra jismein path ki cost uska maximum step hai, sum nahi. | O(m·n·log(m·n)) · O(m·n) | [17](../part-2-dsa/17-graphs-advanced.md) |
| 129 | Min Cost to Connect All Points | 1584 | 🟡 | Complete graph pe Prim's MST (O(n²) version, heap ki zaroorat nahi). | O(n²) · O(n) | [17](../part-2-dsa/17-graphs-advanced.md) |
| 130 | Swim in Rising Water | 778 | 🔴 | "Ab tak dekhi max elevation" pe Dijkstra (ya binary search + BFS). | O(n² log n) · O(n²) | [17](../part-2-dsa/17-graphs-advanced.md) |

### 18 · Union-Find · [Chapter](../part-2-dsa/18-union-find.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 131 | ⭐ Redundant Connection | 684 | 🟡 | Pehla edge jiske dono sire already connected hain, wahi jawab hai. | O(n·α(n)) · O(n) | [18](../part-2-dsa/18-union-find.md) |
| 132 | Graph Valid Tree 🔒 | 261 | 🟡 | Exactly n−1 edges aur koi union fail na ho (koi cycle nahi). | O(n·α(n)) · O(n) | [18](../part-2-dsa/18-union-find.md) |
| 133 | Number of Connected Components in an Undirected Graph 🔒 | 323 | 🟡 | n components se shuru karo; har successful union ek ghata deta hai. | O(V + E·α(V)) · O(V) | [18](../part-2-dsa/18-union-find.md) |
| 134 | Accounts Merge | 721 | 🟡 | Ek account ke saare emails ka union; root ke hisaab se emails group karo, har group sort karo. | O(N log N) · O(N) | [18](../part-2-dsa/18-union-find.md) |
| 135 | Most Stones Removed with Same Row or Column | 947 | 🟡 | Har stone ki row ko uske column se union karo; jawab = stones − components. | O(n·α(n)) · O(n) | [18](../part-2-dsa/18-union-find.md) |

### 19 · Tries · [Chapter](../part-2-dsa/19-tries.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 136 | ⭐ Implement Trie (Prefix Tree) | 208 | 🟡 | Node = children ka dict + `is_word` flag. | O(L) per op · O(total chars) | [19](../part-2-dsa/19-tries.md) |
| 137 | Design Add and Search Words Data Structure | 211 | 🟡 | Trie; `.` pe DFS se har child try karo. | O(L) add; search up to O(26ᵈ·L) with d dots · O(total chars) | [19](../part-2-dsa/19-tries.md) |
| 138 | ⭐ Word Search II | 212 | 🔴 | Saare words ka trie + ek grid DFS; words mil jaayein toh trie nodes prune karo. | O(m·n·4·3ᴸ⁻¹) · O(total chars) | [19](../part-2-dsa/19-tries.md) |
| 139 | Search Suggestions System | 1268 | 🟡 | Products sort karo; har prefix ke liye `bisect` karke 3 tak matches lo (ya top 3 rakhne wala trie). | O((n + m)·L·log n) · O(n) | [19](../part-2-dsa/19-tries.md) |
| 140 | Maximum XOR of Two Numbers in an Array | 421 | 🟡 | Sabse oonchi bit se bitwise trie; greedy se ulti bit ki taraf jaao. | O(32·n) · O(32·n) | [19](../part-2-dsa/19-tries.md) |

### 20 · Dynamic Programming I: 1D · [Chapter](../part-2-dsa/20-dp-1d.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 141 | ⭐ Climbing Stairs | 70 | 🟢 | `ways[i] = ways[i−1] + ways[i−2]` (Fibonacci). | O(n) · O(1) | [20](../part-2-dsa/20-dp-1d.md) |
| 142 | ⭐ House Robber | 198 | 🟡 | `best[i] = max(best[i−1], best[i−2] + nums[i])`. | O(n) · O(1) | [20](../part-2-dsa/20-dp-1d.md) |
| 143 | House Robber II | 213 | 🟡 | Circle: `[0..n−2]` aur `[1..n−1]` pe House Robber chalao, max lo. | O(n) · O(1) | [20](../part-2-dsa/20-dp-1d.md) |
| 144 | Decode Ways | 91 | 🟡 | Aakhri digit 1–9 ho toh `dp[i−1]` jodo, aakhri do 10–26 hon toh `dp[i−2]`. | O(n) · O(1) | [20](../part-2-dsa/20-dp-1d.md) |
| 145 | ⭐ Coin Change | 322 | 🟡 | Saare coins pe `dp[a] = 1 + min(dp[a − coin])` (unbounded). | O(amount·coins) · O(amount) | [20](../part-2-dsa/20-dp-1d.md) |
| 146 | ⭐ Longest Increasing Subsequence | 300 | 🟡 | O(n²) DP, ya O(n log n) ke liye "tails" array + `bisect_left`. | O(n log n) · O(n) | [20](../part-2-dsa/20-dp-1d.md) |
| 147 | ⭐ Word Break | 139 | 🟡 | `dp[i]` = length i ka prefix tod sakte hain; i pe khatam hone wala har dictionary word try karo. | O(n·W·L) · O(n) | [20](../part-2-dsa/20-dp-1d.md) |
| 148 | Maximum Product Subarray | 152 | 🟡 | Yahan khatam hone wala max aur min product dono track karo (negative unhe palat deta hai). | O(n) · O(1) | [20](../part-2-dsa/20-dp-1d.md) |
| 149 | Palindromic Substrings | 647 | 🟡 | Saare 2n−1 centres ke around phailao, palindromes gino. | O(n²) · O(1) | [20](../part-2-dsa/20-dp-1d.md) |
| 150 | ⭐ Longest Palindromic Substring | 5 | 🟡 | Har centre ke around phailao (odd aur even), sabse lamba rakho. | O(n²) · O(1) | [20](../part-2-dsa/20-dp-1d.md) |
| 151 | Combination Sum IV | 377 | 🟡 | Amount bahar wale loop mein → ordered sequences ginta hai. | O(target·n) · O(target) | [20](../part-2-dsa/20-dp-1d.md) |

### 21 · Dynamic Programming II: 2D, Knapsack & Strings · [Chapter](../part-2-dsa/21-dp-2d-advanced.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 152 | ⭐ Unique Paths | 62 | 🟡 | `dp[r][c] = dp[r−1][c] + dp[r][c−1]`; ek rolling row kaafi hai. | O(m·n) · O(n) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 153 | Minimum Path Sum | 64 | 🟡 | `grid[r][c] + min(top, left)`. | O(m·n) · O(n) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 154 | ⭐ Longest Common Subsequence | 1143 | 🟡 | Match → diagonal + 1; warna max(top, left). | O(m·n) · O(min(m, n)) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 155 | ⭐ Edit Distance | 72 | 🟡 | Match → diagonal; warna 1 + min(insert, delete, replace). | O(m·n) · O(n) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 156 | Partition Equal Subset Sum | 416 | 🟡 | 0/1 knapsack: kya koi subset `total / 2` tak pahunch sakta hai? Capacity ka loop ulta chalao. | O(n·sum) · O(sum) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 157 | Coin Change II | 518 | 🟡 | Coins bahar wale loop mein → combinations, orders nahi. | O(n·amount) · O(amount) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 158 | Target Sum | 494 | 🟡 | `(total + target) / 2` tak jodne wale subsets gino (0/1 knapsack count). | O(n·sum) · O(sum) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 159 | Interleaving String | 97 | 🟡 | `dp[i][j]`: kya `s1[:i]` aur `s2[:j]` milke `s3[:i+j]` bana sakte hain? | O(m·n) · O(n) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 160 | Best Time to Buy and Sell Stock with Cooldown | 309 | 🟡 | State machine: hold / sold / rest, har din update. | O(n) · O(1) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 161 | Maximal Square | 221 | 🟡 | Har 1-cell ke liye `side = 1 + min(top, left, diagonal)`. | O(m·n) · O(n) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 162 | Longest Increasing Path in a Matrix | 329 | 🔴 | DFS + memo; strictly increasing moves ek DAG banaate hain, toh visited set ki zaroorat nahi. | O(m·n) · O(m·n) | [21](../part-2-dsa/21-dp-2d-advanced.md) |
| 163 | Burst Balloons | 312 | 🔴 | Interval DP: (i, j) ke andar **aakhri** phootne wala balloon k chuno. | O(n³) · O(n²) | [21](../part-2-dsa/21-dp-2d-advanced.md) |

### 22 · Greedy Algorithms & Intervals · [Chapter](../part-2-dsa/22-greedy-intervals.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 164 | ⭐ Merge Intervals | 56 | 🟡 | Start se sort karo; jab tak overlap ho, aakhri interval ko badhaate jaao. | O(n log n) · O(n) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 165 | ⭐ Insert Interval | 57 | 🟡 | Pehle khatam hone wale copy karo; overlap wale merge karo; baaki copy karo. | O(n) · O(n) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 166 | ⭐ Non-overlapping Intervals | 435 | 🟡 | End se sort karo; har wo interval rakho jo aakhri rakhe hue end pe ya uske baad shuru ho. | O(n log n) · O(1) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 167 | Meeting Rooms 🔒 | 252 | 🟢 | Start se sort karo; padosiyon mein koi bhi overlap → False. | O(n log n) · O(1) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 168 | Meeting Rooms II 🔒 | 253 | 🟡 | End times ka min-heap; jab sabse pehla end ≤ start ho, room dobara use karo. | O(n log n) · O(n) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 169 | Minimum Number of Arrows to Burst Balloons | 452 | 🟡 | End se sort karo; ek end pe teer chalao, naya teer tabhi jab koi balloon uske baad shuru ho. | O(n log n) · O(1) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 170 | ⭐ Jump Game | 55 | 🟡 | Sabse door pahunchne layak index track karo; agar i kabhi usse aage nikle toh fail. | O(n) · O(1) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 171 | Jump Game II | 45 | 🟡 | BFS jaise levels: jab bhi i current reach ko paar kare, ek jump gino. | O(n) · O(1) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 172 | Gas Station | 134 | 🟡 | Agar total gas ≥ total cost, toh jawab hai: tank negative hote hi agle station se dobara shuru karo. | O(n) · O(1) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 173 | Partition Labels | 763 | 🟡 | Har char ka last index record karo; jab i sabse door wale last index tak pahunche, cut lagao. | O(n) · O(26) | [22](../part-2-dsa/22-greedy-intervals.md) |
| 174 | Candy | 135 | 🔴 | Left-to-right ek pass, phir right-to-left ek pass, dono ka max lo. | O(n) · O(n) | [22](../part-2-dsa/22-greedy-intervals.md) |

### 23 · Bit Manipulation & Math · [Chapter](../part-2-dsa/23-bits-math.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 175 | ⭐ Single Number | 136 | 🟢 | Sabka XOR karo; pairs cancel ho jaate hain. | O(n) · O(1) | [23](../part-2-dsa/23-bits-math.md) |
| 176 | Number of 1 Bits | 191 | 🟢 | `x &= x − 1` har step mein ek set bit hata deta hai. | O(set bits) · O(1) | [23](../part-2-dsa/23-bits-math.md) |
| 177 | Counting Bits | 338 | 🟢 | `bits[i] = bits[i >> 1] + (i & 1)`. | O(n) · O(n) | [23](../part-2-dsa/23-bits-math.md) |
| 178 | ⭐ Missing Number | 268 | 🟢 | Saare indexes aur values ka XOR (ya `n(n+1)/2 − sum`). | O(n) · O(1) | [23](../part-2-dsa/23-bits-math.md) |
| 179 | Sum of Two Integers | 371 | 🟡 | XOR = carry ke bina sum, `(a & b) << 1` = carry; Python mein 32 bits pe mask karo. | O(32) · O(1) | [23](../part-2-dsa/23-bits-math.md) |
| 180 | Pow(x, n) | 50 | 🟡 | Exponentiation by squaring; negative n ko 1/x se handle karo. | O(log n) · O(1) | [23](../part-2-dsa/23-bits-math.md) |
| 181 | Count Primes | 204 | 🟡 | Sieve of Eratosthenes, har kaatna p² se shuru karke. | O(n log log n) · O(n) | [23](../part-2-dsa/23-bits-math.md) |

### 24 · Advanced: Segment Trees, Fenwick Trees & String Algorithms · [Chapter](../part-2-dsa/24-advanced-structures.md)

| # | Problem | LC | Level | Key idea | Time · Space | Ch |
|---|---|---|---|---|---|---|
| 182 | Range Sum Query – Mutable | 307 | 🟡 | Fenwick tree ya segment tree: point update + prefix/range query. | O(log n) per op · O(n) | [24](../part-2-dsa/24-advanced-structures.md) |
| 183 | Find the Index of the First Occurrence in a String | 28 | 🟢 | Built-in chalta hai; guaranteed O(n + m) ke liye KMP aana chahiye. | O(n + m) · O(m) | [24](../part-2-dsa/24-advanced-structures.md) |
| 184 | Shortest Palindrome | 214 | 🔴 | `s + "#" + reversed(s)` pe KMP prefix function sabse lamba palindromic prefix dhoondh leta hai. | O(n) · O(n) | [24](../part-2-dsa/24-advanced-structures.md) |
| 185 | The Skyline Problem | 218 | 🔴 | Active heights ke max-heap (lazy deletion) ke saath x-coordinates pe sweep karo. | O(n log n) · O(n) | [24](../part-2-dsa/24-advanced-structures.md) |

> 🤔 **Mann mein sawaal:** Key idea padh ke toh sab samajh aa jaata hai. Phir problem try karne ki kya zaroorat?
>
> **Jawab:** Yahi sabse bada jaal hai. "Padh ke samajh aana" aur "khaali screen pe khud nikaal paana" do alag skills hain. Cricket highlights dekh ke cover drive samajh aata hai, lekin net mein bowler ke saamne bat chalaoge tabhi aayega. Key idea column ek **answer key** hai, textbook nahi. Pehle khud try, phir check.

Teen classics jo interview mein baar baar aate hain, unke liye ready lines:

> 🗣️ **Interview mein aise bolo (Two Sum, LC 1):** "I'll scan the array once and keep a hash map from value to index. For each number x, I first check whether target minus x is already in the map; if it is, I've found the pair, otherwise I store x. That's O(n) time and O(n) space, versus O(n²) for checking every pair."

> 🗣️ **Interview mein aise bolo (LRU Cache, LC 146):** "I'll combine a hash map with a doubly linked list. The map gives O(1) access from key to node, and the list keeps nodes in recency order, so on every get or put I move the node to the front and, when over capacity, evict the node at the tail. Every operation is O(1)."

> 🗣️ **Interview mein aise bolo (Trapping Rain Water, LC 42):** "Water above each bar is the minimum of the tallest wall on its left and on its right, minus its height. With two pointers I always process the side with the smaller max wall, because that side's water is already fully determined by its own running max. That gives O(n) time and O(1) space."

---

## 3. The Core 75 in Solving Order · Core 75, isi order mein

Time kam hai? Bilkul yahi karo, isi order mein. Ye Part 2 ke chapters ko follow karta hai, toh har problem sirf wahi patterns use karta hai jo tum already seekh chuke ho. Brackets wale numbers upar wali list ke row numbers hain.

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

## 4. Suggested Order for the Whole List · Poori list kis order mein karein

Agle section pe jaane se pehle pichhla poora khatam karna zaroori nahi. Ek achhi rhythm:

| Phase | Kya solve karna hai | Kyun |
|---|---|---|
| **Phase 1 · Learn** | Har chapter padhne ke turant baad uske ⭐ problems | Pattern usi din use karo toh dimaag mein chipak jaata hai. |
| **Phase 2 · Widen** | Har chapter ke bina-⭐ wale 🟢 aur 🟡 problems | Variations tumhe bhes badal ke aaye pattern ko pehchaanna sikhaate hain. |
| **Phase 3 · Mix** | Roz *alag alag* chapters se 3 random problems, section ka naam dekhe bina | Interview mein koi tumhe pattern nahi batata. Sabse zyada maayne yahi skill rakhti hai. |
| **Phase 4 · Stretch** | 🔴 problems | Hard problems aam taur pe do patterns ka combination hote hain. Basics automatic ho jaayein, tab inhe karo. |

> 💡 **Mixing hi asli secret hai.** Lagaatar das sliding-window problems solve karna achha lagta hai, lekin zyadatar ye sikhaata hai "mujhe pata hai ye sliding window hai kyunki main sliding-window section mein hoon". Phase 3 asli skill sikhaata hai: bina kisi hint ke pattern pehchaanna. Mix karne ke liye random row numbers chuno (dice app chalega), ya kisi dost se chunwao.

> 🇮🇳 **Desi Analogy:** Cricket ki net practice socho. Agar bowling machine sirf off-stump ke bahar wali ball daale, toh tum 50 cover drives maar ke khush ho jaoge. Lekin match mein bowler pehle se nahi batata ki agli ball bouncer hai, yorker hai ya googly. Asli batsman wo hai jo ball haath se chhootte hi pehchaan le. Section-wise practice = bowling machine. **Phase 3 ka mix** = asli match. Interviewer bowler hai, aur wo kabhi nahi bolega "ye two pointers ki ball hai".

**Roughly kitna difficulty mix rakhna hai:** lagbhag 25% Easy, 60% Medium, 15% Hard. Zyadatar asli interview questions Medium hote hain.

> 🤔 **Mann mein sawaal:** Hard problems itne kam (15%) kyun? Hard karenge toh Medium apne aap aa jaayenge na?
>
> **Jawab:** Ulta hota hai. Hard problem aam taur pe do Medium patterns ka jod hota hai. Agar dono patterns pakke nahi hain, toh Hard pe ghante barbaad honge aur kuch seekhoge nahi. Aur interview ka 70-80% Medium hi hota hai. Pehle Medium pe "bina soche haath chale" wali halat lao, phir Hard pe jaao.

---

## 5. How to Review: Spaced Repetition · Revision ka sahi tareeka

Agar tum problems ko **dobara solve** nahi karoge, toh ek hafte mein zyadatar bhool jaoge. Dobara padhna nahi: dobara solve karna, khaali editor se.

> 🇮🇳 **Desi Analogy:** Bachpan ke **pahaade** (multiplication tables) yaad karo. Teacher ne ek din 17 ka pahaada padhaaya, aur agar tumne kabhi dohraaya nahi toh ek hafte mein gaayab. Lekin jo pahaade tumne 3 din baad, phir 10 din baad, phir mahine baad bole, wo aaj bhi neend mein bhi bol doge. Dimaag ko jab baar baar, badhte gaps pe, kisi cheez ko *nikaalna* padta hai, tab wo use pakka kar leta hai. Yahi **spaced repetition** hai.

### The schedule · Schedule

| Kab | Kya |
|---|---|
| **Day 0** | Solve karo (ya solution se seekho). Key idea ek line mein apne log mein likho. |
| **Day 3** | **Zero se** dobara solve karo, timer laga ke. Purana code mat jhaankna. |
| **Day 10** | Phir se solve karo. Agar 15 minute se kam laga aur koi bug nahi, toh ✅ "owned" mark karo. |
| **Day 30** | Jaldi se re-solve, ya owned problems ke liye bas 2 minute mein approach zor se bol do. |

Agar re-solve fail ho gaya, toh ghadi reset: problem wapas "Day 3" pe jaati hai.

### The problem log (copy this table into a notebook or spreadsheet) · Problem log (ise notebook ya spreadsheet mein copy kar lo)

| # | Problem | Pattern | Key idea apne shabdon mein | Date solved | Help chahiye thi? | Day 3 | Day 10 | Day 30 |
|---|---|---|---|---|---|---|---|---|
| 11 | 3Sum | Two pointers | sort, fix i, squeeze the rest, skip dup values | 03-Jun | 🔁 yes | ✅ 06-Jun | ✅ 13-Jun | |
| 18 | Longest Substring Without Repeating Characters | Sliding window | last-seen map, jump left past repeat | 05-Jun | no | ✅ 08-Jun | | |

(Log tum Hinglish mein bhi likh sakte ho, jaise "sort karo, i fix, baaki ko dono taraf se dabao, duplicate skip". Shart bas itni hai ki tumhare *apne* shabdon mein ho.)

**Har din pehle reviews, phir naye problems.** Ek typical din: 1–2 reviews (20–30 minute) + 2–3 naye problems.

> 🤔 **Mann mein sawaal:** Reviews pehle kyun? Naye problems karne ka josh toh shuru mein zyada hota hai.
>
> **Jawab:** Isi liye. Din ke end tak thak jaate ho aur reviews "kal kar lenge" ban jaate hain, aur pura schedule toot jaata hai. Reviews chhote hain (20–30 minute) lekin unhi se cheezein pakki hoti hain. Pehle wo nipta do, phir naye problems bonus hain.

### What to do when re-solving goes badly · Re-solve bigad jaaye toh kya karein

- **Idea poori tarah bhool gaye?** Tumhare log ka key idea bahut dheela tha. Use ek "kyunki" wale sentence mein dobara likho: "chhoti line ko move karo *kyunki* lambi line area ko behtar nahi kar sakti."
- **Idea yaad tha, code mein atak gaye?** Us pattern ka template [Pattern Recognition](01-pattern-recognition.md) se teen baar dobara type karo. Muscle memory sach mein hoti hai.
- **Har baar wahi bug** (off-by-one, visited set bhool jaana)? Use ek personal "mere bugs" list mein daalo aur har session se pehle wo list padho.

---

## 6. Never-Forget Summary · Kabhi Mat Bhoolna

- Lagbhag 180 problems, Part 2 ke order mein. **⭐ Core 75 pehle.**
- Ek problem = **padho, socho (brute force → pattern), code, test, seekho**. Hint lene se pehle zyada se zyada ~25 minute atko.
- **Day 3, 10 aur 30 pe re-solve.** Re-solve fail → wapas day 3.
- Basics ho jaayein toh **sections mix karo**: bina hint ke pattern pehchaanna hi asli interview skill hai.
- Ek **log** rakho jismein key idea tumhare apne shabdon mein ho. Wahi log tumhare revision notes ban jaata hai.

**Memory hook: "SOLVE, RE-SOLVE, MIX"**: ek baar solve karo, schedule pe zero se re-solve karo, phir use baaki sab ke saath mix karo.

**🪝 Yaad rakhne ka jugaad:** **"Teen, Dus, Tees: tab jaake paas."** Day 3, Day 10, Day 30 pe re-solve, tab jaake problem tumhari. Aur ek aur: **"Ratta nahi, dobara banao"**: solution padhna ratta hai, khaali screen pe dobara banana seekhna hai.

> **Agar sirf ek cheez yaad rakhni hai:** 100 problems jo teen baar re-solve kiye gaye, 300 problems jo ek baar solve kiye gaye, unse behtar hain.

---
**Aage:** [Chapter 04 · System Design Cheatsheet](04-system-design-cheatsheet.md)  ·  **Wapas** [Contents](../README.md)
