# Chapter 02 · Python Interview Questions

> DSA round se pehle, kaafi interviews das minute ke "quick Python questions" se shuru hote hain. Yeh sawaal aasaan dikhte hain, aur isi wajah se inme atakna sabse zyada chubhta hai. Yeh chapter poora question bank hai: woh sawaal jo sach mein poochhe jaate hain, har ek ke saath ek crisp answer jo tum ek minute se kam mein bol sako.

**Is chapter ko kaise use karo:**
- Sawaal padho, **pehle zor se khud answer bolo**, phir answer kholo. Bolna aur pehchaanna, dono bilkul alag cheezein hain.
- 🔥🔥🔥 = bahut baar poochha jaata hai, 🔥🔥 = aksar, 🔥 = kabhi-kabhi. Time kam hai? Pehle saare 🔥🔥🔥 karo.
- Har answer Part 1 ke us chapter se link hai jo use detail mein sikhata hai.
- Jo code `python` mark hai, woh as-is chalta hai. Khud type karo aur run karne se pehle output predict karo.

**Isse pehle padho:** [Part 1 · Python from Scratch](../part-1-python/01-getting-started.md). Yeh chapter revision hai, pehli baar padhaai nahi.

> 🇮🇳 **Desi Analogy:** Yeh chapter board exam se pehle wali **"important questions" ki guide** jaisa hai. Tum poori textbook pehle padh chuke ho (Part 1). Ab exam se ek raat pehle tumhe chahiye: kaunse sawaal baar-baar aate hain (🔥🔥🔥), unka ekdum pakka, short answer, aur ek example jo examiner (interviewer) ko impress kare. Bas farak itna hai ki yahan answer **bolna** hai, likhna nahi. Isliye har 🔥🔥🔥 ke neeche ek "Interview mein aise bolo" English line bhi di gayi hai.

---

## Contents · Is Chapter Mein Kya Hai

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

(Section headings English mein hi rakhi gayi hain, taaki upar ke links seedha sahi jagah le jaayein.)

---

## 1. Basics

Chapters: [01](../part-1-python/01-getting-started.md) · [02](../part-1-python/02-variables-types-memory.md) · [03](../part-1-python/03-operators-expressions.md) · [05](../part-1-python/05-conditionals.md) · [06](../part-1-python/06-loops.md)

### Q1. Is Python compiled or interpreted? 🔥🔥

<details><summary>Answer dekho 👀</summary>

Ek tarah se dono. Jab tum `python app.py` chalate ho, toh **CPython** (standard implementation) pehle tumhare source code ko **bytecode** mein **compile** karta hai. Bytecode ek virtual machine ke liye simple instructions ki list hai. Phir **Python Virtual Machine** (C mein likha ek interpreter loop) us bytecode ko ek-ek instruction karke chalata hai. Import kiye gaye modules ka bytecode `__pycache__/*.pyc` files mein cache ho jaata hai, taaki agli baar compile step skip ho jaaye.

Toh imaandaar answer yeh hai: "Python source is compiled to bytecode, and the bytecode is interpreted. It is not compiled to machine code ahead of time like C." (PyPy ek JIT compiler jodta hai jo baar-baar chalne wale "hot" bytecode ko run time pe machine code mein badal deta hai.)

</details>

### Q2. What does "dynamically typed" and "strongly typed" mean for Python? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

- **Dynamically typed:** type **objects** ka hota hai, variables ka nahi. Ek naam abhi int ko point kar sakta hai aur baad mein string ko. Types run time pe check hote hain, pehle nahi.
- **Strongly typed:** Python alag-alag types ke beech chupchaap conversion nahi karta. `"1" + 1` error hai, na `"11"` banta hai na `2`.

```python
x = 10
print(type(x).__name__)
x = "ten"                      # wahi naam, ab str ko point karta hai: dynamic typing
print(type(x).__name__)
try:
    print("1" + 1)             # koi silent conversion nahi: strong typing
except TypeError as e:
    print("TypeError:", e)
```

```text
int
str
TypeError: can only concatenate str (not "int") to str
```

> 🤔 **Mann mein sawaal:** Dynamic aur strong ek saath kaise? Mujhe laga dynamic matlab "weak" hota hai.
>
> **Jawab:** Yeh do alag sawaalon ke jawab hain. **Dynamic vs static** poochta hai: "type *kab* check hota hai?" (run time pe ya code chalne se pehle). **Strong vs weak** poochta hai: "kya language khud se types mix kar degi?" JavaScript dynamic **aur** weak hai (`"1" + 1` = `"11"`). Python dynamic **aur** strong hai (error). Java static aur strong hai.

> 🗣️ **Interview mein aise bolo:** "Python is dynamically typed because types are attached to objects, not variables, and they're checked at run time. It's also strongly typed, because it never silently converts between unrelated types: `"1" + 1` raises a TypeError instead of guessing."

</details>

### Q3. What is PEP 8? 🔥

<details><summary>Answer dekho 👀</summary>

**PEP 8** Python ka official style guide hai (PEP matlab "Python Enhancement Proposal"). Main rules: 4-space indentation, functions aur variables ke liye `snake_case`, classes ke liye `PascalCase`, constants ke liye `UPPER_CASE`, lines lagbhag 79–99 characters, top-level definitions ke beech do blank lines, aur imports sabse upar teen groups mein: standard library / third-party / local. `black`, `ruff` aur `flake8` jaise tools ise automatically enforce karte hain.

</details>

### Q4. What's the difference between `is` and `==`? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

- `==` poochta hai: **kya dono ki values barabar hain?** (yeh `__eq__` call karta hai)
- `is` poochta hai: **kya dono memory mein ekdum same object hain?** (yeh `id()` compare karta hai)

> 🇮🇳 **Desi Analogy:** Do judwa bhai, Ram aur Shyam. Shakal ekdum same, kapde same (`==` True). Lekin Aadhaar number alag hai, yeh do alag insaan hain (`is` False). Ab Ram ka nickname "Pappu" hai. "Pappu" aur "Ram" ek hi insaan ke do naam hain (`is` True). Pappu ko chot lagi, toh Ram ko bhi lagi, kyunki banda ek hi hai. Code mein `c = a` bilkul yahi nickname wala case hai.

```python
a = [1, 2, 3]
b = [1, 2, 3]
c = a
print(a == b, a is b)    # values barabar, lekin do alag list objects
print(a == c, a is c)    # c usi object ka bas doosra naam hai
```

```text
True False
True True
```

`is` sirf singletons ke liye use karo: `x is None`, `x is True`. Numbers ya strings compare karne ke liye `is` kabhi mat use karo: caching ki wajah se yeh *kaam karta dikh* sakta hai (Q62 dekho) aur phir achanak toot jaata hai.

> 🗣️ **Interview mein aise bolo:** "`==` compares values by calling `__eq__`, while `is` checks identity, whether both names point to the very same object in memory. I use `is` only for singletons like `None`, and `==` for everything else, because small-int and string caching can make `is` look like it works when it isn't guaranteed."

</details>

### Q5. Which types are mutable and which are immutable? Why does it matter? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

| Immutable (banne ke baad badal nahi sakte) | Mutable (wahin ke wahin badal sakte hain) |
|---|---|
| `int`, `float`, `complex`, `bool`, `str`, `bytes`, `tuple`, `frozenset`, `None` | `list`, `dict`, `set`, `bytearray`, zyaadatar user-defined objects |

Yeh kyun matter karta hai:
1. **Dict keys aur set members hashable hone chahiye**, jiska practical matlab hai immutable.
2. **Aliasing:** agar do naam ek hi mutable object ko point karte hain, toh ek naam se kiya gaya change doosre naam se bhi dikhega.
3. **Function arguments:** function tumhari pass ki hui list ko mutate kar sakta hai, lekin tumhara int nahi badal sakta (Q30).
4. Immutable object ko "badalna" asal mein naya object banana hai: `s += "x"` ek nayi string banata hai.

> 🗣️ **Interview mein aise bolo:** "Immutable types like int, str, tuple and frozenset can't change after creation; lists, dicts and sets can. It matters for three reasons: only hashable, effectively immutable objects can be dict keys or set members; mutable objects can be changed through any alias; and a function can mutate a list I pass in but never my int."

</details>

### Q6. What are truthy and falsy values? 🔥🔥

<details><summary>Answer dekho 👀</summary>

`if` ya `while` mein har object ko True ya False maana jaata hai. **Falsy:** `False`, `None`, `0`, `0.0`, `0j`, `""`, `[]`, `()`, `{}`, `set()`, `range(0)`, aur woh objects jinka `__bool__` False return kare ya `__len__` 0 return kare. **Baaki sab truthy hai.**

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

Dhyaan do, `"0"` aur `[0]` truthy hain: non-empty string ya list truthy hoti hai, andar chahe kuch bhi ho. Khaali dabba = False, kuch bhi rakha hua dabba = True, chahe usme zero rakha ho.

</details>

### Q7. What do `/`, `//` and `%` return, especially with negative numbers? 🔥🔥

<details><summary>Answer dekho 👀</summary>

- `/` true division hai aur **hamesha float return karta hai**.
- `//` **floor** division hai: **negative infinity** ki taraf round karta hai, zero ki taraf nahi.
- `%` ka sign **divisor ke sign** jaisa hota hai, taaki `a == (a // b) * b + a % b` hamesha sach rahe.

```python
print(7 / 2, 6 / 2)
print(7 // 2, -7 // 2)
print(7 % 3, -7 % 3, 7 % -3)
print(int(-7 / 2))       # zero ki taraf truncation, C/Java jaisa
```

```text
3.5 3.0
3 -4
1 2 -2
-3
```

`-7 // 2` ko number line pe socho: `-3.5` ke neeche wala integer `-4` hai (floor matlab "neeche wala"), `-3` nahi. Aur check: `(-4) * 2 + 1 = -7`, toh `-7 % 2 = 1`. C++/Java se solution port karne walon ko yeh kaat-ta hai: Python mein `-7 // 2` `-4` hai, Java mein `-3`.

</details>

### Q8. What does `if __name__ == "__main__":` do? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

Har module mein ek built-in variable `__name__` hota hai. Jab file **seedha run** ki jaati hai, Python use `"__main__"` set karta hai. Jab file **import** hoti hai, `__name__` module ka naam hota hai (jaise `"utils"`). Toh is check ke neeche ka code sirf tab chalta hai jab tum file execute karte ho, tab nahi jab koi use import karta hai. Isi tarah ek file reusable module bhi ban sakti hai aur runnable script bhi (aur Windows aur macOS pe `multiprocessing` ke liye yeh zaroori hai).

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

> 🗣️ **Interview mein aise bolo:** "Every module has a `__name__` variable. It's set to `"__main__"` only when the file is run directly, and to the module's name when it's imported. So code under that check runs as a script entry point but not on import, which lets one file be both a reusable module and a runnable program. It's also required for multiprocessing on Windows and macOS."

</details>

### Q9. Explain `break`, `continue`, `pass` and the loop `else` clause. 🔥🔥

<details><summary>Answer dekho 👀</summary>

- `break`: loop se abhi bahar niklo.
- `continue`: agli iteration pe jao.
- `pass`: kuch mat karo (placeholder, jahan syntax ko ek statement chahiye).
- Loop `else`: sirf tab chalta hai jab loop **bina** `break` ke khatam hua. Ise "no break" samjho.

```python
def find_first_even(nums):
    for x in nums:
        if x % 2 == 0:
            print("found", x)
            break
    else:                      # sirf tab chalta hai jab break nahi hua
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

<details><summary>Answer dekho 👀</summary>

Yeh **operands mein se ek** return karte hain, zaroori nahi ki `True`/`False`:
- `a or b`: agar `a` truthy hai toh `a`, warna `b`.
- `a and b`: agar `a` falsy hai toh `a`, warna `b`.

**Short-circuiting:** agar left side se hi result tay ho gaya, toh right side evaluate hi nahi hoti. Isiliye `if node and node.val > 0` safe hai jab `node` `None` ho.

```python
print(0 or "default", "x" or "default")
print(0 and 1 / 0, 3 and 5)          # 1 / 0 kabhi chalta hi nahi
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

