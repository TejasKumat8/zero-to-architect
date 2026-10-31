# Chapter 23 · Bit Manipulation & Math

> Tumhare computer ka har number chhote-chhote light switches ki ek line hai, har switch ON ya OFF. Zyadatar code ek number ko ek hi cheez ki tarah treat karta hai. Bit manipulation alag-alag switches ko flip karta hai, ya ek hi CPU instruction mein saare 64 ek saath. Isi se tum das lakh items mein se ek akela odd item sirf ek variable se dhundh lete ho, ek `for` loop se kisi set ke saare subsets list kar lete ho, aur bina `+` ke do numbers jod lete ho. Isme thodi si number theory (GCD, primes, modular arithmetic) jod do, aur "return the answer modulo 10⁹ + 7" wali line se tumhara darr hamesha ke liye khatam.

**Is chapter mein tum seekhoge:**
- Integers binary mein asal mein kaise dikhte hain, aur **two's complement** negative numbers ko kaise store karta hai
- Har bit operator (`&`, `|`, `^`, `~`, `<<`, `>>`) aur unse bane darjan bhar tricks: bit check/set/clear/toggle karna, `n & (n-1)`, lowest set bit, power of two
- **XOR ka jaadu**: Single Number I, II, III, Missing Number, aur bina temp ke swap
- Counting Bits, Reverse Bits, bitmasks se subsets, aur bina `+` ke addition
- DSA ke liye math: **GCD/LCM** (Euclid ke proof ke saath), **primes** (trial division, Sieve of Eratosthenes), **modular arithmetic** aur 10⁹ + 7, **fast exponentiation**, **modular inverse** (Fermat), **nCr mod p**, fast Fibonacci
- Integer overflow (Python ise kyun chhupata hai aur baaki languages kyun nahi) aur **reservoir sampling**

**Isse pehle padho:** [Operators & Expressions](../part-1-python/03-operators-expressions.md) · [Variables, Data Types & Memory](../part-1-python/02-variables-types-memory.md) · [Big-O](01-big-o-complexity.md) · [Recursion & Backtracking](09-backtracking.md) (subsets ke liye)

---

## 🧠 The Big Idea · Asli Baat

Decimal mein har position apne right wale se 10 guna keemti hai: 1, 10, 100, 1000. **Binary** mein har position **2 guna** keemti hai: 1, 2, 4, 8, 16, ... aur har digit (ek **bit**) 0 ya 1 hota hai.

```text
bit position:   7    6    5    4    3    2    1    0
worth:        128   64   32   16    8    4    2    1
13 in binary:   0    0    0    0    1    1    0    1     -> 8 + 4 + 1 = 13
```

Har bit ko ek light switch samjho. Ek number switches ka ek panel hai. Bit operators **saare switches pe ek saath** kaam karte hain, position by position:

```text
      13 = 0000 1101
       6 = 0000 0110
 13 & 6  = 0000 0100  = 4    (AND: on only where BOTH are on)
 13 | 6  = 0000 1111  = 15   (OR: on where EITHER is on)
 13 ^ 6  = 0000 1011  = 11   (XOR: on where they DIFFER)
```

CPU ye kaam 64 positions ke liye ek hi instruction mein karta hai. Isiliye bit tricks fast hain, aur isiliye ek single integer zyada se zyada 64 haan/na flags ka compact set ban sakta hai (ek **bitmask**).

> 🇮🇳 **Desi Analogy:** Ghar ke main switchboard ko socho jisme 8 switches hain: pankha, tubelight, AC, geyser, TV... Tum ek number se poore board ki state bata sakte ho: `13 = 0000 1101` matlab switch 0, 2 aur 3 ON hain, baaki OFF. Ab `&` ek "dono boards mein jo ON hai" wala check hai, `|` "kisi bhi board mein ON" hai, `^` "jahan dono boards alag hain" hai. Aur sabse mast baat: electrician (CPU) poore board ko ek hi jhatke mein padh leta hai, ek-ek switch nahi. **Switch = bit**, **board = integer**, **ek jhatka = ek CPU instruction**.

> 💡 **Soch ka badlav:** `13` ko "terah" padhna band karo aur "switch 0, 2 aur 3 on hain" padhna shuru karo. Jaise hi tumhe switches dikhne lagenge, is chapter ki har trick obvious lagne lagegi.

Chapter ka doosra half **DSA ke liye math** hai: number theory ka ek chhota toolkit jo interviews mein baar-baar aata hai. GCD, primes, aur khaas taur pe **modular arithmetic**, kyunki jab answers bahut hi bade ho jaate hain (paths, arrangements, subsets ginna), toh problems unhe "mod 10⁹ + 7" mein maangte hain.

---

## 🔨 Building It Up · Zero Se Shuru

### 1. Python mein binary

```python
n = 13
print(bin(n))                 # string with the 0b prefix
print(format(n, "08b"))       # padded to 8 bits, no prefix
print(int("1101", 2))         # parse binary text
print(0b1101, 0xFF, 0o17)     # binary, hex, octal literals
print(n.bit_length())         # how many bits are needed

# converting by hand: repeatedly divide by 2, read remainders bottom-up
x, bits = 13, []
while x:
    bits.append(x % 2)
    x //= 2
print("".join(map(str, reversed(bits))))
```

```text
0b1101
00001101
13
13 255 15
4
1101
```

Kya hua yahan: `x % 2` sabse neeche wala bit padhta hai aur `x // 2` sab kuch ek position right khiska deta hai. Ye dono operations exactly `x & 1` aur `x >> 1` hain, jaise hum aage dekhenge.

Haath se 13 ko convert karo: 13 ÷ 2 = 6 baaki **1**, 6 ÷ 2 = 3 baaki **0**, 3 ÷ 2 = 1 baaki **1**, 1 ÷ 2 = 0 baaki **1**. Remainders neeche se upar padho: `1101`. Wahi answer.

### 2. Two's complement: negative numbers kaise store hote hain

Hardware integers ko fixed bits mein store karta hai (8, 32, 64). -5 ko kaise represent karoge? Har modern CPU jo scheme use karta hai wo hai **two's complement**:

> n bits mein, top bit ki value +2ⁿ⁻¹ ki jagah **-2ⁿ⁻¹** hoti hai. Baaki sab normal.

8 bits mein, top bit ki value -128 hai:

```text
 5  = 0000 0101  =  4 + 1
-5  = 1111 1011  = -128 + 64 + 32 + 16 + 8 + 2 + 1 = -5
-1  = 1111 1111  = -128 + 127
-128= 1000 0000
127 = 0111 1111
```

**Negate karne ki recipe:** har bit flip karo, phir 1 jodo. `-x == ~x + 1`. Check karo: 5 = `0000 0101` → flip → `1111 1010` → +1 → `1111 1011` = -5. ✓

Ye design kyun? Kyunki addition **bina kisi special case** ke kaam karta hai: 5 + (-5) = `0000 0101 + 1111 1011 = 1 0000 0000`, aur 9th bit kinaare se gir jaata hai, bachta hai 0. CPU signed aur unsigned dono numbers ke liye ek hi adder use karta hai.

> 🇮🇳 **Desi Analogy:** Purani car ka 3-digit odometer socho jo 000 se 999 tak jaata hai. 000 se ek kilometer *peeche* jao toh 999 dikhega. Toh "999" ko "-1" maan sakte ho, "998" ko "-2". Ab 999 + 1 = 1000, lekin odometer mein sirf 3 digits hain, toh pehla 1 gir jaata hai aur 000 bachta hai, yaani -1 + 1 = 0. Two's complement exactly yahi hai, bas binary mein: **odometer = fixed bits**, **peeche jaana = negative**, **gira hua digit = overflow carry jo kinaare se gir jaata hai**.

**Python alag hai:** iske integers ka **size unlimited** hai, toh koi "top bit" nahi hota. Concept mein, ek negative Python int two's complement hai jiske left mein **infinite 1s** hain. 8-bit ya 32-bit picture dekhni hai toh mask lagao:

```python
x = -5
print(bin(x))                          # Python shows a minus sign, not the bits
print(format(x & 0xFF, "08b"))         # the 8-bit two's complement pattern
print(format(x & 0xFFFFFFFF, "032b"))  # the 32-bit pattern
print(~5, -5 == ~5 + 1)                # ~x is always -x - 1

def to_signed32(u):
    """Interpret a 32-bit pattern (0..2**32-1) as a signed integer."""
    return u - (1 << 32) if u & (1 << 31) else u

print(to_signed32(0xFFFFFFFB), to_signed32(0x7FFFFFFF))
```

```text
-0b101
11111011
11111111111111111111111111111011
-6 True
-5 2147483647
```

| Signed n-bit integer ki range | Min | Max |
|---|---|---|
| 8-bit | -128 | 127 |
| 32-bit (C/Java mein `int`) | -2,147,483,648 | 2,147,483,647 |
| 64-bit (`long`) | lagbhag -9.2 × 10¹⁸ | lagbhag 9.2 × 10¹⁸ |

> 🤔 **Mann mein sawaal:** `bin(-5)` `-0b101` kyun dikhata hai, `11111011` kyun nahi?
>
> **Jawab:** Kyunki Python ke liye -5 ke left mein infinite 1s hain, toh wo poora pattern print hi nahi kar sakta. Isliye wo shortcut mein sign aur magnitude dikhata hai. Asli bits dekhne hain toh ek fixed width choose karo aur mask lagao: `x & 0xFF` 8 bits rakhta hai, `x & 0xFFFFFFFF` 32 bits. Mask lagane se number non-negative ban jaata hai, aur tab `format(..., "08b")` saaf bits dikha deta hai.

### 3. Chhe bit operators

| Operator | Naam | Har bit ka rule | Example (12 = `1100`, 10 = `1010`) |
|---|---|---|---|
| `a & b` | AND | 1 agar dono 1 hain | `1000` = 8 |
| `a \| b` | OR | 1 agar koi ek bhi 1 hai | `1110` = 14 |
| `a ^ b` | XOR | 1 agar dono alag hain | `0110` = 6 |
| `~a` | NOT | har bit flip (Python mein: `-a - 1`) | -13 |
| `a << k` | left shift | bits ko k jagah left khiskao (× 2ᵏ) | `12 << 2` = 48 |
| `a >> k` | right shift | bits ko k jagah right khiskao (floor ÷ 2ᵏ) | `12 >> 2` = 3 |

```python
a, b = 12, 10
print(a & b, a | b, a ^ b, ~a, a << 2, a >> 2)
print(-12 >> 2, -12 // 4)        # right shift of a negative = floor division
print(1 << 10, 7 >> 1)
```

