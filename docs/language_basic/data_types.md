# 数据类型
数据类型是指在计算机中能够记录文本、数值等的数据单位。算法处理的对象是数据，而数据是以某种特定的形式(如整数、实数、字符等形式)存在的。不同的数据之间往往还存在某些联系，例如由若干个整数组成一个整数数组。

## 1. 变量声明
1. 隐式声明(不再使用)
隐式声明是传统 Fortran 语言预先定义且无须通过类型声明语句对变量类型进行定义，习惯称为`I-N规则`。Fortran 规定，凡以字母`I、J、K、L、M、N`(无论大写还是 小写)6个字母开头的变量名，如无另外说明则为整型变量。以其他字母开头的变量被默认为实型变量，如`I、J、IMAX、NUMBER、LINE、JOB、Kl`等为整型变量，而 `A、Bl、COUNT、AMOUNT、TOTAL、BOOK`等为实型变量。
> 注意:隐式声明具有一定的副作用，在 Fortran 95 之后已不多用，因为隐式说 明与类型说明语句一同使用时，变量类型不清晰，可以通过在程序变量说明之前加 入:`IMPLICIT NONE`语句来取消`I-N规则`.
2. 显式声明
显式声明是在可执行语句前通过类型声明语句对变量类型进行定义。
Fortran 中有6个说明语句:
    - INTEGER语句(整型说明语句)
    - REAL语句(实型说明语句)
    - DOUBLE PRECISION语句(双精度说明语句)
    - COMPLEX语句(复型说明语句)
    - LOGICAL语句(逻辑型说明语句)
    - CHARACTER语句(字符型说明语句)

### 1.1 变量命名的规则
和其他的高级语言一样, 对于使用者申请的变量空间，需要一个标识符来标定变量的名称，以便后续调用, 在 fortran 中 声明变量有如下规则
1. 变量名只能由**字母、下划线和数字组成**，且**第一个字符必须是字母**。比如sum、 student1、student2、student_num等都是合法的标识符。这一点与其他语言中 可以用下划线开头不同。**类似_store这样的变量名在FORTRAN中是不合法的标识符**。
2. 变量命中**不能含有空格字符**，如my school这样是不可以的。
3. 编译系统将大小写字母认为是两个相同的字符，长度限定为31个字符。
>命名变量时尽量贴近变量的使用原意，比如学生成绩用 `student_score` 或 `studentScore`命名，而不是 `a` 或 `ss`。

## 2. Fortran中的数据类型
### 2.1 整型 (Integer)
整型常量也称为整型常数或整数。按照所需存储空间的大小，又分为长整型和短整 型两种。长整型占用4字节(byte)的存储空间，其保存的数据大小为`-2147483648 ~ +2147483647`。短整型则占用2字节的存储空间，保存的数据大小为`-32768 ~ +32767`。
在赋值时也可以手动给定所占用的字节数，如
```fortran
integer(kind=2) :: a
integer*4       :: b (老式)
integer(8)      :: c
```
>其中，符号∷在声明中可有可无。若有，则可赋初值，否则不可赋初值，赋初值则出错。