<details><summary>Answer dekho 👀</summary>

| | List | Tuple |
|---|---|---|
| Mutable? | Haan | Nahi |
| Syntax | `[1, 2]` | `(1, 2)` ya `1, 2` |
| Hashable (dict key)? | Nahi | Haan, agar saare items hashable hain |
| Typical use | Ek jaisi cheezon ka collection jo badhta/ghatta hai | Ek fixed record: `(x, y)`, `(name, age)`, kai values return karna |
| Memory / speed | Thoda bada (badhne ke liye extra jagah rakhta hai) | Thoda chhota, banane mein tez |

Rule of thumb: **list "ek jaisi bahut saari cheezon" ke liye, tuple "kai hisson se bani ek cheez" ke liye**.

> 🗣️ **Interview mein aise bolo:** "A list is mutable and meant for a collection of similar items that can grow or shrink. A tuple is immutable, so it's hashable when its items are, which means it can be a dict key; I use it for fixed records like coordinates or for returning several values. Tuples are also slightly smaller and faster to create."

</details>

### Q12. How is a Python list implemented? What is the cost of `append`, `insert(0, x)` and `x in list`? 🔥🔥

<details><summary>Answer dekho 👀</summary>

List ek **dynamic array** hai: objects ke pointers ka ek contiguous block. Jab yeh bhar jaata hai, CPython ek bada block allocate karta hai (thoda extra over-allocate karta hai) aur pointers copy kar deta hai. Kyunki resize kabhi-kabhi hota hai aur size geometric tarah se badhta hai, `append` **amortised O(1)** hai.

| Operation | Cost | Kyun |
|---|---|---|
| `lst[i]`, `lst[i] = x` | O(1) | array mein seedha offset |
| `append`, `pop()` | O(1) amortised | end pe, kuch shift nahi hota |
| `insert(0, x)`, `pop(0)` | O(n) | har element ek jagah khisakta hai |
| `x in lst`, `lst.index(x)` | O(n) | linear scan |
| `lst[a:b]` | O(b − a) | nayi list copy hoti hai |
| `sort()` | O(n log n) | Timsort |

Dono ends pe fast operations chahiye? `collections.deque` use karo.

</details>

### Q13. What is a set? When would you use it? What's a frozenset? 🔥🔥

<details><summary>Answer dekho 👀</summary>

**Set** **unique, hashable** items ka unordered collection hai, jo hash table pe bana hai. Membership test `x in s`, `add` aur `remove` **average O(1)** hain. Ise duplicates hatane, fast "kya maine yeh dekha hai?" checks, aur set maths ke liye use karo.

**Frozenset** immutable set hai, isliye hashable hai aur dict key ya kisi doosre set ka element ban sakta hai.

```python
a, b = {1, 2, 3}, {2, 3, 4}
print(a | b, a & b, a - b, a ^ b)      # union, intersection, difference, symmetric difference
print(sorted(set([3, 1, 3, 2, 1])))   # duplicates hatao
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

<details><summary>Answer dekho 👀</summary>

Dict ek **hash table** hai. `d[key] = value` store karne ke liye Python `hash(key)` calculate karta hai, usse ek slot chunta hai, aur wahan key, value aur hash rakh deta hai. Lookup pe woh key ko phir hash karta hai, slot pe jump karta hai, aur `==` se confirm karta hai (kyunki alag keys ka hash same ho sakta hai: isse **collision** kehte hain, jo doosre slots probe karke solve hota hai). Jab table lagbhag do-tihaai bhar jaati hai, toh resize hoti hai aur sab kuch dobara insert hota hai.

> 🇮🇳 **Desi Analogy:** Railway ka **PNR system** socho. Tumhara PNR number (key) ek formula se seedha batata hai ki record kis "khaane" (slot) mein hai, isliye poori list nahi chhaan-ni padti. Kabhi do PNR ka formula ek hi khaana de de (collision), toh system paas wala khaali khaana dekh leta hai, aur confirm karne ke liye PNR poora match karta hai (`==`). Jab khaane bahut bhar jaayein, toh bada register le ke sab entries naye sire se likhi jaati hain (resize).

- get / set / delete / `in` ka average cost: **O(1)**. Worst case (bahut saare collisions): O(n).
- CPython 3.6 se (aur language ki guarantee **3.7** se), dicts **insertion order yaad rakhte hain**. Modern CPython entries ko insertion order mein ek compact array mein rakhta hai, plus ek alag chhoti index table, jo memory bhi bachati hai.

> 🗣️ **Interview mein aise bolo:** "A dict is a hash table. Python hashes the key to pick a slot, and on lookup it hashes again and confirms with `==`, since different keys can collide; collisions are resolved by probing. Get, set, delete and membership are O(1) on average, O(n) in the worst case. Since Python 3.7, dicts are guaranteed to preserve insertion order."

</details>

### Q15. What can be used as a dictionary key? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

Koi bhi **hashable** object: jiska `__hash__` uski poori zindagi mein kabhi na badle aur jiska `__eq__` usse consistent ho. Practically: numbers, strings, `None`, hashables ke tuples, frozensets, aur user objects (by default identity se hash hote hain). **Lists, dicts aur sets** keys **nahi** ban sakte kyunki woh mutable hain: agar insert karne ke baad key badal jaaye, toh uska hash badal jaayega aur dict use kabhi dobara dhoondh nahi paayegi.

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

Interview tip: list ko key banana ho (jaise anagrams ko letter counts se group karna), toh pehle use tuple mein convert karo.

> 🗣️ **Interview mein aise bolo:** "Any hashable object can be a key: its hash must never change and must be consistent with `__eq__`. So numbers, strings, tuples of hashables and frozensets work, but lists, dicts and sets don't, because if a key mutated after insertion its hash would change and the dict could never find it. If I need a list as a key, I convert it to a tuple."

</details>

### Q16. What is the difference between a shallow copy and a deep copy? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

- **Assignment** (`b = a`) kuch copy nahi karta: dono naam same object ko point karte hain.
- **Shallow copy** (`a.copy()`, `list(a)`, `a[:]`, `copy.copy(a)`) ek naya bahar wala container banata hai, lekin **andar ke objects shared** rehte hain.
- **Deep copy** (`copy.deepcopy(a)`) sab kuch recursively copy karta hai.

> 🇮🇳 **Desi Analogy:** Shaadi ke liye guest list ki photocopy (shallow copy) banayi. Kaagaz naya hai, lekin us pe likhe har parivaar ka WhatsApp group wahi purana hai. Kisi parivaar ke group mein naya member juda, toh dono copies mein woh dikhega, kyunki dono ek hi group ko point karti hain. Deep copy matlab har parivaar ka bhi alag naya group bana diya: ab ek mein badlaav doosre ko chhoota bhi nahi.

```python
import copy

a = [[1, 2], [3, 4]]
shallow = a.copy()
deep = copy.deepcopy(a)
a[0].append(99)            # ek ANDAR wali list ko mutate karo
print(shallow)             # change dikhta hai: andar ki lists shared hain
print(deep)                # poori tarah independent
print(shallow is a, shallow[0] is a[0])
```

```text
[[1, 2, 99], [3, 4]]
[[1, 2], [3, 4]]
False True
```

> 🗣️ **Interview mein aise bolo:** "Assignment copies nothing, it just adds another name. A shallow copy, like `list.copy()` or slicing, creates a new outer container but shares the inner objects, so mutating a nested list shows up in both. A deep copy with `copy.deepcopy` recursively copies everything, so the two are fully independent."

</details>

### Q17. Why does `[[0] * 3] * 3` behave strangely? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

Bahar wali list pe `* 3` **reference** ko teen baar copy karta hai, toh teeno rows *ek hi* andar wali list hain. Ek row badlo, toh "saari" badal jaati hain. Har row ke liye comprehension se nayi list banao.

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

Andar wala `[0] * 3` theek hai kyunki ints immutable hain: tum unhe replace karte ho, kabhi mutate nahi karte. DP tables banate waqt yeh **#1 bug** hai.

> 🗣️ **Interview mein aise bolo:** "Multiplying the outer list copies the reference to the same inner list three times, so all rows are one object and changing one changes them all. The inner `[0] * 3` is fine because ints are immutable. The fix is a comprehension, `[[0] * 3 for _ in range(3)]`, which builds a fresh row each time."

</details>

### Q18. What useful tools are in the `collections` module? 🔥🔥

<details><summary>Answer dekho 👀</summary>

| Tool | Yeh kya hai | Typical use |
|---|---|---|
| `Counter` | ginti karne wali dict | frequencies, anagram checks, `most_common(k)` |
| `defaultdict(factory)` | dict jo missing values khud bana deti hai | grouping (`defaultdict(list)`), adjacency lists |
| `deque` | double-ended queue, dono ends pe O(1) | BFS, sliding windows |
| `namedtuple` | field names wala tuple | halke immutable records |
| `OrderedDict` | `move_to_end` aur `popitem(last=False)` wali dict | LRU caches |

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

<details><summary>Answer dekho 👀</summary>

- `lst.sort()` **in place** sort karta hai aur `None` return karta hai. Yeh sirf lists ke paas hai.
- `sorted(iterable)` ek **nayi list** return karta hai aur kisi bhi iterable pe kaam karta hai.
- `key=` ek function hai jo har element pe lagta hai aur compare karne wali value deta hai. `reverse=True` order ulta kar deta hai.
- Python **Timsort** use karta hai: worst case O(n log n), already-sorted data pe O(n), aur **stable** (barabar keys apna original order rakhti hain). Stability ki wajah se tum kai keys se alag-alag passes mein sort kar sakte ho.

```python
people = [("asha", 25), ("ravi", 22), ("bina", 25), ("dev", 22)]
print(sorted(people, key=lambda p: p[1]))                 # stable: asha pehle, bina baad mein
print(sorted(people, key=lambda p: (-p[1], p[0])))        # age desc, phir name asc
nums = [3, 1, 2]
print(nums.sort(), nums)
```

```text
[('ravi', 22), ('dev', 22), ('asha', 25), ('bina', 25)]
[('asha', 25), ('bina', 25), ('dev', 22), ('ravi', 22)]
None [1, 2, 3]
```

Teesri line ka trap: `nums.sort()` `None` deta hai. Isliye `nums = nums.sort()` likhoge toh list gayi, `nums` ab `None` hai.

</details>

### Q20. List comprehension vs generator expression? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

- `[x * x for x in data]` **poori list turant memory mein** bana deta hai. Tum use index kar sakte ho aur kai baar loop kar sakte ho.
- `(x * x for x in data)` ek **generator** banata hai: values **lazily**, ek-ek karke banti hain, O(1) memory mein. Ise sirf **ek baar** consume kiya ja sakta hai.

Generator tab use karo jab sirf ek baar loop karna ho, khaaskar bade data pe ya jab `sum`, `max`, `any`, `all` ko feed kar rahe ho.

```python
squares_list = [x * x for x in range(5)]
squares_gen = (x * x for x in range(5))
print(squares_list, type(squares_gen).__name__)
print(sum(squares_gen))
print(sum(squares_gen))          # pehle hi khatam ho chuka
print(sum(x * x for x in range(10**6)))   # das laakh elements ki koi list nahi banti
```

```text
[0, 1, 4, 9, 16] generator
30
0
333332833333500000
```

> 🗣️ **Interview mein aise bolo:** "A list comprehension builds the whole list in memory immediately, so I can index it and iterate it many times. A generator expression produces values lazily, one at a time, in constant memory, but it can only be consumed once. I prefer a generator when I iterate once over large data, for example inside `sum` or `any`."

</details>

---

## 3. Strings

Chapter: [04 Strings Deep Dive](../part-1-python/04-strings.md)

### Q21. Strings are immutable. Why is `s += c` in a loop a problem, and what should you do? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

Har `s += c` ek **nayi string** bana sakta hai aur saare purane characters copy kar sakta hai, toh is tarah length n ki string banana worst case mein O(n²) ho sakta hai. (CPython kabhi-kabhi ise in place optimise kar leta hai, lekin us pe bharosa nahi kar sakte.) Sahi idiom: pieces ko ek list mein ikattha karo aur ek baar `"".join()` karo: total O(n).

Kyun n²? Pehli baar 1 character copy, phir 2, phir 3... n tak. `1 + 2 + ... + n` lagbhag n²/2 hai.

```python
parts = []
for i in range(5):
    parts.append(str(i))