```text
8 14 6 -13 48 3
-3 -3
1024 3
```

Kya hua yahan: `<<` aur `>>`, 2 ki powers se multiplication aur floor division hain. Negatives ke liye `>>` sign bachaye rakhta hai (ye ek **arithmetic** shift hai), toh `-12 >> 2 == -3`.

`<<` kyun multiply karta hai? Decimal mein 12 ke peeche ek zero lagao toh 120 (× 10). Binary mein `1100` ke peeche ek zero lagao toh `11000` = 24 (× 2). Do zeros = × 4 = 48. Same logic.

> ⚠️ **Precedence:** Python mein arithmetic (`+ -`) shifts (`<< >>`) se zyada tight bind karta hai, shifts `&` se zyada, phir `^`, phir `|`, phir comparisons. Toh `1 << n - 1` ka matlab `1 << (n - 1)` hai. Doubt ho toh brackets lagao.

### 4. Single-bit tricks: check, set, clear, toggle

Ye chaar bit manipulation ki ABCD hain. `1 << i` ek **mask** hai jisme sirf bit i on hai.

```python
def check(x, i):  return (x >> i) & 1         # is bit i on? (0 or 1)
def set_bit(x, i): return x | (1 << i)         # force bit i on
def clear(x, i):  return x & ~(1 << i)         # force bit i off
def toggle(x, i): return x ^ (1 << i)          # flip bit i

x = 0b1010                                      # 10
print(check(x, 1), check(x, 2))
print(format(set_bit(x, 0), "04b"), format(clear(x, 3), "04b"), format(toggle(x, 2), "04b"))
```

```text
1 0
1011 0010 1110
```

| Chahiye | Code | Kyun |
|---|---|---|
| Kya bit i on hai? | `(x >> i) & 1` | bit i ko position 0 pe le aao, sirf use rakho |
| Bit i on karo | `x \| (1 << i)` | 1 ke saath OR hamesha 1 deta hai; 0 ke saath OR waisa hi rakhta hai |
| Bit i off karo | `x & ~(1 << i)` | 0 ke saath AND hamesha 0 deta hai; 1 ke saath AND waisa hi rakhta hai |
| Bit i flip karo | `x ^ (1 << i)` | 1 ke saath XOR flip karta hai; 0 ke saath XOR waisa hi rakhta hai |

`clear` ko dhyaan se dekho: `~(1 << i)` ek aisa mask hai jisme bit i ke alawa *saare* bits on hain. Usse AND karne pe sirf bit i band hota hai, baaki sab waise ke waise.

### 5. Famous tricks: `n & (n-1)`, `x & -x`, power of two

**`n & (n - 1)` sabse neeche wala set bit hata deta hai.** 1 ghatane se sabse neeche wala 1, 0 ban jaata hai aur uske neeche ke saare 0s, 1s ban jaate hain. Original ke saath AND karne pe ye sab saaf ho jaate hain:

```text
n       = 1011 0100
n - 1   = 1011 0011
n&(n-1) = 1011 0000      <- the lowest 1 is gone
```

**`x & -x` sabse neeche wale set bit ko akela kar deta hai.** `-x = ~x + 1`: flip karne se sabse neeche wala 1, 0 ban jaata hai aur uske neeche 1s aa jaate hain, aur +1 carry hoke wapas usi position pe pahunchta hai. Uske upar ka har bit x ke relative flipped hai, toh AND karne pe sirf wahi ek bit bachta hai.

```text
x       = 0101 1000
-x      = 1010 1000
x & -x  = 0000 1000      <- only the lowest 1 survives
```

**Power of two** = exactly ek bit on = `n > 0 and n & (n - 1) == 0`.

**Set bits ginna** (**popcount** ya **Hamming weight**): baar-baar sabse neeche wala set bit hatao aur gino. Ye **Brian Kernighan ka algorithm** hai: ye har *set* bit ke liye ek baar loop chalata hai, har bit ke liye nahi.

```python
def is_power_of_two(n):
    return n > 0 and n & (n - 1) == 0

def lowest_set_bit(x):
    return x & -x

def popcount(n):
    count = 0
    while n:
        n &= n - 1          # drop the lowest 1
        count += 1
    return count

print([n for n in range(1, 70) if is_power_of_two(n)])
print(lowest_set_bit(0b1011000), lowest_set_bit(12))
print(popcount(0b1011), popcount(255), (255).bit_count(), bin(255).count("1"))
```

```text
[1, 2, 4, 8, 16, 32, 64]
8 4
3 8 8 8
```

Kya hua yahan: Python 3.10+ mein `int.bit_count()` built-in hai (sabse fast); `bin(n).count("1")` har jagah chalta hai. Interviews mein Kernighan ka loop aana chahiye: wahi test kiya jaata hai.

> 🤔 **Mann mein sawaal:** `n - 1` karne se *sirf* neeche wale bits kyun badalte hain? Upar wale kyun nahi?
>
> **Jawab:** Wahi borrow jo school mein decimal subtraction mein seekha tha. `1000 - 1` mein last digit 0 hai, toh wo pados se udhaar leta hai, wo bhi 0 hai toh aur aage, jab tak pehla non-zero digit na mile. Binary mein pehla non-zero digit sabse neeche wala 1 hai: wo 0 ban jaata hai aur udhaar ke raste ke saare 0s, 1s ban jaate hain. Uske upar ke bits ko udhaar ki zaroorat hi nahi padi, toh wo bilkul nahi badle. Isiliye `n & (n - 1)` mein upar ka hissa same rehta hai aur sirf wo ek 1 gayab hota hai.

### 6. XOR: cancel karne wala operator

XOR ki chaar properties use jaadui banati hain:

| Property | Matlab |
|---|---|
| `a ^ a = 0` | koi bhi cheez khud ko cancel kar deti hai |
| `a ^ 0 = a` | 0 matlab "kuch mat karo" |
| commutative aur associative | order matter nahi karta: `a ^ b ^ a = b` |
| `a ^ b = c` ⟺ `a ^ c = b` | XOR khud ka inverse hai (dobara karo toh undo) |

Toh agar tum ek list ka XOR lo jisme ek item ke alawa sab do-do baar aate hain, toh pairs cancel ho jaate hain aur akela wala bachta hai. Saath hi, tum bina temporary variable ke do variables swap kar sakte ho (party trick hai; Python mein bas `a, b = b, a` likho):

> 🇮🇳 **Desi Analogy:** Shaadi mein joote churai ka scene socho. Har mehmaan apne joote ka *joda* (pair) rakh ke gaya. Sab wapas lene aaye, lekin aakhir mein ek akela joota bacha hai jiska joda nahi aaya. Pairs ko milate jao aur hatate jao, jo akela bacha wahi tumhara answer hai. XOR yahi karta hai: **joda = `a ^ a = 0`**, **akela joota = single number**. Aur maze ki baat: jooton ka order kuch bhi ho, jode mil hi jaate hain (commutative).

```python
from functools import reduce
from operator import xor

print(reduce(xor, [4, 1, 2, 1, 2]))       # pairs cancel, 4 remains

a, b = 7, 12
a ^= b
b ^= a                                     # b = b ^ (a ^ b) = a
a ^= b                                     # a = (a ^ b) ^ a = b
print(a, b)
```

```text
4
12 7
```

### 7. Single Number I, II aur III

**I.** Ek ke alawa har element do baar aata hai. O(n) time, O(1) space mein dhundo → sab kuch XOR kar do (upar dekho).

**II.** Ek ke alawa har element **teen** baar aata hai. XOR triples ko cancel nahi karta. Iski jagah **har bit position gino**: har bit ke liye jodo ki kitne numbers mein wo on hai. Triples 3 ka multiple contribute karte hain, toh `count % 3` akele wale ka bit hai. (Python mein negatives ko 32 bits pe kaam karke aur wapas convert karke handle karo.)

```python
def single_number_ii(nums):
    result = 0
    for i in range(32):
        bit_sum = sum((x >> i) & 1 for x in nums)
        if bit_sum % 3:
            result |= 1 << i
    return result - (1 << 32) if result & (1 << 31) else result   # back to signed

print(single_number_ii([2, 2, 3, 2]), single_number_ii([0, 1, 0, 1, 0, 1, 99]), single_number_ii([-2, -2, 1, 1, 4, 1, 4, 4, -4, -2]))
```

```text
3 99 -4
```

`[2, 2, 3, 2]` pe haath se: 2 = `10`, 3 = `11`. Bit 0: sirf 3 mein on, count 1, `1 % 3 = 1` → on. Bit 1: teen 2's aur ek 3, count 4, `4 % 3 = 1` → on. Answer `11` = 3. ✓

(Ek famous O(1)-state version bhi hai jisme do variables `ones` aur `twos` har bit ke liye ek mod 3 counter ki tarah kaam karte hain; Interview Question 2 dekho.)

**III.** Exactly **do** elements ek baar aate hain; baaki sab do baar. Sab ka XOR `x ^ y` deta hai (non-zero, kyunki x ≠ y). `x ^ y` mein koi bit on hai, matlab us bit pe x aur y **alag** hain. Saare numbers ko us bit ke hisaab se do groups mein baanto: x aur y alag groups mein jaate hain, aur har pair ek saath ek hi group mein. Har group ka alag XOR lo.

```python
def single_number_iii(nums):
    both = 0
    for v in nums:
        both ^= v                    # = x ^ y
    diff_bit = both & -both          # lowest bit where x and y differ
    x = 0
    for v in nums:
        if v & diff_bit:
            x ^= v                   # group with that bit on -> isolates one loner
    return sorted([x, both ^ x])

print(single_number_iii([1, 2, 1, 3, 2, 5]), single_number_iii([-1, 0]))
```

```text
[3, 5] [-1, 0]
```

`[1, 2, 1, 3, 2, 5]` ka **trace**: `both = 3 ^ 5 = 011 ^ 101 = 110` (6). Lowest set bit = `010` (2). Jin numbers mein bit 1 on hai: 2, 3, 2 → XOR = 3. Doosra akela = 6 ^ 3 = 5.

### 8. Counting Bits: ek bit DP

Ek array return karo jahan `ans[i]` i mein 1 bits ki ginti ho, i = 0..n ke liye, O(n) mein.

`i >> 1` matlab i jiska aakhri bit hata diya gaya, aur wo chhota hai, toh uska answer pehle se pata hai: `ans[i] = ans[i >> 1] + (i & 1)`. Ek shift se chalne wali chhoti si DP ([Chapter 20](20-dp-1d.md)). (Alternative: `ans[i] = ans[i & (i - 1)] + 1`.)

