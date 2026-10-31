# Chapter 23 · Bit Manipulation & Math

> Every number in your computer is a row of tiny light switches, each ON or OFF. Most code treats a number as one thing. Bit manipulation flips individual switches, or all 64 of them at once in a single CPU instruction. It's how you find the one odd item in a million with a single variable, list every subset of a set with a `for` loop, and add two numbers without `+`. Add a handful of number theory (GCD, primes, modular arithmetic) and you'll stop fearing the "return the answer modulo 10⁹ + 7" line forever.

**You will learn:**
- How integers really look in binary, and how **two's complement** stores negative numbers
- Every bit operator (`&`, `|`, `^`, `~`, `<<`, `>>`) and the dozen tricks built from them: check/set/clear/toggle a bit, `n & (n-1)`, lowest set bit, power of two
- **XOR magic**: Single Number I, II, III, Missing Number, and swapping without a temp
- Counting Bits, Reverse Bits, subsets via bitmasks, and adding without `+`
- Math for DSA: **GCD/LCM** (with Euclid's proof), **primes** (trial division, Sieve of Eratosthenes), **modular arithmetic** and 10⁹ + 7, **fast exponentiation**, **modular inverse** (Fermat), **nCr mod p**, fast Fibonacci
- Integer overflow (why Python hides it and other languages don't) and **reservoir sampling**

**Before this:** [Operators & Expressions](../part-1-python/03-operators-expressions.md) · [Variables, Data Types & Memory](../part-1-python/02-variables-types-memory.md) · [Big-O](01-big-o-complexity.md) · [Recursion & Backtracking](09-backtracking.md) (for subsets)

---

## 🧠 The Big Idea

In decimal, each position is worth 10× the one to its right: 1, 10, 100, 1000. In **binary**, each position is worth **2×**: 1, 2, 4, 8, 16, ... and each digit (a **bit**) is 0 or 1.

```text
bit position:   7    6    5    4    3    2    1    0
worth:        128   64   32   16    8    4    2    1
13 in binary:   0    0    0    0    1    1    0    1     -> 8 + 4 + 1 = 13
```

Picture each bit as a light switch. A number is a panel of switches. Bit operators act on **all switches at once**, position by position:

```text
      13 = 0000 1101
       6 = 0000 0110
 13 & 6  = 0000 0100  = 4    (AND: on only where BOTH are on)
 13 | 6  = 0000 1111  = 15   (OR: on where EITHER is on)
 13 ^ 6  = 0000 1011  = 11   (XOR: on where they DIFFER)
```

The CPU does this for 64 positions in one instruction. That's why bit tricks are fast, and why a single integer can act as a compact set of up to 64 yes/no flags (a **bitmask**).

> 💡 **The mental shift:** stop reading `13` as "thirteen" and start reading it as "switches 0, 2 and 3 are on". Every trick in this chapter becomes obvious once you see the switches.

The second half of the chapter is **math for DSA**: a small toolkit of number theory that keeps showing up in interviews. GCD, primes, and especially **modular arithmetic**, because when answers get astronomically large (counting paths, arrangements, subsets), problems ask for them "mod 10⁹ + 7".

---

## 🔨 Building It Up

### 1. Binary in Python

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

What just happened: `x % 2` reads the lowest bit and `x // 2` shifts everything right by one position. Those two operations are exactly `x & 1` and `x >> 1`, as we'll see.

### 2. Two's complement: how negative numbers are stored

Hardware stores integers in a fixed number of bits (8, 32, 64). How do you represent -5? The scheme every modern CPU uses is **two's complement**:

> In n bits, the top bit is worth **-2ⁿ⁻¹** instead of +2ⁿ⁻¹. Everything else is normal.

With 8 bits, the top bit is worth -128:

```text
 5  = 0000 0101  =  4 + 1
-5  = 1111 1011  = -128 + 64 + 32 + 16 + 8 + 2 + 1 = -5
-1  = 1111 1111  = -128 + 127
-128= 1000 0000
127 = 0111 1111
```

**The recipe to negate:** flip every bit, then add 1. `-x == ~x + 1`. Check: 5 = `0000 0101` → flip → `1111 1010` → +1 → `1111 1011` = -5. ✓

Why this design? Because adding works with **no special cases**: 5 + (-5) = `0000 0101 + 1111 1011 = 1 0000 0000`, and the 9th bit falls off the edge, leaving 0. The CPU uses the same adder for signed and unsigned numbers.

**Python is different:** its integers have **unlimited size**, so there's no "top bit". Conceptually, a negative Python int is two's complement with **infinitely many 1s** on the left. To see the 8-bit or 32-bit picture, mask it:

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

| Range of a signed n-bit integer | Min | Max |
|---|---|---|
| 8-bit | -128 | 127 |
| 32-bit (`int` in C/Java) | -2,147,483,648 | 2,147,483,647 |
| 64-bit (`long`) | about -9.2 × 10¹⁸ | about 9.2 × 10¹⁸ |

### 3. The six bit operators

| Operator | Name | Rule per bit | Example (12 = `1100`, 10 = `1010`) |
|---|---|---|---|
| `a & b` | AND | 1 if both are 1 | `1000` = 8 |
| `a \| b` | OR | 1 if either is 1 | `1110` = 14 |
| `a ^ b` | XOR | 1 if they differ | `0110` = 6 |
| `~a` | NOT | flip every bit (in Python: `-a - 1`) | -13 |
| `a << k` | left shift | move bits left k places (× 2ᵏ) | `12 << 2` = 48 |
| `a >> k` | right shift | move bits right k places (floor ÷ 2ᵏ) | `12 >> 2` = 3 |

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

What just happened: `<<` and `>>` are multiplication and floor division by powers of 2. For negatives, `>>` keeps the sign (it's an **arithmetic** shift), so `-12 >> 2 == -3`.

> ⚠️ **Precedence:** in Python, arithmetic (`+ -`) binds tighter than shifts (`<< >>`), which bind tighter than `&`, then `^`, then `|`, then comparisons. So `1 << n - 1` is `1 << (n - 1)`. When in doubt, add parentheses.

### 4. Single-bit tricks: check, set, clear, toggle

These four are the alphabet of bit manipulation. `1 << i` is a **mask** with only bit i on.

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

| Want | Code | Why |
|---|---|---|
| Is bit i on? | `(x >> i) & 1` | slide bit i to position 0, keep only it |
| Turn bit i on | `x \| (1 << i)` | OR with 1 forces 1; OR with 0 keeps |
| Turn bit i off | `x & ~(1 << i)` | AND with 0 forces 0; AND with 1 keeps |
| Flip bit i | `x ^ (1 << i)` | XOR with 1 flips; XOR with 0 keeps |

### 5. The famous tricks: `n & (n-1)`, `x & -x`, power of two

**`n & (n - 1)` clears the lowest set bit.** Subtracting 1 flips the lowest 1 to 0 and all the 0s below it to 1s. ANDing with the original wipes all of those out:

```text
n       = 1011 0100
n - 1   = 1011 0011
n&(n-1) = 1011 0000      <- the lowest 1 is gone
```

**`x & -x` isolates the lowest set bit.** `-x = ~x + 1`: flipping makes the lowest 1 a 0 with 1s below it, and +1 carries back into that position. Every bit above it is flipped relative to x, so ANDing leaves only that one bit.

```text
x       = 0101 1000
-x      = 1010 1000
x & -x  = 0000 1000      <- only the lowest 1 survives
```

**Power of two** = exactly one bit on = `n > 0 and n & (n - 1) == 0`.

**Counting set bits** (the **popcount** or **Hamming weight**): repeatedly clear the lowest set bit and count. This is **Brian Kernighan's algorithm**: it loops once per *set* bit, not once per bit.

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

What just happened: Python 3.10+ has `int.bit_count()` built in (fastest); `bin(n).count("1")` works everywhere. In interviews, know Kernighan's loop: it's what they're testing.

### 6. XOR: the cancelling operator

XOR has four properties that make it magical:

| Property | Meaning |
|---|---|
| `a ^ a = 0` | anything cancels itself |
| `a ^ 0 = a` | 0 is "do nothing" |
| commutative and associative | order doesn't matter: `a ^ b ^ a = b` |
| `a ^ b = c` ⟺ `a ^ c = b` | XOR is its own inverse (undo by doing it again) |

So if you XOR a list where everything appears twice except one item, the pairs cancel and the loner remains. Also, you can swap two variables without a temporary (a party trick; in Python just write `a, b = b, a`):

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

### 7. Single Number I, II and III

**I.** Every element appears twice except one. Find it in O(n) time, O(1) space → XOR everything (above).

**II.** Every element appears **three** times except one. XOR doesn't cancel triples. Instead, **count each bit position**: for every bit, add up how many numbers have it on. Triples contribute a multiple of 3, so `count % 3` is the loner's bit. (In Python, handle negatives by working with 32 bits and converting back.)

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

(There's a famous O(1)-state version with two variables `ones` and `twos` acting as a counter mod 3 per bit; see Interview Question 2.)

**III.** Exactly **two** elements appear once; all others twice. XOR of everything gives `x ^ y` (non-zero, since x ≠ y). Some bit is on in `x ^ y`, meaning x and y **differ** there. Split all numbers into two groups by that bit: x and y land in different groups, and every pair lands together. XOR each group separately.

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

**Trace** for `[1, 2, 1, 3, 2, 5]`: `both = 3 ^ 5 = 011 ^ 101 = 110` (6). Lowest set bit = `010` (2). Numbers with bit 1 on: 2, 3, 2 → XOR = 3. The other loner = 6 ^ 3 = 5.

### 8. Counting Bits: a bit DP

Return an array where `ans[i]` is the number of 1 bits in i, for i = 0..n, in O(n).

`i >> 1` is i with its last bit removed, and it's smaller, so its answer is already known: `ans[i] = ans[i >> 1] + (i & 1)`. A tiny DP ([Chapter 20](20-dp-1d.md)) powered by a shift. (Alternative: `ans[i] = ans[i & (i - 1)] + 1`.)

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

### 9. Reverse Bits

Reverse the 32 bits of an unsigned integer. Take bits off the right of n and push them onto the right of the result (which moves earlier ones left).

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

O(32) = O(1). (Follow-up "called many times?" Cache the reverse of each byte in a 256-entry table and combine 4 lookups.)

### 10. Missing Number

`nums` contains n distinct numbers from `0..n`, so exactly one is missing. Find it in O(1) space.

**XOR way:** XOR all indexes 0..n and all values. Every present number appears twice and cancels; the missing one appears once. **Sum way:** `n(n+1)/2 - sum(nums)` (in Python no overflow; in Java/C++ the XOR way avoids it).

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

### 11. Subsets via bitmasks

A set of n items has 2ⁿ subsets. Number them 0 to 2ⁿ - 1: the binary digits of the number say which items are in (bit i on → item i included). One loop lists every subset, no recursion needed. (Compare with the backtracking version in [Chapter 09](09-backtracking.md).)

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

Time O(n × 2ⁿ). This is also how bitmask DP ([Chapter 21](21-dp-2d-advanced.md)) represents "the set of visited cities".

### 12. Sum of Two Integers without `+`

Add with only bit operations. Think of grade-school addition in binary:

- `a ^ b` adds each column **ignoring carries** (1+1 = 0, carry 1).
- `(a & b) << 1` is the **carry**: a 1 wherever both bits are 1, moved one column left.
- Add those two the same way, until there's no carry.

In Python, negative numbers have infinite leading 1s, so the carry would never fall off. We simulate 32-bit hardware with a mask and convert back to signed at the end.

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

**Trace** for 15 + 27 (`01111 + 11011`):

| step | a | b (carry) |
|---|---|---|
| start | 001111 | 011011 |
| 1 | 010100 | 010110 |
| 2 | 000010 | 101000 |
| 3 | 101010 | 000000 |

Result `101010` = 42. `~(a ^ MASK)` flips the 32 bits back and then applies Python's `~` to get the negative value (equivalent to `a - 2**32`).

### 13. GCD and LCM: Euclid's algorithm (with proof)

The **greatest common divisor** `gcd(a, b)` is the largest number dividing both. **Euclid's algorithm** (about 2300 years old and still the best):

```text
gcd(a, b) = gcd(b, a mod b),   gcd(a, 0) = a
gcd(48, 18) -> gcd(18, 12) -> gcd(12, 6) -> gcd(6, 0) = 6
```

**Why it's correct:** write `a = q·b + r` (r = a mod b). Any d dividing both a and b divides `r = a - q·b`. Any d dividing both b and r divides `a = q·b + r`. So the pairs (a, b) and (b, r) have **exactly the same common divisors**, hence the same greatest one. The numbers shrink every step, and `gcd(a, 0) = a` because everything divides 0.

**Why it's fast:** every two steps, the larger number at least halves (if `b ≤ a/2`, then `r < b ≤ a/2`; otherwise `r = a - b < a/2`). So it takes O(log min(a, b)) steps.

**LCM** (least common multiple): `lcm(a, b) = a // gcd(a, b) * b` (divide first to keep numbers small).

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

> 💡 `gcd(a, b) == 1` means a and b are **coprime**. Fractions are in lowest terms when numerator and denominator are coprime. Gears with coprime tooth counts wear evenly. It shows up everywhere.

### 14. Primes: trial division and the Sieve of Eratosthenes

A **prime** has exactly two divisors: 1 and itself. (1 is not prime.)

**Trial division:** to test n, try dividing by 2, 3, ... up to **√n**. Why stop at √n? If `n = a × b` with both a and b greater than √n, then `a × b > n`. So any factorisation has a factor ≤ √n. Use `math.isqrt` (exact integer square root) rather than `n ** 0.5` (floats lose precision for huge n).

**Sieve of Eratosthenes:** to find **all** primes up to N, write down 2..N; take the first unmarked number p (it's prime), cross out its multiples, repeat.

Two optimisations: start crossing out at **p × p** (smaller multiples like 2p, 3p were already crossed out by smaller primes), and stop when p × p > N.

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

| Method | Use it for | Time |
|---|---|---|
| Trial division | testing one number | O(√n) |
| Sieve | all primes up to N, or many queries ≤ N | O(N log log N) |
| Factorisation by trial division | one number | O(√n) |

`log log N` grows so slowly (it's about 3 for N = 10⁹) that the sieve is practically linear.

### 15. Modular arithmetic and 10⁹ + 7

When a problem says "return the answer **modulo 10⁹ + 7**", it means the true answer is huge (e.g. the number of ways to climb 10⁵ stairs has about 21,000 digits) and they only want the remainder. Why that number?

- **It's prime.** That makes division possible (modular inverses exist, section 17).
- **It fits in a 32-bit signed int** (about 2³⁰), and the sum of two of them fits too.
- **The product of two of them fits in 64 bits** (about 10¹⁸ < 9.2 × 10¹⁸), so C++/Java can multiply then reduce without overflow.

The rules: you may reduce **at every step** of `+`, `-` and `×`, and the final remainder is the same:

```text
(a + b) mod m = ((a mod m) + (b mod m)) mod m
(a - b) mod m = ((a mod m) - (b mod m)) mod m      (Python's % keeps it non-negative)
(a × b) mod m = ((a mod m) × (b mod m)) mod m
(a / b) mod m  ≠  (a mod m) / (b mod m)            <- division does NOT work like this!
```

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

What just happened: keeping numbers small at every step keeps each addition O(1). Without `% MOD`, Python would still work (big ints), but each number would grow to tens of thousands of digits and the loop would crawl. In C++/Java, it would silently overflow.

### 16. Fast exponentiation (binary exponentiation)

Computing `aⁿ` by multiplying n times is O(n). For n = 10¹⁸, impossible. The trick: **square repeatedly** and use the binary digits of n.

```text
3^13, 13 = 1101 in binary = 8 + 4 + 1
3^13 = 3^8 × 3^4 × 3^1
and 3^1 -> 3^2 -> 3^4 -> 3^8 by squaring
```

So walk through n's bits from the lowest: keep a running `base` (a, a², a⁴, a⁸, ...) and multiply it into the result whenever the current bit is 1. That's O(log n) multiplications.

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

**Trace** for `3^13` (n = 1101₂):

| n (binary) | bit | result | a (current power) |
|---|---|---|---|
| 1101 | 1 | 1 × 3 = 3 | 3² = 9 |
| 110 | 0 | 3 | 9² = 81 |
| 11 | 1 | 3 × 81 = 243 | 81² = 6561 |
| 1 | 1 | 243 × 6561 = 1594323 | (done) |

In Python always use the built-in **`pow(a, n, mod)`**: it's this exact algorithm in C. The interview, however, wants you to write it.

### 17. Modular inverse with Fermat's little theorem

You can't divide under a modulus directly, but you can **multiply by an inverse**. The inverse of b mod m is the number `b⁻¹` with `b × b⁻¹ ≡ 1 (mod m)`. It exists when `gcd(b, m) = 1`.

**Fermat's little theorem:** if p is prime and p doesn't divide b, then `b^(p-1) ≡ 1 (mod p)`. Split off one b: `b × b^(p-2) ≡ 1`. So:

> **b⁻¹ ≡ b^(p-2) (mod p)**, computed with fast exponentiation in O(log p).

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

What just happened: 333333336 behaves like "1/3" mod 10⁹+7. That's why 10⁹+7 being **prime** matters: every non-zero number has an inverse.

### 18. nCr mod p with factorials

"How many ways to choose r items from n" = `C(n, r) = n! / (r! × (n - r)!)`. Under a prime modulus, replace the divisions with inverses. For many queries, **precompute** factorials and inverse factorials once in O(N), then each query is O(1).

The inverse factorials trick: compute `inv_fact[N]` with one Fermat call, then go down using `inv_fact[i-1] = inv_fact[i] × i` (since `1/(i-1)! = i / i!`).

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

For small n without a modulus, use `math.comb(n, r)` directly (exact big integers). For a few small values, **Pascal's triangle** `C(n, r) = C(n-1, r-1) + C(n-1, r)` is a nice DP that needs no division at all.

### 19. Fast Fibonacci in O(log n)

The Fibonacci step `(F(n+1), F(n)) → (F(n+2), F(n+1))` is a **matrix multiplication**:

```text
| F(n+1) |   | 1 1 |^n   | 1 |
| F(n)   | = | 1 0 |   × | 0 |
```

Raise the matrix to the n-th power with **fast exponentiation** (section 16, with matrices instead of numbers): O(log n) 2×2 multiplications. The same trick computes *any* linear recurrence (Tribonacci, tiling counts) for n = 10¹⁸.

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

(`fib(90)` here is reduced mod 10⁹ + 7; the exact value is 2880067194370816120.) There's an even slicker method called **fast doubling** using `F(2k) = F(k)·(2F(k+1) − F(k))` and `F(2k+1) = F(k)² + F(k+1)²`, also O(log n).

### 20. Integer overflow: Python hides it, interviews don't

Python integers **never overflow**: they grow as needed (`2 ** 1000` just works). Java, C++, C#, Go and Rust use fixed 32/64-bit integers that **wrap around** silently (or panic):

```text
Java:  int x = 2147483647;  x + 1  ->  -2147483648
```

Why you still care, writing Python:

- **Interviewers may ask** "what if this were Java?" Classic example: binary search's `mid = (lo + hi) / 2` overflows when `lo + hi > 2³¹ - 1`. The safe version is `lo + (hi - lo) / 2`.
- **Problems that say "assume a 32-bit environment"** (Reverse Integer, Sum of Two Integers, Divide Two Integers) expect you to **clamp or mask** manually.
- **Floats do lose precision**: integers above 2⁵³ can't all be represented as floats. Never use `/`, `math.sqrt` or `**0.5` on huge integers; use `//`, `math.isqrt`, and integer arithmetic.
- **Big ints are slower**: arithmetic on 10,000-digit numbers costs much more than O(1). That's another reason to reduce mod p as you go.

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

### 21. Reservoir sampling: a fair pick from a stream

You see items **one at a time**, you don't know how many there will be (a stream, a huge log file, a linked list), and you must pick one **uniformly at random** using O(1) memory.

**Algorithm R:** keep the first item. When the i-th item arrives (1-indexed), replace your pick with it **with probability 1/i**.

**Why it's uniform:** item i is picked when it arrives with probability `1/i`, then must survive every later arrival j (each replaces it with probability `1/j`):

```text
P(item i is the final pick) = 1/i × (i/(i+1)) × ((i+1)/(i+2)) × ... × ((n-1)/n) = 1/n
```

The product telescopes. Every item ends with probability exactly 1/n. For k samples, keep the first k and replace a random slot with probability k/i.

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

Interview problems: **Linked List Random Node**, **Random Pick Index**. (Also used for sampling rows from huge databases in one pass.)

---

## 🔬 Under the Hood

### Why bit operations are "free"

The CPU's arithmetic unit has dedicated circuits for AND, OR, XOR, NOT and shifts. Each runs on all 64 bits **in parallel** in about one clock cycle, the same as an addition. Multiplication takes a few cycles; division takes tens. That's why compilers turn `x * 8` into `x << 3` and `x % 8` into `x & 7` (for non-negative x). In **Python**, the interpreter overhead per operation (~tens of nanoseconds) dwarfs the hardware difference, so `x << 3` vs `x * 8` makes no measurable difference. Use bits in Python for **clarity of intent** (masks, sets of flags) and for algorithmic wins (Single Number in O(1) space), not micro-speed.

### How Python stores integers

A CPython `int` is an object holding a sign and an array of 30-bit "digits" (base 2³⁰). Small numbers use one digit; `2**1000` uses 34. Bit operations on negatives are defined **as if** the number were two's complement with infinitely many leading 1s, which is why `~x == -x - 1` and `-1 >> 5 == -1` (shifting in 1s forever). That's also why a loop like `while n: n >>= 1` **never ends** for negative n: it gets stuck at -1. Mask to a fixed width first.

### Why `x & -x` works, precisely

Write `x = [prefix] 1 [k zeros]`. Then `~x = [~prefix] 0 [k ones]`, and adding 1 carries through the k ones: `-x = ~x + 1 = [~prefix] 1 [k zeros]`. AND with x: the prefix and its complement give 0, the single 1 survives, the zeros stay zeros. Result: `1` followed by k zeros, the lowest set bit. The Fenwick tree in [Chapter 24](24-advanced-structures.md) is built entirely on this one trick.

### Complexity reference

| Operation | Time | Notes |
|---|---|---|
| Bit op on a machine word | O(1) | Python: O(number of 30-bit digits) for huge ints |
| Popcount (Kernighan) | O(number of set bits) | `int.bit_count()` is fastest |
| Enumerate all subsets | O(2ⁿ · n) | |
| Enumerate all submasks of all masks | O(3ⁿ) | each element: not in mask / in mask only / in both |
| Euclid's GCD | O(log min(a, b)) | |
| Trial division primality | O(√n) | |
| Sieve of Eratosthenes | O(N log log N) | O(N) memory |
| Fast exponentiation | O(log n) multiplications | |
| Precompute factorials for nCr | O(N), then O(1) per query | |
| Matrix power Fibonacci | O(log n) | 8 multiplications per 2×2 product |

---

## 🧩 Pattern Decoder

### Signals: when bits or math are the key

| You see in the problem... | Think |
|---|---|
| "appears twice except one", "find the odd one out", "missing number" | XOR cancellation |
| "appears three times except one" | count bits mod 3 |
| "two numbers appear once" | XOR all, split by the lowest differing bit |
| "power of two", "number of 1 bits", "Hamming distance" | `n & (n-1)`, popcount of XOR |
| "all subsets", n ≤ 20 | loop masks `0..2ⁿ-1` |
| "set of visited / used items", n ≤ 20 | bitmask state ([Chapter 21](21-dp-2d-advanced.md)) |
| "without using + / * / /", "32-bit environment" | bit simulation with a mask |
| "answer modulo 10⁹ + 7" | reduce at each step; division → modular inverse |
| aⁿ with huge n, n-th term of a linear recurrence | fast exponentiation / matrix power |
| "count primes", many primality queries | sieve |
| "fraction in lowest terms", "repeating pattern", "can measure / tile" | GCD |
| "choose r of n", "paths in a grid" with huge n | nCr with precomputed factorials |
| "random from a stream / unknown length" | reservoir sampling |
| maximise XOR of a pair | greedy bit-by-bit from the top (prefix set or Trie, [Chapter 19](19-tries.md)) |

### Template: iterate over set bits

```py
x = mask
while x:
    low = x & -x                 # the lowest set bit as a value
    i = low.bit_length() - 1     # its index
    # ... use bit i ...
    x &= x - 1                   # remove it
```

### Template: enumerate all submasks of a mask

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

### Variation: Hamming Distance (popcount of XOR)

**Problem:** the number of positions where the bits of x and y differ.
**Idea:** XOR marks exactly the differing positions; count them.

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

**Problem:** AND of every integer in `[left, right]`.
**Idea:** any bit that changes somewhere in the range becomes 0. Bits that never change are exactly the **common binary prefix** of left and right. Shift both right until they're equal, then shift back.

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

5 = `101`, 7 = `111`: common prefix `1`, then two changing bits → `100` = 4.

### Variation: Enumerating submasks (with trace)

**Problem:** list every subset of the items represented by `mask = 0b1011`.

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

`(sub - 1) & mask` = "count down, but only through bits that belong to mask". Over all masks this totals O(3ⁿ), the standard cost of "DP over subsets of subsets".

### Variation: Pow(x, n) with negative exponents

**Problem:** implement `x ** n` for float x and any integer n.
**Idea:** fast exponentiation; for negative n, compute `(1/x) ** (-n)`.

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

### Dry run: counting bits with `n & (n-1)` on n = 44

| step | n (binary) | n - 1 | n & (n - 1) | count |
|---|---|---|---|---|
| 1 | 101100 | 101011 | 101000 | 1 |
| 2 | 101000 | 100111 | 100000 | 2 |
| 3 | 100000 | 011111 | 000000 | 3 |

Three iterations for three set bits, regardless of how many zeros there are.

### When NOT to use bit tricks

- **Readability matters more than a constant factor.** In Python, `x % 2 == 0` and `x & 1 == 0` are equally fast; choose the clearer one for the reader.
- **n > ~25 for subset enumeration.** 2²⁵ ≈ 33 million subsets is already slow in Python. You need DP, greedy, or meet-in-the-middle.
- **Sets of large or unknown universes.** Use a Python `set`, not a giant bitmask.
- **Modular inverse with a non-prime modulus.** Fermat needs a prime. Use the extended Euclidean algorithm (or `pow(b, -1, m)`, which uses it) and check `gcd(b, m) == 1`.
- **Sieve for a single huge number** (like 10¹²): the array would be gigantic. Use trial division up to √n (10⁶ steps), or Miller-Rabin for even bigger numbers.

---

## ⚠️ Traps & Common Mistakes

1. **Assuming Python ints have 32 bits.** `~5` is -6, not 4294967290. Mask with `& 0xFFFFFFFF` when the problem is about unsigned 32-bit values.

2. **Infinite loops on negative numbers.** `-1 >> 1 == -1` in Python, so this never stops:

```py
while n:              # ❌ n = -8 shifts to -4, -2, -1, -1, -1, ...
    n >>= 1

n &= 0xFFFFFFFF       # ✅ make it a non-negative 32-bit pattern first
while n:
    n >>= 1
```

3. **Precedence surprises.** `1 << n - 1` is `1 << (n - 1)`. `a + b >> 1` is `(a + b) >> 1`. `x & 1 == 0` works in Python (comparisons are lower than `&`) but **not** in C/Java, where it means `x & (1 == 0)`. Parenthesise everything bitwise.

4. **Using `n & (n - 1) == 0` for power of two without `n > 0`.** It's true for 0, which is not a power of two.

5. **Dividing under a modulus.** `(a // b) % MOD` is wrong once a has been reduced. Multiply by the inverse: `a * pow(b, MOD - 2, MOD) % MOD`.

6. **Forgetting to reduce after multiplication.** `result = result * a` without `% MOD` lets numbers grow to thousands of digits (slow in Python, overflow elsewhere).

7. **Negative results from subtraction in other languages.** `(a - b) % MOD` can be negative in C++/Java. Write `((a - b) % MOD + MOD) % MOD`. (Python is fine.)

8. **`n ** 0.5` on big integers.** Float rounding can be off by one. Use `math.isqrt(n)`.

9. **Sieve starting at `2 * p`** (correct but slower) or looping p up to n (wasted work). Start at `p * p` and stop when `p * p > n`.

10. **Single Number II with negatives in Python.** Building the answer from 32 bit-counts gives an unsigned value; convert bit 31 back to a negative.

11. **Calling `random` without a seed in tests.** Results change every run. Use `random.Random(seed)` for reproducibility (and never use `random` for security; that's what `secrets` is for).

---

## 💡 Tips & Tricks

- `x & 1` → odd? `x >> 1` → halve. `x << k` → multiply by 2ᵏ. `x & (x - 1)` → drop lowest 1. `x & -x` → keep lowest 1.
- `(1 << n) - 1` is the mask with the lowest n bits on (all items of an n-set).
- `mask | (1 << i)`, `mask & ~(1 << i)`, `mask ^ (1 << i)`: add / remove / toggle item i.
- `bin(x).count("1")` or `x.bit_count()` for popcount; `x.bit_length()` for "position of highest set bit + 1".
- **XOR of 1..n** has a pattern by `n % 4`: n, 1, n + 1, 0 (for remainders 0, 1, 2, 3).
- **Lowercase/uppercase toggle:** `chr(ord(c) ^ 32)` flips the case of an ASCII letter (bit 5).
- **Check same sign:** `(a ^ b) >= 0`.
- Use `pow(a, b, m)` and `pow(a, -1, m)` in Python; know how to write both by hand for interviews.
- `math.gcd`, `math.lcm`, `math.comb`, `math.isqrt`, `math.factorial` are all built in. Mention them, then implement if asked.
- For "answer mod 10⁹ + 7" DP problems, put `% MOD` on **every** line that adds or multiplies.

---

## 🎯 Interview Questions

### 1. Single Number 🔥🔥🔥

Every element appears twice except one.

<details><summary>Answer</summary>

XOR everything: pairs cancel (`a ^ a = 0`), and `0 ^ x = x`. O(n) time, O(1) space, which beats the hash-set solution's O(n) space.

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

</details>

### 2. Single Number II 🔥🔥

Every element appears three times except one.

<details><summary>Answer</summary>

Either count bits mod 3 (section 7), or the elegant two-variable state machine: `ones` holds bits seen once (mod 3), `twos` holds bits seen twice. A bit seen a third time is cleared from both.

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

O(n) time, O(1) space. (This version handles negatives in Python automatically, because it never assumes 32 bits.)

</details>

### 3. Number of 1 Bits 🔥🔥🔥

<details><summary>Answer</summary>

Kernighan: `n &= n - 1` removes one set bit per iteration.

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

O(number of set bits). Mention `n.bit_count()` as the built-in.

</details>

### 4. Counting Bits 🔥🔥

<details><summary>Answer</summary>

DP: `ans[i] = ans[i >> 1] + (i & 1)`. O(n) total, no per-number loop. Code in section 8.

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

<details><summary>Answer</summary>

Shift bits out of n from the right and into the result from the right, 32 times (section 9). O(1). Follow-up: a 256-entry byte lookup table for repeated calls.

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

<details><summary>Answer</summary>

XOR all indexes and values (and n); every present number cancels. Or Gauss's sum. Both O(n) time, O(1) space. Code in section 10. Mention that XOR avoids overflow in fixed-width languages.

```python
def missing_number(nums):
    n = len(nums)
    return n * (n + 1) // 2 - sum(nums)

print(missing_number([3, 0, 1]), missing_number([0]))
```

```text
2 1
```

</details>

### 7. Power of Two 🔥🔥

<details><summary>Answer</summary>

A power of two has exactly one set bit: `n > 0 and n & (n - 1) == 0`. O(1).

```python
def is_power_of_two(n):
    return n > 0 and n & (n - 1) == 0

print(is_power_of_two(1), is_power_of_two(16), is_power_of_two(18), is_power_of_two(0), is_power_of_two(-8))
```

```text
True True False False False
```

Follow-up "Power of Four": also require the bit to be at an even position: `n & 0x55555555 != 0` (the mask `0101...01`).

</details>

### 8. Sum of Two Integers 🔥🔥

<details><summary>Answer</summary>

XOR = sum without carries; `(a & b) << 1` = carries; repeat until no carry. In Python mask to 32 bits and convert back to signed (section 12). O(32) iterations at most.

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

This compact version lets Python grow the numbers and only masks at the end. If the explanation feels fiddly, the version in section 12 (mask every step) is clearer; either is fine.

</details>

### 9. Subsets 🔥🔥🔥

<details><summary>Answer</summary>

Each mask from 0 to 2ⁿ - 1 is a subset; bit i says whether `nums[i]` is in it (section 11). Or backtracking ([Chapter 09](09-backtracking.md)). Both O(n × 2ⁿ).

```python
def subsets(nums):
    n = len(nums)
    return [[nums[i] for i in range(n) if mask >> i & 1] for mask in range(1 << n)]

print(subsets([1, 2, 3]))
```

```text
[[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
```

</details>

### 10. Count Primes 🔥🔥

Count primes strictly less than n.

<details><summary>Answer</summary>

Sieve of Eratosthenes from p × p. Slice assignment makes it fast in Python.

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

<details><summary>Answer</summary>

Binary exponentiation, O(log n). Handle negative n by inverting x. Recursive version for variety:

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

O(log n) time, O(log n) recursion depth (the iterative version in the Pattern Decoder is O(1) space).

</details>

### 12. Greatest Common Divisor of Strings 🔥

The largest string x that divides both s and t (s = x repeated, t = x repeated).

<details><summary>Answer</summary>

If `s + t != t + s`, no common divisor exists. Otherwise the answer is the prefix of length `gcd(len(s), len(t))`. (If both are repetitions of some base, the concatenation order can't matter, and the longest common repeat unit has length equal to the GCD of the lengths.)

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

Return a uniformly random node's value from a singly linked list of unknown length, in O(1) extra space.

<details><summary>Answer</summary>

Reservoir sampling: walk the list, replace the pick with the i-th node with probability 1/i. Proof: the telescoping product in section 21 gives 1/n for every node.

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

O(n) per call, O(1) space.

</details>

---

## 🏋️ Practice

**🟢 1. Hamming Distance.** Number of differing bit positions between x and y.

<details><summary>Solution</summary>

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

<details><summary>Solution</summary>

One set bit (power of two) at an even position. `0x55555555` has 1s at positions 0, 2, 4, ...

```python
def is_power_of_four(n):
    return n > 0 and n & (n - 1) == 0 and n & 0x55555555 != 0

print([n for n in range(1, 300) if is_power_of_four(n)])
```

```text
[1, 4, 16, 64, 256]
```

(Alternative: power of two and `n % 3 == 1`.)

</details>

**🟢 3. LCM of a list and simplified fractions.** Print the LCM of `[4, 6, 10]` and simplify the fraction 84/126.

<details><summary>Solution</summary>

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

**🟡 4. Gray Code.** Generate an n-bit Gray code: a sequence of all 2ⁿ numbers where neighbours differ in exactly one bit, starting at 0.

<details><summary>Solution</summary>

The i-th Gray code is `i ^ (i >> 1)`. (Neighbouring i and i+1 differ in a run of low bits; the XOR with the shifted copy collapses that run to a single changed bit.)

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

**🟡 5. Unique Paths for a huge grid.** Count right/down paths in an `m × n` grid modulo 10⁹ + 7, with m, n up to 10⁵.

<details><summary>Solution</summary>

The answer is `C(m + n - 2, m - 1)`. Compute with factorials and a Fermat inverse in O(m + n), instead of the O(mn) DP from Chapter 21.

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

<details><summary>Solution</summary>

Build the answer **bit by bit from the top**. At each bit, greedily hope it can be 1: `candidate = answer | (1 << bit)`. It's achievable if two prefixes p, q (numbers truncated to the bits seen so far) satisfy `p ^ q == candidate`, i.e. `candidate ^ p` is also in the prefix set (XOR's inverse property). O(32 × n).

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

(The other standard solution inserts numbers into a binary Trie, [Chapter 19](19-tries.md).)

</details>

**🔴 7. Minimum Flips to Make a OR b Equal to c.** Flip the fewest bits in a and b so that `a | b == c`.

<details><summary>Solution</summary>

Look at each bit independently. If c's bit is 1, you need at least one of a, b to be 1 (1 flip if both are 0). If c's bit is 0, both must be 0 (flip each 1).

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

O(number of bits).

</details>

---

## 🧠 Never-Forget Summary

- A number is a row of **switches**; bit operators act on all of them at once.
- **Two's complement:** top bit is negative; `-x == ~x + 1`. Python ints are unbounded (infinite sign bits), so **mask with `& 0xFFFFFFFF`** for 32-bit problems.
- **Check / set / clear / toggle** bit i: `(x >> i) & 1`, `x | 1<<i`, `x & ~(1<<i)`, `x ^ 1<<i`.
- `n & (n-1)` drops the lowest 1 (popcount, power of two). `x & -x` keeps only the lowest 1.
- **XOR** cancels pairs: Single Number, Missing Number. Triples → count bits mod 3. Two loners → split by a differing bit.
- Masks `0..2ⁿ-1` enumerate all subsets; `(sub-1) & mask` walks submasks.
- **GCD:** `gcd(a, b) = gcd(b, a % b)`, O(log). **LCM** = `a // gcd * b`.
- **Primes:** trial division to √n; **sieve** from p² for all primes ≤ N.
- **Mod 10⁹+7:** reduce after every + and ×; **divide by multiplying with `pow(b, MOD-2, MOD)`** (Fermat, needs a prime).
- **Fast power:** square and multiply by bits, O(log n). Matrix power gives Fibonacci in O(log n).
- **nCr:** precompute factorials and inverse factorials once.
- **Reservoir sampling:** replace with probability 1/i; the product telescopes to 1/n.

**Memory hook: "AND masks, OR sets, XOR flips and cancels."**

**Second hook for the number theory: "Euclid divides, Eratosthenes crosses, Fermat inverts."**

**One picture:**

| Need | Trick | Cost |
|---|---|---|
| Is bit i on? | `(x >> i) & 1` | O(1) |
| Drop lowest 1 | `x & (x - 1)` | O(1) |
| Lowest 1 alone | `x & -x` | O(1) |
| Power of two | `x > 0 and x & (x-1) == 0` | O(1) |
| Odd one out | XOR all | O(n) |
| All subsets | `for mask in range(1 << n)` | O(2ⁿ n) |
| GCD | Euclid | O(log) |
| All primes ≤ N | Sieve from p² | O(N log log N) |
| aⁿ mod m | `pow(a, n, m)` | O(log n) |
| a / b mod p | `a * pow(b, p-2, p)` | O(log p) |
| C(n, r) mod p | fact × inv_fact × inv_fact | O(1) after O(N) |
| Uniform pick from a stream | reservoir, keep with prob 1/i | O(n), O(1) space |

> **If you remember only one thing:** read numbers as switches (`x & (x-1)` and XOR will feel obvious), and under a prime modulus, **division is multiplication by `pow(b, p-2, p)`**.

---
**Next:** [Chapter 24 · Advanced: Segment Trees, Fenwick Trees & String Algorithms](24-advanced-structures.md)  ·  **Back to** [Contents](../README.md)