print("".join(parts), "-".join(parts))
```

```text
01234 0-1-2-3-4
```

> 🗣️ **Interview mein aise bolo:** "Strings are immutable, so each `+=` can create a new string and copy everything built so far, which is O(n²) overall in the worst case. CPython sometimes optimises it, but that's not guaranteed. The idiomatic fix is to append pieces to a list and call `''.join()` once at the end, which is O(n)."

</details>

### Q22. How do you reverse a string? Explain slicing. 🔥🔥

<details><summary>Answer dekho 👀</summary>

Slicing hai `s[start:stop:step]`: start shaamil hai, stop shaamil nahi hai, aur koi bhi hissa chhoda ja sakta hai. Negative step peeche ki taraf chalta hai, isliye `s[::-1]` reverse karta hai. Slices **kabhi IndexError raise nahi karte**; woh valid range tak clamp ho jaate hain.

```python
s = "python"
print(s[::-1], s[1:4], s[-3:], s[::2])
print(s[10:], "".join(reversed(s)))
```

```text
nohtyp yth hon pto
 nohtyp
```

(Doosri line `s[10:]` ki empty string se shuru hoti hai, phir `print` ka ek space aata hai. Isliye line space se shuru dikhti hai.)

</details>

### Q23. What are the ways to format strings? 🔥

<details><summary>Answer dekho 👀</summary>

Teen tareeke hain, sabse naya aur preferred pehle:

```python
name, score = "Asha", 92.456
print(f"{name} scored {score:.1f}")            # f-string (3.6+): sabse tez, sabse readable
print("{} scored {:.1f}".format(name, score))  # str.format
print("%s scored %.1f" % (name, score))        # purana %-formatting
print(f"{score=:.2f}", f"{42:08b}", f"{1234567:,}", f"{'hi':>5}|")
```

```text
Asha scored 92.5
Asha scored 92.5
Asha scored 92.5
score=92.46 00101010 1,234,567    hi|
```

Kaam ke format specs: `.2f` decimals, `08b` binary jo 8 tak zeros se padded ho, `,` thousands separator, `>5` right-align, `=` (3.8+) expression bhi print karta hai.

</details>

### Q24. What's the difference between `str` and `bytes`? 🔥🔥

<details><summary>Answer dekho 👀</summary>

`str` **Unicode characters** (text) ka sequence hai. `bytes` **raw 8-bit values** ka sequence hai (jo files, sockets aur disks asal mein rakhte hain). Inke beech convert karne ke liye **encoding** chahiye, aksar UTF-8: `text.encode("utf-8")` → bytes, `data.decode("utf-8")` → str. UTF-8 mein ASCII characters 1 byte lete hain, lekin baaki 2–4 bytes, isliye `len(text)` aur `len(text.encode())` alag ho sakte hain.

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

Yahan `é` ne 2 bytes (`\xc3\xa9`) liye, isliye 4 characters ki string 5 bytes ki ho gayi.

</details>

### Q25. Check if two strings are anagrams, and if a string is a palindrome, the Pythonic way. 🔥🔥

<details><summary>Answer dekho 👀</summary>

```python
from collections import Counter

def is_anagram(a, b):
    return Counter(a) == Counter(b)          # O(n); sorted(a) == sorted(b) O(n log n) hai

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

DSA round mein O(1) extra space wala two-pointer palindrome bhi mention karo ([Two Pointers](../part-2-dsa/03-two-pointers.md)).

</details>

### Q26. `split()` vs `split(" ")`, and `find()` vs `index()`? 🔥🔥

<details><summary>Answer dekho 👀</summary>

- Bina argument ke `split()` **whitespace ki kisi bhi run** pe todta hai aur empty strings hata deta hai. `split(" ")` **har ek space** pe todta hai aur empty strings rakhta hai.
- `find(sub)` na mile toh `-1` deta hai. `index(sub)` `ValueError` raise karta hai.

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

<details><summary>Answer dekho 👀</summary>

**Interning** matlab kuch strings ki sirf ek copy rakhna, taaki barabar strings ek hi object share karein. CPython bahut saari identifier jaisi strings ko automatically intern karta hai (names, attribute names, code ke chhote literals), aur tum `sys.intern(s)` se force kar sakte ho. Fayde: kam memory aur identity se tez dict lookups. Lekin kaunsi strings intern hongi, yeh **implementation detail** hai, toh strings pe `a is b` True bhi ho sakta hai aur False bhi, is pe depend karta hai ki woh kaise bani. Strings ko hamesha `==` se compare karo.

```py
import sys
a = "hello world"
b = " ".join(["hello", "world"])   # run time pe bani
print(a == b)                      # True, hamesha
print(a is b)                      # aksar False: do alag objects
print(sys.intern(a) is sys.intern(b))  # True: dono ab interned copy ko point karte hain
```

</details>

---

## 4. Functions

Chapters: [10 Functions](../part-1-python/10-functions.md) · [11 Comprehensions & Functional Tools](../part-1-python/11-comprehensions-functional.md)

### Q28. What are `*args` and `**kwargs`? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

- `*args` extra **positional** arguments ko ek **tuple** mein ikattha karta hai.
- `**kwargs` extra **keyword** arguments ko ek **dict** mein ikattha karta hai.
- Call karte waqt yahi stars **unpack** karte hain: `f(*lst, **dct)`.

Naam sirf convention hain; asli kaam stars ka hai.

```python
def show(first, *args, **kwargs):
    print(first, args, kwargs)

show(1)
show(1, 2, 3, mode="fast", debug=True)
values = [10, 20]
options = {"sep": " | "}
print(*values, **options)            # call karte waqt unpacking
```

```text
1 () {}
1 (2, 3) {'mode': 'fast', 'debug': True}
10 | 20
```

Aakhri line ko khol ke dekho: `print(*values, **options)` asal mein `print(10, 20, sep=" | ")` hai.

> 🗣️ **Interview mein aise bolo:** "`*args` collects extra positional arguments into a tuple and `**kwargs` collects extra keyword arguments into a dict. The same stars unpack a list or dict when calling a function. The names are just convention; the stars do the work. It's how decorators and wrappers forward any arguments to the original function."

</details>

### Q29. What is the mutable default argument trap? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

Default values **sirf ek baar evaluate hoti hain, jab function define hota hai**, har call pe nahi. Isliye mutable default (list, dict, set) saari calls mein shared ho jaata hai.

> 🇮🇳 **Desi Analogy:** Office mein ek **common register** rakha hai jis pe likha hai "agar apni diary nahi laaye, toh isme likh lo". Register ek hi hai, office khulte waqt ek baar rakha gaya. Har banda jo apni diary nahi laaya, usi register mein likhta jaata hai. Doosre din aane wale ko pichhle sab logon ki entries dikhti hain. `bucket=[]` wahi common register hai. Fix: "diary nahi laaye toh **har baar naya kaagaz** do" (`bucket=None`, phir andar `[]`).

```python
def add_bad(item, bucket=[]):
    bucket.append(item)
    return bucket

def add_good(item, bucket=None):
    if bucket is None:            # har call pe ek nayi list banao
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

(Pehli line `[1, 2]` do baar print karti hai kyunki dono calls ek hi list object return karti hain, aur print dono appends ke baad hota hai.)

> 🗣️ **Interview mein aise bolo:** "Default values are evaluated once, when the `def` statement runs, not on every call. So a mutable default like a list is shared across all calls and keeps growing. The standard fix is to default to `None` and create a fresh list inside the function."

</details>

### Q30. Is Python pass-by-value or pass-by-reference? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

Theek-theek dono mein se koi nahi. Python **pass-by-object-reference** hai (ise "call by sharing" bhi kehte hain). Function ka parameter **usi object ka ek naya naam** ban jaata hai.
- Agar function us object ko **mutate** kare (jaise `lst.append`), caller ko change dikhta hai.
- Agar function naam ko **rebind** kare (`lst = [...]`, int pe `n += 1`), sirf local naam badalta hai; caller pe koi asar nahi.

```python
def mutate(lst):
    lst.append(4)          # shared object ko badalta hai

def rebind(lst, n):
    lst = [0]              # local naam ab kahin aur point karta hai
    n += 1                 # ints immutable hain: locally naya int banta hai

nums, count = [1, 2, 3], 10
mutate(nums)
rebind(nums, count)
print(nums, count)
```

```text
[1, 2, 3, 4] 10
```

> 🤔 **Mann mein sawaal:** Agar list "reference" se jaati hai, toh `rebind` mein `lst = [0]` karne se caller ki list `[0]` kyun nahi bani?
>
> **Jawab:** Kyunki function ko tumhara **variable** nahi mila, sirf usi **object** pe chipka ek naya label mila. `lst = [0]` us label ko utha ke ek naye object pe chipka deta hai. Caller ka label (`nums`) abhi bhi purane object pe chipka hai. Mutation (`append`) object ko hi badalta hai, isliye dono labels ko dikhta hai. Rebinding sirf label hilata hai. Yahi "pass-by-object-reference" ka poora matlab hai.

> 🗣️ **Interview mein aise bolo:** "Python is pass-by-object-reference, sometimes called call by sharing. The parameter becomes a new name bound to the same object. If the function mutates that object, the caller sees it; if it rebinds the name to something else, only the local name changes. That's why a function can append to my list but can't change my integer."

</details>

### Q31. Explain scope (LEGB), `global` and `nonlocal`. 🔥🔥

<details><summary>Answer dekho 👀</summary>

Python kisi naam ko is order mein dhoondhta hai: **L**ocal (current function) → **E**nclosing (bahar wale functions) → **G**lobal (module) → **B**uilt-in (`len`, `print`...). Function ke andar kisi naam ko assign karna use **poore function ke liye local** bana deta hai, jab tak tum `global name` (module-level) ya `nonlocal name` (sabse paas wala enclosing function) declare na karo.

```python
counter = 0

def bump_global():
    global counter
    counter += 1

def make_counter():
    count = 0
    def bump():
        nonlocal count          # iske bina: UnboundLocalError
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

<details><summary>Answer dekho 👀</summary>

**Lambda** ek chhota anonymous function hai jo sirf **ek expression** tak limited hai: `lambda x: x * 2`. Yeh `sorted(key=...)`, `max(key=...)`, `map`, `filter` mein pass kiye jaane wale chhote, ek-baar wale functions ke liye perfect hai. Lambda ko naam pe assign mat karo (`f = lambda ...`): uski jagah `def` use karo, jo tracebacks mein sahi naam deta hai aur statements aur docstrings allow karta hai.

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

<details><summary>Answer dekho 👀</summary>

- `map(f, it)` har item pe `f` lagata hai; `filter(pred, it)` sirf woh items rakhta hai jahan `pred` truthy ho. Python 3 mein dono **lazy iterators** return karte hain.
- `functools.reduce(f, it, start)` ek sequence ko fold karke ek value bana deta hai.
- Comprehensions aksar zyada saaf hote hain aur Python mein preferred hain. Agar tumhare paas already ek named function hai toh `map` theek hai.

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

<details><summary>Answer dekho 👀</summary>

**Closure** ek inner function hai jo **enclosing function ke scope ke variables yaad rakhta hai**, outer function return ho jaane ke baad bhi. Yaad rakhe gaye variables function se jude "cells" mein rehte hain (`fn.__closure__`). Decorators, factories aur callbacks isi pe chalte hain.

```python
def make_multiplier(factor):
    def multiply(x):
        return x * factor        # 'factor' bahar wale scope se capture hua hai
    return multiply

double, triple = make_multiplier(2), make_multiplier(3)
print(double(5), triple(5))
print(double.__closure__[0].cell_contents)
```