```python
def count_bits(n):
    ans = [0] * (n + 1)
    for i in range(1, n + 1):
        ans[i] = ans[i >> 1] + (i & 1)
    return ans

print(count_bits(5), count_bits(10))
```

```text
[0, 1, 1, 2, 1, 2] [0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2]
```

Example: `ans[5]`. 5 = `101`. `5 >> 1` = `10` = 2, aur `ans[2] = 1`. 5 ka aakhri bit 1 hai. Toh `ans[5] = 1 + 1 = 2`. ✓

### 9. Reverse Bits

Ek unsigned integer ke 32 bits ulte karo. n ke right se bits utaaro aur result ke right pe chadhao (isse pehle wale left khisak jaate hain).

```python
def reverse_bits(n):
    result = 0
    for _ in range(32):
        result = (result << 1) | (n & 1)    # append n's lowest bit to result
        n >>= 1
    return result

r = reverse_bits(43261596)
print(r)
print(format(43261596, "032b"))
print(format(r, "032b"))
```

```text
964176192
00000010100101000001111010011100
00111001011110000010100101000000
```

O(32) = O(1). (Follow-up "agar ye baar-baar call ho?" Har byte ka reverse ek 256-entry table mein cache karo aur 4 lookups combine karo.)

Ye exactly waisa hai jaise tum ek stack of plates ulta karte ho: upar se plate uthao aur doosre stack pe rakho. Jo pehle utha wo neeche chala gaya, jo aakhir mein utha wo upar.

### 10. Missing Number

`nums` mein `0..n` se n distinct numbers hain, toh exactly ek missing hai. O(1) space mein dhundo.

**XOR wala tareeka:** saare indexes 0..n aur saari values ka XOR lo. Har present number do baar aata hai aur cancel ho jaata hai; missing wala ek baar aata hai. **Sum wala tareeka:** `n(n+1)/2 - sum(nums)` (Python mein koi overflow nahi; Java/C++ mein XOR wala tareeka overflow se bachata hai).

```python
def missing_number(nums):
    result = len(nums)               # start with n (the index that has no slot)
    for i, v in enumerate(nums):
        result ^= i ^ v
    return result

def missing_number_sum(nums):
    n = len(nums)
    return n * (n + 1) // 2 - sum(nums)

print(missing_number([3, 0, 1]), missing_number([9, 6, 4, 2, 3, 5, 7, 0, 1]), missing_number_sum([0, 1]))
```

```text
2 8 2
```

`[3, 0, 1]` pe XOR: result shuru mein 3 (n). Phir `^ (0 ^ 3) ^ (1 ^ 0) ^ (2 ^ 1)`. Sab ek line mein: `3 ^ 0 ^ 3 ^ 1 ^ 0 ^ 2 ^ 1`. 3 do baar, 0 do baar, 1 do baar, cancel. Bacha 2. ✓

### 11. Bitmasks se subsets

n items ke set ke 2ⁿ subsets hote hain. Unhe 0 se 2ⁿ - 1 tak number do: number ke binary digits batate hain ki kaunse items andar hain (bit i on → item i included). Ek loop har subset list kar deta hai, recursion ki zaroorat nahi. ([Chapter 09](09-backtracking.md) ke backtracking version se compare karo.)

```python
def subsets(items):
    n = len(items)
    result = []
    for mask in range(1 << n):                     # 0 .. 2^n - 1
        result.append([items[i] for i in range(n) if mask & (1 << i)])
    return result

for mask, sub in enumerate(subsets(["a", "b", "c"])):
    print(format(mask, "03b"), sub)
```

```text
000 []
001 ['a']
010 ['b']
011 ['a', 'b']
100 ['c']
101 ['a', 'c']
110 ['b', 'c']
111 ['a', 'b', 'c']
```

Time O(n × 2ⁿ). Bitmask DP ([Chapter 21](21-dp-2d-advanced.md)) bhi "visited cities ka set" isi tarah represent karta hai.

> 🇮🇳 **Desi Analogy:** Thali order karte waqt tumhare saamne 3 options hain: dal (a), paneer (b), chhole (c). Har option ke saamne ek haan/na checkbox. 3 checkboxes ke 2³ = 8 combinations hain, khaali thali (000) se full thali (111) tak. Har combination ek 3-bit number hai. Toh 0 se 7 tak ginna = har possible thali ek baar dekhna. **Checkbox = bit**, **thali = subset**, **0..2ⁿ-1 = saari thalis**.

### 12. Bina `+` ke Sum of Two Integers

Sirf bit operations se jodo. Binary mein school wala addition socho:

- `a ^ b` har column ko **carry ignore karke** jodta hai (1+1 = 0, carry 1).
- `(a & b) << 1` **carry** hai: jahan bhi dono bits 1 hain wahan 1, ek column left khiska hua.
- In dono ko isi tarah jodo, jab tak koi carry na bache.

Python mein negative numbers ke aage infinite 1s hote hain, toh carry kabhi gir ke khatam nahi hoga. Hum ek mask se 32-bit hardware simulate karte hain aur end mein wapas signed mein convert karte hain.

```python
def get_sum(a, b):
    MASK = 0xFFFFFFFF                  # keep 32 bits, like real hardware
    a, b = a & MASK, b & MASK
    while b:
        carry = ((a & b) << 1) & MASK
        a = a ^ b                      # sum without carries
        b = carry
    return a if a <= 0x7FFFFFFF else ~(a ^ MASK)   # reinterpret as signed 32-bit

print(get_sum(1, 2), get_sum(-2, 3), get_sum(-5, -7), get_sum(15, 27))
```

```text
3 1 -12 42
```

15 + 27 ka **trace** (`01111 + 11011`):

| step | a | b (carry) |
|---|---|---|
| start | 001111 | 011011 |
| 1 | 010100 | 010110 |
| 2 | 000010 | 101000 |
| 3 | 101010 | 000000 |

Result `101010` = 42. `~(a ^ MASK)` 32 bits ko wapas flip karta hai aur phir Python ka `~` lagata hai taaki negative value mile (`a - 2**32` ke barabar).

Kyun? Maano `a` = `0xFFFFFFF4` (32-bit pattern -12 ka). `a ^ MASK` saare 32 bits flip karta hai = `0x0000000B` = 11. Phir `~11` = -12. ✓

### 13. GCD aur LCM: Euclid ka algorithm (proof ke saath)

**Greatest common divisor** `gcd(a, b)` wo sabse bada number hai jo dono ko divide karta hai. **Euclid ka algorithm** (lagbhag 2300 saal purana aur aaj bhi sabse best):

```text
gcd(a, b) = gcd(b, a mod b),   gcd(a, 0) = a
gcd(48, 18) -> gcd(18, 12) -> gcd(12, 6) -> gcd(6, 0) = 6
```

**Ye sahi kyun hai:** likho `a = q·b + r` (r = a mod b). Jo bhi d, a aur b dono ko divide karta hai, wo `r = a - q·b` ko bhi divide karta hai. Jo bhi d, b aur r dono ko divide karta hai, wo `a = q·b + r` ko bhi divide karta hai. Toh pairs (a, b) aur (b, r) ke **bilkul same common divisors** hain, isliye greatest bhi same hai. Har step pe numbers chhote hote jaate hain, aur `gcd(a, 0) = a` kyunki har cheez 0 ko divide karti hai.

**Ye fast kyun hai:** har do steps mein bada number kam se kam aadha ho jaata hai (agar `b ≤ a/2`, toh `r < b ≤ a/2`; warna `r = a - b < a/2`). Toh ye O(log min(a, b)) steps leta hai.

> 🇮🇳 **Desi Analogy:** Tumhare paas 48 cm aur 18 cm ki do patti hain, aur tumhe sabse badi tile size chahiye jo dono ko bina tukde bache exactly bhar de. Badi patti se chhoti patti jitne tukde kaat lo: 48 mein se 18 do baar, 12 bacha. Ab sawaal 18 aur 12 ka hai. 18 mein se 12 ek baar, 6 bacha. Ab 12 aur 6: 12 mein 6 exactly do baar, kuch nahi bacha. Answer 6 cm tile. **Patti = number**, **kaat ke bacha tukda = `a mod b`**, **kuch na bache = `gcd(a, 0) = a`**. Har baar bacha tukda chhota hota jaata hai, isliye jaldi khatam.

**LCM** (least common multiple): `lcm(a, b) = a // gcd(a, b) * b` (numbers chhote rakhne ke liye pehle divide karo).

```python
import math

def gcd(a, b):
    while b:
        a, b = b, a % b
    return a

def lcm(a, b):
    return a // gcd(a, b) * b

print(gcd(48, 18), gcd(17, 5), gcd(0, 9), lcm(4, 6), lcm(21, 6))
print(math.gcd(48, 18), math.lcm(4, 6), math.gcd(12, 18, 24))     # built-ins (3.9+)
```

```text
6 1 9 12 42
6 12 6
```

> 💡 `gcd(a, b) == 1` ka matlab a aur b **coprime** hain. Fractions lowest terms mein tab hote hain jab numerator aur denominator coprime ho. Coprime daanton wale gears barabar ghiste hain. Ye har jagah dikhta hai.

### 14. Primes: trial division aur Sieve of Eratosthenes

**Prime** ke exactly do divisors hote hain: 1 aur khud. (1 prime nahi hai.)

**Trial division:** n test karne ke liye, 2, 3, ... se **√n** tak divide karke dekho. √n pe kyun ruko? Agar `n = a × b` aur a, b dono √n se bade hain, toh `a × b > n`. Toh har factorisation mein ek factor ≤ √n hota hai. `n ** 0.5` ki jagah `math.isqrt` use karo (exact integer square root) (bade n ke liye floats precision kho dete hain).

Example: 97 prime hai ya nahi? √97 ≈ 9.8, toh sirf 2 se 9 tak check karo. Koi divide nahi karta, toh prime. 97 tak saare numbers check karne ki zaroorat nahi.

**Sieve of Eratosthenes:** N tak ke **saare** primes dhundne ke liye, 2..N likho; pehla bina-kata number p lo (wo prime hai), uske multiples kaat do, dohrao.

Do optimisations: kaatna **p × p** se shuru karo (2p, 3p jaise chhote multiples pehle hi chhote primes ne kaat diye hain), aur jab p × p > N ho jaaye toh ruk jao.

