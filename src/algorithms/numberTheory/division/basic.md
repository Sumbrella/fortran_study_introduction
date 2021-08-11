# Division
## 1. 整除
### Definition
若整数$n$除以整数$d$的余数为$0$, 则称$n$能整除$d$, $d$为$n$的约数, 记为 $d|n$.

### 0x01 Properties

###### 1.1 $a|b, \ b|c \Rightarrow a|c$
###### 1.2 $a|b \Rightarrow a|bc, c$ 为任意整数
###### 1.3 $a|b, a|c \Rightarrow a|kb + lc, k$ 与 $l$ 为任意整数
###### 1.4 $a|b, b|a \Rightarrow a = \pm b$
###### 1.5 $a = kb \pm c \Rightarrow a, b$ 的公因数与 $b, c$ 的公因数完全相同
###### 1.6 $a|bc$ 且 $a, c$ 互质, 则 $a|b$


## 2. 素数
### 2.1 Definition
素数是只有1和它本身两个因数的数。
### 2.2 Theorem
假设 $\pi (x)$ 为 $1$ 到 $x$ 中素数的个数。
其中:
$$
\pi(n) =
    -1 + \sum_{k=1}^{x}
    \left[
        \cos^2
        \left[
            \pi \frac{(n - 1)! + 1} {n}
            \right]
    \right]