```text
10 15
2
```

Socho jaise `make_multiplier` ek factory hai jo har function ke saath uska apna "tiffin" (`factor`) pack karke bhejti hai. `double` ke tiffin mein 2 hai, `triple` ke mein 3.

</details>

### Q35. Why do all these lambdas return the same value: `[lambda: i for i in range(3)]`? 🔥🔥

<details><summary>Answer dekho 👀</summary>

**Late binding:** closures **variable** ko capture karte hain, banne ke waqt ki uski value ko nahi. Jab lambdas aakhir mein call hote hain, loop khatam ho chuka hota hai aur sabke liye `i` 2 hai. Fix: current value ko default argument bana ke bind karo (jo definition ke waqt evaluate hota hai), ya `functools.partial` use karo.

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

Dhyaan do: yahan Q29 wali "default ek baar evaluate hota hai" property hi **fix** ban gayi. Wahan woh bug thi, yahan woh feature hai.

</details>

### Q36. What do `/` and `*` mean in a function signature? 🔥

<details><summary>Answer dekho 👀</summary>

- **`/` se pehle** wale parameters **positional-only** hain (3.8+): caller unhe naam se pass nahi kar sakta.
- **`*` ke baad** wale parameters **keyword-only** hain: caller ko unhe naam se hi pass karna padega.

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

Keyword-only flags (`admin=True`) calls ko self-documenting banate hain; positional-only se tum baad mein parameter ka naam badal sakte ho bina callers ko tode.

</details>

### Q37. Does Python enforce type hints? 🔥

<details><summary>Answer dekho 👀</summary>

Nahi. **Type hints** (`def f(x: int) -> str:`) `__annotations__` mein store hote hain aur run time pe ignore ho jaate hain. Yeh insaano, IDEs aur **mypy** ya **pyright** jaise static checkers ke liye hain, jo code chalane se pehle type bugs pakad lete hain. `pydantic` aur `dataclasses` jaisi libraries inhe *padh* ke extra kaam karti hain, lekin plain Python galat type ko kabhi reject nahi karta.

```python
def greet(name: str) -> str:
    return "hi " + str(name)

print(greet(42))                 # aaram se chalta hai: hints enforce nahi hote
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

<details><summary>Answer dekho 👀</summary>

**Class** ek blueprint hai (`Dog`); **object** (instance) usse bani ek cheez hai (`rex = Dog("Rex")`). `self` **woh instance hai jis pe method call hua**. `rex.bark()` asal mein `Dog.bark(rex)` hai: Python object ko pehle argument ke roop mein automatically pass karta hai. `self` sirf ek convention hai, keyword nahi, lekin hamesha yahi use karo.

> 🇮🇳 **Desi Analogy:** Builder ka **flat ka naksha** (class) ek hai, lekin uss naakshe se bane flats (objects) sau hain: Flat 101, Flat 102... Naksha kehta hai "har flat ki apni nameplate hogi". Jab electrician ko bolte ho "nameplate laga do", toh woh poochta hai "kis flat mein?" `self` wahi jawab hai: "isi flat mein, jiske darwaaze pe tum khade ho".

```python
class Dog:
    def __init__(self, name):
        self.name = name            # instance attribute, isi object pe store hota hai

    def bark(self):
        return f"{self.name} says woof"

rex = Dog("Rex")
print(rex.bark(), Dog.bark(rex))
```

```text
Rex says woof Rex says woof
```

> 🗣️ **Interview mein aise bolo:** "A class is a blueprint and an object is an instance built from it, with its own state. `self` is simply the instance a method was called on: `rex.bark()` is really `Dog.bark(rex)`, and Python passes the object as the first argument automatically. `self` is a convention, not a keyword."

</details>

### Q39. `__init__` vs `__new__`? 🔥🔥

<details><summary>Answer dekho 👀</summary>

- `__new__(cls, ...)` naya object **banata** hai aur return karta hai. Yeh static method hai jo pehle chalta hai.
- `__init__(self, ...)` pehle se bane object ko **initialise** karta hai aur `None` return karta hai.

Tum lagbhag kabhi `__new__` nahi likhte. Iski zaroorat immutable types (`int`, `str`, `tuple`) ko subclass karte waqt padti hai, jahan value banne ke waqt hi set honi chahiye, ya singletons jaise patterns ke liye.

```python
class Celsius(float):
    def __new__(cls, value):
        print("__new__ creates")
        return super().__new__(cls, round(value, 1))   # immutable: value yahin set karo

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

Seedhi bhasha mein: `__new__` = ghar banana, `__init__` = ghar mein furniture lagana. Float jaise immutable ghar mein banne ke baad deewar nahi hila sakte, isliye value `__new__` mein hi set karni padti hai.

</details>

### Q40. Class variables vs instance variables? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

**Class variable** class body mein define hota hai aur saare instances mein **shared** hota hai. **Instance variable** `self` pe set hota hai aur ek object ka hota hai. `obj.x` padhne pe pehle instance check hota hai, phir class. Classic bug: **mutable** class variable shared hota hai, toh ek instance ka change baaki sab mein leak ho jaata hai.

```python
class Team:
    members = []                  # class variable: saari teams ke liye EK list (bug!)
    def __init__(self, name):
        self.name = name          # instance variable

class FixedTeam:
    def __init__(self, name):
        self.name = name
        self.members = []         # har team ki apni list

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

> 🗣️ **Interview mein aise bolo:** "A class variable is defined in the class body and shared by every instance; an instance variable is set on `self` and belongs to one object. Attribute lookup checks the instance first, then the class. The classic bug is a mutable class variable like a list, which every instance ends up sharing, so mutable per-object state should be created in `__init__`."

</details>

### Q41. Instance method vs `@classmethod` vs `@staticmethod`? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

| Kind | Pehla argument | Kya access kar sakta hai | Typical use |
|---|---|---|---|
| Instance method | `self` (object) | instance aur class | normal behaviour |
| `@classmethod` | `cls` (class) | class, koi specific instance nahi | **alternative constructors** (`from_string`), subclasses ke saath bhi kaam karta hai |
| `@staticmethod` | kuch nahi | dono nahi (jab tak naam se explicitly na bulao) | ek helper jo logically class ka hissa hai |

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

`from_string` mein `Date(...)` ki jagah `cls(...)` kyun? Taaki agar koi `class IndianDate(Date)` banaye, toh `IndianDate.from_string(...)` ek `IndianDate` object de, `Date` nahi.

> 🗣️ **Interview mein aise bolo:** "An instance method receives `self` and works with one object's state. A classmethod receives the class as `cls`, so it's ideal for alternative constructors like `from_string`, and it works correctly for subclasses. A staticmethod receives neither; it's just a helper function that logically belongs in the class namespace."

</details>

### Q42. How does `super()` work? What is the MRO? 🔥🔥

<details><summary>Answer dekho 👀</summary>

**MRO** (Method Resolution Order) woh order hai jisme Python kisi method ke liye classes mein dhoondhta hai. Yeh **C3 linearisation** se calculate hota hai: children parents se pehle, aur base classes ka left-to-right order bana rehta hai. `super()` ka matlab hai "MRO mein **agli** class", sirf "mera parent" nahi. Isi wajah se cooperative multiple inheritance (diamond) mein har class exactly ek baar call hoti hai.

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

Dhyaan do ki `Left` ke andar `super()` ne `Right` ko call kiya, `Base` ko nahi: yeh actual object ke MRO ko follow karta hai.

</details>

### Q43. Does Python have private variables? What do `_x` and `__x` mean? 🔥🔥

<details><summary>Answer dekho 👀</summary>

Asli `private` jaisa kuch nahi hai. Python convention pe chalta hai:
- `_x`: "internal hai, please mat chhedo". Koi ise enforce nahi karta (lekin `from module import *` aise names skip kar deta hai).
- `__x` (shuru mein do underscores, end mein nahi): **name mangling**. Class `Account` ke andar `__x` ka naam badal ke `_Account__x` ho jaata hai. Iska maqsad subclasses mein galti se naam takraane se bachana hai, security nahi.
- `__x__`: special "dunder" names jo Python ke liye reserved hain.

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
print(acc._Account__balance)       # mangled naam ab bhi kaam karta hai
```

```text
internal
no attribute __balance
100
```

</details>

### Q44. What is `@property` and why use it? 🔥🔥

<details><summary>Answer dekho 👀</summary>

`@property` ek method ko aisi cheez bana deta hai jo attribute ki tarah access hoti hai, aur validation ke saath ek **setter** jodne deta hai. Tum ek plain attribute se shuru kar sakte ho aur baad mein property pe switch kar sakte ho **bina koi calling code badle**. Isiliye Python ko Java-style getters aur setters ki zaroorat nahi.

```python
class Temperature:
    def __init__(self, celsius):
        self.celsius = celsius            # neeche wale setter se hoke jaata hai

    @property
    def celsius(self):
        return self._celsius

    @celsius.setter
    def celsius(self, value):
        if value < -273.15:
            raise ValueError("below absolute zero")
        self._celsius = value

    @property
    def fahrenheit(self):                 # calculated, read-only
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

<details><summary>Answer dekho 👀</summary>

- `__repr__`: **developers ke liye** ek **unambiguous** representation, ideally aisa valid Python jo object ko dobara bana sake. REPL, debuggers aur containers ke andar yahi use hota hai.
- `__str__`: **users ke liye** ek **readable** representation. `print()` aur `str()` yahi use karte hain. Na ho toh `__repr__` pe fall back karta hai.

Hamesha `__repr__` define karo; jab friendlier form madad kare tab `__str__` bhi jodo.

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
print([p])                       # containers repr use karte hain
```

```text
(1, 2) (1, 2) Point(1, 2)
[Point(1, 2)]
```

Yaad rakhne ka tareeka: `repr` = doctor ki **medical report** (exact, technical, doctor ke liye). `str` = patient ko bola gaya **"aap theek ho jaoge"** (simple, user ke liye).

> 🗣️ **Interview mein aise bolo:** "`__repr__` is the unambiguous, developer-facing representation, ideally valid Python that recreates the object; the REPL, debuggers and containers use it. `__str__` is the readable, user-facing form used by `print` and `str`, and it falls back to `__repr__` if it isn't defined. So I always define `__repr__` and add `__str__` when a friendlier form helps."

</details>

### Q46. What are magic (dunder) methods? Show operator overloading. 🔥🔥

<details><summary>Answer dekho 👀</summary>

**Dunder methods** (double underscore, jaise `__add__`) tumhare objects ko Python ke syntax mein fit hone dete hain: `a + b` `a.__add__(b)` call karta hai, `len(x)` `x.__len__()` call karta hai, `x[i]` `x.__getitem__(i)` call karta hai, `for` `__iter__` use karta hai, `==` `__eq__` use karta hai, `<` `__lt__` use karta hai, `with` `__enter__`/`__exit__` use karta hai, `obj()` `__call__` use karta hai.

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

<details><summary>Answer dekho 👀</summary>

Rule: **agar `a == b`, toh `hash(a) == hash(b)`** sach hona hi chahiye, warna dicts aur sets toot jaate hain. Isliye:
- Agar tum `__eq__` define karo bina `__hash__` ke, Python `__hash__ = None` set kar deta hai aur tumhare objects **unhashable** ho jaate hain (safe default).
- Unhe hashable banana hai toh `__hash__` ko unhi **immutable fields** se define karo jo `__eq__` compare karta hai, jaise `hash((self.x, self.y))`.

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

Rule kyun? Set pehle hash se "khaana" dhoondhta hai, phir `==` se match karta hai. Agar do barabar objects ke hash alag hon, toh woh alag khaanon mein jaayenge aur set unhe kabhi compare hi nahi karega. Duplicate andar ghus jaayega.

</details>

### Q48. What is an abstract base class? 🔥

<details><summary>Answer dekho 👀</summary>

**Abstract base class** (ABC) ek interface define karti hai jo subclasses ko implement karna hi padega. `@abstractmethod` se mark kiye methods override karne zaroori hain; jis class ne unhe implement nahi kiya, uska object banane ki koshish `TypeError` deti hai.

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