> 🇮🇳 **Desi Analogy:** School assembly mein 1 se 100 roll numbers ke bachche khade hain. PT sir kehte hain: "Roll number 2 ko chhod ke, 2 ke saare multiples baith jao." Phir "3 ko chhod ke, 3 ke multiples baith jao." Phir 4 toh pehle hi baith gaya, skip. "5 ke multiples baith jao." Jo log end tak khade rehte hain, wahi primes hain. Aur 7 ke multiples mein 14, 21, 28... pehle hi baith chuke hain (2, 3 ki wajah se), toh 7 ka kaam 49 se shuru hota hai. Wahi **p × p** wala optimisation hai.

```python
import math

def is_prime(n):
    if n < 2:
        return False
    for d in range(2, math.isqrt(n) + 1):
        if n % d == 0:
            return False
    return True

def sieve(n):
    is_p = [True] * (n + 1)
    is_p[0] = is_p[1] = False
    for p in range(2, math.isqrt(n) + 1):
        if is_p[p]:
            for multiple in range(p * p, n + 1, p):
                is_p[multiple] = False
    return [i for i, flag in enumerate(is_p) if flag]

def prime_factors(n):
    factors, d = [], 2
    while d * d <= n:
        while n % d == 0:
            factors.append(d)
            n //= d
        d += 1
    if n > 1:
        factors.append(n)              # whatever is left is a prime > sqrt(original)
    return factors

print([n for n in range(30) if is_prime(n)])
print(sieve(50))
print(len(sieve(1_000_000)))
print(prime_factors(360), prime_factors(97), prime_factors(1001))
```

```text
[2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
[2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
78498
[2, 2, 2, 3, 3, 5] [97] [7, 11, 13]
```

| Method | Kis kaam ke liye | Time |
|---|---|---|
| Trial division | ek number test karna | O(√n) |
| Sieve | N tak ke saare primes, ya ≤ N ki bahut saari queries | O(N log log N) |
| Trial division se factorisation | ek number | O(√n) |

`log log N` itna dheere badhta hai (N = 10⁹ ke liye lagbhag 3) ki sieve practically linear hai.

### 15. Modular arithmetic aur 10⁹ + 7

Jab problem kehta hai "return the answer **modulo 10⁹ + 7**", matlab asli answer bahut bada hai (jaise 10⁵ stairs chadhne ke tareekon mein lagbhag 21,000 digits hain) aur unhe sirf remainder chahiye. Yahi number kyun?

- **Ye prime hai.** Isse division possible hota hai (modular inverses exist karte hain, section 17).
- **Ye 32-bit signed int mein fit hota hai** (lagbhag 2³⁰), aur do ka sum bhi fit hota hai.
- **Do ka product 64 bits mein fit hota hai** (lagbhag 10¹⁸ < 9.2 × 10¹⁸), toh C++/Java bina overflow ke multiply karke phir reduce kar sakte hain.

Rules: tum `+`, `-` aur `×` ke **har step pe** reduce kar sakte ho, aur final remainder same aata hai:

```text
(a + b) mod m = ((a mod m) + (b mod m)) mod m
(a - b) mod m = ((a mod m) - (b mod m)) mod m      (Python's % keeps it non-negative)
(a × b) mod m = ((a mod m) × (b mod m)) mod m
(a / b) mod m  ≠  (a mod m) / (b mod m)            <- division does NOT work like this!
```

> 🇮🇳 **Desi Analogy:** Ghadi (clock) ka 12-hour system hi modular arithmetic hai, mod 12. Abhi 10 baje hain, 5 ghante baad kitne bajenge? 15 nahi, 3. Aur 100 ghante baad? Tumhe 100 ghante gin ke chalne ki zaroorat nahi: 100 mod 12 = 4, toh 10 + 4 = 14, mod 12 = 2 baje. Har step pe reduce karo, answer same. **Ghadi = mod m**, **ghante jodna = `+`**, **12 ke baad wapas 0 = `% m`**. Bas 10⁹ + 7 waali ghadi bahut badi hai.

```python
MOD = 10**9 + 7

# climbing stairs for n = 100000, reduced at every step
a, b = 1, 1
for _ in range(100000 - 1):
    a, b = b, (a + b) % MOD
print(b)

print((-7) % 5, (3 - 10) % MOD)          # Python's % is never negative for positive m
print((10**18) % MOD, (MOD - 1) * (MOD - 1) % MOD)
```

```text
967618232
3 1000000000
49 1
```

Kya hua yahan: har step pe numbers ko chhota rakhne se har addition O(1) rehta hai. `% MOD` ke bina Python phir bhi kaam karta (big ints), lekin har number das hazaaron digits ka ho jaata aur loop reng-reng ke chalta. C++/Java mein ye chupchaap overflow ho jaata.

> 🤔 **Mann mein sawaal:** Agar plus aur multiply mein har step pe mod lena chalta hai, toh divide mein kyun nahi chalta?
>
> **Jawab:** Ek chhota example: `(12 / 4) mod 5 = 3`. Ab pehle reduce karo: `12 mod 5 = 2`, `4 mod 5 = 4`, aur `2 / 4` integer bhi nahi hai! Mod lene ke baad number ka "divisible hona" kho jaata hai. Plus aur multiply mein remainder ka hisaab saaf chalta hai, division mein nahi. Isiliye division ko "inverse se multiply" mein badalna padta hai: section 17 mein `4` ka inverse mod 5 nikaalo toh wo 4 hai (`4 × 4 = 16 = 1 mod 5`), aur `2 × 4 = 8 mod 5 = 3`. Sahi answer!

### 16. Fast exponentiation (binary exponentiation)

`aⁿ` ko n baar multiply karke nikalna O(n) hai. n = 10¹⁸ ke liye impossible. Trick: **baar-baar square karo** aur n ke binary digits use karo.

```text
3^13, 13 = 1101 in binary = 8 + 4 + 1
3^13 = 3^8 × 3^4 × 3^1
and 3^1 -> 3^2 -> 3^4 -> 3^8 by squaring
```

Toh n ke bits pe sabse neeche se chalo: ek running `base` rakho (a, a², a⁴, a⁸, ...) aur jab bhi current bit 1 ho, use result mein multiply kar do. Ye O(log n) multiplications hain.

```python
def power_mod(a, n, mod):
    result = 1
    a %= mod
    while n:
        if n & 1:                 # this bit of n is on: include the current power
            result = result * a % mod
        a = a * a % mod           # a, a^2, a^4, a^8, ...
        n >>= 1
    return result

MOD = 10**9 + 7
print(power_mod(3, 13, 10**9), 3 ** 13)
print(power_mod(2, 10**18, MOD), pow(2, 10**18, MOD))     # built-in pow with 3 args does the same
```

```text
1594323 1594323
719476260 719476260
```

`3^13` ka **trace** (n = 1101₂):

| n (binary) | bit | result | a (current power) |
|---|---|---|---|
| 1101 | 1 | 1 × 3 = 3 | 3² = 9 |
| 110 | 0 | 3 | 9² = 81 |
| 11 | 1 | 3 × 81 = 243 | 81² = 6561 |
| 1 | 1 | 243 × 6561 = 1594323 | (done) |

Python mein hamesha built-in **`pow(a, n, mod)`** use karo: ye C mein yahi algorithm hai. Lekin interview chahta hai ki tum ise khud likho.

n = 10¹⁸ ke liye kitne steps? 10¹⁸ lagbhag 2⁶⁰ hai, toh sirf ~60 squarings aur ~60 multiplications. 10¹⁸ multiplications ki jagah 120. Yahi O(log n) ki taakat hai.

### 17. Fermat's little theorem se modular inverse

Modulus ke andar seedha divide nahi kar sakte, lekin **inverse se multiply** kar sakte ho. b mod m ka inverse wo number `b⁻¹` hai jiske liye `b × b⁻¹ ≡ 1 (mod m)`. Ye tab exist karta hai jab `gcd(b, m) = 1`.

**Fermat's little theorem:** agar p prime hai aur p, b ko divide nahi karta, toh `b^(p-1) ≡ 1 (mod p)`. Ek b alag karo: `b × b^(p-2) ≡ 1`. Toh:

> **b⁻¹ ≡ b^(p-2) (mod p)**, fast exponentiation se O(log p) mein compute hota hai.

```python
MOD = 10**9 + 7

def mod_inverse(b, p=MOD):
    return pow(b, p - 2, p)

inv3 = mod_inverse(3)
print(inv3, 3 * inv3 % MOD)
print(12 * mod_inverse(4) % MOD)          # "12 / 4" under the modulus
print(pow(3, -1, MOD) == inv3)            # Python 3.8+: pow with -1 exponent
```

```text
333333336 1
3
True
```

Kya hua yahan: 333333336 mod 10⁹+7 mein "1/3" ki tarah behave karta hai. Isiliye 10⁹+7 ka **prime** hona matter karta hai: har non-zero number ka inverse hota hai.

Chhote prime se check karo: p = 7, b = 3. `3^(7-2) = 3^5 = 243`. `243 mod 7 = 5`. Check: `3 × 5 = 15 = 2×7 + 1 ≡ 1`. ✓ Toh mod 7 mein "1/3" = 5.

### 18. Factorials ke saath nCr mod p

"n mein se r items chunne ke kitne tareeke" = `C(n, r) = n! / (r! × (n - r)!)`. Prime modulus ke andar divisions ko inverses se badal do. Bahut saari queries ho toh factorials aur inverse factorials ek baar O(N) mein **precompute** kar lo, phir har query O(1) hai.

Inverse factorials wali trick: `inv_fact[N]` ek Fermat call se nikalo, phir neeche aao `inv_fact[i-1] = inv_fact[i] × i` use karke (kyunki `1/(i-1)! = i / i!`).

```python
MOD = 10**9 + 7
N = 200_000

fact = [1] * (N + 1)
for i in range(1, N + 1):
    fact[i] = fact[i - 1] * i % MOD

inv_fact = [1] * (N + 1)
inv_fact[N] = pow(fact[N], MOD - 2, MOD)
for i in range(N, 0, -1):
    inv_fact[i - 1] = inv_fact[i] * i % MOD

def ncr(n, r):
    if r < 0 or r > n:
        return 0
    return fact[n] * inv_fact[r] % MOD * inv_fact[n - r] % MOD

import math
print(ncr(10, 3), math.comb(10, 3))
print(ncr(100000, 50000), math.comb(100000, 50000) % MOD)
```

```text
120 120
149033233 149033233
```

Bina modulus ke chhote n ke liye seedha `math.comb(n, r)` use karo (exact big integers). Kuch chhote values ke liye **Pascal's triangle** `C(n, r) = C(n-1, r-1) + C(n-1, r)` ek achhi DP hai jisme division ki zaroorat hi nahi.