下面的程序示例展示了不同的整数类型声明及获取最大值
```fortran
!> program 2-1
program integer_test

    implicit none

    integer(kind=2)  :: shortint
    integer(kind=4)  :: longint
    integer(kind=8)  :: verylongint
    integer(kind=16) :: veryverylongint

    integer :: defval

    write(*, *) "short: ", shortval
    write(*, *) "long: ", longint
    write(*, *) "verylong: ", verylongint
    write(*, *) "veryverylongval: ", veryverylongint
    write(*, *) "defval", defval

end program integer_test

```
### 2.2 实型 (REAL)
实型常量也称为实数，也就是日常使用的小数。按照所需存储空间的大小，实数分为单精度和双精度两种。在实数的表达方式上，可以分为小数形式和指数形式两种。
1. 实数的精度
单精度实数在计算机中占用4字节的存储空间，有效位数是6~7位，可记录的最大数 据是±3.4×1038，最小数是±1.18×10-38。双精度实数在计算机中占用8字节的存 储空间，有效位数是15~16位，可记录的最大数据是±1.79×10308，最小数是 ±2.23×10-308。
当一个数值用单精度无法进行存储时，可以使用双精度进行存储。
2. 实数的表达形式
实型常量有两种表达形式:小数形式和指数形式。
小数的表达形式主要分为3种:
    1. `x.y`、`x.`、`.y`。数字前面可以加上“+”号“−”号， 默认为正号。小数点“.”前或后可以不出现数字，但不允许小数点前后都不出现数字，且小数点不可以少。如`+3.5、7.、.3`等都是合法的小数形式。
    2. 用指数形式表示的实数由两部分组成，即数字部分和指数部分。E将数字部分和指数 部分分隔，E的右边是指数部分，E的左边是数字部分，表示方式是用E表示以10为底 的指数。如`5.35E9`表示`5.35×109`，`2.66E-3`表示`2.66×10-3`。

### 2.3 复型 (COMPLEX)
在FORTRAN中，一个复数用一对圆括号括起来的两个实数 表示，其中第一个实数表示复数的实部，第二个实数表示复数的虚部，实部与虚部 之间用逗号分隔。如:`(2.0，4.0)`表示复数`2.0+4.0i`，`(5.3，−7.2)`表示复数 `5.3−7.2i`。

### 2.4 字符型 (CHARACTER)
用一对单引号(撇号)或双引号括起来的若干个非空字符串为字
符型常量，又称为字符或字符串，长度为1的字符串简称为字符， 如:‘x’、‘Y’、‘x+y’、‘@$%’等都是字符型常量。
字符型变量在声明时，由于一串字符是有长度的，计算机需要知道用户需要声明多长的字符串，因此在声明时候需要告知计算机*字符串长度*， 默认为1，如：
```fortran
character char = "a"
character(len=3) string = "abc"

write(*, *) a       !> a
write(*, *) string  !> abc
```
如果赋值时超出字符串给定的长度，编译器会将超出长度的部分截取，如：
```fortran
character(len=2) string = "abc"
write(*, *) string  !> ab
```
也可以使用 `*` 作为长度，来表示默认长度，此时字符变量必须被赋初值，编译器将会字符变量长度赋值为初值字符串的长度，如：
```fortran
character(len=*), parameter :: string = "abc"
write(*, *) string       !> abc
write(*, *) len(string)  !> 3
```
此时，字符串变量只能是常量`(parameter)`或是函数/例程参数。

### 2.5 逻辑型 (LOGICAL)
逻辑类型的值仅仅表示真假, 用 `.true.` 或 `.false.` 来赋值。
```fortran
logical bool_variable = .true.
write(*, *) bool_variable  !> T
```

## 3. 常量
常量是在程序运行过程中不变的量， Fortran 有多种声明常量的办法，可以在变量类型后面增加 `parameter`, 来说明该变量是一个常量
```fortran
real, parameter :: pi = 3.1415926
```
也可以直接使用 parameter 来声明常量
```fortran
parameter(pi = 3.1415926)
```

## 4. 等价声明
等价声明(equivalence)可以使两个变量公用同一个内存空间，方便对其中某一个进行操作，简化代码量。
```fortran
equivalence(a, b)
```


## 5. ios_fortran_env
在不同的机器上申请相同kind值的变量可能实际上获取的内存空间不同，如果申请得到的内存太少，不足以满足原始精度需求，有可能会给程序造成影响。
fortran自带的`ios_fortran_env`库会自动获取当前机器上特定变量类型所需的kind值，如
```fortran
program ios_test
    use ios_fortran_env, only: int8, int16
    integer(kind=int8)  :: a
    integer(kind=1nt16) :: b
end program
```