<details><summary>Answer dekho 👀</summary>

"Agar woh batakh jaisa chalta hai aur batakh jaisa quack karta hai, toh woh batakh hai." Python ko is baat se matlab hai ki object ke paas **woh method hai ya nahi jo tum call kar rahe ho**, is baat se nahi ki woh kaunsi class ka hai. Jis bhi object ke paas `.read()` method hai, woh wahan kaam karega jahan file expect ki jaati hai. Isliye polymorphism ke liye shared base class ki zaroorat nahi: alag classes bas same method names implement karti hain (ya dunder methods, isiliye `len()` lists, strings aur tumhari apni classes sab pe chalta hai).

```python
class Duck:
    def speak(self):
        return "Quack"

class Robot:
    def speak(self):
        return "Beep"

for thing in (Duck(), Robot()):
    print(thing.speak())          # koi common parent nahi chahiye
```

```text
Quack
Beep
```

Desi version: UPI ko farak nahi padta ki tum PhonePe se pay karo ya GPay se ya Paytm se. Jo bhi app "UPI collect request" handle kar sake, payment ho jaayegi. Duck typing yahi hai: "kaam kar sakte ho? bas, kaafi hai."

</details>

### Q50. What does `__slots__` do? 🔥

<details><summary>Answer dekho 👀</summary>

Normally har object apne attributes ek per-instance `__dict__` mein rakhta hai. `__slots__ = ("x", "y")` declare karne se woh dict fixed slots se replace ho jaati hai, jo **memory bachata hai** (laakhon objects ho, jaise trie ya graph nodes, toh farak dikhta hai) aur attribute access thoda tez karta hai. Keemat: tum aise **naye attributes nahi jod sakte** jo list mein nahi hain.

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

<details><summary>Answer dekho 👀</summary>

`@dataclass` (3.7+) type-annotated fields se `__init__`, `__repr__` aur `__eq__` automatically bana deta hai. Options: `frozen=True` (immutable aur hashable), `order=True` (`<`, `>` waghera jodta hai), mutable defaults ke liye `field(default_factory=list)` (yeh plain `= []` ko mana kar deta hai, aur tumhe Q29 ke trap se bachata hai).

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

`order=True` fields ko unke likhe gaye order mein compare karta hai, yaani pehle `marks`. Isliye 85 wala `ravi` sort mein pehle aaya.

</details>

---

## 6. Iterators, Generators, Decorators & Context Managers

Chapter: [16 Iterators, Generators, Decorators & Context Managers](../part-1-python/16-iterators-generators-decorators.md)

### Q52. Iterable vs iterator? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

- **Iterable** tumhe ek iterator de sakta hai: uske paas `__iter__` hai (lists, strings, dicts, files, ranges).
- **Iterator** `__next__` se ek-ek karke values deta hai, khatam hone pe `StopIteration` raise karta hai, aur uska `__iter__` khud ko return karta hai. Yeh **single-use** hai.

`for` loop iterable pe ek baar `iter()` call karta hai, phir `StopIteration` aane tak baar-baar `next()`.

> 🇮🇳 **Desi Analogy:** Iterable ek **book** hai, iterator uska **bookmark**. Ek book se tum jitne chaaho bookmarks bana sakte ho (har `iter()` call ek naya bookmark). Bookmark sirf aage badhta hai, ek-ek page (`next()`), aur aakhri page ke baad "book khatam" (`StopIteration`). Bookmark ko wapas shuru pe nahi le ja sakte; naya chahiye toh book se naya bookmark lo.

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

> 🗣️ **Interview mein aise bolo:** "An iterable is anything that can hand out an iterator through `__iter__`, like a list or a file. An iterator actually produces the values through `__next__`, raises StopIteration when it's done, and is single-use. A `for` loop calls `iter()` once and then `next()` repeatedly until StopIteration."

</details>

### Q53. What is a generator? Why is it memory-efficient? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

**Generator** ek function hai jisme `yield` hai. Use call karne se body nahi chalti; ek generator object (ek iterator) return hota hai. Har `next()` body ko agle `yield` tak chalata hai, woh value deta hai, aur **ruk jaata hai**, saare local variables sambhaal ke. Yeh values **lazily** banata hai, isliye chahe kitni bhi values de, O(1) memory leta hai, aur infinite bhi ho sakta hai.

> 🇮🇳 **Desi Analogy:** Shaadi mein do tarah ki rotiyan. Ek: caterer ne subah 500 rotiyan bana ke dher laga diya (list): jagah bhi gheri, aur aadhi thandi bhi ho gayi. Doosra: **tawa counter** (generator): jab koi plate aage karta hai (`next()`), tabhi ek garam roti banti hai, aur rotiwala wahin ruk ke agle ka intezaar karta hai (`yield`), aata kahan tak gundha tha woh yaad rakhte hue (local state). Tawe pe ek time mein ek hi roti, chahe 5000 log khaayein.

```python
def fibonacci():
    a, b = 0, 1
    while True:              # infinite, lekin values sirf maangne pe banti hain
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

Asli use: 10 GB ki log file ko line by line stream karna, transformations ki pipelines, pagination.

> 🗣️ **Interview mein aise bolo:** "A generator is a function that uses `yield`. Calling it returns an iterator without running the body; each `next()` runs until the next `yield`, hands out that value and pauses with its local state intact. Because values are produced lazily, memory stays constant no matter how many values it yields, so it's ideal for streaming large files or even infinite sequences."

</details>

### Q54. What does `yield from` do? 🔥

<details><summary>Answer dekho 👀</summary>

`yield from sub` kisi doosre iterable ya generator ki har value yield kar deta hai, taaki tumhe `for x in sub: yield x` na likhna pade. Yeh `send()` ko bhi aage forward karta hai aur sub-generator ki `return` value return karta hai. Recursive generators ke liye perfect hai.

```python
def flatten(items):
    for item in items:
        if isinstance(item, list):
            yield from flatten(item)     # recursive call ko kaam saunp do
        else:
            yield item

print(list(flatten([1, [2, [3, 4]], 5])))
```

```text
[1, 2, 3, 4, 5]
```

</details>

### Q55. What is a decorator? Write one. 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

**Decorator** ek function hai jo ek function leta hai aur ek naya function return karta hai, jo aksar original ko extra behaviour ke saath lapet deta hai (logging, timing, caching, auth checks, retries). `def f` ke upar `@deco` ka matlab hai `f = deco(f)`. `functools.wraps` use karo taaki wrapper original ka naam aur docstring rakh sake.

> 🇮🇳 **Desi Analogy:** Gift wrapping. Andar ka gift (original function) wahi hai, lekin dukaandar ne upar ek wrapper lagaya jo kholte waqt "Happy Birthday" gaata hai (extra behaviour). Lene wala ab bhi gift hi khol raha hai. `functools.wraps` us wrapper pe original gift ka label chipka deta hai, taaki dekhne wale ko lage ki yeh wahi gift hai (same `__name__`, same docstring), "wrapper" naam ka koi anjaan packet nahi.

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

> 🗣️ **Interview mein aise bolo:** "A decorator is a function that takes a function and returns a new one, usually a wrapper that adds behaviour like logging, timing, caching or auth checks before and after calling the original. The `@deco` syntax is just `f = deco(f)`. I always use `functools.wraps` so the wrapper keeps the original's name and docstring."

</details>

### Q56. How do you write a decorator that takes arguments? 🔥🔥

<details><summary>Answer dekho 👀</summary>

Ek layer aur jodo: ek **factory** jo arguments leti hai aur asli decorator return karti hai. `@repeat(3)` ka matlab hai `f = repeat(3)(f)`.

```python
import functools

def repeat(times):                       # 1. factory: arguments leti hai
    def decorator(func):                 # 2. asli decorator: function leta hai
        @functools.wraps(func)
        def wrapper(*args, **kwargs):    # 3. replacement function
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

<details><summary>Answer dekho 👀</summary>

Yeh ek built-in **memoisation** decorator hai: results ko arguments ke key pe store karta hai aur repeated calls pe stored result lauta deta hai. `maxsize` cache ko LRU eviction ke saath limit karta hai (`maxsize=None`, ya 3.9+ mein `functools.cache`, matlab unlimited). Arguments **hashable** hone chahiye. Ek line mein exponential recursive DP ko polynomial time bana deta hai.

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

Cache ke bina `fib(80)` lagbhag 10¹⁶ calls karta, yaani tumhari poori zindagi. Cache ke saath har `n` sirf ek baar calculate hota hai: 81 values, khatam.

</details>

### Q58. What is a context manager? How do you write one? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

**Context manager** kuch setup karta hai aur **cleanup ki guarantee** deta hai, chahe exception aa jaaye. `with` statement shuru mein `__enter__` aur end mein `__exit__` call karta hai. Examples: files (automatically close), locks (release), database transactions (commit ya rollback). Ise class ki tarah likho ya `@contextlib.contextmanager` se (`yield` se pehle ka code setup hai, baad ka cleanup).

> 🇮🇳 **Desi Analogy:** Library se book issue karna. `with` block = book tumhare paas hai. Andar kuch bhi ho jaaye, chahe tum padhte-padhte so jao ya beech mein phone aa jaaye (exception), library ka system ensure karta hai ki book **wapas return ho** (`__exit__` / `finally`). Tumhe khud yaad nahi rakhna padta.

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
        return False             # False: exceptions ko nigal mat jao

@contextmanager
def tag(name):
    print(f"<{name}>")
    try:
        yield
    finally:                     # body raise kare tab bhi chalta hai
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

> 🗣️ **Interview mein aise bolo:** "A context manager sets something up and guarantees cleanup, even if an exception is raised. The `with` statement calls `__enter__` at the start and `__exit__` at the end; files, locks and database transactions all use it. I can write one as a class with those two methods, or with `@contextmanager`, where code before `yield` is setup and code in `finally` after it is cleanup."

</details>

### Q59. Why does looping over the same generator twice give nothing the second time? 🔥🔥

<details><summary>Answer dekho 👀</summary>

Generators (aur saare iterators) **single-use** hain: ek baar khatam, toh khatam hi rehte hain. `sum`, `max`, `list`, `in` jaise functions inhe consume karte hain. Values do baar chahiye toh unhe list mein store karo, ya naya generator banao.

```python
squares = (x * x for x in range(4))
print(4 in squares)          # 4 dhoondhne ke liye 0, 1, 4 consume ho gaye
print(list(squares))         # sirf jo bacha hai
print(list(squares))         # kuch nahi bacha
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

<details><summary>Answer dekho 👀</summary>

CPython mein:
1. **Sab kuch ek private heap pe object hai**, aur variables sirf naam hain jo objects ko point karte hain.
2. **Reference counting:** har object ginta hai ki kitne references use point kar rahe hain. Jaise hi count zero hota hai, object **turant** free ho jaata hai.
3. **Cyclic garbage collector:** reference counting cycles free nahi kar sakti (`a.ref = b; b.ref = a`). `gc` module samay-samay pe aise unreachable groups dhoondhta hai. Yeh **generational** hai: naye objects ko baar-baar check kiya jaata hai, aur jo bach jaate hain woh purani generations mein chale jaate hain jinhe kam check kiya jaata hai (zyaadatar objects jaldi mar jaate hain).
4. **pymalloc:** chhote objects (≤ 512 bytes) ek tez pool allocator se aate hain, isliye bahut saare chhote objects banana sasta hai. Free hui memory aksar operating system ko lautane ki jagah reuse ke liye rakh li jaati hai.

```python
import gc

class Node:
    def __init__(self):
        self.other = None