`1/(i-1)! = i / i!` ko ek baar khol ke dekho: `i! = i × (i-1)!`, toh `i / i! = i / (i × (i-1)!) = 1 / (i-1)!`. Bas itna. Isse N inverses ke liye N Fermat calls ki jagah sirf **ek** call lagti hai.

### 19. O(log n) mein fast Fibonacci

Fibonacci step `(F(n+1), F(n)) → (F(n+2), F(n+1))` ek **matrix multiplication** hai:

```text
| F(n+1) |   | 1 1 |^n   | 1 |
| F(n)   | = | 1 0 |   × | 0 |
```

Matrix ko n-th power tak **fast exponentiation** se le jao (section 16, bas numbers ki jagah matrices): O(log n) 2×2 multiplications. Yahi trick *koi bhi* linear recurrence (Tribonacci, tiling counts) n = 10¹⁸ ke liye compute kar deti hai.

```python
MOD = 10**9 + 7

def mat_mult(A, B):
    return [[(A[0][0] * B[0][0] + A[0][1] * B[1][0]) % MOD, (A[0][0] * B[0][1] + A[0][1] * B[1][1]) % MOD],
            [(A[1][0] * B[0][0] + A[1][1] * B[1][0]) % MOD, (A[1][0] * B[0][1] + A[1][1] * B[1][1]) % MOD]]

def fib(n):
    result = [[1, 0], [0, 1]]            # identity matrix
    base = [[1, 1], [1, 0]]
    while n:
        if n & 1:
            result = mat_mult(result, base)
        base = mat_mult(base, base)
        n >>= 1
    return result[0][1]                  # the top-right entry of M^n is F(n)

print([fib(i) for i in range(10)])
print(fib(90), fib(10**18))
```

```text
[0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
210345902 209783453
```

(Yahan `fib(90)` mod 10⁹ + 7 mein reduced hai; exact value 2880067194370816120 hai.) Ek aur slick method hai **fast doubling**, jo `F(2k) = F(k)·(2F(k+1) − F(k))` aur `F(2k+1) = F(k)² + F(k+1)²` use karta hai, wo bhi O(log n).

Matrix kaam kyun karta hai? `[[1,1],[1,0]] × [F(n+1), F(n)]` = `[F(n+1) + F(n), F(n+1)]` = `[F(n+2), F(n+1)]`. Matlab is matrix se ek baar multiply karna = Fibonacci ka ek step aage. n baar = n steps, aur n baar multiply karna wahi `Mⁿ` hai jo fast power O(log n) mein deta hai.

### 20. Integer overflow: Python chhupata hai, interviews nahi

Python integers **kabhi overflow nahi hote**: wo zaroorat ke hisaab se badhte hain (`2 ** 1000` aaram se chalta hai). Java, C++, C#, Go aur Rust fixed 32/64-bit integers use karte hain jo chupchaap **wrap around** ho jaate hain (ya panic karte hain):

```text
Java:  int x = 2147483647;  x + 1  ->  -2147483648
```

Python likhte hue bhi tumhe kyun parwah karni chahiye:

- **Interviewers pooch sakte hain** "agar ye Java hota toh?" Classic example: binary search ka `mid = (lo + hi) / 2` overflow hota hai jab `lo + hi > 2³¹ - 1`. Safe version hai `lo + (hi - lo) / 2`.
- **Jo problems kehte hain "assume a 32-bit environment"** (Reverse Integer, Sum of Two Integers, Divide Two Integers) wo chahte hain ki tum manually **clamp ya mask** karo.
- **Floats sach mein precision khote hain**: 2⁵³ se upar ke saare integers floats mein represent nahi ho sakte. Bade integers pe kabhi `/`, `math.sqrt` ya `**0.5` mat use karo; `//`, `math.isqrt`, aur integer arithmetic use karo.
- **Big ints slow hain**: 10,000-digit numbers pe arithmetic O(1) se kahin zyada mehenga hai. Ye ek aur wajah hai ki chalte-chalte mod p se reduce karo.

```python
INT_MAX, INT_MIN = 2**31 - 1, -2**31

def reverse_integer(x):
    sign = -1 if x < 0 else 1
    r = sign * int(str(abs(x))[::-1])
    return r if INT_MIN <= r <= INT_MAX else 0        # emulate 32-bit overflow -> 0

print(reverse_integer(123), reverse_integer(-120), reverse_integer(1534236469))
print(float(2**53) == float(2**53 + 1))               # floats can't tell these apart
print(int((10**16 + 1) ** 0.5) ** 2 <= 10**16 + 1, __import__("math").isqrt(10**16 + 1))
```

```text
321 -21 0
True
True 100000000
```

Teesri line samjho: `10**16 + 1` ka asli square root lagbhag `100000000.000000005` hai, lekin float itna precise nahi, toh wo `100000000.0` de deta hai. Is case mein `int()` ke baad answer sanyog se sahi nikla, lekin bade numbers pe float rounding answer ko ek se upar ya neeche kar sakti hai. `math.isqrt` hamesha exact hai.

### 21. Reservoir sampling: stream se ek fair pick

Tumhe items **ek-ek karke** dikhte hain, tumhe nahi pata kitne honge (ek stream, ek bahut badi log file, ek linked list), aur tumhe O(1) memory use karke ek item **uniformly at random** chunna hai.

**Algorithm R:** pehla item rakh lo. Jab i-th item aaye (1-indexed), apne pick ko usse **1/i probability** ke saath replace karo.

**Ye uniform kyun hai:** item i aate waqt `1/i` probability se chuna jaata hai, phir use har baad wale arrival j se bachna padta hai (har ek use `1/j` probability se replace karta hai):

```text
P(item i is the final pick) = 1/i × (i/(i+1)) × ((i+1)/(i+2)) × ... × ((n-1)/n) = 1/n
```

Product telescope ho jaata hai (har numerator agle denominator ko cancel kar deta hai). Har item exactly 1/n probability ke saath end tak pahunchta hai. k samples ke liye, pehle k rakho aur ek random slot ko k/i probability se replace karo.

> 🇮🇳 **Desi Analogy:** Ek radio station "lucky caller" contest chala raha hai, lekin unhe nahi pata ki aaj kitne log call karenge, aur unke paas sirf **ek** winner ka naam likhne ki jagah hai. Rule: pehla caller winner. Doosra caller aaya toh sikka uchhalo (1/2), jeeta toh naam badal do. Teesra aaya toh 1/3 chance se badlo. i-th caller aaya toh 1/i chance se. Din ke end mein, chahe 10 log aaye ya 10 lakh, har caller ke jeetne ka chance exactly barabar hai. **Caller = stream item**, **ek naam ki jagah = O(1) memory**, **1/i ka sikka = replace probability**.

```python
import random

def reservoir_pick(stream, rng):
    chosen = None
    for i, item in enumerate(stream, start=1):
        if rng.randrange(i) == 0:          # true with probability 1/i
            chosen = item
    return chosen

def reservoir_k(stream, k, rng):
    sample = []
    for i, item in enumerate(stream, start=1):
        if i <= k:
            sample.append(item)
        else:
            j = rng.randrange(i)            # 0 .. i-1
            if j < k:                       # probability k/i
                sample[j] = item
    return sample

rng = random.Random(42)                     # seeded: same output every run
counts = {x: 0 for x in "ABCDE"}
for _ in range(50_000):
    counts[reservoir_pick("ABCDE", rng)] += 1
print(counts)                               # each close to 10,000
print(reservoir_k(range(100), 5, random.Random(7)))
```

```text
{'A': 9890, 'B': 10002, 'C': 10098, 'D': 10041, 'E': 9969}
[14, 25, 35, 59, 57]
```

Interview problems: **Linked List Random Node**, **Random Pick Index**. (Bahut badi databases se ek pass mein rows sample karne mein bhi use hota hai.)

---

## 🔬 Under the Hood · Andar Ki Kahani

### Bit operations "free" kyun hain

CPU ke arithmetic unit mein AND, OR, XOR, NOT aur shifts ke liye dedicated circuits hain. Har ek saare 64 bits pe **parallel** mein lagbhag ek clock cycle mein chalta hai, addition jitna hi. Multiplication kuch cycles leta hai; division das-bees. Isiliye compilers `x * 8` ko `x << 3` aur `x % 8` ko `x & 7` mein badal dete hain (non-negative x ke liye). **Python** mein har operation ka interpreter overhead (~das nanoseconds) hardware ke farq ko dabaa deta hai, toh `x << 3` vs `x * 8` mein koi measurable farq nahi. Python mein bits ko **intent ki clarity** (masks, flags ke sets) aur algorithmic jeet (O(1) space mein Single Number) ke liye use karo, micro-speed ke liye nahi.

`x % 8 == x & 7` kyun? 8 = `1000`, toh 8 se divide karne ka remainder bas neeche ke 3 bits hain. `7 = 0111` exactly wahi 3 bits rakhta hai. Decimal mein bhi aisa hi hai: kisi number ka 1000 se remainder bas uske aakhri 3 digits hain.

### Python integers kaise store karta hai

CPython ka `int` ek object hai jisme ek sign aur 30-bit "digits" ka array hota hai (base 2³⁰). Chhote numbers ek digit use karte hain; `2**1000` 34 use karta hai. Negatives pe bit operations **aise define** hain jaise number two's complement ho jiske aage infinite 1s hain, isiliye `~x == -x - 1` aur `-1 >> 5 == -1` (hamesha ke liye 1s andar shift hote rehte hain). Isiliye `while n: n >>= 1` jaisa loop negative n ke liye **kabhi khatam nahi hota**: wo -1 pe atak jaata hai. Pehle fixed width pe mask karo.

### `x & -x` exactly kyun kaam karta hai

Likho `x = [prefix] 1 [k zeros]`. Toh `~x = [~prefix] 0 [k ones]`, aur 1 jodne se carry k ones se guzarta hai: `-x = ~x + 1 = [~prefix] 1 [k zeros]`. x ke saath AND: prefix aur uska complement 0 dete hain, akela 1 bachta hai, zeros zeros rehte hain. Result: `1` ke baad k zeros, yaani lowest set bit. [Chapter 24](24-advanced-structures.md) ka Fenwick tree poora isi ek trick pe bana hai.

### Complexity reference

| Operation | Time | Notes |
|---|---|---|
| Machine word pe bit op | O(1) | Python: bahut bade ints ke liye O(30-bit digits ki ginti) |
| Popcount (Kernighan) | O(set bits ki ginti) | `int.bit_count()` sabse fast |
| Saare subsets enumerate karna | O(2ⁿ · n) | |
| Saare masks ke saare submasks | O(3ⁿ) | har element: mask mein nahi / sirf mask mein / dono mein |
| Euclid ka GCD | O(log min(a, b)) | |
| Trial division primality | O(√n) | |
| Sieve of Eratosthenes | O(N log log N) | O(N) memory |
| Fast exponentiation | O(log n) multiplications | |
| nCr ke liye factorials precompute | O(N), phir har query O(1) | |
| Matrix power Fibonacci | O(log n) | har 2×2 product mein 8 multiplications |

