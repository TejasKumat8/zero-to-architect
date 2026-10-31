# Chapter 02 · Python Interview Questions

> Before the DSA round, many interviews open with ten minutes of "quick Python questions". They look easy, which is exactly why a fumbled answer hurts. This chapter is the full bank: the questions that actually get asked, each with a crisp answer you can say in under a minute.

**How to use this chapter:**
- Read the question, **answer it out loud first**, then open the answer. Saying it is very different from recognising it.
- 🔥🔥🔥 = asked very often, 🔥🔥 = often, 🔥 = sometimes. Short on time? Do every 🔥🔥🔥 first.
- Every answer links back to the Part 1 chapter that teaches it in depth.
- Code marked `python` runs as-is. Type it out and predict the output before you run it.

**Before this:** [Part 1 · Python from Scratch](../part-1-python/01-getting-started.md). This chapter is revision, not first teaching.

---

## Contents

1. [Basics](#1-basics) (Q1–Q10)
2. [Data Types & Collections](#2-data-types--collections) (Q11–Q20)
3. [Strings](#3-strings) (Q21–Q27)
4. [Functions](#4-functions) (Q28–Q37)
5. [OOP](#5-oop) (Q38–Q51)
6. [Iterators, Generators, Decorators & Context Managers](#6-iterators-generators-decorators--context-managers) (Q52–Q59)
7. [Memory, Internals & the GIL](#7-memory-internals--the-gil) (Q60–Q67)
8. [Exceptions](#8-exceptions) (Q68–Q72)
9. [Modules & Packages](#9-modules--packages) (Q73–Q77)
10. [Concurrency](#10-concurrency) (Q78–Q83)
11. [Tricky Output Puzzles](#11-tricky-output-puzzles) (Q84–Q97)

---

## 1. Basics

Chapters: [01](../part-1-python/01-getting-started.md) · [02](../part-1-python/02-variables-types-memory.md) · [03](../part-1-python/03-operators-expressions.md) · [05](../part-1-python/05-conditionals.md) · [06](../part-1-python/06-loops.md)

### Q1. Is Python compiled or interpreted? 🔥🔥

<details><summary>Answer</summary>

Both, in a way. When you run `python app.py`, **CPython** (the standard implementation) first **compiles** your source code into **bytecode**, a simple instruction list for a virtual machine. Then the **Python Virtual Machine** (an interpreter loop written in C) executes that bytecode one instruction at a time. Imported modules have their bytecode cached in `__pycache__/*.pyc` files so the compile step is skipped next time.

So the honest answer: "Python source is compiled to bytecode, and the bytecode is interpreted. It is not compiled to machine code ahead of time like C." (PyPy adds a JIT compiler that turns hot bytecode into machine code at run time.)

</details>

### Q2. What does "dynamically typed" and "strongly typed" mean for Python? 🔥🔥🔥

<details><summary>Answer</summary>

- **Dynamically typed:** types belong to **objects**, not variables. A name can point to an int now and a string later. Types are checked at run time, not before.
- **Strongly typed:** Python won't silently convert between unrelated types. `"1" + 1` is an error, not `"11"` or `2`.

```python
x = 10
print(type(x).__name__)
x = "ten"                      # same name, now points to a str: dynamic typing
print(type(x).__name__)
try:
    print("1" + 1)             # no silent conversion: strong typing
except TypeError as e:
    print("TypeError:", e)
```

```text
int
str
TypeError: can only concatenate str (not "int") to str
```

</details>

### Q3. What is PEP 8? 🔥

<details><summary>Answer</summary>

**PEP 8** is Python's official style guide (a PEP is a "Python Enhancement Proposal"). Key rules: 4-space indentation, `snake_case` for functions and variables, `PascalCase` for classes, `UPPER_CASE` for constants, lines around 79–99 characters, two blank lines between top-level definitions, imports at the top grouped as standard library / third-party / local. Tools like `black`, `ruff` and `flake8` enforce it automatically.

</details>

### Q4. What's the difference between `is` and `==`? 🔥🔥🔥

<details><summary>Answer</summary>

- `==` asks: **do they have equal values?** (it calls `__eq__`)
- `is` asks: **are they the very same object in memory?** (it compares `id()`)

```python
a = [1, 2, 3]
b = [1, 2, 3]
c = a
print(a == b, a is b)    # equal values, two different list objects
print(a == c, a is c)    # c is just another name for the same object
```

```text
True False
True True
```

Use `is` only for singletons: `x is None`, `x is True`. Never use `is` to compare numbers or strings: it can *seem* to work because of caching (see Q62) and then break.

</details>

### Q5. Which types are mutable and which are immutable? Why does it matter? 🔥🔥🔥

<details><summary>Answer</summary>

| Immutable (can't change after creation) | Mutable (can change in place) |
|---|---|
| `int`, `float`, `complex`, `bool`, `str`, `bytes`, `tuple`, `frozenset`, `None` | `list`, `dict`, `set`, `bytearray`, most user-defined objects |

Why it matters:
1. **Dict keys and set members must be hashable**, which in practice means immutable.
2. **Aliasing:** if two names point to the same mutable object, a change through one name is visible through the other.
3. **Function arguments:** a function can mutate a list you pass in, but can't change your int (Q30).
4. "Changing" an immutable object really creates a new one: `s += "x"` builds a new string.

</details>

### Q6. What are truthy and falsy values? 🔥🔥

<details><summary>Answer</summary>

In an `if` or `while`, every object is treated as True or False. **Falsy:** `False`, `None`, `0`, `0.0`, `0j`, `""`, `[]`, `()`, `{}`, `set()`, `range(0)`, and objects whose `__bool__` returns False or `__len__` returns 0. **Everything else is truthy.**

```python
for value in [0, 1, "", "0", [], [0], None, {}]:
    print(repr(value), bool(value))
```

```text
0 False
1 True
'' False
'0' True
[] False
[0] True
None False
{} False
```

Note `"0"` and `[0]` are truthy: a non-empty string or list is truthy no matter what's inside.

</details>

### Q7. What do `/`, `//` and `%` return, especially with negative numbers? 🔥🔥

<details><summary>Answer</summary>

- `/` is true division and **always returns a float**.
- `//` is **floor** division: rounds toward **negative infinity**, not toward zero.
- `%` has the **sign of the divisor**, so that `a == (a // b) * b + a % b` always holds.

```python
print(7 / 2, 6 / 2)
print(7 // 2, -7 // 2)
print(7 % 3, -7 % 3, 7 % -3)
print(int(-7 / 2))       # truncation toward zero, like C/Java
```

```text
3.5 3.0
3 -4
1 2 -2
-3
```

This bites people porting C++/Java solutions: `-7 // 2` is `-4` in Python but `-3` in Java.

</details>

### Q8. What does `if __name__ == "__main__":` do? 🔥🔥🔥

<details><summary>Answer</summary>

Every module has a built-in variable `__name__`. When a file is **run directly**, Python sets it to `"__main__"`. When the file is **imported**, `__name__` is the module's name (like `"utils"`). So the code under this check runs only when you execute the file, not when someone imports it. It's how a file can be both a reusable module and a runnable script (and it's required for `multiprocessing` on Windows and macOS).

```python
def main():
    print("running as a script")

print("__name__ is", __name__)
if __name__ == "__main__":
    main()
```

```text
__name__ is __main__
running as a script
```

</details>

### Q9. Explain `break`, `continue`, `pass` and the loop `else` clause. 🔥🔥

<details><summary>Answer</summary>

- `break`: leave the loop now.
- `continue`: skip to the next iteration.
- `pass`: do nothing (a placeholder where syntax needs a statement).
- Loop `else`: runs only if the loop finished **without** `break`. Think of it as "no break".

```python
def find_first_even(nums):
    for x in nums:
        if x % 2 == 0:
            print("found", x)
            break
    else:                      # runs only when no break happened
        print("no even number")

find_first_even([1, 3, 4, 5])
find_first_even([1, 3, 5])
```

```text
found 4
no even number
```

</details>

### Q10. What do `and` / `or` actually return? What is short-circuiting? 🔥🔥

<details><summary>Answer</summary>

They return **one of the operands**, not necessarily `True`/`False`:
- `a or b` returns `a` if `a` is truthy, else `b`.
- `a and b` returns `a` if `a` is falsy, else `b`.

**Short-circuiting:** the right side is not evaluated if the left side already decides the result. That's why `if node and node.val > 0` is safe when `node` is `None`.

```python
print(0 or "default", "x" or "default")
print(0 and 1 / 0, 3 and 5)          # 1 / 0 never runs
name = ""
print(name or "Anonymous")
print(1 < 3 < 5, 1 < 3 > 5)          # chained comparisons: 1 < 3 and 3 < 5
```

```text
default x
0 5
Anonymous
True False
```

</details>

---

## 2. Data Types & Collections

Chapters: [07 Lists](../part-1-python/07-lists.md) · [08 Tuples & Sets](../part-1-python/08-tuples-sets.md) · [09 Dictionaries](../part-1-python/09-dictionaries.md) · [11 Comprehensions](../part-1-python/11-comprehensions-functional.md)

### Q11. List vs tuple: what's the difference and when do you use each? 🔥🔥🔥

<details><summary>Answer</summary>

| | List | Tuple |
|---|---|---|
| Mutable? | Yes | No |
| Syntax | `[1, 2]` | `(1, 2)` or `1, 2` |
| Hashable (dict key)? | No | Yes, if all items are hashable |
| Typical use | A collection of similar items that grows/shrinks | A fixed record: `(x, y)`, `(name, age)`, returning several values |
| Memory / speed | Slightly larger (over-allocates for growth) | Slightly smaller, faster to create |

Rule of thumb: **list for "many of the same thing", tuple for "one thing made of parts"**.

</details>

### Q12. How is a Python list implemented? What is the cost of `append`, `insert(0, x)` and `x in list`? 🔥🔥

<details><summary>Answer</summary>

A list is a **dynamic array**: a contiguous block of pointers to objects. When it fills up, CPython allocates a bigger block (it over-allocates by a fraction) and copies the pointers over. Because resizes are rare and grow geometrically, `append` is **amortised O(1)**.

| Operation | Cost | Why |
|---|---|---|
| `lst[i]`, `lst[i] = x` | O(1) | direct offset into the array |
| `append`, `pop()` | O(1) amortised | at the end, nothing shifts |
| `insert(0, x)`, `pop(0)` | O(n) | every element shifts by one |
| `x in lst`, `lst.index(x)` | O(n) | linear scan |
| `lst[a:b]` | O(b − a) | copies a new list |
| `sort()` | O(n log n) | Timsort |

Need fast operations at both ends? Use `collections.deque`.

</details>

### Q13. What is a set? When would you use it? What's a frozenset? 🔥🔥

<details><summary>Answer</summary>

A **set** is an unordered collection of **unique, hashable** items, built on a hash table. Membership test `x in s`, `add` and `remove` are **O(1) on average**. Use it to remove duplicates, for fast "have I seen this?" checks, and for set maths.

A **frozenset** is an immutable set, so it is hashable and can be a dict key or an element of another set.

```python
a, b = {1, 2, 3}, {2, 3, 4}
print(a | b, a & b, a - b, a ^ b)      # union, intersection, difference, symmetric difference
print(sorted(set([3, 1, 3, 2, 1])))   # dedupe
groups = {frozenset({1, 2}): "pair"}
print(groups[frozenset({2, 1})])
```

```text
{1, 2, 3, 4} {2, 3} {1} {1, 4}
[1, 2, 3]
pair
```

</details>

### Q14. How does a dictionary work internally? Are dicts ordered? 🔥🔥🔥

<details><summary>Answer</summary>

A dict is a **hash table**. To store `d[key] = value`, Python computes `hash(key)`, uses it to pick a slot, and stores the key, value and hash there. On a lookup it hashes the key again, jumps to the slot, and confirms with `==` (because different keys can share a hash: a **collision**, resolved by probing other slots). When the table gets about two-thirds full, it is resized and everything is re-inserted.

- Average cost of get / set / delete / `in`: **O(1)**. Worst case (many collisions): O(n).
- Since CPython 3.6 (and guaranteed by the language since **3.7**), dicts **remember insertion order**. Modern CPython stores entries in a compact array in insertion order plus a separate small index table, which also saves memory.

</details>

### Q15. What can be used as a dictionary key? 🔥🔥🔥

<details><summary>Answer</summary>

Any **hashable** object: one with a `__hash__` that never changes during its lifetime and an `__eq__` consistent with it. In practice: numbers, strings, `None`, tuples of hashables, frozensets, and user objects (hashed by identity by default). **Lists, dicts and sets can't** be keys because they're mutable: if a key changed after insertion, its hash would change and the dict could never find it again.

```python
d = {}
d[(1, 2)] = "tuple ok"
print(d)
try:
    d[[1, 2]] = "list?"
except TypeError as e:
    print("TypeError:", e)
```

```text
{(1, 2): 'tuple ok'}
TypeError: unhashable type: 'list'
```

Interview tip: to use a list as a key (for example, to group anagrams by letter counts), convert it to a tuple first.

</details>

### Q16. What is the difference between a shallow copy and a deep copy? 🔥🔥🔥

<details><summary>Answer</summary>

- **Assignment** (`b = a`) copies nothing: both names point to the same object.
- **Shallow copy** (`a.copy()`, `list(a)`, `a[:]`, `copy.copy(a)`) makes a new outer container, but the **inner objects are shared**.
- **Deep copy** (`copy.deepcopy(a)`) recursively copies everything.

```python
import copy

a = [[1, 2], [3, 4]]
shallow = a.copy()
deep = copy.deepcopy(a)
a[0].append(99)            # mutate an INNER list
print(shallow)             # sees the change: inner lists are shared
print(deep)                # fully independent
print(shallow is a, shallow[0] is a[0])
```

```text
[[1, 2, 99], [3, 4]]
[[1, 2], [3, 4]]
False True
```

</details>

### Q17. Why does `[[0] * 3] * 3` behave strangely? 🔥🔥🔥

<details><summary>Answer</summary>

`* 3` on the outer list copies the **reference** three times, so all three rows are the *same* inner list. Changing one row changes "all" of them. Build a fresh list per row with a comprehension.

```python
bad = [[0] * 3] * 3
bad[0][0] = 1
print(bad)

good = [[0] * 3 for _ in range(3)]
good[0][0] = 1
print(good)
```

```text
[[1, 0, 0], [1, 0, 0], [1, 0, 0]]
[[1, 0, 0], [0, 0, 0], [0, 0, 0]]
```

The inner `[0] * 3` is fine because ints are immutable: you replace them, you never mutate them. This is the #1 bug when building DP tables.

</details>

### Q18. What useful tools are in the `collections` module? 🔥🔥

<details><summary>Answer</summary>

| Tool | What it is | Typical use |
|---|---|---|
| `Counter` | dict that counts | frequencies, anagram checks, `most_common(k)` |
| `defaultdict(factory)` | dict that creates missing values | grouping (`defaultdict(list)`), adjacency lists |
| `deque` | double-ended queue, O(1) at both ends | BFS, sliding windows |
| `namedtuple` | tuple with field names | lightweight immutable records |
| `OrderedDict` | dict with `move_to_end` and `popitem(last=False)` | LRU caches |

```python
from collections import Counter, defaultdict, deque, namedtuple

print(Counter("banana").most_common(2))
groups = defaultdict(list)
for word in ["apple", "avocado", "banana"]:
    groups[word[0]].append(word)
print(dict(groups))
q = deque([1, 2, 3])
q.appendleft(0)
q.pop()
print(q)
Point = namedtuple("Point", ["x", "y"])
p = Point(3, 4)
print(p.x + p.y, p)
```

```text
[('a', 3), ('n', 2)]
{'a': ['apple', 'avocado'], 'b': ['banana']}
deque([0, 1, 2])
7 Point(x=3, y=4)
```

</details>

### Q19. `sort()` vs `sorted()`? What is a key function? Is Python's sort stable? 🔥🔥

<details><summary>Answer</summary>

- `lst.sort()` sorts **in place** and returns `None`. Only lists have it.
- `sorted(iterable)` returns a **new list** and works on any iterable.
- `key=` is a function applied to each element to get the value to compare. `reverse=True` flips the order.
- Python uses **Timsort**: O(n log n) worst case, O(n) on already-sorted data, and **stable** (equal keys keep their original order). Stability lets you sort by several keys in passes.

```python
people = [("asha", 25), ("ravi", 22), ("bina", 25), ("dev", 22)]
print(sorted(people, key=lambda p: p[1]))                 # stable: asha before bina
print(sorted(people, key=lambda p: (-p[1], p[0])))        # age desc, then name asc
nums = [3, 1, 2]
print(nums.sort(), nums)
```

```text
[('ravi', 22), ('dev', 22), ('asha', 25), ('bina', 25)]
[('asha', 25), ('bina', 25), ('dev', 22), ('ravi', 22)]
None [1, 2, 3]
```

</details>

### Q20. List comprehension vs generator expression? 🔥🔥🔥

<details><summary>Answer</summary>

- `[x * x for x in data]` builds the **whole list in memory** right away. You can index it and loop over it many times.
- `(x * x for x in data)` creates a **generator**: values are produced **lazily**, one at a time, using O(1) memory. It can be consumed only **once**.

Use a generator when you only need to loop once, especially for big data or when feeding `sum`, `max`, `any`, `all`.

```python
squares_list = [x * x for x in range(5)]
squares_gen = (x * x for x in range(5))
print(squares_list, type(squares_gen).__name__)
print(sum(squares_gen))
print(sum(squares_gen))          # already exhausted
print(sum(x * x for x in range(10**6)))   # no million-element list is built
```

```text
[0, 1, 4, 9, 16] generator
30
0
333332833333500000
```

</details>

---

## 3. Strings

Chapter: [04 Strings Deep Dive](../part-1-python/04-strings.md)

### Q21. Strings are immutable. Why is `s += c` in a loop a problem, and what should you do? 🔥🔥🔥

<details><summary>Answer</summary>

Each `s += c` may create a **new string** and copy all the old characters, so building a string of length n this way can cost O(n²) in the worst case. (CPython sometimes optimises it in place, but you can't rely on that.) The idiom is to collect pieces in a list and `"".join()` them once: O(n) total.

```python
parts = []
for i in range(5):
    parts.append(str(i))
print("".join(parts), "-".join(parts))
```

```text
01234 0-1-2-3-4
```

</details>

### Q22. How do you reverse a string? Explain slicing. 🔥🔥

<details><summary>Answer</summary>

Slicing is `s[start:stop:step]`: start is included, stop is excluded, and any part can be omitted. A negative step walks backwards, so `s[::-1]` reverses. Slices **never raise IndexError**; they clamp to the valid range.

```python
s = "python"
print(s[::-1], s[1:4], s[-3:], s[::2])
print(s[10:], "".join(reversed(s)))
```

```text
nohtyp yth hon pto
 nohtyp
```

(The second line starts with an empty string from `s[10:]`, then a space from `print`.)

</details>

### Q23. What are the ways to format strings? 🔥

<details><summary>Answer</summary>

Three ways, newest and preferred first:

```python
name, score = "Asha", 92.456
print(f"{name} scored {score:.1f}")            # f-string (3.6+): fastest, most readable
print("{} scored {:.1f}".format(name, score))  # str.format
print("%s scored %.1f" % (name, score))        # old %-formatting
print(f"{score=:.2f}", f"{42:08b}", f"{1234567:,}", f"{'hi':>5}|")
```

```text
Asha scored 92.5
Asha scored 92.5
Asha scored 92.5
score=92.46 00101010 1,234,567    hi|
```

Handy format specs: `.2f` decimals, `08b` binary padded to 8, `,` thousands separator, `>5` right-align, `=` (3.8+) prints the expression too.

</details>

### Q24. What's the difference between `str` and `bytes`? 🔥🔥

<details><summary>Answer</summary>

`str` is a sequence of **Unicode characters** (text). `bytes` is a sequence of **raw 8-bit values** (what files, sockets and disks actually hold). You convert with an **encoding**, usually UTF-8: `text.encode("utf-8")` → bytes, `data.decode("utf-8")` → str. In UTF-8, ASCII characters take 1 byte, but others take 2–4 bytes, so `len(text)` and `len(text.encode())` can differ.

```python
text = "café"
data = text.encode("utf-8")
print(data, len(text), len(data))
print(data.decode("utf-8") == text)
```

```text
b'caf\xc3\xa9' 4 5
True
```

</details>

### Q25. Check if two strings are anagrams, and if a string is a palindrome, the Pythonic way. 🔥🔥

<details><summary>Answer</summary>

```python
from collections import Counter

def is_anagram(a, b):
    return Counter(a) == Counter(b)          # O(n); sorted(a) == sorted(b) is O(n log n)

def is_palindrome(s):
    cleaned = [ch.lower() for ch in s if ch.isalnum()]
    return cleaned == cleaned[::-1]

print(is_anagram("listen", "silent"), is_anagram("rat", "car"))
print(is_palindrome("A man, a plan, a canal: Panama"))
```

```text
True False
True
```

In a DSA round, also mention the two-pointer palindrome with O(1) extra space ([Two Pointers](../part-2-dsa/03-two-pointers.md)).

</details>

### Q26. `split()` vs `split(" ")`, and `find()` vs `index()`? 🔥🔥

<details><summary>Answer</summary>

- `split()` with no argument splits on **any run of whitespace** and drops empty strings. `split(" ")` splits on **every single space**, keeping empty strings.
- `find(sub)` returns `-1` if not found. `index(sub)` raises `ValueError`.

```python
s = "  a  b c "
print(s.split())
print(s.split(" "))
print("hello".find("z"), "hello".find("l"))
try:
    "hello".index("z")
except ValueError as e:
    print("ValueError:", e)
```

```text
['a', 'b', 'c']
['', '', 'a', '', 'b', 'c', '']
-1 2
ValueError: substring not found
```

</details>

### Q27. What is string interning? 🔥

<details><summary>Answer</summary>

**Interning** means keeping only one copy of certain strings, so equal strings share one object. CPython automatically interns many identifier-like strings (names, attribute names, short literals in code), and you can force it with `sys.intern(s)`. Benefits: less memory and faster dict lookups by identity. But which strings get interned is an **implementation detail**, so `a is b` on strings may be True or False depending on how they were created. Always compare strings with `==`.

```py
import sys
a = "hello world"
b = " ".join(["hello", "world"])   # built at run time
print(a == b)                      # True, always
print(a is b)                      # usually False: two separate objects
print(sys.intern(a) is sys.intern(b))  # True: both now point to the interned copy
```

</details>

---

## 4. Functions

Chapters: [10 Functions](../part-1-python/10-functions.md) · [11 Comprehensions & Functional Tools](../part-1-python/11-comprehensions-functional.md)

### Q28. What are `*args` and `**kwargs`? 🔥🔥🔥

<details><summary>Answer</summary>

- `*args` collects extra **positional** arguments into a **tuple**.
- `**kwargs` collects extra **keyword** arguments into a **dict**.
- The same stars **unpack** when calling: `f(*lst, **dct)`.

The names are convention; the stars are what matter.

```python
def show(first, *args, **kwargs):
    print(first, args, kwargs)

show(1)
show(1, 2, 3, mode="fast", debug=True)
values = [10, 20]
options = {"sep": " | "}
print(*values, **options)            # unpacking when calling
```

```text
1 () {}
1 (2, 3) {'mode': 'fast', 'debug': True}
10 | 20
```

</details>

### Q29. What is the mutable default argument trap? 🔥🔥🔥

<details><summary>Answer</summary>

Default values are evaluated **once, when the function is defined**, not on each call. A mutable default (list, dict, set) is therefore shared across all calls.

```python
def add_bad(item, bucket=[]):
    bucket.append(item)
    return bucket

def add_good(item, bucket=None):
    if bucket is None:            # create a fresh list on every call
        bucket = []
    bucket.append(item)
    return bucket

print(add_bad(1), add_bad(2))
print(add_good(1), add_good(2))
```

```text
[1, 2] [1, 2]
[1] [2]
```

(The first line prints `[1, 2]` twice because both calls return the same list object, printed after both appends.)

</details>

### Q30. Is Python pass-by-value or pass-by-reference? 🔥🔥🔥

<details><summary>Answer</summary>

Neither, exactly. Python is **pass-by-object-reference** (also called "call by sharing"). The function's parameter becomes a **new name for the same object**.
- If the function **mutates** that object (e.g. `lst.append`), the caller sees the change.
- If the function **rebinds** the name (`lst = [...]`, `n += 1` on an int), only the local name changes; the caller is unaffected.

```python
def mutate(lst):
    lst.append(4)          # changes the shared object

def rebind(lst, n):
    lst = [0]              # local name now points elsewhere
    n += 1                 # ints are immutable: creates a new int locally

nums, count = [1, 2, 3], 10
mutate(nums)
rebind(nums, count)
print(nums, count)
```

```text
[1, 2, 3, 4] 10
```

</details>

### Q31. Explain scope (LEGB), `global` and `nonlocal`. 🔥🔥

<details><summary>Answer</summary>

Python looks up a name in this order: **L**ocal (current function) → **E**nclosing (outer functions) → **G**lobal (module) → **B**uilt-in (`len`, `print`...). Assigning to a name inside a function makes it **local** for the whole function, unless you declare `global name` (module-level) or `nonlocal name` (nearest enclosing function).

```python
counter = 0

def bump_global():
    global counter
    counter += 1

def make_counter():
    count = 0
    def bump():
        nonlocal count          # without this: UnboundLocalError
        count += 1
        return count
    return bump

bump_global()
bump_global()
c = make_counter()
c()
print(counter, c())
```

```text
2 2
```

</details>

### Q32. What is a lambda? When should you (not) use it? 🔥🔥

<details><summary>Answer</summary>

A **lambda** is a small anonymous function limited to a **single expression**: `lambda x: x * 2`. It's ideal for short throwaway functions passed to `sorted(key=...)`, `max(key=...)`, `map`, `filter`. Don't assign a lambda to a name (`f = lambda ...`): use `def` instead, which gives a proper name in tracebacks and allows statements and docstrings.

```python
words = ["banana", "kiwi", "apple"]
print(sorted(words, key=lambda w: (len(w), w)))
print(max(words, key=len))
```

```text
['kiwi', 'apple', 'banana']
banana
```

</details>

### Q33. `map`, `filter` and `reduce` vs comprehensions? 🔥

<details><summary>Answer</summary>

- `map(f, it)` applies `f` to each item; `filter(pred, it)` keeps items where `pred` is truthy. Both return **lazy iterators** in Python 3.
- `functools.reduce(f, it, start)` folds a sequence into one value.
- Comprehensions are usually clearer and are preferred in Python. `map` is fine when you already have a named function.

```python
from functools import reduce

nums = [1, 2, 3, 4, 5]
print(list(map(str, nums)), [str(x) for x in nums])
print(list(filter(lambda x: x % 2, nums)), [x for x in nums if x % 2])
print(reduce(lambda acc, x: acc * x, nums, 1))
```

```text
['1', '2', '3', '4', '5'] ['1', '2', '3', '4', '5']
[1, 3, 5] [1, 3, 5]
120
```

</details>

### Q34. What is a closure? 🔥🔥

<details><summary>Answer</summary>

A **closure** is an inner function that **remembers variables from the enclosing function's scope**, even after the outer function has returned. The remembered variables live in "cells" attached to the function (`fn.__closure__`). Closures power decorators, factories and callbacks.

```python
def make_multiplier(factor):
    def multiply(x):
        return x * factor        # 'factor' is captured from the outer scope
    return multiply

double, triple = make_multiplier(2), make_multiplier(3)
print(double(5), triple(5))
print(double.__closure__[0].cell_contents)
```

```text
10 15
2
```

</details>

### Q35. Why do all these lambdas return the same value: `[lambda: i for i in range(3)]`? 🔥🔥

<details><summary>Answer</summary>

**Late binding:** closures capture the **variable**, not its value at creation time. When the lambdas are finally called, the loop has finished and `i` is 2 for all of them. Fix it by binding the current value as a default argument (evaluated at definition time), or with `functools.partial`.

```python
late = [lambda: i for i in range(3)]
print([f() for f in late])

fixed = [lambda i=i: i for i in range(3)]
print([f() for f in fixed])
```

```text
[2, 2, 2]
[0, 1, 2]
```

</details>

### Q36. What do `/` and `*` mean in a function signature? 🔥

<details><summary>Answer</summary>

- Parameters **before `/`** are **positional-only** (3.8+): callers can't pass them by name.
- Parameters **after `*`** are **keyword-only**: callers must pass them by name.

```python
def make_user(name, /, age, *, admin=False):
    return f"{name} {age} admin={admin}"

print(make_user("asha", 21, admin=True))
print(make_user("ravi", age=30))
try:
    make_user(name="dev", age=20)
except TypeError as e:
    print("TypeError:", e)
```

```text
asha 21 admin=True
ravi 30 admin=False
TypeError: make_user() got some positional-only arguments passed as keyword arguments: 'name'
```

Keyword-only flags (`admin=True`) make calls self-documenting; positional-only lets you rename a parameter later without breaking callers.

</details>

### Q37. Does Python enforce type hints? 🔥

<details><summary>Answer</summary>

No. **Type hints** (`def f(x: int) -> str:`) are stored in `__annotations__` and ignored at run time. They're for humans, IDEs and static checkers like **mypy** or **pyright**, which catch type bugs before you run the code. Libraries such as `pydantic` and `dataclasses` *read* them to do extra work, but plain Python never rejects a wrong type.

```python
def greet(name: str) -> str:
    return "hi " + str(name)

print(greet(42))                 # runs fine: hints are not enforced
print(greet.__annotations__)
```

```text
hi 42
{'name': <class 'str'>, 'return': <class 'str'>}
```

</details>

---

## 5. OOP

Chapters: [14 OOP I](../part-1-python/14-oop-classes-objects.md) · [15 OOP II](../part-1-python/15-oop-inheritance-magic.md)

### Q38. What is `self`? What's the difference between a class and an object? 🔥🔥🔥

<details><summary>Answer</summary>

A **class** is a blueprint (`Dog`); an **object** (instance) is a thing built from it (`rex = Dog("Rex")`). `self` is the **instance the method was called on**. `rex.bark()` is really `Dog.bark(rex)`: Python passes the object as the first argument automatically. `self` is just a convention, not a keyword, but always use it.

```python
class Dog:
    def __init__(self, name):
        self.name = name            # instance attribute, stored on this object

    def bark(self):
        return f"{self.name} says woof"

rex = Dog("Rex")
print(rex.bark(), Dog.bark(rex))
```

```text
Rex says woof Rex says woof
```

</details>

### Q39. `__init__` vs `__new__`? 🔥🔥

<details><summary>Answer</summary>

- `__new__(cls, ...)` **creates** and returns the new object. It's a static method that runs first.
- `__init__(self, ...)` **initialises** the already-created object and returns `None`.

You almost never write `__new__`. It's needed when subclassing immutable types (`int`, `str`, `tuple`), where the value must be set at creation, or for patterns like singletons.

```python
class Celsius(float):
    def __new__(cls, value):
        print("__new__ creates")
        return super().__new__(cls, round(value, 1))   # immutable: set the value here

    def __init__(self, value):
        print("__init__ initialises")

t = Celsius(36.66)
print(t)
```

```text
__new__ creates
__init__ initialises
36.7
```

</details>

### Q40. Class variables vs instance variables? 🔥🔥🔥

<details><summary>Answer</summary>

A **class variable** is defined in the class body and **shared** by all instances. An **instance variable** is set on `self` and belongs to one object. Reading `obj.x` checks the instance first, then the class. The classic bug: a **mutable** class variable is shared, so one instance's change leaks into all of them.

```python
class Team:
    members = []                  # class variable: ONE list for all teams (bug!)
    def __init__(self, name):
        self.name = name          # instance variable

class FixedTeam:
    def __init__(self, name):
        self.name = name
        self.members = []         # each team gets its own list

a, b = Team("A"), Team("B")
a.members.append("asha")
print(b.members)

c, d = FixedTeam("C"), FixedTeam("D")
c.members.append("asha")
print(d.members)
```

```text
['asha']
[]
```

</details>

### Q41. Instance method vs `@classmethod` vs `@staticmethod`? 🔥🔥🔥

<details><summary>Answer</summary>

| Kind | First argument | Can access | Typical use |
|---|---|---|---|
| Instance method | `self` (the object) | instance and class | normal behaviour |
| `@classmethod` | `cls` (the class) | class, not a specific instance | **alternative constructors** (`from_string`), works with subclasses |
| `@staticmethod` | nothing | neither (unless named explicitly) | a helper that logically belongs to the class |

```python
class Date:
    def __init__(self, y, m, d):
        self.y, self.m, self.d = y, m, d

    @classmethod
    def from_string(cls, text):          # alternative constructor
        return cls(*map(int, text.split("-")))

    @staticmethod
    def is_leap(year):                   # pure helper
        return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)

    def show(self):
        return f"{self.d:02}/{self.m:02}/{self.y}"

print(Date.from_string("2024-02-09").show(), Date.is_leap(2024), Date.is_leap(1900))
```

```text
09/02/2024 True False
```

</details>

### Q42. How does `super()` work? What is the MRO? 🔥🔥

<details><summary>Answer</summary>

The **MRO** (Method Resolution Order) is the order Python searches classes for a method. It's computed with the **C3 linearisation**: children before parents, and the left-to-right order of base classes is kept. `super()` means "the **next** class in the MRO", not simply "my parent". That's what makes cooperative multiple inheritance (the diamond) call each class exactly once.

```python
class Base:
    def hello(self):
        return ["Base"]

class Left(Base):
    def hello(self):
        return ["Left"] + super().hello()

class Right(Base):
    def hello(self):
        return ["Right"] + super().hello()

class Child(Left, Right):
    def hello(self):
        return ["Child"] + super().hello()

print(Child().hello())
print([cls.__name__ for cls in Child.__mro__])
```

```text
['Child', 'Left', 'Right', 'Base']
['Child', 'Left', 'Right', 'Base', 'object']
```

Notice that `super()` inside `Left` called `Right`, not `Base`: it follows the MRO of the actual object.

</details>

### Q43. Does Python have private variables? What do `_x` and `__x` mean? 🔥🔥

<details><summary>Answer</summary>

There's no true `private`. Python relies on convention:
- `_x`: "internal, please don't touch". Nothing enforces it (but `from module import *` skips such names).
- `__x` (two leading underscores, no trailing): **name mangling**. Inside class `Account`, `__x` is renamed to `_Account__x`. Its purpose is to avoid accidental name clashes in subclasses, not security.
- `__x__`: special "dunder" names reserved for Python.

```python
class Account:
    def __init__(self):
        self._hint = "internal"
        self.__balance = 100

acc = Account()
print(acc._hint)
try:
    print(acc.__balance)
except AttributeError:
    print("no attribute __balance")
print(acc._Account__balance)       # the mangled name still works
```

```text
internal
no attribute __balance
100
```

</details>

### Q44. What is `@property` and why use it? 🔥🔥

<details><summary>Answer</summary>

`@property` turns a method into something accessed like an attribute, and lets you add a **setter** with validation. You can start with a plain attribute and later switch to a property **without changing any calling code**. That's why Python doesn't need Java-style getters and setters.

```python
class Temperature:
    def __init__(self, celsius):
        self.celsius = celsius            # goes through the setter below

    @property
    def celsius(self):
        return self._celsius

    @celsius.setter
    def celsius(self, value):
        if value < -273.15:
            raise ValueError("below absolute zero")
        self._celsius = value

    @property
    def fahrenheit(self):                 # computed, read-only
        return self._celsius * 9 / 5 + 32

t = Temperature(25)
print(t.celsius, t.fahrenheit)
try:
    t.celsius = -300
except ValueError as e:
    print("ValueError:", e)
```

```text
25 77.0
ValueError: below absolute zero
```

</details>

### Q45. `__str__` vs `__repr__`? 🔥🔥🔥

<details><summary>Answer</summary>

- `__repr__`: an **unambiguous** representation **for developers**, ideally valid Python that recreates the object. Used by the REPL, debuggers, and inside containers.
- `__str__`: a **readable** representation **for users**. Used by `print()` and `str()`. Falls back to `__repr__` if missing.

Always define `__repr__`; add `__str__` when a friendlier form helps.

```python
class Point:
    def __init__(self, x, y):
        self.x, self.y = x, y
    def __repr__(self):
        return f"Point({self.x}, {self.y})"
    def __str__(self):
        return f"({self.x}, {self.y})"

p = Point(1, 2)
print(p, str(p), repr(p))
print([p])                       # containers use repr
```

```text
(1, 2) (1, 2) Point(1, 2)
[Point(1, 2)]
```

</details>

### Q46. What are magic (dunder) methods? Show operator overloading. 🔥🔥

<details><summary>Answer</summary>

**Dunder methods** (double underscore, like `__add__`) let your objects plug into Python's syntax: `a + b` calls `a.__add__(b)`, `len(x)` calls `x.__len__()`, `x[i]` calls `x.__getitem__(i)`, `for` uses `__iter__`, `==` uses `__eq__`, `<` uses `__lt__`, `with` uses `__enter__`/`__exit__`, `obj()` uses `__call__`.

```python
class Vector:
    def __init__(self, *coords):
        self.coords = coords
    def __add__(self, other):
        return Vector(*(a + b for a, b in zip(self.coords, other.coords)))
    def __mul__(self, k):
        return Vector(*(a * k for a in self.coords))
    def __eq__(self, other):
        return isinstance(other, Vector) and self.coords == other.coords
    def __len__(self):
        return len(self.coords)
    def __getitem__(self, i):
        return self.coords[i]
    def __repr__(self):
        return f"Vector{self.coords}"

v = Vector(1, 2) + Vector(3, 4)
print(v, v * 2, len(v), v[0], v == Vector(4, 6))
```

```text
Vector(4, 6) Vector(8, 12) 2 4 True
```

</details>

### Q47. How are `__eq__` and `__hash__` related? 🔥🔥

<details><summary>Answer</summary>

The rule: **if `a == b`, then `hash(a) == hash(b)`** must hold, or dicts and sets break. So:
- If you define `__eq__` without `__hash__`, Python sets `__hash__ = None` and your objects become **unhashable** (safe default).
- To make them hashable, define `__hash__` using the **same immutable fields** that `__eq__` compares, e.g. `hash((self.x, self.y))`.

```python
class P:
    def __init__(self, x, y):
        self.x, self.y = x, y
    def __eq__(self, other):
        return (self.x, self.y) == (other.x, other.y)
    def __hash__(self):
        return hash((self.x, self.y))

print(len({P(1, 2), P(1, 2), P(3, 4)}))

class OnlyEq:
    def __eq__(self, other):
        return True
print(OnlyEq.__hash__)
```

```text
2
None
```

</details>

### Q48. What is an abstract base class? 🔥

<details><summary>Answer</summary>

An **abstract base class** (ABC) defines an interface that subclasses must implement. Methods marked `@abstractmethod` must be overridden; trying to instantiate a class that hasn't implemented them raises `TypeError`.

```python
from abc import ABC, abstractmethod

class Shape(ABC):
    @abstractmethod
    def area(self): ...

class Square(Shape):
    def __init__(self, side):
        self.side = side
    def area(self):
        return self.side ** 2

print(Square(3).area())
try:
    Shape()
except TypeError:
    print("can't instantiate an abstract class")
```

```text
9
can't instantiate an abstract class
```

</details>

### Q49. What is duck typing? How is polymorphism done in Python? 🔥🔥

<details><summary>Answer</summary>

"If it walks like a duck and quacks like a duck, it's a duck." Python cares whether an object **has the method you call**, not what class it is. Any object with a `.read()` method works where a file is expected. Polymorphism therefore doesn't need a shared base class: different classes just implement the same method names (or dunder methods, so `len()` works on lists, strings and your own classes alike).

```python
class Duck:
    def speak(self):
        return "Quack"

class Robot:
    def speak(self):
        return "Beep"

for thing in (Duck(), Robot()):
    print(thing.speak())          # no common parent needed
```

```text
Quack
Beep
```

</details>

### Q50. What does `__slots__` do? 🔥

<details><summary>Answer</summary>

Normally each object stores its attributes in a per-instance `__dict__`. Declaring `__slots__ = ("x", "y")` replaces that dict with fixed slots, which **saves memory** (noticeable with millions of objects, like trie or graph nodes) and makes attribute access slightly faster. The cost: you **can't add new attributes** that aren't listed.

```python
class Node:
    __slots__ = ("val", "next")
    def __init__(self, val):
        self.val, self.next = val, None

n = Node(1)
try:
    n.extra = 5
except AttributeError:
    print("can't add attributes outside __slots__")
print(hasattr(n, "__dict__"))
```

```text
can't add attributes outside __slots__
False
```

</details>

### Q51. What are dataclasses? 🔥🔥

<details><summary>Answer</summary>

`@dataclass` (3.7+) auto-generates `__init__`, `__repr__` and `__eq__` from type-annotated fields. Options: `frozen=True` (immutable and hashable), `order=True` (adds `<`, `>` etc.), `field(default_factory=list)` for mutable defaults (it refuses a plain `= []`, protecting you from Q29's trap).

```python
from dataclasses import dataclass, field

@dataclass(order=True)
class Student:
    marks: int
    name: str
    tags: list = field(default_factory=list)

a, b = Student(90, "asha"), Student(85, "ravi")
print(a)
print(a == Student(90, "asha"), sorted([a, b])[0].name)
```

```text
Student(marks=90, name='asha', tags=[])
True ravi
```

</details>

---

## 6. Iterators, Generators, Decorators & Context Managers

Chapter: [16 Iterators, Generators, Decorators & Context Managers](../part-1-python/16-iterators-generators-decorators.md)

### Q52. Iterable vs iterator? 🔥🔥🔥

<details><summary>Answer</summary>

- An **iterable** can give you an iterator: it has `__iter__` (lists, strings, dicts, files, ranges).
- An **iterator** produces values one at a time with `__next__`, raises `StopIteration` when done, and its `__iter__` returns itself. It's **single-use**.

A `for` loop calls `iter()` on the iterable once, then `next()` repeatedly until `StopIteration`.

```python
nums = [10, 20]
it = iter(nums)
print(next(it), next(it))
try:
    next(it)
except StopIteration:
    print("exhausted")

class Countdown:
    def __init__(self, start):
        self.current = start
    def __iter__(self):
        return self
    def __next__(self):
        if self.current <= 0:
            raise StopIteration
        self.current -= 1
        return self.current + 1

print(list(Countdown(3)))
```

```text
10 20
exhausted
[3, 2, 1]
```

</details>

### Q53. What is a generator? Why is it memory-efficient? 🔥🔥🔥

<details><summary>Answer</summary>

A **generator** is a function containing `yield`. Calling it doesn't run the body; it returns a generator object (an iterator). Each `next()` runs the body until the next `yield`, hands out that value, and **pauses**, keeping all local variables. It produces values **lazily**, so it uses O(1) memory however many values it yields, and it can even be infinite.

```python
def fibonacci():
    a, b = 0, 1
    while True:              # infinite, but values are made only on demand
        yield a
        a, b = b, a + b

def read_in_chunks(data, size):
    for i in range(0, len(data), size):
        yield data[i:i + size]

gen = fibonacci()
print([next(gen) for _ in range(8)])
print(list(read_in_chunks("abcdefg", 3)))
```

```text
[0, 1, 1, 2, 3, 5, 8, 13]
['abc', 'def', 'g']
```

Real use: streaming a 10 GB log file line by line, pipelines of transformations, pagination.

</details>

### Q54. What does `yield from` do? 🔥

<details><summary>Answer</summary>

`yield from sub` yields every value from another iterable or generator, so you don't write `for x in sub: yield x`. It also forwards `send()` and returns the sub-generator's `return` value. It's perfect for recursive generators.

```python
def flatten(items):
    for item in items:
        if isinstance(item, list):
            yield from flatten(item)     # delegate to the recursive call
        else:
            yield item

print(list(flatten([1, [2, [3, 4]], 5])))
```

```text
[1, 2, 3, 4, 5]
```

</details>

### Q55. What is a decorator? Write one. 🔥🔥🔥

<details><summary>Answer</summary>

A **decorator** is a function that takes a function and returns a new function that usually wraps the original with extra behaviour (logging, timing, caching, auth checks, retries). `@deco` above `def f` means `f = deco(f)`. Use `functools.wraps` so the wrapper keeps the original's name and docstring.

```python
import functools

def count_calls(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        wrapper.calls += 1
        print(f"calling {func.__name__}{args}")
        return func(*args, **kwargs)
    wrapper.calls = 0
    return wrapper

@count_calls
def add(a, b):
    """Add two numbers."""
    return a + b

print(add(2, 3))
print(add(4, 5))
print(add.calls, add.__name__, add.__doc__)
```

```text
calling add(2, 3)
5
calling add(4, 5)
9
2 add Add two numbers.
```

</details>

### Q56. How do you write a decorator that takes arguments? 🔥🔥

<details><summary>Answer</summary>

Add one more layer: a **factory** that takes the arguments and returns the actual decorator. `@repeat(3)` means `f = repeat(3)(f)`.

```python
import functools

def repeat(times):                       # 1. factory: receives the arguments
    def decorator(func):                 # 2. the real decorator: receives the function
        @functools.wraps(func)
        def wrapper(*args, **kwargs):    # 3. the replacement function
            return [func(*args, **kwargs) for _ in range(times)]
        return wrapper
    return decorator

@repeat(3)
def greet(name):
    return f"hi {name}"

print(greet("asha"))
```

```text
['hi asha', 'hi asha', 'hi asha']
```

</details>

### Q57. What does `functools.lru_cache` do? 🔥🔥

<details><summary>Answer</summary>

It's a built-in **memoisation** decorator: it stores results keyed by the arguments and returns the stored result on repeated calls. `maxsize` bounds the cache with LRU eviction (`maxsize=None`, or `functools.cache` in 3.9+, means unbounded). Arguments must be **hashable**. It turns exponential recursive DP into polynomial time in one line.

```python
from functools import lru_cache

@lru_cache(maxsize=None)
def fib(n):
    return n if n < 2 else fib(n - 1) + fib(n - 2)

print(fib(80))
print(fib.cache_info().hits > 0)
```

```text
23416728348467685
True
```

</details>

### Q58. What is a context manager? How do you write one? 🔥🔥🔥

<details><summary>Answer</summary>

A **context manager** sets something up and **guarantees cleanup**, even if an exception happens. The `with` statement calls `__enter__` at the start and `__exit__` at the end. Examples: files (closed automatically), locks (released), database transactions (committed or rolled back). Write one as a class or with `@contextlib.contextmanager` (code before `yield` is setup, after is cleanup).

```python
from contextlib import contextmanager

class Tag:
    def __init__(self, name):
        self.name = name
    def __enter__(self):
        print(f"<{self.name}>")
        return self
    def __exit__(self, exc_type, exc, tb):
        print(f"</{self.name}>")
        return False             # False: don't swallow exceptions

@contextmanager
def tag(name):
    print(f"<{name}>")
    try:
        yield
    finally:                     # runs even if the body raises
        print(f"</{name}>")

with Tag("div"):
    with tag("p"):
        print("hello")
```

```text
<div>
<p>
hello
</p>
</div>
```

</details>

### Q59. Why does looping over the same generator twice give nothing the second time? 🔥🔥

<details><summary>Answer</summary>

Generators (and all iterators) are **single-use**: once exhausted, they stay exhausted. Functions like `sum`, `max`, `list`, `in` all consume them. If you need the values twice, store them in a list, or create a new generator.

```python
squares = (x * x for x in range(4))
print(4 in squares)          # consumes 0, 1, 4 to find 4
print(list(squares))         # only what's left
print(list(squares))         # nothing left
```

```text
True
[9]
[]
```

</details>

---

## 7. Memory, Internals & the GIL

Chapters: [02 Variables & Memory](../part-1-python/02-variables-types-memory.md) · [18 Internals & Concurrency](../part-1-python/18-internals-concurrency.md)

### Q60. How does Python manage memory? 🔥🔥🔥

<details><summary>Answer</summary>

In CPython:
1. **Everything is an object on a private heap**, and variables are just names pointing to objects.
2. **Reference counting:** every object counts how many references point to it. When the count hits zero, the object is freed **immediately**.
3. **Cyclic garbage collector:** reference counting can't free cycles (`a.ref = b; b.ref = a`). The `gc` module periodically finds unreachable groups of objects. It is **generational**: new objects are checked often, and objects that survive are moved to older generations that are checked less often (most objects die young).
4. **pymalloc:** small objects (≤ 512 bytes) come from a fast pool allocator, so creating many small objects is cheap. Freed memory is often kept for reuse rather than returned to the operating system.

```python
import gc

class Node:
    def __init__(self):
        self.other = None

a, b = Node(), Node()
a.other, b.other = b, a          # a reference cycle
del a, b                         # refcounts never reach 0 on their own
print(gc.collect() >= 2)         # the cycle collector frees them
```

```text
True
```

</details>

### Q61. What is the GIL? Does Python have true multithreading? 🔥🔥🔥

<details><summary>Answer</summary>

The **Global Interpreter Lock** is a mutex in CPython that lets **only one thread execute Python bytecode at a time**. It exists because reference counting isn't thread-safe, and one big lock made CPython simple and single-thread-fast.

Consequences:
- **CPU-bound** work (pure Python maths, loops) does **not** speed up with threads. Use `multiprocessing` / `ProcessPoolExecutor` (separate processes, each with its own GIL), or C extensions like NumPy that release the GIL.
- **I/O-bound** work (network, disk, sleeping) **does** benefit from threads, because a thread releases the GIL while it waits.
- The GIL doesn't make your code thread-safe: `count += 1` is several bytecodes and can still race (Q79).

Update to mention in interviews: **Python 3.13 ships an experimental free-threaded build** (PEP 703) that can run without the GIL. The default build still has it.

</details>

### Q62. Why is `a is b` True for small integers but sometimes False for big ones? 🔥🔥

<details><summary>Answer</summary>

CPython **pre-creates and caches the integers −5 to 256**; every use of those values refers to the same object, so `is` returns True. Larger integers are created on demand, so two equal big ints computed at run time are usually different objects. (The compiler may also merge equal constants in the same code block, which is why results differ between the REPL and a script.) It's an implementation detail: **compare numbers with `==`**.

```py
a = 256; b = 256
print(a is b)              # True: cached small int
x = int("1000"); y = int("1000")
print(x is y)              # False in CPython: two separate objects
print(x == y)              # True: this is the comparison you want
```

</details>

### Q63. What are CPython, PyPy, Jython? 🔥

<details><summary>Answer</summary>

Python is a **language specification**; these are **implementations**:
- **CPython**: the reference implementation, written in C. What you get from python.org. Has the GIL and the richest C-extension ecosystem.
- **PyPy**: written in (R)Python with a **JIT compiler**; often several times faster on long-running pure-Python code.
- **Jython** (runs on the JVM) and **IronPython** (.NET): integrate with Java / C# libraries; historically lagged behind on Python 3.
- **MicroPython**: a tiny implementation for microcontrollers.

</details>

### Q64. What is bytecode, and how can you see it? 🔥

<details><summary>Answer</summary>

**Bytecode** is the low-level instruction set of the Python virtual machine (`LOAD_FAST`, `BINARY_OP`, `RETURN_VALUE`...). The `dis` module disassembles it. It's useful to see *why* something is not atomic (`x += 1` is a load, an add and a store) or why one version is faster than another. The exact instructions change between Python versions.

```py
import dis

def add_one(x):
    return x + 1

dis.dis(add_one)
# Shows lines like: LOAD_FAST x, LOAD_CONST 1, BINARY_OP (+), RETURN_VALUE
```

</details>

### Q65. Why is Python slower than C/C++, and how can you speed it up? 🔥🔥

<details><summary>Answer</summary>

**Why slow:** every value is a heap object with a type check on each operation (dynamic typing), bytecode is interpreted one instruction at a time, attribute and name lookups go through dictionaries, and the GIL limits CPU parallelism.

**How to speed up (best first):**
1. A **better algorithm / data structure** (O(n²) → O(n log n) beats any micro-optimisation).
2. Use **built-ins and the standard library** (`sum`, `sorted`, `set`, `collections`, `heapq`), which run in C.
3. **Vectorise** with NumPy / pandas.
4. Cache results (`lru_cache`), avoid repeated work in loops, use local variables in hot loops.
5. Use **multiprocessing** for CPU-bound parallel work, **asyncio/threads** for I/O.
6. **PyPy**, **Cython**, **Numba**, or rewrite the hot spot in C/Rust.
7. **Profile first** (`cProfile`, `timeit`): optimise the measured bottleneck, not a guess.

</details>

### Q66. How much memory does a list use? Why does `sys.getsizeof` seem wrong? 🔥

<details><summary>Answer</summary>

`sys.getsizeof(lst)` reports only the list object itself: its header plus the **array of pointers** (8 bytes each on 64-bit), including spare over-allocated slots. It does **not** include the objects the list points to. To measure everything you must sum the sizes of the elements too (or use a tool like `tracemalloc`). Exact numbers vary between Python versions, so don't memorise them.

```py
import sys
nums = list(range(1000))
print(sys.getsizeof(nums))                        # about 8 KB: just the pointer array
print(sum(sys.getsizeof(x) for x in nums))        # the int objects themselves: about 28 KB more
```

</details>

### Q67. What does `del x` actually do? 🔥

<details><summary>Answer</summary>

`del x` **removes the name** `x` from the current namespace and decrements the object's reference count. It does **not** directly destroy the object: the object is freed only if no other references remain. `del lst[i]` and `del d[key]` remove an element from a container.

```python
a = [1, 2, 3]
b = a
del a                    # removes the name 'a' only
print(b)                 # the list is still alive through 'b'
del b[0]                 # removes an element from the list
print(b)
```

```text
[1, 2, 3]
[2, 3]
```

</details>

---

## 8. Exceptions

Chapter: [13 Errors, Exceptions & Files](../part-1-python/13-exceptions-files.md)

### Q68. Explain `try`, `except`, `else` and `finally`. In what order do they run? 🔥🔥🔥

<details><summary>Answer</summary>

- `try`: code that might raise.
- `except`: runs if a matching exception was raised.
- `else`: runs only if **no** exception was raised. Put the "success" code here so its own errors aren't accidentally caught.
- `finally`: **always** runs (success, exception, even `return`). Use it for cleanup.

```python
def divide(a, b):
    try:
        result = a / b
    except ZeroDivisionError:
        print("except: can't divide by zero")
        return None
    else:
        print("else: no error")
        return result
    finally:
        print("finally: always runs")

print(divide(6, 3))
print(divide(1, 0))
```

```text
else: no error
finally: always runs
2.0
except: can't divide by zero
finally: always runs
None
```

</details>

### Q69. How do you create a custom exception? 🔥🔥

<details><summary>Answer</summary>

Subclass `Exception` (not `BaseException`, which also covers `KeyboardInterrupt` and `SystemExit`). Build a small hierarchy so callers can catch a whole family, and attach useful data.

```python
class BankError(Exception):
    """Base class for all bank errors."""

class InsufficientFunds(BankError):
    def __init__(self, balance, amount):
        super().__init__(f"need {amount}, have {balance}")
        self.shortfall = amount - balance

try:
    raise InsufficientFunds(100, 250)
except BankError as e:                 # catches the whole family
    print(type(e).__name__, "-", e, "- short by", e.shortfall)
```

```text
InsufficientFunds - need 250, have 100 - short by 150
```

</details>

### Q70. What is `raise ... from ...`? 🔥

<details><summary>Answer</summary>

It **chains** exceptions: you raise a higher-level error while keeping the original as its `__cause__`, so the traceback shows both ("The above exception was the direct cause of..."). Use it when translating low-level errors into your own. `raise X from None` hides the original.

```python
class ConfigError(Exception):
    pass

def load_port(settings):
    try:
        return int(settings["port"])
    except (KeyError, ValueError) as e:
        raise ConfigError("invalid port setting") from e

try:
    load_port({"port": "eighty"})
except ConfigError as e:
    print(e, "| caused by:", type(e.__cause__).__name__)
```

```text
invalid port setting | caused by: ValueError
```

</details>

### Q71. Why is a bare `except:` (or `except Exception: pass`) a bad idea? 🔥🔥

<details><summary>Answer</summary>

- A bare `except:` catches **everything**, including `KeyboardInterrupt` (Ctrl+C) and `SystemExit`, so your program may refuse to stop.
- Catching too broadly **hides real bugs**: a typo causing `NameError` gets silently swallowed.
- `pass` throws away the information you need to debug.

Catch the **most specific** exception you can actually handle, keep the `try` block small, and at least log what you swallow.

```py
# ❌ hides every bug, even Ctrl+C
try:
    process(data)
except:
    pass

# ✅ specific, small, and visible
try:
    value = int(text)
except ValueError:
    logger.warning("not a number: %r", text)
    value = 0
```

</details>

### Q72. EAFP vs LBYL? 🔥🔥

<details><summary>Answer</summary>

- **LBYL** ("Look Before You Leap"): check first, then act. `if key in d: use(d[key])`.
- **EAFP** ("Easier to Ask Forgiveness than Permission"): just try it and handle the exception. `try: use(d[key]) except KeyError: ...`.

Python culture prefers **EAFP**: it's often faster when failures are rare (one lookup instead of two) and avoids **race conditions** where the situation changes between the check and the action (e.g. a file deleted after `os.path.exists`). Use LBYL when failure is common or the check is cheap and clear.

```python
config = {"debug": True}

value = config["debug"] if "debug" in config else False     # LBYL
try:                                                         # EAFP
    timeout = config["timeout"]
except KeyError:
    timeout = 30
print(value, timeout, config.get("timeout", 30))            # .get is the tidy middle ground
```

```text
True 30 30
```

</details>

---

## 9. Modules & Packages

Chapter: [17 Modules, Packages & the Standard Library](../part-1-python/17-modules-stdlib.md)

### Q73. Module vs package? What is `__init__.py` for? 🔥🔥

<details><summary>Answer</summary>

- A **module** is a single `.py` file.
- A **package** is a directory of modules, imported with dotted names (`shop.payments.upi`).
- `__init__.py` marks a directory as a regular package and **runs when the package is first imported**. Use it to expose a clean API (`from .core import Cart`) or run package setup. Since Python 3.3, a directory without it can still be imported as a **namespace package**, but including `__init__.py` is the normal, explicit choice.

</details>

### Q74. How does `import` work? What happens if you import a module twice? 🔥🔥

<details><summary>Answer</summary>

On `import x`, Python:
1. Checks **`sys.modules`** (a cache of already-imported modules). If found, it reuses it: the module's code runs **only once per process**, no matter how many times it's imported.
2. Otherwise searches **`sys.path`** in order: the script's directory, `PYTHONPATH`, the standard library, then `site-packages` (where pip installs).
3. Creates a module object, **executes the module's code** top to bottom, stores it in `sys.modules`, and binds the name `x`.

```python
import sys
import math
import math as m2           # no second execution: same cached object
print(m2 is math, "math" in sys.modules)
```

```text
True True
```

A common bug: naming your own file `random.py` or `json.py` shadows the standard library module, because your script's folder comes first on `sys.path`.

</details>

### Q75. What causes circular imports and how do you fix them? 🔥

<details><summary>Answer</summary>

`a.py` imports `b`, and `b.py` imports `a`. When `a` starts executing, it imports `b`; `b` then imports `a`, gets the **half-initialised** `a` from `sys.modules`, and fails with `ImportError` / `AttributeError` if it needs a name `a` hasn't defined yet.

Fixes (best first):
1. **Restructure:** move the shared code into a third module both can import.
2. Import the **module**, not names (`import a` then use `a.func` at call time, instead of `from a import func`).
3. Move the import **inside the function** that needs it (a local import).
4. For type hints only, use `from typing import TYPE_CHECKING` and import under `if TYPE_CHECKING:`.

</details>

### Q76. What is a virtual environment and why use one? 🔥🔥

<details><summary>Answer</summary>

A **virtual environment** is an isolated folder with its own Python interpreter link and its own `site-packages`. Each project gets its own dependency versions, so project A can use `django==4.2` while project B uses `5.0`, and nothing pollutes the system Python.

```py
python -m venv .venv                 # create
.venv\Scripts\activate               # Windows
source .venv/bin/activate            # macOS / Linux
pip install requests                 # installs into .venv only
pip freeze > requirements.txt        # record exact versions
pip install -r requirements.txt      # reproduce elsewhere
```

Modern alternatives that manage this for you: `poetry`, `pipenv`, `uv`.

</details>

### Q77. `import module` vs `from module import name` vs `from module import *`? 🔥

<details><summary>Answer</summary>

- `import math` → use `math.sqrt`. Clear origin, no name clashes. Preferred.
- `from math import sqrt` → use `sqrt` directly. Shorter; fine for frequently used names. Note it copies the **binding** at import time: if the module later rebinds `sqrt`, you won't see it.
- `from math import *` → dumps all public names into your namespace. Avoid it: it hides where names come from and can silently overwrite your own names. A module can limit what `*` exports with `__all__`.

</details>

---

## 10. Concurrency

Chapter: [18 Python Internals & Concurrency](../part-1-python/18-internals-concurrency.md)

### Q78. Threads vs processes vs asyncio: when do you use each? 🔥🔥🔥

<details><summary>Answer</summary>

| | `threading` | `multiprocessing` | `asyncio` |
|---|---|---|---|
| Runs | many threads in one process | many processes | many coroutines in **one thread** |
| Memory | shared (needs locks) | separate (share via queues/pipes) | shared, no locks needed between awaits |
| GIL | one thread runs Python at a time | each process has its own GIL | single thread anyway |
| Best for | **I/O-bound** work with blocking libraries | **CPU-bound** work | **lots of concurrent I/O** (thousands of sockets) |
| Cost | medium (OS threads) | high (process start-up, pickling data) | very low per task |
| Switching | pre-emptive (OS decides) | pre-emptive | **cooperative** (only at `await`) |

One-liner: **CPU-bound → processes; I/O-bound → asyncio if the libraries support it, else threads.**

</details>

### Q79. What is a race condition? Show a fix. 🔥🔥

<details><summary>Answer</summary>

A **race condition** happens when the result depends on the unlucky timing of threads. `count += 1` is really *read, add, write*; two threads can both read 5 and both write 6, losing an update. The GIL doesn't prevent this because a thread can be switched out between those steps. Fix it with a **`Lock`** so only one thread runs the critical section at a time (or avoid shared state: use a `queue.Queue`, or give each thread its own counter and combine at the end).

```python
import threading

count = 0
lock = threading.Lock()

def work():
    global count
    for _ in range(100_000):
        with lock:              # acquire, run, always release
            count += 1

threads = [threading.Thread(target=work) for _ in range(4)]
for t in threads:
    t.start()
for t in threads:
    t.join()
print(count)
```

```text
400000
```

Without the lock, the final value is *sometimes* less than 400,000, and how often depends on the Python version and machine. That unpredictability is exactly what makes race conditions dangerous.

</details>

### Q80. Explain `async` / `await`. 🔥🔥

<details><summary>Answer</summary>

`async def` defines a **coroutine**. `await` pauses it until the awaited operation finishes, **handing control back to the event loop**, which runs other coroutines meanwhile. One thread juggles thousands of waiting tasks. `asyncio.gather` runs several concurrently. Key rule: never call blocking functions (`time.sleep`, `requests.get`) inside a coroutine; they freeze the whole loop. Use async libraries (`asyncio.sleep`, `aiohttp`) or `asyncio.to_thread`.

```python
import asyncio
import time

async def fetch(name, delay):
    await asyncio.sleep(delay)          # simulated network wait; the loop runs others meanwhile
    return f"{name} done"

async def main():
    start = time.perf_counter()
    results = await asyncio.gather(fetch("a", 0.2), fetch("b", 0.2), fetch("c", 0.2))
    elapsed = time.perf_counter() - start
    print(results)
    print("ran concurrently:", elapsed < 0.5)    # about 0.2 s, not 0.6 s

asyncio.run(main())
```

```text
['a done', 'b done', 'c done']
ran concurrently: True
```

</details>

### Q81. What is `concurrent.futures`? 🔥

<details><summary>Answer</summary>

A high-level API over threads and processes. `ThreadPoolExecutor` and `ProcessPoolExecutor` share the same interface: `submit(fn, *args)` returns a **Future**; `map(fn, items)` returns results **in input order**. Switching from threads to processes is a one-word change.

```python
from concurrent.futures import ThreadPoolExecutor

def square(x):
    return x * x

with ThreadPoolExecutor(max_workers=4) as pool:
    print(list(pool.map(square, range(6))))
    future = pool.submit(square, 12)
    print(future.result())
```

```text
[0, 1, 4, 9, 16, 25]
144
```

</details>

### Q82. What is a deadlock and how do you avoid it? 🔥

<details><summary>Answer</summary>

A **deadlock** is when two (or more) threads each hold a lock the other needs, so both wait forever. Thread 1 holds lock A and waits for B; thread 2 holds B and waits for A.

Avoid it by:
1. **Always acquiring locks in the same global order** (e.g. by account ID).
2. Holding locks for as short a time as possible, and never calling unknown code while holding one.
3. Using `lock.acquire(timeout=...)` and backing off.
4. Using fewer locks: higher-level tools like `queue.Queue` or message passing.

</details>

### Q83. How do processes share data in `multiprocessing`? 🔥

<details><summary>Answer</summary>

Processes **don't share memory** by default; each has its own copy. Data is passed by **pickling** (serialising) it. Options:
- `multiprocessing.Queue` / `Pipe`: send messages between processes.
- `Pool.map` / `ProcessPoolExecutor.map`: arguments and results are pickled for you.
- `Value` / `Array`: small shared-memory primitives with their own locks.
- `multiprocessing.shared_memory`: raw shared buffers (e.g. big NumPy arrays).
- `Manager()`: proxy objects (shared dict/list) via a server process, convenient but slow.

On Windows and macOS, processes are started with **spawn**, so the entry code must sit under `if __name__ == "__main__":`.

```py
from multiprocessing import Pool

def cube(x):
    return x ** 3

if __name__ == "__main__":
    with Pool(4) as pool:
        print(pool.map(cube, range(5)))   # [0, 1, 8, 27, 64]
```

</details>

---

## 11. Tricky Output Puzzles

Interviewers love "what does this print?". Predict **before** opening the answer. Each one tests a real concept.

### Q84. `+=` vs `+` on a shared list 🔥🔥

```py
a = [1, 2]
b = a
b += [3]
b = b + [4]
print(a, b)
```

<details><summary>Answer</summary>

```python
a = [1, 2]
b = a
b += [3]          # in-place extend: a and b are still the same list
b = b + [4]       # builds a NEW list and rebinds b only
print(a, b)
```

```text
[1, 2, 3] [1, 2, 3, 4]
```

For lists, `+=` calls `__iadd__` (mutates in place), while `+` creates a new object.

</details>

### Q85. What type is `(1)`? 🔥

<details><summary>Answer</summary>

Parentheses alone don't make a tuple: **the comma does**.

```python
print(type((1)).__name__, type((1,)).__name__, type(()).__name__)
t = 1, 2
print(t)
```

```text
int tuple tuple
(1, 2)
```

</details>

### Q86. Float comparison 🔥🔥🔥

```py
print(0.1 + 0.2 == 0.3)
```

<details><summary>Answer</summary>

Floats are stored in **binary**, and 0.1 has no exact binary representation (like 1/3 in decimal), so tiny errors appear. Compare with a tolerance, or use `decimal.Decimal` / `fractions.Fraction` for exact arithmetic (money!).

```python
import math
from decimal import Decimal

print(0.1 + 0.2 == 0.3, 0.1 + 0.2)
print(math.isclose(0.1 + 0.2, 0.3))
print(Decimal("0.1") + Decimal("0.2") == Decimal("0.3"))
```

```text
False 0.30000000000000004
True
True
```

</details>

### Q87. `round()` surprises 🔥🔥

```py
print(round(0.5), round(1.5), round(2.5), round(2.675, 2))
```

<details><summary>Answer</summary>

Python 3 uses **banker's rounding** (round half to even): ties go to the nearest **even** number, which avoids a statistical upward bias. And `2.675` is actually stored as 2.67499999..., so it rounds down.

```python
print(round(0.5), round(1.5), round(2.5), round(2.675, 2))
```

```text
0 2 2 2.67
```

</details>

### Q88. Booleans are integers 🔥🔥

```py
print(True + True, True * 10, sum([True, False, True]))
print({True: "a", 1: "b", 1.0: "c"})
```

<details><summary>Answer</summary>

`bool` is a subclass of `int`: `True == 1` and `False == 0`. And since `True == 1 == 1.0` and their hashes are equal, they're the **same dict key**. The first key object (`True`) is kept; the value is overwritten each time.

```python
print(True + True, True * 10, sum([True, False, True]))
print({True: "a", 1: "b", 1.0: "c"})
```

```text
2 10 2
{True: 'c'}
```

`sum(flags)` counting True values is a handy idiom.

</details>

### Q89. Mutating a list inside a tuple 🔥

```py
t = ([1, 2],)
t[0] += [3]
```

<details><summary>Answer</summary>

It **raises** `TypeError`... **and** changes the list anyway! `t[0] += [3]` does two steps: (1) `t[0].__iadd__([3])` extends the list in place (succeeds), then (2) `t[0] = result` tries to assign into the tuple (fails).

```python
t = ([1, 2],)
try:
    t[0] += [3]
except TypeError as e:
    print("TypeError:", e)
print(t)
```

```text
TypeError: 'tuple' object does not support item assignment
([1, 2, 3],)
```

Safe way: `t[0].append(3)` or `t[0].extend([3])`.

</details>

### Q90. Removing items while looping 🔥🔥

```py
nums = [1, 2, 2, 3, 2]
for x in nums:
    if x == 2:
        nums.remove(x)
print(nums)
```

<details><summary>Answer</summary>

The loop uses an internal index. Removing an element shifts everything left, so the element right after a removed one is **skipped**.

```python
nums = [1, 2, 2, 3, 2]
for x in nums:
    if x == 2:
        nums.remove(x)
print(nums)

nums = [1, 2, 2, 3, 2]
nums = [x for x in nums if x != 2]     # build a new list instead
print(nums)
```

```text
[1, 3, 2]
[1, 3]
```

</details>

### Q91. `UnboundLocalError` 🔥🔥

```py
x = 10
def f():
    print(x)
    x = 20
f()
```

<details><summary>Answer</summary>

Because `x` is **assigned** somewhere inside `f`, the compiler marks `x` as **local for the whole function**. So `print(x)` looks for a local `x` that hasn't been assigned yet, even though a global `x` exists.

```python
x = 10
def f():
    print(x)
    x = 20

try:
    f()
except UnboundLocalError as e:
    print("UnboundLocalError:", e)
```

```text
UnboundLocalError: cannot access local variable 'x' where it is not associated with a value
```

Fix: use `global x` (rarely a good idea), or better, pass the value in as a parameter.

</details>

### Q92. `return` inside `finally` 🔥

```py
def f():
    try:
        return "try"
    finally:
        return "finally"
print(f())
```

<details><summary>Answer</summary>

`finally` always runs, and a `return` there **overrides** the earlier return (it would even swallow an exception!). That's why returning from `finally` is considered bad practice, and Python 3.14 emits a `SyntaxWarning` for it.

```py
print(f())    # finally
```

</details>

### Q93. `all([])` and `any([])` 🔥

<details><summary>Answer</summary>

`all` of nothing is **True** ("no element is falsy" is vacuously true), and `any` of nothing is **False** ("there is no truthy element").

```python
print(all([]), any([]), all([0]), any([0, "", None, 3]))
```

```text
True False False True
```

</details>

### Q94. Slice vs index out of range 🔥

<details><summary>Answer</summary>

Indexing past the end raises `IndexError`; slicing past the end just returns what exists (possibly empty).

```python
s = "abc"
print(repr(s[5:]), repr(s[1:100]), s[-1])
try:
    s[5]
except IndexError as e:
    print("IndexError:", e)
```

```text
'' 'bc' c
IndexError: string index out of range
```

</details>

### Q95. Chained comparisons in disguise 🔥

```py
print(1 < 3 > 2)
print(False == False in [False])
```

<details><summary>Answer</summary>

Comparison operators (including `in`, `is`, `==`) chain: `a op1 b op2 c` means `(a op1 b) and (b op2 c)`. So the second line is `(False == False) and (False in [False])`, not `(False == False) in [False]`.

```python
print(1 < 3 > 2)
print(False == False in [False])
print((False == False) in [False])
```

```text
True
True
False
```

</details>

### Q96. Default argument evaluated once, with a timestamp 🔥🔥

```py
import time
def log(msg, when=time.time()):
    print(when, msg)
```

<details><summary>Answer</summary>

Every call prints **the same time**: the default was computed once, when `def` ran (same root cause as Q29). Use `when=None` and compute it inside.

```python
calls = []
def stamp():
    calls.append(len(calls) + 1)
    return len(calls)

def log(msg, when=stamp()):        # stamp() runs ONCE, at definition
    return (when, msg)

print(log("a"), log("b"), len(calls))
```

```text
(1, 'a') (1, 'b') 1
```

</details>

### Q97. Class attribute vs instance attribute shadowing 🔥🔥

```py
class A:
    x = 1
a, b = A(), A()
a.x = 5
A.x = 10
print(a.x, b.x)
```

<details><summary>Answer</summary>

`a.x = 5` creates an **instance** attribute on `a` that shadows the class attribute. `b` has no instance attribute, so it reads the class attribute, which is now 10.

```python
class A:
    x = 1

a, b = A(), A()
a.x = 5
A.x = 10
print(a.x, b.x, a.__dict__, b.__dict__)
```

```text
5 10 {'x': 5} {}
```

</details>

---

## 🧠 Never-Forget Summary

- **`is` = same object, `==` = same value.** Use `is` only for `None`/singletons.
- **Mutable defaults are shared.** Use `None` and create inside.
- **Python passes object references.** Mutation is visible to the caller; rebinding is not.
- **Shallow copy shares inner objects**; `[[0]*n]*m` shares rows.
- **Dict/set = hash tables**, O(1) average; keys must be hashable; dicts keep insertion order (3.7+).
- **Generators are lazy and single-use.** Comprehension `[]` builds a list; `()` builds a generator.
- **Decorator = function in, function out** (`functools.wraps`!). With arguments, add one more layer.
- **Context managers guarantee cleanup** (`__enter__` / `__exit__`, or `@contextmanager`).
- **Memory:** reference counting + generational cycle collector.
- **GIL:** one thread runs bytecode at a time. CPU-bound → processes; I/O-bound → threads/asyncio.
- **`super()` follows the MRO**, not just "the parent".
- **`else` on loops = "no break"; `else` on try = "no exception"; `finally` = always.**

**Memory hook: "MID-GAP"**, the six things interviewers check most: **M**utable defaults, **I**s vs ==, **D**ecorators, **G**enerators, **A**rgs/kwargs, **P**ass-by-object-reference. (Then add the GIL as the "boss question".)

**One picture:**

| Topic | The one sentence to say |
|---|---|
| list vs tuple | mutable collection vs immutable record (hashable) |
| dict | hash table, O(1) average, insertion-ordered |
| copy | shallow shares inner objects, deep copies everything |
| args | `*args` tuple, `**kwargs` dict |
| closure | inner function remembering outer variables (late binding!) |
| generator | lazy, pauses at `yield`, single-use |
| decorator | `f = deco(f)` wrapping behaviour |
| context manager | setup + guaranteed cleanup |
| `__repr__` / `__str__` | developers / users |
| staticmethod / classmethod | no `self` / gets `cls`, alternative constructors |
| memory | refcounting + cyclic GC |
| GIL | one bytecode thread at a time; processes for CPU work |

> **If you remember only one thing:** in Python, **names point to objects**. Almost every tricky question (mutable defaults, copies, `is`, pass-by-reference, aliasing) is that one idea in disguise.

---
**Next:** [Chapter 03 · The Must-Do Problem List](03-must-do-problems.md)  ·  **Back to** [Contents](../README.md)