a, b = Node(), Node()
a.other, b.other = b, a          # ek reference cycle
del a, b                         # refcounts khud se kabhi 0 nahi honge
print(gc.collect() >= 2)         # cycle collector inhe free karta hai
```

```text
True
```

> 🤔 **Mann mein sawaal:** `del a, b` ke baad bhi objects free kyun nahi hue? Naam toh hata diye.
>
> **Jawab:** Naam hataye, lekin dono objects ab bhi **ek doosre** ko point kar rahe hain. A ka count 1 (B ki taraf se), B ka count 1 (A ki taraf se). Reference counting ke hisaab se dono "zinda" hain, jabki program mein koi unhe pahunch nahi sakta. Yeh do log hain jo ek doosre ka haath pakad ke kisi band kamre mein khade hain. Cycle collector kamre mein jhaank ke dekhta hai ki bahar se koi raasta aata hai ya nahi, aur nahi aata toh dono ko hata deta hai.

> 🗣️ **Interview mein aise bolo:** "CPython uses reference counting as the main mechanism: each object tracks how many references point to it and is freed immediately when that hits zero. Since reference counting can't free cycles, a generational cyclic garbage collector periodically finds unreachable groups. Small objects come from the pymalloc pool allocator, which makes creating many small objects cheap."

</details>

### Q61. What is the GIL? Does Python have true multithreading? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

**Global Interpreter Lock** CPython mein ek mutex hai jo **ek time pe sirf ek thread ko Python bytecode chalane deta hai**. Yeh isliye hai kyunki reference counting thread-safe nahi hai, aur ek bade lock ne CPython ko simple aur single-thread mein tez bana diya.

> 🇮🇳 **Desi Analogy:** Ek railway reservation counter, kai clerk (threads), lekin **sirf ek computer** (GIL). Ek time pe ek hi clerk computer pe ticket book kar sakta hai. Toh agar kaam "computer pe typing" (CPU-bound) hai, toh 4 clerk rakhne se speed nahi badhegi. Lekin agar kaam mein zyaadatar time "passenger se ID maangna aur intezaar karna" (I/O-bound) hai, toh jab ek clerk intezaar kar raha hai, woh computer chhod deta hai aur doosra clerk use kar leta hai. Wahan kai clerk sach mein madad karte hain. CPU-heavy kaam ke liye **alag counters, alag computers** chahiye: yahi `multiprocessing` hai.

Nateeje:
- **CPU-bound** kaam (pure Python maths, loops) threads se **tez nahi** hota. `multiprocessing` / `ProcessPoolExecutor` use karo (alag processes, har ek ka apna GIL), ya NumPy jaise C extensions jo GIL chhod dete hain.
- **I/O-bound** kaam (network, disk, sleeping) ko threads se **fayda hota hai**, kyunki intezaar karte waqt thread GIL chhod deta hai.
- GIL tumhare code ko thread-safe nahi banata: `count += 1` kai bytecodes hai aur ab bhi race kar sakta hai (Q79).

Interviews mein mention karne wala update: **Python 3.13 ek experimental free-threaded build ke saath aata hai** (PEP 703) jo bina GIL ke chal sakta hai. Default build mein GIL ab bhi hai.

> 🗣️ **Interview mein aise bolo:** "The GIL is a mutex in CPython that allows only one thread to execute Python bytecode at a time, mainly because reference counting isn't thread-safe. So threads don't speed up CPU-bound Python code; for that I'd use multiprocessing or libraries like NumPy that release the GIL. Threads still help I/O-bound work, because a thread releases the GIL while it waits. Python 3.13 also has an experimental free-threaded build without the GIL."

</details>

### Q62. Why is `a is b` True for small integers but sometimes False for big ones? 🔥🔥

<details><summary>Answer dekho 👀</summary>

CPython **integers −5 se 256 tak pehle se bana ke cache kar leta hai**; in values ka har use same object ko refer karta hai, isliye `is` True deta hai. Bade integers zaroorat pe bante hain, toh run time pe calculate kiye do barabar bade ints aksar alag objects hote hain. (Compiler same code block ke barabar constants ko merge bhi kar sakta hai, isiliye REPL aur script mein results alag aate hain.) Yeh implementation detail hai: **numbers ko `==` se compare karo**.

```py
a = 256; b = 256
print(a is b)              # True: cached small int
x = int("1000"); y = int("1000")
print(x is y)              # CPython mein False: do alag objects
print(x == y)              # True: tumhe yahi comparison chahiye
```

</details>

### Q63. What are CPython, PyPy, Jython? 🔥

<details><summary>Answer dekho 👀</summary>

Python ek **language specification** hai; yeh sab uske **implementations** hain:
- **CPython**: reference implementation, C mein likha. python.org se yahi milta hai. Isme GIL hai aur sabse rich C-extension ecosystem.
- **PyPy**: (R)Python mein likha, **JIT compiler** ke saath; lambe chalne wale pure-Python code pe aksar kai guna tez.
- **Jython** (JVM pe chalta hai) aur **IronPython** (.NET): Java / C# libraries ke saath integrate karte hain; Python 3 support mein historically peeche rahe.
- **MicroPython**: microcontrollers ke liye ek chhota sa implementation.

</details>

### Q64. What is bytecode, and how can you see it? 🔥

<details><summary>Answer dekho 👀</summary>

**Bytecode** Python virtual machine ka low-level instruction set hai (`LOAD_FAST`, `BINARY_OP`, `RETURN_VALUE`...). `dis` module ise disassemble karta hai. Yeh dekhne ke kaam aata hai ki koi cheez atomic *kyun* nahi hai (`x += 1` ek load, ek add aur ek store hai) ya ek version doosre se tez kyun hai. Exact instructions Python versions ke beech badalte rehte hain.

```py
import dis

def add_one(x):
    return x + 1

dis.dis(add_one)
# Aisi lines dikhti hain: LOAD_FAST x, LOAD_CONST 1, BINARY_OP (+), RETURN_VALUE
```

</details>

### Q65. Why is Python slower than C/C++, and how can you speed it up? 🔥🔥

<details><summary>Answer dekho 👀</summary>

**Slow kyun:** har value ek heap object hai jiska har operation pe type check hota hai (dynamic typing), bytecode ek-ek instruction karke interpret hota hai, attribute aur name lookups dictionaries se hoke jaate hain, aur GIL CPU parallelism ko limit karta hai.

**Tez kaise karo (sabse accha pehle):**
1. **Behtar algorithm / data structure** (O(n²) → O(n log n) kisi bhi micro-optimisation ko hara deta hai).
2. **Built-ins aur standard library** use karo (`sum`, `sorted`, `set`, `collections`, `heapq`), jo C mein chalti hain.
3. NumPy / pandas se **vectorise** karo.
4. Results cache karo (`lru_cache`), loops mein repeated kaam se bacho, hot loops mein local variables use karo.
5. CPU-bound parallel kaam ke liye **multiprocessing**, I/O ke liye **asyncio/threads**.
6. **PyPy**, **Cython**, **Numba**, ya hot spot ko C/Rust mein dobara likho.
7. **Pehle profile karo** (`cProfile`, `timeit`): naapa hua bottleneck optimise karo, andaaza nahi.

</details>

### Q66. How much memory does a list use? Why does `sys.getsizeof` seem wrong? 🔥

<details><summary>Answer dekho 👀</summary>

`sys.getsizeof(lst)` sirf list object khud ka size batata hai: uska header plus **pointers ka array** (64-bit pe har pointer 8 bytes), extra over-allocated slots samet. Isme woh objects **shaamil nahi** jinhe list point karti hai. Sab kuch naapna hai toh elements ke sizes bhi jodo (ya `tracemalloc` jaisa tool use karo). Exact numbers Python versions ke beech badalte hain, toh unhe ratna mat.

```py
import sys
nums = list(range(1000))
print(sys.getsizeof(nums))                        # lagbhag 8 KB: sirf pointer array
print(sum(sys.getsizeof(x) for x in nums))        # int objects khud: lagbhag 28 KB aur
```

</details>

### Q67. What does `del x` actually do? 🔥

<details><summary>Answer dekho 👀</summary>

`del x` current namespace se **naam** `x` **hatata** hai aur object ka reference count ek kam karta hai. Yeh object ko seedha **destroy nahi** karta: object tabhi free hota hai jab koi aur reference na bache. `del lst[i]` aur `del d[key]` container se ek element hatate hain.

```python
a = [1, 2, 3]
b = a
del a                    # sirf naam 'a' hatta hai
print(b)                 # list 'b' ke through abhi bhi zinda hai
del b[0]                 # list se ek element hatata hai
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

<details><summary>Answer dekho 👀</summary>

- `try`: woh code jo raise kar sakta hai.
- `except`: tab chalta hai jab matching exception raise hua.
- `else`: sirf tab chalta hai jab **koi** exception raise **nahi** hua. "Success" wala code yahan rakho, taaki uske apne errors galti se catch na ho jaayein.
- `finally`: **hamesha** chalta hai (success, exception, yahan tak ki `return` pe bhi). Cleanup ke liye use karo.

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

Output ko dhyaan se dekho: `return result` `else` mein likha hai, lekin `2.0` print hone se **pehle** `finally` chal gaya. Python return value ko side mein rakh leta hai, `finally` chalata hai, phir return karta hai.

> 🗣️ **Interview mein aise bolo:** "`try` holds the code that might fail, `except` runs only if a matching exception is raised, `else` runs only if no exception was raised, and `finally` always runs, even when the block returns. I put success-only code in `else` so its own errors aren't accidentally caught, and cleanup in `finally`."

</details>

### Q69. How do you create a custom exception? 🔥🔥

<details><summary>Answer dekho 👀</summary>

`Exception` ko subclass karo (`BaseException` ko nahi, jisme `KeyboardInterrupt` aur `SystemExit` bhi aate hain). Ek chhoti hierarchy banao taaki callers poori family ko catch kar sakein, aur kaam ka data saath mein jodo.

```python
class BankError(Exception):
    """Base class for all bank errors."""

class InsufficientFunds(BankError):
    def __init__(self, balance, amount):
        super().__init__(f"need {amount}, have {balance}")
        self.shortfall = amount - balance

try:
    raise InsufficientFunds(100, 250)
except BankError as e:                 # poori family pakad leta hai
    print(type(e).__name__, "-", e, "- short by", e.shortfall)
```

```text
InsufficientFunds - need 250, have 100 - short by 150
```

</details>

### Q70. What is `raise ... from ...`? 🔥

<details><summary>Answer dekho 👀</summary>

Yeh exceptions ko **chain** karta hai: tum ek higher-level error raise karte ho aur original ko uske `__cause__` ki tarah sambhaal ke rakhte ho, taaki traceback dono dikhaye ("The above exception was the direct cause of..."). Low-level errors ko apne errors mein translate karte waqt use karo. `raise X from None` original ko chhupa deta hai.

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

<details><summary>Answer dekho 👀</summary>

- Bare `except:` **sab kuch** pakad leta hai, `KeyboardInterrupt` (Ctrl+C) aur `SystemExit` bhi, toh tumhara program rukne se mana kar sakta hai.
- Bahut broad catch karna **asli bugs chhupa deta hai**: kisi typo se aaya `NameError` chupchaap nigal liya jaata hai.
- `pass` woh saari information phenk deta hai jo debug karne ke liye chahiye.

Woh **sabse specific** exception pakdo jise tum sach mein handle kar sakte ho, `try` block chhota rakho, aur jo nigal rahe ho use kam se kam log karo.

```py
# ❌ har bug chhupa deta hai, Ctrl+C bhi
try:
    process(data)
except:
    pass

# ✅ specific, chhota, aur dikhne wala
try:
    value = int(text)
except ValueError:
    logger.warning("not a number: %r", text)
    value = 0
```

</details>

### Q72. EAFP vs LBYL? 🔥🔥

<details><summary>Answer dekho 👀</summary>

- **LBYL** ("Look Before You Leap"): pehle check karo, phir kaam karo. `if key in d: use(d[key])`.
- **EAFP** ("Easier to Ask Forgiveness than Permission"): seedha try karo aur exception handle karo. `try: use(d[key]) except KeyError: ...`.

Python culture **EAFP** pasand karta hai: jab failures kam hon toh yeh aksar tez hota hai (do ki jagah ek lookup) aur **race conditions** se bachata hai, jahan check aur action ke beech situation badal jaati hai (jaise `os.path.exists` ke baad file delete ho gayi). LBYL tab use karo jab failure aam ho ya check sasta aur saaf ho.