---

## 🧩 Pattern Decoder · Pattern Pakdo

### Signals: kab bits ya math hi chaabi hai

| Problem mein dikhe... | Socho |
|---|---|
| "ek ke alawa sab do baar", "odd one out dhundo", "missing number" | XOR cancellation |
| "ek ke alawa sab teen baar" | bits ko mod 3 gino |
| "do numbers ek baar aate hain" | sab XOR karo, lowest differing bit se baanto |
| "power of two", "1 bits ki ginti", "Hamming distance" | `n & (n-1)`, XOR ka popcount |
| "saare subsets", n ≤ 20 | masks `0..2ⁿ-1` pe loop |
| "visited / used items ka set", n ≤ 20 | bitmask state ([Chapter 21](21-dp-2d-advanced.md)) |
| "+ / * / / use kiye bina", "32-bit environment" | mask ke saath bit simulation |
| "answer modulo 10⁹ + 7" | har step pe reduce; division → modular inverse |
| bahut bade n ke saath aⁿ, linear recurrence ka n-th term | fast exponentiation / matrix power |
| "count primes", bahut saari primality queries | sieve |
| "fraction lowest terms mein", "repeating pattern", "measure / tile kar sakte ho" | GCD |
| "n mein se r chuno", bade n ke saath "grid mein paths" | precomputed factorials ke saath nCr |
| "stream / unknown length se random" | reservoir sampling |
| ek pair ka XOR maximise karo | top se bit-by-bit greedy (prefix set ya Trie, [Chapter 19](19-tries.md)) |

### Template: set bits pe iterate karo

```py
x = mask
while x:
    low = x & -x                 # the lowest set bit as a value
    i = low.bit_length() - 1     # its index
    # ... use bit i ...
    x &= x - 1                   # remove it
```

### Template: ek mask ke saare submasks enumerate karo

```py
sub = mask
while True:
    # ... use sub ...
    if sub == 0:
        break
    sub = (sub - 1) & mask       # next smaller submask
```

### Template: XOR cancellation

```py
acc = 0
for x in nums:
    acc ^= x                     # pairs vanish; what's left is the odd one out
```

### Template: modular toolkit

```py
MOD = 10**9 + 7
add = (a + b) % MOD
mul = a * b % MOD
inv = pow(b, MOD - 2, MOD)       # only because MOD is prime and b % MOD != 0
div = a * inv % MOD
pw  = pow(a, n, MOD)
```

### Variation: Hamming Distance (XOR ka popcount)

**Problem:** x aur y ke bits kitni positions pe alag hain.
**Idea:** XOR exactly alag positions ko mark karta hai; unhe gino.

```python
def hamming_distance(x, y):
    diff = x ^ y
    count = 0
    while diff:
        diff &= diff - 1
        count += 1
    return count

print(hamming_distance(1, 4), hamming_distance(3, 1), hamming_distance(0b101010, 0b010101))
```

```text
2 1 6
```

### Variation: Bitwise AND of Numbers Range

**Problem:** `[left, right]` ke har integer ka AND.
**Idea:** jo bit range mein kahin bhi badalta hai wo 0 ban jaata hai. Jo bits kabhi nahi badalte wo exactly left aur right ka **common binary prefix** hain. Dono ko right shift karo jab tak barabar na ho jaayein, phir wapas shift karo.

```python
def range_bitwise_and(left, right):
    shift = 0
    while left != right:
        left >>= 1
        right >>= 1
        shift += 1
    return left << shift

print(range_bitwise_and(5, 7), range_bitwise_and(0, 0), range_bitwise_and(1, 2147483647))
```

```text
4 0 0
```

5 = `101`, 7 = `111`: common prefix `1`, phir do badalne wale bits → `100` = 4.

Kyun koi bhi badalne wala bit 0 ho jaata hai? Agar range mein ek bit kabhi 0 se 1 hua, toh range mein kam se kam ek number aisa hai jisme wo bit 0 hai. AND mein ek bhi 0 poore column ko 0 kar deta hai.

### Variation: Submasks enumerate karna (trace ke saath)

**Problem:** `mask = 0b1011` se represent hue items ka har subset list karo.

```python
def submasks(mask):
    out = []
    sub = mask
    while True:
        out.append(format(sub, "04b"))
        if sub == 0:
            break
        sub = (sub - 1) & mask
    return out

print(submasks(0b1011))
```

```text
['1011', '1010', '1001', '1000', '0011', '0010', '0001', '0000']
```

`(sub - 1) & mask` = "ulti ginti karo, lekin sirf un bits se jo mask ke hain". Saare masks pe ye total O(3ⁿ) hota hai, jo "subsets ke subsets pe DP" ka standard cost hai.

### Variation: Negative exponents ke saath Pow(x, n)

**Problem:** float x aur kisi bhi integer n ke liye `x ** n` implement karo.
**Idea:** fast exponentiation; negative n ke liye `(1/x) ** (-n)` compute karo.

```python
def my_pow(x, n):
    if n < 0:
        x, n = 1 / x, -n
    result = 1.0
    while n:
        if n & 1:
            result *= x
        x *= x
        n >>= 1
    return result

print(my_pow(2.0, 10), my_pow(2.0, -2), my_pow(1.0, -2147483648))
```

```text
1024.0 0.25 1.0
```

### Dry run: n = 44 pe `n & (n-1)` se bits ginna

| step | n (binary) | n - 1 | n & (n - 1) | count |
|---|---|---|---|---|
| 1 | 101100 | 101011 | 101000 | 1 |
| 2 | 101000 | 100111 | 100000 | 2 |
| 3 | 100000 | 011111 | 000000 | 3 |

Teen set bits ke liye teen iterations, chahe zeros kitne bhi ho.

### Bit tricks kab use NAHI karna

- **Constant factor se zyada readability matter karti hai.** Python mein `x % 2 == 0` aur `x & 1 == 0` barabar fast hain; reader ke liye jo saaf ho wo chuno.
- **Subset enumeration ke liye n > ~25.** 2²⁵ ≈ 3.3 crore subsets Python mein pehle hi slow hai. Tumhe DP, greedy, ya meet-in-the-middle chahiye.
- **Bade ya unknown universes ke sets.** Python `set` use karo, koi giant bitmask nahi.
- **Non-prime modulus ke saath modular inverse.** Fermat ko prime chahiye. Extended Euclidean algorithm use karo (ya `pow(b, -1, m)`, jo wahi use karta hai) aur `gcd(b, m) == 1` check karo.
- **Ek bahut bade number ke liye sieve** (jaise 10¹²): array gigantic ho jaayega. √n tak trial division (10⁶ steps) use karo, ya aur bade numbers ke liye Miller-Rabin.

---

## ⚠️ Traps & Common Mistakes · Yahan Sab Phisalte Hain

1. **Ye maan lena ki Python ints 32 bits ke hain.** `~5` -6 hai, 4294967290 nahi. Jab problem unsigned 32-bit values ke baare mein ho toh `& 0xFFFFFFFF` se mask karo.

2. **Negative numbers pe infinite loops.** Python mein `-1 >> 1 == -1`, toh ye kabhi nahi rukta:

```py
while n:              # ❌ n = -8 shifts to -4, -2, -1, -1, -1, ...
    n >>= 1

n &= 0xFFFFFFFF       # ✅ make it a non-negative 32-bit pattern first
while n:
    n >>= 1
```

3. **Precedence ke surprises.** `1 << n - 1` matlab `1 << (n - 1)`. `a + b >> 1` matlab `(a + b) >> 1`. `x & 1 == 0` Python mein chalta hai (comparisons `&` se neeche hain) lekin C/Java mein **nahi**, jahan iska matlab `x & (1 == 0)` hai. Har bitwise cheez pe brackets lagao.

4. **Power of two ke liye `n > 0` ke bina `n & (n - 1) == 0` use karna.** Ye 0 ke liye true hai, jo power of two nahi hai.

5. **Modulus ke andar divide karna.** Jab a reduce ho chuka ho toh `(a // b) % MOD` galat hai. Inverse se multiply karo: `a * pow(b, MOD - 2, MOD) % MOD`.

6. **Multiplication ke baad reduce karna bhoolna.** `% MOD` ke bina `result = result * a` numbers ko hazaaron digits tak badhne deta hai (Python mein slow, baaki jagah overflow).

7. **Doosri languages mein subtraction se negative results.** C++/Java mein `(a - b) % MOD` negative ho sakta hai. Likho `((a - b) % MOD + MOD) % MOD`. (Python mein theek hai.)

8. **Bade integers pe `n ** 0.5`.** Float rounding ek se galat ho sakti hai. `math.isqrt(n)` use karo.

9. **Sieve `2 * p` se shuru karna** (sahi lekin slow) ya p ko n tak loop karna (bekaar kaam). `p * p` se shuru karo aur jab `p * p > n` ho toh ruk jao.

10. **Python mein negatives ke saath Single Number II.** 32 bit-counts se answer banane pe unsigned value milti hai; bit 31 ko wapas negative mein convert karo.

11. **Tests mein bina seed ke `random` call karna.** Har run pe results badalte hain. Reproducibility ke liye `random.Random(seed)` use karo (aur security ke liye kabhi `random` mat use karo; uske liye `secrets` hai).

---

## 💡 Tips & Tricks · Pro Wale Moves

- `x & 1` → odd? `x >> 1` → aadha. `x << k` → 2ᵏ se multiply. `x & (x - 1)` → lowest 1 hatao. `x & -x` → sirf lowest 1 rakho.
- `(1 << n) - 1` wo mask hai jisme neeche ke n bits on hain (n-set ke saare items).
- `mask | (1 << i)`, `mask & ~(1 << i)`, `mask ^ (1 << i)`: item i add / remove / toggle.
- Popcount ke liye `bin(x).count("1")` ya `x.bit_count()`; "highest set bit ki position + 1" ke liye `x.bit_length()`.
- **1..n ka XOR** `n % 4` ke hisaab se ek pattern follow karta hai: n, 1, n + 1, 0 (remainders 0, 1, 2, 3 ke liye).
- **Lowercase/uppercase toggle:** `chr(ord(c) ^ 32)` ek ASCII letter ka case flip kar deta hai (bit 5).
- **Same sign check:** `(a ^ b) >= 0`.
- Python mein `pow(a, b, m)` aur `pow(a, -1, m)` use karo; interviews ke liye dono haath se likhna aana chahiye.
- `math.gcd`, `math.lcm`, `math.comb`, `math.isqrt`, `math.factorial` sab built-in hain. Inhe mention karo, phir poocha jaaye toh implement karo.
- "Answer mod 10⁹ + 7" wale DP problems mein **har** us line pe `% MOD` lagao jo add ya multiply karti hai.