$$
上式是由 *黎曼* 给出的精确公式，详细证明见[Rieman Prime Counting](https://mathworld.wolfram.com/RiemannPrimeCountingFunction.html)
求极限易得
$$
\lim_{x\to\infty} \dfrac{\pi(x)}{\frac{x}{\ln x}} = 1
$$
**定理 2.1**
    在自然数集中，小于$n$的质数约有$\dfrac{n}{\ln n}$ 个

**定理 2.2** 伯特兰-切比雪夫定理
- 若整数 $n > 1$, 至少存在一个质数$p$, 符合 $n < p < 2n$
- 若整数 $n > 3$, 则至少存在一个质数$p$, 符合 $n < p < 2n-2$

### 2.3 Judgement
#### 2.3.1 试除法
如果一个数不是质数那么肯定能被一个比自己小的数整除。并且如果 $a|n$, 那么 $\dfrac{a}{n}\  |\  n$, 不妨设 $a \leq \dfrac{n}{a}$, 则 $a \leq{\sqrt{n}}$.

时间复杂度$O(\sqrt{n})$


```fortran
module division

contains

     logical function is_prime(x)
        integer, intent(in) :: x
        integer             :: a
        if (x < 2) is_prime = .false.
        a = 2
        do while (a * a <= n)
            if (mod(n, a) == 0) then
                is_prime = .false.
                return
            end if
            a = a + 1
        end do
        is_prime = .true.
    end function is_prime

end module division

program test
    use division, only: is_prime
    implicit none
    integer :: x
    read(*, *) x
    write(*, *) is_prime(x)
end program test
```

#### 2.3.2 $kn + i$ 法
一个大于1的整数如果不是质数，那么一定有质因子，因此枚举时只需考虑素数因子就可以了。比如取 $k=6$, 则 $6n + 2, 6n + 3, 6n + 4, 6n + 6$ 分别有因子 $2, 3, 2, 6$ 不可能是质数，因此只需要枚举 $6n + 1, 6n + 5$ 即可。
复杂度 $O(n^{\frac{1}{3}})$.
以 $k=6$ 为例
```fortran
module division
contains
    logical function is_prime(x)
        integer, intent(in) :: x
        integer             :: a, i
        integer, parameter  :: adder(*) = (/2, 4/)
        if (x < 2) then
            is_prime = .false.
            return
        end if

        if (x == 2 .or. x == 3 .or. x == 5) then
            is_prime = .true.
            return
        end if

        if (x == 4 .or. x == 6) then
            is_prime = .false.
            return
        end if

        a = 5
        do while (a * a <= n)
            do i = 1, size(adder)
                a = a + adder(i)
                if (mod(n, a) == 0) then
                    is_prime = .false.
                    return
                end if
            end do
        end do
        is_prime = .true.
    end function is_prime
end module division
```
### 3. 素数筛
**引理3.1**
    $$
    O(\sum_{i=1}^n \frac{1}{i}) \approx O(\log n)
    $$
**证:**
    $$
    \begin{align*}
        \sum_{i=1}^{n}\frac{1}{i}
            &= 1 + \frac{1}{2} + \frac{1}{3} + \frac{1}{4} + \frac15 + \frac16 + \frac17 ... + \frac{1}{n}\\
            &= 1 + (\frac{1}{2} + \frac{1}{3}) + (\frac{1}{4} + \frac15 + \frac16 + \frac17) + ... + \frac{1}{n}\\
    \end{align*}
    $$
    显然
    $$
        \sum_{j=i}^{i + k - 1} \frac{1}{i} \leq k \times \frac{1}{i}
    $$
    即
    $$
    \begin{matrix}
    \frac12 + \frac13 &\leq& \frac12 \times 2 &\leq& 1 \\
    \frac14 + \frac15 + \frac16 + \frac17 &\leq& \frac14 \times 4 &\leq&1
    \end{matrix}
    $$
    所以 $1\sim n$ 可以分为 $\log n$ 组，证毕。

#### 3.1 埃式筛
**引理3.2** 如果 $n$ 是合数, 那么 $n$的倍数也是合数。

埃式筛从小到大枚举每一个数, 每次遇到一个数时, 把这个数的合数记为合数, 最终没有被标记的数就是素数。

```fortran
module division
    logical, allocatable :: prime(:)
contains
    !! get all the prime number from 1 to n use eratosthenes.
    subroutine eratosthenes(n)
        implicit none
        integer, intent(in) :: n
        integer             :: i
        integer             :: x
        allocate(prime(1: n + 1))
        prime = 1
        do i = 2, n
            if (.not. prime(i)) cycle
            x = i + i
            do while(x <= n)
                prime(x) = .false.
                x = x + i
            end do
        end do
    end subroutine

    subroutine show_primes(n)
        implicit none
        integer, intent(in) :: n
        integer :: i
        do i = 1, n
            if (prime(i)) write(*, *) i
        end do
    end subroutine show_primes
end module


program test
    use division, only: eratosthenes, show_primes
    implicit none
    integer :: n
    read(*, *) n
    call eratosthenes(n)
    write(*, *) "All prime numbers from 1 to", n
    call show_primes(n)
end program test
```
复杂度 $O(n\log \log n)$
>**证**
由于 $\pi(n) = O(\dfrac{n}{\log n})$, 可以认为第 $n$ 个素数的大小为 $\dfrac{n}{\log n}$
全部花费的时间为 $O\left(n\sum\limits^{\pi(n)}_{k=1} \dfrac{1}{p_k}\right)$
而
$$
\begin{align*}
    \sum_{k=1}^{\pi(n)} \frac{1}{p_k}
    &= O\left(\sum\limits_{k=2}^{\pi(n)} \frac{1}{k\log k}\right)\\
    &= O\left(\int_2^{\pi(n)}\frac{1}{x\log x}dx\right)\\
    &= O(\log\log n)
\end{align*}
$$
证毕。

### 3.2 欧拉筛(线性筛)
容易证明, 在埃式筛中, 可以保证没个数一定只会被它最小的质因素筛去。
用一个 `primes` 数组储存所有已经得到的质数。
每次枚举 `primes` 数组中每一个质数, 当第一次枚举到一个质数 `primes[j]` 满足
`primes[j]|i`时, `primes[j]`一定是 $i$ 的最小质因子, `primes[j]` 也一定是 $i\times primes[j + 1]$ 的最小质因子, 而接下来的 $i\times primes[j + 1]$的最小质因子应该是 `primes[j]`而不是 `primes[j + 1]`, 直接break.
这样可以保证每一个合数都只被自己的最小值因子筛一遍, 时间复杂度$O(n)$。
```fortran
module division
    integer :: prime_number
    integer, allocatable :: primes(:)
    logical, allocatable :: is_prime(:)
contains
    subroutine euler(n)
        implicit none
        integer, intent(in) :: n
        integer             :: i, j

        allocate(is_prime(1: n))
        allocate(primes(1: n))
        is_prime = .true.
        prime_number = 0

        do i = 2, n
            if (is_prime(i)) then
                prime_number = prime_number + 1
                primes(prime_number) = i
            end if
            j = 1
            do while (j <= prime_number .and. i * primes(j) <= n)
                is_prime(i * primes(j)) = .false.
                if (mod(i, primes(j)) == 0) exit
                j = j + 1
            end do
        end do
    end subroutine euler

    subroutine show_primes(n)
        implicit none
        integer, intent(in) :: n
        integer             :: i
        if (.not. allocated(primes)) return
        do i = 1, prime_number
            write(*, *) primes(i)
        end do
    end subroutine show_primes

end module division


program test
    use division, only: euler, show_primes
    implicit none
    integer :: n
    read(*, *) n
    call euler(n)
    write(*, *) "All prime numbers from 1 to", n
    call show_primes(n)
end program test
```