```python
config = {"debug": True}

value = config["debug"] if "debug" in config else False     # LBYL
try:                                                         # EAFP
    timeout = config["timeout"]
except KeyError:
    timeout = 30
print(value, timeout, config.get("timeout", 30))            # .get beech ka saaf raasta hai
```

```text
True 30 30
```

Desi version: LBYL = mummy se poochna "kya main fridge se mithai le sakta hoon?" phir lena. EAFP = mithai le lena, aur agar daant padi toh handle kar lena. Python ka culture doosra wala hai, bas wahi exception pakdo jiske liye tum taiyaar ho.

</details>

---

## 9. Modules & Packages

Chapter: [17 Modules, Packages & the Standard Library](../part-1-python/17-modules-stdlib.md)

### Q73. Module vs package? What is `__init__.py` for? 🔥🔥

<details><summary>Answer dekho 👀</summary>

- **Module** ek single `.py` file hai.
- **Package** modules ki ek directory hai, jise dotted names se import kiya jaata hai (`shop.payments.upi`).
- `__init__.py` ek directory ko regular package mark karta hai aur **package pehli baar import hone pe chalta hai**. Ise ek saaf API expose karne (`from .core import Cart`) ya package setup chalane ke liye use karo. Python 3.3 se, iske bina wali directory bhi **namespace package** ki tarah import ho sakti hai, lekin `__init__.py` rakhna normal, explicit choice hai.

</details>

### Q74. How does `import` work? What happens if you import a module twice? 🔥🔥

<details><summary>Answer dekho 👀</summary>

`import x` pe Python:
1. **`sys.modules`** check karta hai (pehle se import hue modules ka cache). Mil gaya toh wahi reuse karta hai: module ka code **har process mein sirf ek baar** chalta hai, chahe kitni baar bhi import karo.
2. Warna **`sys.path`** ko order mein dhoondhta hai: script ki directory, `PYTHONPATH`, standard library, phir `site-packages` (jahan pip install karta hai).
3. Ek module object banata hai, **module ka code** upar se neeche **execute** karta hai, use `sys.modules` mein rakhta hai, aur naam `x` bind karta hai.

```python
import sys
import math
import math as m2           # dobara execution nahi: wahi cached object
print(m2 is math, "math" in sys.modules)
```

```text
True True
```

Ek aam bug: apni file ka naam `random.py` ya `json.py` rakhna standard library module ko chhupa deta hai, kyunki `sys.path` pe tumhari script ka folder sabse pehle aata hai.

</details>

### Q75. What causes circular imports and how do you fix them? 🔥

<details><summary>Answer dekho 👀</summary>

`a.py` `b` ko import karta hai, aur `b.py` `a` ko. Jab `a` chalna shuru hota hai, woh `b` import karta hai; `b` phir `a` import karta hai, `sys.modules` se **aadha-initialised** `a` paata hai, aur agar use koi aisa naam chahiye jo `a` ne abhi tak define nahi kiya, toh `ImportError` / `AttributeError` se fail ho jaata hai.

Fixes (sabse accha pehle):
1. **Restructure karo:** shared code ko ek teesre module mein le jao jise dono import kar sakein.
2. Names ki jagah **module** import karo (`from a import func` ki jagah `import a`, phir call ke waqt `a.func` use karo).
3. Import ko us **function ke andar** le jao jise uski zaroorat hai (local import).
4. Sirf type hints ke liye ho toh `from typing import TYPE_CHECKING` use karo aur `if TYPE_CHECKING:` ke neeche import karo.

</details>

### Q76. What is a virtual environment and why use one? 🔥🔥

<details><summary>Answer dekho 👀</summary>

**Virtual environment** ek alag-thalag folder hai jisme apna Python interpreter link aur apna `site-packages` hota hai. Har project ko apne dependency versions milte hain, toh project A `django==4.2` use kar sakta hai jabki project B `5.0`, aur system Python mein kuch gandagi nahi phailti.

```py
python -m venv .venv                 # banao
.venv\Scripts\activate               # Windows
source .venv/bin/activate            # macOS / Linux
pip install requests                 # sirf .venv mein install hota hai
pip freeze > requirements.txt        # exact versions record karo
pip install -r requirements.txt      # kahin aur wahi setup dobara banao
```

Modern alternatives jo yeh sab tumhare liye manage karte hain: `poetry`, `pipenv`, `uv`.

Desi version: har project ka apna **alag kitchen**. Ek mein shakkar wali chai (Django 4.2), doosre mein bina shakkar (Django 5.0). Ek hi kitchen mein dono banaoge toh dabbe mix ho jaayenge.

</details>

### Q77. `import module` vs `from module import name` vs `from module import *`? 🔥

<details><summary>Answer dekho 👀</summary>

- `import math` → `math.sqrt` use karo. Origin saaf, koi naam takraav nahi. Preferred.
- `from math import sqrt` → seedha `sqrt` use karo. Chhota; baar-baar use hone wale names ke liye theek. Dhyaan do ki yeh import ke waqt ka **binding** copy karta hai: agar module baad mein `sqrt` ko rebind kare, toh tumhe nahi dikhega.
- `from math import *` → saare public names tumhare namespace mein daal deta hai. Isse bacho: names kahan se aaye yeh chhup jaata hai aur yeh tumhare apne names chupchaap overwrite kar sakta hai. Module `__all__` se limit kar sakta hai ki `*` kya export kare.

</details>

---

## 10. Concurrency

Chapter: [18 Python Internals & Concurrency](../part-1-python/18-internals-concurrency.md)

### Q78. Threads vs processes vs asyncio: when do you use each? 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

| | `threading` | `multiprocessing` | `asyncio` |
|---|---|---|---|
| Kya chalta hai | ek process mein kai threads | kai processes | **ek thread** mein kai coroutines |
| Memory | shared (locks chahiye) | alag (queues/pipes se share) | shared, awaits ke beech locks ki zaroorat nahi |
| GIL | ek time pe ek thread Python chalata hai | har process ka apna GIL | waise bhi single thread |
| Best for | blocking libraries ke saath **I/O-bound** kaam | **CPU-bound** kaam | **bahut saara concurrent I/O** (hazaaron sockets) |
| Cost | medium (OS threads) | high (process start-up, data pickling) | har task pe bahut kam |
| Switching | pre-emptive (OS decide karta hai) | pre-emptive | **cooperative** (sirf `await` pe) |

One-liner: **CPU-bound → processes; I/O-bound → asyncio agar libraries support karein, warna threads.**

> 🇮🇳 **Desi Analogy:** Restaurant ki kitchen. **Threads** = ek kitchen, ek gas chulha (GIL), kai cooks. Jab ek cook ka daal pressure cooker mein hai (I/O wait), doosra chulha use kar leta hai. **Multiprocessing** = kai alag kitchens, har ek ka apna chulha: asli parallel cooking, lekin har kitchen sajaana mehenga, aur saamaan ek kitchen se doosri mein bhejna padta hai (pickling). **Asyncio** = ek hi super-fast cook, jo chai chadha ke, chai ubalne tak (`await`) sabzi kaatne lagta hai, phir roti belne lagta hai. Woh kabhi khaali khada intezaar nahi karta, lekin agar koi kaam khud usi ka haath ghere (blocking call), toh poori kitchen ruk jaati hai.

> 🗣️ **Interview mein aise bolo:** "For CPU-bound work I use multiprocessing, because each process has its own interpreter and GIL, so it gets real parallelism at the cost of start-up and pickling. For I/O-bound work I prefer asyncio when the libraries support it, since one thread can juggle thousands of connections with cooperative switching at each `await`. If the I/O libraries are blocking, threads are the practical choice, because a thread releases the GIL while it waits."

</details>

### Q79. What is a race condition? Show a fix. 🔥🔥

<details><summary>Answer dekho 👀</summary>

**Race condition** tab hoti hai jab result threads ki bad-kismat timing pe depend kare. `count += 1` asal mein *read, add, write* hai; do threads dono 5 padh sakte hain aur dono 6 likh sakte hain, aur ek update kho jaata hai. GIL isse nahi rokta kyunki in steps ke beech thread switch ho sakta hai. Ise **`Lock`** se fix karo taaki ek time pe sirf ek thread critical section chalaye (ya shared state se bacho: `queue.Queue` use karo, ya har thread ko apna counter do aur end mein jod do).

```python
import threading

count = 0
lock = threading.Lock()

def work():
    global count
    for _ in range(100_000):
        with lock:              # acquire, chalao, hamesha release
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

Lock ke bina final value *kabhi-kabhi* 400,000 se kam hoti hai, aur kitni baar, yeh Python version aur machine pe depend karta hai. Yahi unpredictability race conditions ko khatarnaak banati hai.

Desi version: ek joint bank account, do log ek saath ATM pe. Dono ne balance ₹5000 dekha, dono ne ₹1000 jama kiya, dono ne "₹6000" likh diya. Ek ₹1000 gaayab. Lock matlab ATM cabin ka darwaaza: ek time pe ek hi banda andar.

</details>

### Q80. Explain `async` / `await`. 🔥🔥

<details><summary>Answer dekho 👀</summary>

`async def` ek **coroutine** define karta hai. `await` use tab tak rok deta hai jab tak awaited operation khatam na ho, aur **control event loop ko wapas de deta hai**, jo is beech doosre coroutines chalata hai. Ek thread hazaaron intezaar karte tasks sambhaal leta hai. `asyncio.gather` kai coroutines ko concurrently chalata hai. Key rule: coroutine ke andar kabhi blocking functions (`time.sleep`, `requests.get`) call mat karo; woh poore loop ko jam kar dete hain. Async libraries (`asyncio.sleep`, `aiohttp`) ya `asyncio.to_thread` use karo.

```python
import asyncio
import time

async def fetch(name, delay):
    await asyncio.sleep(delay)          # nakli network wait; loop is beech doosron ko chalata hai
    return f"{name} done"

async def main():
    start = time.perf_counter()
    results = await asyncio.gather(fetch("a", 0.2), fetch("b", 0.2), fetch("c", 0.2))
    elapsed = time.perf_counter() - start
    print(results)
    print("ran concurrently:", elapsed < 0.5)    # lagbhag 0.2 s, 0.6 s nahi