Case toggle ko ek baar dekho: `'a'` = 97 = `110 0001`, `'A'` = 65 = `100 0001`. Farq sirf bit 5 (value 32) ka hai. XOR 32 us bit ko flip kar deta hai. ASCII designers ne ye jaan-boojh ke kiya tha.

---

## 🎯 Interview Questions · Interview Mein Yahi Poochenge

### 1. Single Number 🔥🔥🔥

Ek ke alawa har element do baar aata hai.

<details><summary>Answer dekho 👀</summary>

Sab kuch XOR karo: pairs cancel ho jaate hain (`a ^ a = 0`), aur `0 ^ x = x`. O(n) time, O(1) space, jo hash-set solution ke O(n) space ko hara deta hai.

```python
def single_number(nums):
    result = 0
    for x in nums:
        result ^= x
    return result

print(single_number([2, 2, 1]), single_number([4, 1, 2, 1, 2]))
```

```text
1 4
```

> 🗣️ **Interview mein aise bolo:** "XOR has three useful properties: a number XOR itself is zero, XOR with zero leaves a number unchanged, and order doesn't matter. So if I XOR every element, all the pairs cancel and only the single number remains. That's O(n) time and O(1) extra space, better than a hash set's O(n) space."

</details>

### 2. Single Number II 🔥🔥

Ek ke alawa har element teen baar aata hai.

<details><summary>Answer dekho 👀</summary>

Ya toh bits ko mod 3 gino (section 7), ya elegant do-variable state machine: `ones` un bits ko rakhta hai jo ek baar dikhe (mod 3), `twos` un bits ko jo do baar dikhe. Teesri baar dikhne wala bit dono se clear ho jaata hai.

```python
def single_number(nums):
    ones = twos = 0
    for x in nums:
        ones = (ones ^ x) & ~twos
        twos = (twos ^ x) & ~ones
    return ones

print(single_number([2, 2, 3, 2]), single_number([0, 1, 0, 1, 0, 1, 99]), single_number([-2, -2, -2, -7]))
```

```text
3 99 -7
```

O(n) time, O(1) space. (Ye version Python mein negatives ko apne aap handle karta hai, kyunki ye kabhi 32 bits assume nahi karta.)

Har bit ke liye ye ek chhota counter hai jo 0 → 1 → 2 → 0 chalta hai: state "0" = (ones 0, twos 0), "1" = (ones 1, twos 0), "2" = (ones 0, twos 1). Teesri baar wahi bit aaya toh wapas (0, 0). End mein jo bits "1" state mein hain, wahi akele number ke bits hain, isliye `ones` return karte hain.

</details>

### 3. Number of 1 Bits 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

Kernighan: `n &= n - 1` har iteration mein ek set bit hata deta hai.

```python
def hamming_weight(n):
    count = 0
    while n:
        n &= n - 1
        count += 1
    return count

print(hamming_weight(11), hamming_weight(128), hamming_weight(2147483645))
```

```text
3 1 30
```

O(set bits ki ginti). Built-in ke taur pe `n.bit_count()` mention karo.

> 🗣️ **Interview mein aise bolo:** "I use Brian Kernighan's trick: n AND n minus one clears the lowest set bit, because subtracting one flips that bit and every zero below it. I loop until n becomes zero and count the iterations, so the loop runs once per set bit rather than once per bit. In Python I'd also mention the built-in int.bit_count()."

</details>

### 4. Counting Bits 🔥🔥

<details><summary>Answer dekho 👀</summary>

DP: `ans[i] = ans[i >> 1] + (i & 1)`. Total O(n), har number pe alag loop nahi. Code section 8 mein hai.

```python
def count_bits(n):
    ans = [0] * (n + 1)
    for i in range(1, n + 1):
        ans[i] = ans[i & (i - 1)] + 1     # i with its lowest 1 removed, plus that 1
    return ans

print(count_bits(8))
```

```text
[0, 1, 1, 2, 1, 2, 2, 3, 1]
```

</details>

### 5. Reverse Bits 🔥🔥

<details><summary>Answer dekho 👀</summary>

n ke right se bits nikalo aur result ke right mein daalo, 32 baar (section 9). O(1). Follow-up: baar-baar calls ke liye 256-entry byte lookup table.

```python
def reverse_bits(n):
    result = 0
    for _ in range(32):
        result = (result << 1) | (n & 1)
        n >>= 1
    return result

print(reverse_bits(0b00000010100101000001111010011100), reverse_bits(4294967293))
```

```text
964176192 3221225471
```

</details>

### 6. Missing Number 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

Saare indexes aur values (aur n) ka XOR lo; har present number cancel ho jaata hai. Ya Gauss ka sum. Dono O(n) time, O(1) space. Code section 10 mein hai. Mention karo ki fixed-width languages mein XOR overflow se bachata hai.

```python
def missing_number(nums):
    n = len(nums)
    return n * (n + 1) // 2 - sum(nums)

print(missing_number([3, 0, 1]), missing_number([0]))
```

```text
2 1
```

> 🗣️ **Interview mein aise bolo:** "The numbers are 0 to n with one missing, so I can compare against what should be there. Either I subtract the actual sum from n(n+1)/2, or I XOR all indexes, all values and n, so every present number cancels and the missing one is left. Both are O(n) time and O(1) space, and the XOR version avoids overflow in fixed-width languages like Java."

</details>

### 7. Power of Two 🔥🔥

<details><summary>Answer dekho 👀</summary>

Power of two mein exactly ek set bit hota hai: `n > 0 and n & (n - 1) == 0`. O(1).

```python
def is_power_of_two(n):
    return n > 0 and n & (n - 1) == 0

print(is_power_of_two(1), is_power_of_two(16), is_power_of_two(18), is_power_of_two(0), is_power_of_two(-8))
```

```text
True True False False False
```

Follow-up "Power of Four": saath mein ye bhi chahiye ki bit even position pe ho: `n & 0x55555555 != 0` (mask `0101...01`).

</details>

### 8. Sum of Two Integers 🔥🔥

<details><summary>Answer dekho 👀</summary>

XOR = carries ke bina sum; `(a & b) << 1` = carries; jab tak carry na bache dohrao. Python mein 32 bits pe mask karo aur wapas signed mein convert karo (section 12). Zyada se zyada O(32) iterations.

```python
def get_sum(a, b):
    MASK, MAX = 0xFFFFFFFF, 0x7FFFFFFF
    while b & MASK:
        a, b = a ^ b, (a & b) << 1
    return a & MASK if b > MASK else a if a <= MAX else ~(a ^ MASK)

print(get_sum(1, 2), get_sum(2, 3), get_sum(-1, 1), get_sum(-12, -8))
```

```text
3 5 0 -20
```

Ye compact version Python ko numbers badhane deta hai aur sirf end mein mask karta hai. Agar explanation pechida lage, toh section 12 wala version (har step pe mask) zyada saaf hai; dono theek hain.

</details>

### 9. Subsets 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

0 se 2ⁿ - 1 tak ka har mask ek subset hai; bit i batata hai ki `nums[i]` usme hai ya nahi (section 11). Ya backtracking ([Chapter 09](09-backtracking.md)). Dono O(n × 2ⁿ).

```python
def subsets(nums):
    n = len(nums)
    return [[nums[i] for i in range(n) if mask >> i & 1] for mask in range(1 << n)]

print(subsets([1, 2, 3]))
```

```text
[[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
```

> 🗣️ **Interview mein aise bolo:** "A set of n elements has 2 to the n subsets, and each one corresponds to an n-bit number where bit i says whether nums[i] is included. So I loop mask from 0 to 2^n minus 1 and build the subset from the set bits. That's O(n · 2^n) time, which matches the output size, and it avoids recursion entirely; backtracking is the equivalent recursive approach."

</details>

### 10. Count Primes 🔥🔥

n se strictly kam primes gino.

<details><summary>Answer dekho 👀</summary>

p × p se Sieve of Eratosthenes. Slice assignment se Python mein fast ho jaata hai.

```python
def count_primes(n):
    if n < 3:
        return 0
    is_p = [True] * n
    is_p[0] = is_p[1] = False
    p = 2
    while p * p < n:
        if is_p[p]:
            is_p[p * p::p] = [False] * len(range(p * p, n, p))
        p += 1
    return sum(is_p)

print(count_primes(10), count_primes(0), count_primes(5_000_000))
```

```text
4 0 348513
```

O(n log log n) time, O(n) space.

</details>

### 11. Pow(x, n) 🔥🔥🔥

<details><summary>Answer dekho 👀</summary>

Binary exponentiation, O(log n). Negative n ko x invert karke handle karo. Variety ke liye recursive version:

```python
def my_pow(x, n):
    if n < 0:
        return 1 / my_pow(x, -n)
    if n == 0:
        return 1.0
    half = my_pow(x, n // 2)
    return half * half * (x if n % 2 else 1)

print(my_pow(2.0, 10), my_pow(2.0, -2), round(my_pow(2.1, 3), 5))
```

```text
1024.0 0.25 9.261
```

O(log n) time, O(log n) recursion depth (Pattern Decoder wala iterative version O(1) space hai).

> 🗣️ **Interview mein aise bolo:** "I use binary exponentiation: x to the n equals x to the n/2, squared, times one extra x if n is odd. That halves n at every step, so it's O(log n) multiplications instead of O(n). For negative n I compute the positive power and take the reciprocal, and an iterative version over the bits of n brings the space down to O(1)."

</details>

### 12. Greatest Common Divisor of Strings 🔥

Sabse badi string x jo s aur t dono ko divide kare (s = x repeated, t = x repeated).

<details><summary>Answer dekho 👀</summary>

Agar `s + t != t + s`, toh koi common divisor exist nahi karta. Warna answer `gcd(len(s), len(t))` length ka prefix hai. (Agar dono kisi base ki repetitions hain, toh jodne ka order matter nahi kar sakta, aur sabse lamba common repeat unit lengths ke GCD jitna lamba hota hai.)

