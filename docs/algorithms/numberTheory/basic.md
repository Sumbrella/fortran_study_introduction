# 数论
## 1. 整除
### 1.1 定义
若整数$n$除以整数$d$的余数为$0$, 则称$n$能整除$d$, $d$为$n$的约数, 记为 $d|n$.

### 1.2 性质

###### 1.1 $a|b, \ b|c \Rightarrow a|c$
###### 1.2 $a|b \Rightarrow a|bc, c$ 为任意整数
###### 1.3 $a|b, a|c \Rightarrow a|kb + lc, k$ 与 $l$ 为任意整数
###### 1.4 $a|b, b|a \Rightarrow a = \pm b$
###### 1.5 $a = kb \pm c \Rightarrow a, b$ 的公因数与 $b, c$ 的公因数完全相同
###### 1.6 $a|bc$ 且 $a, c$ 互质, 则 $a|b$


## 2. 素数
### 2.1 定义
素数是只有1和它本身两个因数的数。
### 2.2 定理
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
***
## 4. 剩余类群
### 4.1 $Z^*$ 与 $(Z^*_p, )$
$(Z^*_P,), $ 称为 $Z_p$的剩余类群，即$(1, 2, ..., p - 1)$, 与 $p$ 互质的数。

#### 4.2 唯一分解定理(算数基本定理)
任何一个大于 $1$ 的数都可以被分解为有限个质数乘积的形式
$$
n = \prod_{i=1}^{m}p_i^{C^i}
$$
其中 $p_1 < p_2 < \cdots < p_m$为质数, $C_i$为正整数。
> 证明: [欧几里得《几何原本》](http://zh.wikipedia.org/wiki/%E7%AE%97%E8%A1%93%E5%9F%BA%E6%9C%AC%E5%AE%9A%E7%90%86)

**分解一个质数的方法**
- **试除法**
    直接枚举所有因子，然后把当前因子全部除去.
    复杂度$O(\sqrt n)$
    ```fortran
    module division
    contains
        subroutine divide(n, factor_number, factors, count_of_factors)
            implicit none
            integer, intent(in)                :: n
            integer, intent(out)               :: factor_number
            integer, intent(out), dimension(:) :: factors
            integer, intent(out), dimension(:) :: count_of_factors

            integer              :: i
            integer              :: x

            x = n
            factor_number = 0
            i = 2
            do while(i * i <= x)
                if (mod(x, i) == 0) then
                    factor_number = factor_number + 1
                    factors(factor_number) = i
                    do while(mod(x, i) == 0)
                        x = x / i
                        count_of_factors(factor_number) =&
                            count_of_factors(factor_number) + 1
                    end do
                end if
                i = i + 1
            end do
            if (x > 1) then  ! must remind a prime
                factor_number = factor_number + 1
                factors(factor_number) = x
                count_of_factors(factor_number) = 1
            end if
        end subroutine divide

    end module division


    program test
        use division, only: divide
        implicit none
        integer                  :: x, nof, i
        integer, dimension(100)  :: factors, count_of_factors
        read(*, *) x

        call divide(x, nof, factors, count_of_factors)

        write(*, *) "The factor of number", x, ":"

        do i = 1, nof
            write(*, "(I4, A, I4)") factors(i), "^", count_of_factors(i)
        end do

    end program test

    ```
    <img src=/assets/Screen%20Shot%202021-08-13%20at%201.01.23%20PM.png width=60%>



 <!-- - Pollard Rho 算法
> TODO: 增加Pollard Rho 算法 -->

### 4.3 $Z^*$结构中的一些定理
**定理 4.1**
若
$$
n = p_1^{\alpha_1} \times p_2^{\alpha_2} \times \cdots \times p_k^{\alpha_k}\\
m = p_1^{\beta_1} \times p_2^{\beta_2} \times \cdots\times p_k^{\beta_k}
$$
则

$$
n \times m = p_1^{\alpha_1 + \beta_1} \times p_2^{\alpha_2+\beta_2} \times \cdots \times p_k^{\alpha-k + \beta_k}\\
gcd(n, m) = p_1^{min\{\alpha_1, \beta_1\}} \times p_2^{min\{\alpha_2, \beta_2\}} \times \cdots \times p_k^{min\{\alpha_k, \beta_k\}}\\
lcm(n, m) = p_1^{max\{\alpha_1, \beta_1\}} \times p_2^{max\{\alpha_2, \beta_2\}} \times \cdots \times p_k^{max\{\alpha_k, \beta_k\}}
$$

**定理 4.2**
$$
(p - 1)! + 1 \equiv 0 (\mod \ p)
$$

**定理 4.3**
$$
(n + 1) (n + 2) \cdots (n + k) \neq 0 \ \ (\mod \ k)
$$

***
## 5. 最大公因数及最小公倍数
### 5.1 约数
整数$a$除以整数$b$除得的商正好是整数而没有余数，则称b为a的约数。
设有整数$N$可以分解为
$$
N = \prod_{i=1}^m p_i^{C_i}
$$
**定理 5.1**
$N$ 的正约数的个数为
$$
(c_1 + 1) \times (c_2 + 1) \times \cdots \times (c_m + 1) = \prod_{i=1}^{m}(c_i + 1)
$$
**定理 5.2**
$N^M$ 的正约数的个数为
$$
(M \times c_1 + 1) \times(M \times c_2 + 1) \times \cdots \times (M\times c_m + 1) = \prod_{i = 1}^{m}(M \times c_i + 1)
$$

**定理 5.3**
$N$ 的 所有正约数的和为
$$
(1 + p_1 + p_1^2 + \cdots + p_1^{c_1}) \times \cdots \times
(1 + p_m + p_m^2 + \cdots + p_m^{c_2}) = \prod_{i=1}^m{\sum_{j=1}^{c_i}(p_i)^j}
$$

### 5.2 最大公约数
对于两个整数 $a, b$ , 最大公约数是同时整除 $a, b$ 的最大约数，记为 $gcd(a, b)$。
#### 5.2.1 基本定理
**5.1**  $\gcd(a, b) = \gcd(b, a)$  

**5.2**  $\gcd(a, b) = \gcd(a - b, b) \ (a\geq b)$

**5.3**  $\gcd(a, b) = \gcd(a\mod b, b)$

**5.4**  $\gcd(a, b, c) = \gcd(\gcd(a, b), c) $

**5.5**  $\gcd(ka, kb) = k \gcd(a, b)$

**5.6**  $\gcd(k, ab) = 1  \Leftrightarrow \gcd(k, a) = 1\  and \ \gcd(k, b) = 1$

#### 5.2.2 最大公约数求法
- **辗转相除法**
    运用**定理5.3**
    ```fortran
    recursive function gcd(a, b) result(r)
        implicit none
        integer, intent(in) :: a, b
        integer :: r
        if (b == 0) then
            r = a
        else
            r = gcd(b, mod(a, b))
        end if
    end function gcd
    ```
    辗转相除法在大整数下由于需要大量的取模运算，效果不佳。
- **Stein**
    Stein算法主要运用**定理5.5**,如果两个数都是偶数, 把两个数共同除以二并记录2; 如果只有一个数是偶数, 此时2不可能包含在最大公因数里, 则该偶数除以2; 如果两数都是奇数, 返回 `stein(a - b, b) (a > b)`。算法只包含位运算与乘法，在大整数下也有较好的效果。
    ```fortran
    recursive function stein(a, b) result(r)
        implicit none
        integer, intent(in) :: a, b
        integer :: r
        if (a < b) then
            r = stein(b, a)
            return
        end if

        if (b == 0) then
            r = a
            return
        end if

        if (iand(a, 1) == 0 .and. iand(b, 1) == 0) then
            r = lshift(stein(rshift(a, 1), rshift(b, 1)), 1)
        else if (iand(a, 1) == 1 .and. iand(b, 1) == 0) then
            r = stein(a, rshift(b, 1))
        else if (iand(a, 1) == 0 .and. iand(b, 1) == 1) then
            r = stein(rshift(a, 1), b)
        else
            r = stein(a - b, b)
        end if

    end function stein
    ```

**Problem**
$f[0] = 0$, 当 $n > 1$ 时, $f[n] = (f[n - 1] + a) % b$, 给定 $a$ 和 $b$, 是否存在一个自然数 $k (0 <= k < b)$, 满足$\forall n \in N, f[n] \neq k.$

### 5.3 最小公倍数
两个数$a, b$的最小公倍数是指能同时被$a, b$整除的数中最小的数, 记为$lcm(a, b)$。
可以证明
$$
\forall a, b \in N, gcd(a, b) \times lcm(a, b) = a \times b
$$

**Poblem**
三个数$x, y, z$, 他们的$\gcd$ 为 $G$, $lcm$ 为 $L$, $G$ 和 $L$ 已知, 求有多少个三元组$x, y, z$ 满足条件。

## 5.4 GCD 与 LCM
**定理5.7**  $\ \ \gcd (F(n), F(m)) = F(\gcd(n, m))$
**定理5.8**  $\ \ \gcd(a^m - 1, a^n - 1) = a^{\gcd(n, m)} - 1$
**定理5.9**  $\ \ \gcd(a^m - b^m, a^n - b^n) = a^{\gcd(n, m)} - b^{\gcd(m, n)}$
**定理5.10**  $\ \gcd(a, b) = 1 \Rightarrow gcd(a^m, b^m) = 1$
**定理5.11** $\ (a + b) | ab \Rightarrow gcd(a, b) \neq 1$
**定理5.12** 设 $G = gcd(C_n^1, C_n^2, \dots, C_n^{n - 1})$
- 若 $n$ 为素数，则 $G = n$
- 若 $n$ 非素且有一个素因子$p$, $G = p$
- $n$ 有多个素因子， $G = 1$

**定理5.13** $(n + 1)lcm(C_0^0, C_n^1, \cdots, C_n^n) = lcm(1, 2, \cdots, n + 1)$
**定理5.14** $Fibonacc$ 数列中相邻两项 $gcd$ 时, 辗转相减的次数等于辗转相乘的次数。
**定理5.15** $\gcd(fib_n, fib_m) = fib_{gcd(n, m)}$
> [证明](https://blog.csdn.net/alan_cty/article/details/73928751)

## 6. $Fibonacc$数列
**定理6.1** $\sum_{i=1}^n F_i = F_{n + 2} - 1$
**定理6.2** $\sum_{i=1}^n F_{2i - 1} = F_{2n}$
**定理6.3** $\sum_{i=1}^n F_{2i} = F_{2n + 1} - 1$
**定理6.4** $\sum_{i=1}^n F_i^2 = F_nF_{n + 1}$
**定理6.5** $F_{n + m} = F_{n - 1}F_{m - 1} + F_nF_m$
**定理6.6** $F_{2n - 1} =F_n^2 - F_{n - 2}^2$
**定理6.7** $F_{2n-1} = \dfrac{F_{2n-1} + F_{2n+1}}{3}$
**定理6.8** $\dfrac{F_i}{F_{i - 1}} \approx \dfrac{\sqrt{5} - 1}{2}$
**定理6.9** $F_n = \dfrac{({1+\frac{\sqrt{5}}2})^2 + ({1-\frac{\sqrt{5}}2})^2}{\sqrt{5}}$

## 7. 欧拉函数


## 8. 傅立叶变换
