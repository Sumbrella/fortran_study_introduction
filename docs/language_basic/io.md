# 输入输出
## 1. 输入
**read 语句（用法一)**
```fortran
!> program 3-1
program read_test
    implicit none
    integer ::  a
    read (*, *) a
    write(*, *) a
end program
```
上面的程序从键盘读取一个整数，再输出这个整数。
其中 `read(*, *)` 语句为输入语句，其原型为

```fortran
read(unit=*, fmt=*) [...]
```
该语句接受两个参数:
1. `unit` :  需要读取的输入位置, 键盘为5, 如果填入*表示默认，则为5。
2. `fmt`  :  输出的格式，如果填入*表示默认格式。

最后的`[...]`为读取列表，程序会依次将输入按照格式读取进该列表的变量中。

在书写时，可以写成 `read(*, *)` 省略`unit` 及 `fmt`。

**read 语句（用法二)**
```fortran
read *, [...]
```
默认从键盘输入, *为输入格式。用法同上。

## 2. 输出
**write 语句**
write语句的原型为
```fortran
write(unit=*, fmt=*) [...]
```
该语句接受两个参数:
1. `unit` :  需要读取的输入位置, 屏幕为6, 如果填入*表示默认，则为6。
2. `fmt`  :  输出的格式，如果填入*表示默认格式。

最后的`[...]`为读取列表，程序会依次将变量列表中的变量按照格式输出到`unit`中。

**print 语句**
该语句与`write`接近，但是print语句只将变量输出到屏幕中。
原型为
```fortran
print fmt=*, [...]
```
`fmt`  :  输出的格式，如果填入*表示默认格式。
最后的`[...]`为读取列表，程序会依次将变量列表中的变量按照格式输出到屏幕中。

## 3. 格式化
### 3.1 概述
```fortran
!> program: 3-2
program format_test
    implicit none

    integer :: a = 123
    write(*, "(I2)") a  ! 这里既要有括号也要有引号
    write(*, "(I3)") a
    write(*, "(I4)") a
end program
```
输出为
```
**
123
 123
```
在上面的`write` 语句中, 我们改变了 `fmt` 参数，分别为`(I2), (I3), (I4)`。
在这些格式中, `I`表示输出一个整数, `2, 3, 4`分别表示输出的宽度, 其中`(I2)`宽度为2, `fortran`会输出`**`表示警告, `(I4)` 宽度为4, 输出时数字右对其占用3个宽度，剩的宽度用空格填补。

在老式fortran中,格式化可以这样书写:
```fortran
!> program: 3-3
program format_test
    implicit none

    integer :: a = 123
    write(*, 100) a

100 FORMAT(I4)

end program
```
在上述程序中, 100是格式化标识符，后面使用 `FORMAT` 语句来创建一个格式化模版，在使用时，可以直接将`write`中的`fmt`参数更改为此标识符。
这样的写法在程序阅读时可能会造成一定的阅读困难(`format`语句可能与`write`语句相隔较远)，但是如果存在大量重复的相同格式，可以降低代码量。

### 3.2 整形格式化
格式`rIw` 或 `rIw.m`
`r`: 描述符使用次数
`I`: 输出整形变量
`w`: 整形变量的宽度
`m`: 至少输出的位数
注意的点
1. 整数在输出域内为右对齐
2. 字符个数超出域宽，输出时会用*号填充；
> 可以`w=0`， 即`I0` 使输出宽度和整数宽度相同。

**例1**  输出5个整数，宽度为5
```fortram
(I5, I5, I5, I5, I5)
```
或
```
(5I5)
```
**例2**  输出1个整数，长度为其本身长度
```
(I0)
```

### 3.2 实数格式化

1. 格式 `rFw.d`
    `r`: 描述符使用次数
    `F`: 输出实型变量
    `w`: 使出变量的宽度
    `d`: 输出小数点后的位数

    **例1**  输出2个实数，宽度为8, 保留小数点后三位
    ```
    (2F8.3)
    ```
2. 格式 `rEw.d`
    `r`: 描述符使用次数
    `E`: 使用科学计数法(非标准)
    `w`: 使出变量的宽度
    `d`: 输出小数点后的位数
    >域宽需要满足一定的条件：w≥d+7，如精确至2位小数则有±0.ddE±aa，共9位字符；精确至5位小数则有±0.dddddE±aa，共12位字符。

3. 格式 `rESw.d`
    `r`: 描述符使用次数
    `ES`: 使用科学计数法
    `w`: 使出变量的宽度
    `d`: 输出小数点后的位数
    >具体用法与E相同，域宽满足一定条件：w≥d+7，该条件同样不是十分严格，但是均能避免不利情况，因此建议使用该条件；

### 3.3 逻辑格式化
格式 `rLw`
`r`: 描述符使用次数
`L`: 输出逻辑值
`w`: 输出变量的宽度
> 使用 (L0) 会报错

### 3.4 字符输出
格式 `rA` 或 `rAw`
`r`: 描述符使用次数
`L`: 输出字符(字符串)
`w`: 输出变量的宽度


### 3.5 特殊格式化符号
1. `rGw.d`
    `r`: 描述符使用次数
    `G`: 输出控制符
    `w`: 输出变量的宽度
    输出所有类型的数据。
    > 输出浮点数时比较特殊，当宽度不足时会转化成E类型，否则为F类型。

2. `nX`
    表示在当前位置增加`n`个空格，例如:
    一个整数后面三个空格
    ```fortran
    integer a = 123
    write(*, "(I0, 3X)") a  
    ! 123   
    ```
    三个整数用空格分开
    ```fortran
    interger :: a = 123, b = 23, c = 3
    write(*, "(3(I0, 1X))") a, b, c
    ! 123 23 3
    ```
3. `T`
    - `Tc`
        表示将输出位置移动到本行的第`c`个字节。
    - `TLn`
        向左移动`n`个字符
    - 'TRn'
        向右移动`n`个字符

4. `/`
    表示换行
    每行输出一个实数，共3个
    ```fortran
    real :: a = 123, b = 123, c = 123
    write(*, "3(F0.3, /)") a, b, c
    ! 123.000
    ! 123.000
    ! 123.000
    !
    ```
5. `$`
    表示行尾不换行
    ```fortran
    write(*, "A, $") "123"
    write(*, "A, $") "123"
    ! 1231123
    ```
6. SP, SS
    在增加了 `SP` 后， 会输出数字的正负号, `SS`后会关闭该功能
    ```fortran
    write(*, "(SP, I0, I0, SS, I0)") 5, 5, 5
    ! +5 +5 5
    ```
7. BN, BZ (`READ`)
    增加了 `BN` 后, 格式化中的空字节代表0, `BZ`关闭。
    ```fortran
    integer :: a
    read(*, "(BN, I5)") a
    ！ 如果输入1 则会读入 10000
    ```

8. kP(`READ`)
    增加了 `BN` 后, 读入的`F`类型的数据会被乘以$10^{-k}$.

9. B, O, Z
    分别将整数转化成二进制、八进制、十六进制。
10. `:`
    遇到冒号后，如果后面没有更多的数据项时停止输出。