asyncio.run(main())
```

```text
['a done', 'b done', 'c done']
ran concurrently: True
```

</details>

### Q81. What is `concurrent.futures`? 🔥

<details><summary>Answer dekho 👀</summary>

Threads aur processes ke upar ek high-level API. `ThreadPoolExecutor` aur `ProcessPoolExecutor` ka interface same hai: `submit(fn, *args)` ek **Future** return karta hai; `map(fn, items)` results **input ke order mein** deta hai. Threads se processes pe switch karna ek shabd ka change hai.

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

<details><summary>Answer dekho 👀</summary>

**Deadlock** tab hota hai jab do (ya zyada) threads mein se har ek ke paas woh lock hai jo doosre ko chahiye, toh dono hamesha ke liye intezaar karte rehte hain. Thread 1 ke paas lock A hai aur woh B ka intezaar kar raha hai; thread 2 ke paas B hai aur woh A ka intezaar kar raha hai.

Desi version: patli gali mein do gaadiyan aamne-saamne. Dono kehti hain "pehle tum peeche hato". Koi nahi hatta, traffic hamesha ke liye jam.

Isse bachne ke tareeke:
1. **Locks hamesha ek hi global order mein lo** (jaise account ID ke hisaab se).
2. Locks ko jitna kam ho sake utni der pakdo, aur lock pakde hue kabhi anjaan code call mat karo.
3. `lock.acquire(timeout=...)` use karo aur fail ho toh peeche hato.
4. Kam locks use karo: `queue.Queue` jaise higher-level tools ya message passing.

</details>

### Q83. How do processes share data in `multiprocessing`? 🔥

<details><summary>Answer dekho 👀</summary>

By default processes **memory share nahi karte**; har ek ke paas apni copy hai. Data **pickling** (serialising) karke bheja jaata hai. Options:
- `multiprocessing.Queue` / `Pipe`: processes ke beech messages bhejo.
- `Pool.map` / `ProcessPoolExecutor.map`: arguments aur results tumhare liye pickle ho jaate hain.
- `Value` / `Array`: chhote shared-memory primitives, apne locks ke saath.
- `multiprocessing.shared_memory`: raw shared buffers (jaise bade NumPy arrays).
- `Manager()`: ek server process ke through proxy objects (shared dict/list), convenient lekin slow.

Windows aur macOS pe processes **spawn** se shuru hote hain, toh entry code `if __name__ == "__main__":` ke neeche hi hona chahiye.

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

Interviewers ko "yeh kya print karega?" bahut pasand hai. Answer kholne se **pehle** predict karo. Har ek ek asli concept test karta hai.

### Q84. `+=` vs `+` on a shared list 🔥🔥

```py
a = [1, 2]
b = a
b += [3]
b = b + [4]
print(a, b)
```

<details><summary>Answer dekho 👀</summary>

```python
a = [1, 2]
b = a
b += [3]          # in-place extend: a aur b ab bhi wahi list hain
b = b + [4]       # NAYI list banata hai aur sirf b ko rebind karta hai
print(a, b)
```

```text
[1, 2, 3] [1, 2, 3, 4]
```

Lists ke liye `+=` `__iadd__` call karta hai (in place mutate karta hai), jabki `+` naya object banata hai.

</details>

### Q85. What type is `(1)`? 🔥

<details><summary>Answer dekho 👀</summary>

Sirf brackets se tuple nahi banta: **comma banata hai**.

```python
print(type((1)).__name__, type((1,)).__name__, type(()).__name__)
t = 1, 2
print(t)
```

```text
int tuple tuple
(1, 2)
```

(Ek exception yaad rakho: khaali `()` bina comma ke bhi tuple hai.)

</details>

### Q86. Float comparison 🔥🔥🔥

```py
print(0.1 + 0.2 == 0.3)
```

<details><summary>Answer dekho 👀</summary>

Floats **binary** mein store hote hain, aur 0.1 ka koi exact binary representation nahi hai (jaise decimal mein 1/3 ka nahi hota: 0.3333... kabhi khatam nahi hota), isliye chhote errors aa jaate hain. Tolerance ke saath compare karo, ya exact arithmetic ke liye `decimal.Decimal` / `fractions.Fraction` use karo (paise ke hisaab mein zaroor!).

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

Dhyaan do: `Decimal("0.1")` string se banaya, float se nahi. `Decimal(0.1)` likhoge toh woh float ki galti bhi saath le aayega.

> 🗣️ **Interview mein aise bolo:** "It prints False, because floats are stored in binary and 0.1 and 0.2 have no exact binary representation, so the sum is 0.30000000000000004. I'd compare floats with a tolerance using `math.isclose`, and for money or anything that needs exact decimal arithmetic I'd use `Decimal` built from strings, or `Fraction`."

</details>

### Q87. `round()` surprises 🔥🔥

```py
print(round(0.5), round(1.5), round(2.5), round(2.675, 2))
```

<details><summary>Answer dekho 👀</summary>

Python 3 **banker's rounding** (round half to even) use karta hai: barabar door wale ties sabse paas wale **even** number ki taraf jaate hain, jo statistically upar ki taraf jhukaav (bias) se bachata hai. Aur `2.675` asal mein 2.67499999... store hota hai, isliye neeche round hota hai.

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

<details><summary>Answer dekho 👀</summary>

`bool` `int` ki subclass hai: `True == 1` aur `False == 0`. Aur kyunki `True == 1 == 1.0` aur unke hashes barabar hain, woh **same dict key** hain. Pehla key object (`True`) rakha jaata hai; value har baar overwrite hoti hai.

```python
print(True + True, True * 10, sum([True, False, True]))
print({True: "a", 1: "b", 1.0: "c"})
```

```text
2 10 2
{True: 'c'}
```

`sum(flags)` se True values ginna ek kaam ka idiom hai.

</details>

### Q89. Mutating a list inside a tuple 🔥

```py
t = ([1, 2],)
t[0] += [3]
```

<details><summary>Answer dekho 👀</summary>

Yeh `TypeError` **raise karta hai**... **aur** phir bhi list badal deta hai! `t[0] += [3]` do steps karta hai: (1) `t[0].__iadd__([3])` list ko in place extend karta hai (safal), phir (2) `t[0] = result` tuple mein assign karne ki koshish karta hai (fail).

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

Safe tareeka: `t[0].append(3)` ya `t[0].extend([3])`.

</details>

### Q90. Removing items while looping 🔥🔥

```py
nums = [1, 2, 2, 3, 2]
for x in nums:
    if x == 2:
        nums.remove(x)
print(nums)
```

<details><summary>Answer dekho 👀</summary>

Loop andar se ek index use karta hai. Element hatane se sab kuch left khisak jaata hai, toh hataye gaye element ke theek baad wala element **skip** ho jaata hai.

Step by step dekho:
1. Index 0: `x = 1`, kuch nahi.
2. Index 1: `x = 2`, `remove(2)` → list `[1, 2, 3, 2]`. Sab left khisak gaye.
3. Index 2: ab yahan `3` hai. Doosra `2` (jo khisak ke index 1 pe aa gaya) **skip** ho gaya.
4. Index 3: `x = 2`, `remove(2)`. Lekin `remove` value ka **pehla** occurrence hatata hai, yaani index 1 wala `2` → list `[1, 3, 2]`.
5. Index 4: list ki length ab 3 hai, loop khatam.

```python
nums = [1, 2, 2, 3, 2]
for x in nums:
    if x == 2:
        nums.remove(x)
print(nums)

nums = [1, 2, 2, 3, 2]
nums = [x for x in nums if x != 2]     # iski jagah nayi list banao
print(nums)
```

```text
[1, 3, 2]
[1, 3]
```

Is puzzle mein do traps ek saath hain: (1) skip hona, aur (2) `remove(x)` value ka **pehla** occurrence hatata hai, current wala nahi.

</details>

### Q91. `UnboundLocalError` 🔥🔥

```py
x = 10
def f():
    print(x)
    x = 20
f()
```

<details><summary>Answer dekho 👀</summary>

Kyunki `f` ke andar kahin `x` ko **assign** kiya gaya hai, compiler `x` ko **poore function ke liye local** mark kar deta hai. Isliye `print(x)` ek local `x` dhoondhta hai jo abhi tak assign nahi hua, jabki ek global `x` maujood hai.

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

Fix: `global x` use karo (aksar acchi idea nahi), ya behtar, value ko parameter ki tarah pass karo.

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

<details><summary>Answer dekho 👀</summary>

`finally` hamesha chalta hai, aur wahan ka `return` pehle wale return ko **override** kar deta hai (yeh ek exception ko bhi nigal jaata!). Isiliye `finally` se return karna bad practice maana jaata hai, aur Python 3.14 iske liye `SyntaxWarning` deta hai.

```py
print(f())    # finally
```

</details>

### Q93. `all([])` and `any([])` 🔥

<details><summary>Answer dekho 👀</summary>

Kuch nahi ka `all` **True** hai ("koi element falsy nahi hai" khaali list ke liye apne aap sach hai), aur kuch nahi ka `any` **False** hai ("koi truthy element hai hi nahi").

```python
print(all([]), any([]), all([0]), any([0, "", None, 3]))
```

```text
True False False True
```

Aise socho: class mein koi student hi nahi, toh "saare students pass hue" galat saabit nahi kiya ja sakta (True), lekin "koi ek student pass hua" bhi sach nahi (False).

</details>

### Q94. Slice vs index out of range 🔥

<details><summary>Answer dekho 👀</summary>

End ke aage index karna `IndexError` raise karta hai; end ke aage slice karna bas jo hai woh de deta hai (shayad khaali).

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

<details><summary>Answer dekho 👀</summary>

Comparison operators (`in`, `is`, `==` samet) chain hote hain: `a op1 b op2 c` ka matlab hai `(a op1 b) and (b op2 c)`. Toh doosri line `(False == False) and (False in [False])` hai, `(False == False) in [False]` nahi.

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

Teesri line: `(False == False)` = `True`, aur `True in [False]` = False.

</details>

### Q96. Default argument evaluated once, with a timestamp 🔥🔥

```py
import time
def log(msg, when=time.time()):
    print(when, msg)
```

<details><summary>Answer dekho 👀</summary>

Har call **same time** print karti hai: default ek baar calculate hua tha, jab `def` chala tha (Q29 wali hi jad). `when=None` use karo aur andar calculate karo.

```python
calls = []
def stamp():
    calls.append(len(calls) + 1)
    return len(calls)

def log(msg, when=stamp()):        # stamp() sirf EK BAAR chalta hai, definition ke waqt
    return (when, msg)

print(log("a"), log("b"), len(calls))
```

```text
(1, 'a') (1, 'b') 1
```

`len(calls)` 1 hai, yaani `stamp()` poore program mein sirf ek baar chala, do calls ke baawajood.

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

<details><summary>Answer dekho 👀</summary>

`a.x = 5` `a` pe ek **instance** attribute banata hai jo class attribute ko chhupa (shadow) deta hai. `b` ke paas koi instance attribute nahi, toh woh class attribute padhta hai, jo ab 10 hai.

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

## 🧠 Never-Forget Summary · Kabhi Mat Bhoolna

- **`is` = same object, `==` = same value.** `is` sirf `None`/singletons ke liye.
- **Mutable defaults shared hote hain.** `None` use karo aur andar banao.
- **Python object references pass karta hai.** Mutation caller ko dikhta hai; rebinding nahi.
- **Shallow copy andar ke objects share karti hai**; `[[0]*n]*m` rows share karta hai.
- **Dict/set = hash tables**, average O(1); keys hashable honi chahiye; dicts insertion order rakhte hain (3.7+).
- **Generators lazy aur single-use hain.** Comprehension `[]` list banata hai; `()` generator banata hai.
- **Decorator = function andar, function bahar** (`functools.wraps`!). Arguments ke saath ho toh ek layer aur.
- **Context managers cleanup ki guarantee dete hain** (`__enter__` / `__exit__`, ya `@contextmanager`).
- **Memory:** reference counting + generational cycle collector.
- **GIL:** ek time pe ek thread bytecode chalata hai. CPU-bound → processes; I/O-bound → threads/asyncio.
- **`super()` MRO follow karta hai**, sirf "parent" nahi.
- **Loops pe `else` = "no break"; try pe `else` = "no exception"; `finally` = hamesha.**

**Memory hook: "MID-GAP"**, woh chhe cheezein jo interviewers sabse zyada check karte hain: **M**utable defaults, **I**s vs ==, **D**ecorators, **G**enerators, **A**rgs/kwargs, **P**ass-by-object-reference. (Phir GIL ko "boss question" ki tarah jod do.)

**🪝 Yaad rakhne ka jugaad:** "**MID-GAP** ko bharo, warna interview mein **gap** reh jaayega." Aur poore chapter ka ek mantra: **"Naam sirf sticker hai, dabba object hai."** `b = a` = ek hi dabbe pe doosra sticker. Mutation = dabbe ke andar ka saamaan badalna (har sticker wale ko dikhega). Rebinding = sticker utha ke doosre dabbe pe chipkana (baaki sticker wahin rahe). `is` = "kya dono sticker ek hi dabbe pe hain?" `==` = "kya dono dabbon mein same saamaan hai?"

**Ek picture mein sab:**

| Topic | Bolne wala ek sentence |
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

(Right column English mein hi hai, kyunki yahi sentences interview mein bolne hain.)

> **Agar sirf ek cheez yaad rakho:** Python mein **naam objects ko point karte hain**. Lagbhag har tricky sawaal (mutable defaults, copies, `is`, pass-by-reference, aliasing) isi ek idea ka bhes badla hua roop hai.

---
**Aage:** [Chapter 03 · The Must-Do Problem List](03-must-do-problems.md)  ·  **Wapas** [Contents](../README.md)