```python
from math import gcd

def gcd_of_strings(s, t):
    if s + t != t + s:
        return ""
    return s[:gcd(len(s), len(t))]

print(repr(gcd_of_strings("ABCABC", "ABC")), repr(gcd_of_strings("ABABAB", "ABAB")), repr(gcd_of_strings("LEET", "CODE")))
```

```text
'ABC' 'AB' ''
```

O(m + n).

</details>

### 13. Linked List Random Node 🔥

Unknown length ki singly linked list se ek uniformly random node ki value return karo, O(1) extra space mein.

<details><summary>Answer dekho 👀</summary>

Reservoir sampling: list pe chalo, i-th node se pick ko 1/i probability ke saath replace karo. Proof: section 21 ka telescoping product har node ke liye 1/n deta hai.

```python
import random

class ListNode:
    def __init__(self, val, next=None):
        self.val, self.next = val, next

def get_random(head, rng):
    chosen, i, node = None, 0, head
    while node:
        i += 1
        if rng.randrange(i) == 0:
            chosen = node.val
        node = node.next
    return chosen

head = ListNode(1, ListNode(2, ListNode(3)))
rng = random.Random(0)
picks = [get_random(head, rng) for _ in range(30000)]
print({v: picks.count(v) for v in (1, 2, 3)})
```

```text
{1: 9880, 2: 10125, 3: 9995}
```

Har call O(n), O(1) space.

</details>

---

## 🏋️ Practice · Ab Tumhari Baari

**🟢 1. Hamming Distance.** x aur y ke beech alag bit positions ki ginti.

<details><summary>Solution dekho 👀</summary>

```python
def hamming_distance(x, y):
    return (x ^ y).bit_count()

print(hamming_distance(1, 4), hamming_distance(93, 73))
```

```text
2 2
```

</details>

**🟢 2. Power of Four.**

<details><summary>Solution dekho 👀</summary>

Ek set bit (power of two) even position pe. `0x55555555` mein positions 0, 2, 4, ... pe 1s hain.

```python
def is_power_of_four(n):
    return n > 0 and n & (n - 1) == 0 and n & 0x55555555 != 0

print([n for n in range(1, 300) if is_power_of_four(n)])
```

```text
[1, 4, 16, 64, 256]
```

(Alternative: power of two aur `n % 3 == 1`.)

</details>

**🟢 3. Ek list ka LCM aur simplified fractions.** `[4, 6, 10]` ka LCM print karo aur fraction 84/126 ko simplify karo.

<details><summary>Solution dekho 👀</summary>

```python
from functools import reduce
from math import gcd

def lcm(a, b):
    return a // gcd(a, b) * b

print(reduce(lcm, [4, 6, 10]))
num, den = 84, 126
g = gcd(num, den)
print(f"{num}/{den} = {num // g}/{den // g}")
```

```text
60
84/126 = 2/3
```

</details>

**🟡 4. Gray Code.** n-bit Gray code generate karo: saare 2ⁿ numbers ka ek sequence jisme padosi exactly ek bit mein alag ho, 0 se shuru.

<details><summary>Solution dekho 👀</summary>

i-th Gray code `i ^ (i >> 1)` hai. (Padosi i aur i+1 neeche ke bits ke ek run mein alag hote hain; shifted copy ke saath XOR us run ko ek single badle hue bit mein samet deta hai.)

```python
def gray_code(n):
    return [i ^ (i >> 1) for i in range(1 << n)]

codes = gray_code(3)
print(codes)
print([format(c, "03b") for c in codes])
```

```text
[0, 1, 3, 2, 6, 7, 5, 4]
['000', '001', '011', '010', '110', '111', '101', '100']
```

</details>

**🟡 5. Bahut bade grid ke liye Unique Paths.** `m × n` grid mein right/down paths gino modulo 10⁹ + 7, jahan m, n 10⁵ tak ho.

<details><summary>Solution dekho 👀</summary>

Answer `C(m + n - 2, m - 1)` hai. Chapter 21 ki O(mn) DP ki jagah, factorials aur ek Fermat inverse se O(m + n) mein compute karo.

```python
MOD = 10**9 + 7

def unique_paths_mod(m, n):
    total, r = m + n - 2, m - 1
    num = den = 1
    for i in range(r):
        num = num * (total - i) % MOD
        den = den * (i + 1) % MOD
    return num * pow(den, MOD - 2, MOD) % MOD

print(unique_paths_mod(3, 7), unique_paths_mod(100000, 100000))
```

```text
28 691090292
```

</details>

**🔴 6. Maximum XOR of Two Numbers in an Array.** `[3, 10, 5, 25, 2, 8]` → 28 (5 ^ 25).

<details><summary>Solution dekho 👀</summary>

Answer ko **top se bit by bit** banao. Har bit pe greedily umeed karo ki wo 1 ho sakta hai: `candidate = answer | (1 << bit)`. Ye achievable hai agar do prefixes p, q (ab tak dekhe bits tak kaate gaye numbers) `p ^ q == candidate` satisfy karein, yaani `candidate ^ p` bhi prefix set mein ho (XOR ki inverse property). O(32 × n).

Top bit pe greedy kyun safe hai? Ek bada bit neeche ke saare bits milake bhi zyada keemti hai (`2ᵏ > 2ᵏ⁻¹ + ... + 1`). Toh agar top bit 1 ban sakta hai, toh use 1 banana hamesha behtar hai, neeche chahe jo ho.

```python
def find_maximum_xor(nums):
    answer = 0
    for bit in range(max(nums).bit_length() - 1, -1, -1):
        answer <<= 1
        candidate = answer | 1
        prefixes = {x >> bit for x in nums}
        if any(candidate ^ p in prefixes for p in prefixes):
            answer = candidate
    return answer

print(find_maximum_xor([3, 10, 5, 25, 2, 8]), find_maximum_xor([14, 70, 53, 83, 49, 91, 36, 80, 92, 51, 66, 70]))
```

```text
28 127
```

(Doosra standard solution numbers ko ek binary Trie mein insert karta hai, [Chapter 19](19-tries.md).)

</details>

**🔴 7. Minimum Flips to Make a OR b Equal to c.** a aur b mein sabse kam bits flip karo taaki `a | b == c` ho.

<details><summary>Solution dekho 👀</summary>

Har bit ko alag se dekho. Agar c ka bit 1 hai, toh a, b mein se kam se kam ek 1 hona chahiye (agar dono 0 hain toh 1 flip). Agar c ka bit 0 hai, toh dono 0 hone chahiye (har 1 ko flip karo).

```python
def min_flips(a, b, c):
    flips = 0
    while a or b or c:
        x, y, z = a & 1, b & 1, c & 1
        if z:
            flips += (x | y) == 0
        else:
            flips += x + y
        a, b, c = a >> 1, b >> 1, c >> 1
    return flips

print(min_flips(2, 6, 5), min_flips(4, 2, 7), min_flips(1, 2, 3))
```

```text
3 1 0
```

O(bits ki ginti).

</details>

---

## 🧠 Never-Forget Summary · Kabhi Mat Bhoolna

- Ek number **switches** ki line hai; bit operators sab pe ek saath kaam karte hain.
- **Two's complement:** top bit negative hai; `-x == ~x + 1`. Python ints unbounded hain (infinite sign bits), toh 32-bit problems ke liye **`& 0xFFFFFFFF` se mask karo**.
- Bit i ko **check / set / clear / toggle**: `(x >> i) & 1`, `x | 1<<i`, `x & ~(1<<i)`, `x ^ 1<<i`.
- `n & (n-1)` lowest 1 hatata hai (popcount, power of two). `x & -x` sirf lowest 1 rakhta hai.
- **XOR** pairs cancel karta hai: Single Number, Missing Number. Triples → bits mod 3 gino. Do akele → ek differing bit se baanto.
- Masks `0..2ⁿ-1` saare subsets enumerate karte hain; `(sub-1) & mask` submasks pe chalta hai.
- **GCD:** `gcd(a, b) = gcd(b, a % b)`, O(log). **LCM** = `a // gcd * b`.
- **Primes:** √n tak trial division; N tak ke saare primes ke liye p² se **sieve**.
- **Mod 10⁹+7:** har + aur × ke baad reduce; **divide karna hai toh `pow(b, MOD-2, MOD)` se multiply karo** (Fermat, prime chahiye).
- **Fast power:** bits ke hisaab se square aur multiply, O(log n). Matrix power O(log n) mein Fibonacci deta hai.
- **nCr:** factorials aur inverse factorials ek baar precompute karo.
- **Reservoir sampling:** 1/i probability se replace karo; product telescope hoke 1/n ban jaata hai.

**Memory hook: "AND masks, OR sets, XOR flips and cancels."**

**Second hook for the number theory: "Euclid divides, Eratosthenes crosses, Fermat inverts."**

**🪝 Yaad rakhne ka jugaad:** "**AND chhaanta hai, OR jodta hai, XOR jooton ka joda mila ke hatata hai.**" Aur `n & (n-1)` ke liye: "**ek ghata, ek gaya**" (ek ghataya, sabse neeche wala ek bit gaya). Number theory ke liye teen kirdaar socho: **Euclid patti kaatta hai** (GCD), **Eratosthenes PT sir hai jo multiples ko bitha deta hai** (sieve), aur **Fermat ulta chashma pehnta hai** (inverse = `p-2` ki power).

**Ek picture:**

| Chahiye | Trick | Cost |
|---|---|---|
| Kya bit i on hai? | `(x >> i) & 1` | O(1) |
| Lowest 1 hatao | `x & (x - 1)` | O(1) |
| Sirf lowest 1 | `x & -x` | O(1) |
| Power of two | `x > 0 and x & (x-1) == 0` | O(1) |
| Odd one out | sab XOR | O(n) |
| Saare subsets | `for mask in range(1 << n)` | O(2ⁿ n) |
| GCD | Euclid | O(log) |
| N tak ke saare primes | p² se Sieve | O(N log log N) |
| aⁿ mod m | `pow(a, n, m)` | O(log n) |
| a / b mod p | `a * pow(b, p-2, p)` | O(log p) |
| C(n, r) mod p | fact × inv_fact × inv_fact | O(N) ke baad O(1) |
| Stream se uniform pick | reservoir, 1/i prob se rakho | O(n), O(1) space |

> **Agar sirf ek cheez yaad rakho:** numbers ko switches ki tarah padho (`x & (x-1)` aur XOR obvious lagne lagenge), aur prime modulus ke andar, **division matlab `pow(b, p-2, p)` se multiplication**.

---
**Aage:** [Chapter 24 · Advanced: Segment Trees, Fenwick Trees & String Algorithms](24-advanced-structures.md)  ·  **Wapas** [Contents](../README.md)
