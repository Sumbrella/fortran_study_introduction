# 数组
在之前的章节中，常量，变量用于保存一个数值。如果需要保存大量的数据，就可以用到数组，数组是一系列相同类型的数据组合而成的特殊数据类型。

## 1. 数组的声明
在创建数组时，可以增加`dimension`修饰词来表明声明数组的长度，也可以在变量名称后增加圆括号，并在圆括号内使用数字来表明数组的长度。下面的两个例子都声明了一个用于储存`integer`变量类型的长度为`10`的数组。

```fortran
integer, dimension(10) :: array
integer :: array(10)
```
总的来说，按照如下的方式声明数组:
```fortran
DataType, dimension(size) :: name
DataType :: array(size)
```

如果需要声明多维数组，使用逗号分隔各个纬度

```fortran
integer, dimension(10, 10) :: array
integer :: array(10, 10)
```
在声明时，也可以使用常量来声明数组的长度，如:
```fortran
integer, parameter :: n = 10
integer :: array(n)
```
如果使用变量，则会报错
```fortran
integer :: n = 10
integer :: array(n)
```
错误如下:
```bash
Error: Explicit shaped array with nonconstant bounds at (1)
```

默认情况下，数组是从下标`1`开始索引的，但是可以在声明时改变开始索引的数字，如
```fortran
intger :: a(-3:3)
```
该数组大小为7，索引从-3到3。

## 2. 数组的赋值
### 2.1 整体赋值
#### 显式赋值
使用`/(`和`/)`或者`[` 和`]`将需要赋予的数据括起来，用`=`号赋给声明时的数组。
```fortran
integer :: array(5) = (/ 1, 2, 3, 4, 5 /)
integer :: array(5) = [1, 2, 3, 4, 5]
```
赋值后数组五个数分别为1, 2, 3, 4, 5.

> 注:括号和斜杠之间不能用空格

#### 隐式赋值
```fortran
integer :: i
integer :: array(5) = (/ (i, i = 1, 5)/)
```
隐式赋值相当于省略了`do`的内容，原本可以用`do`循环写成如下形式
```fortran
integer :: array(5), i
do i = 1, 5
    array(i) = i
end do
```
隐式循环也可以嵌套, 如
```fortran
integer :: i, j
integer :: array(2, 2) = /( ((i + j, i = 1, 2), j = 1, 2) )/
```
注: 整体赋值时，给定值的数量**必须**与数组声明的数量相同，不然会报错,比如
```fortran
integer :: a(5) = (/1, 2, 3/)
```
会报错，因为数组长度为5，而只给了3个初值。
如果需要赋满，可以改成这样
```fortran
integer :: i
integer :: a(5) = (/ 1, (2, i=1, 3), 3 /)
```
## 3. 数组操作
### 3.1 元素操作
数组声明后直接通过括号 + 索引值来获取数组索引值位置的元素。如
```fortran
a(1), a(2), a(5)
```
下面的例程序展示了通过循环读入并且输出一个数组。
```fortran
!> program 8-1
program read_write_array
    implicit none
    integer, parameter :: n = 5
    integer :: i
    integer :: array(n)
    write(*, "('Enter', I4, ' line, each line with an integer')") n
    do i = 1, n
        read(*, *) array(i)
    end do

    do i = 1, n
        write(*, *) array(i)
    end do

end program
```
在高维数组中, 从纬度低
### 3.2 数组操作
#### 1. 整体赋值
将数组所有元素赋值为0.
```fortran
a = 0
```
将数组赋值为 1, 2, 3
```fortran
a = [1, 2, 3]
a = (/ 1, 2, 3 /)
```
另数组中所有元素与另一个数组相同，两个数组必须大小相同
```fortran
a = b
```

#### 2.基本运算
加减乘除, a, b, c必须大小相同
```fortran
a = b + c
a = b - c
a = b * c
a = b / c
```
逻辑运算，a, b, c必须大小相同。对于每一个位置，如果该位置上`b == c`则将该位置赋值为`.true.`否则为`.false.`
```fortran
a = b == c
```
上述代码用循环可以表达为
```fortran
integer, parameter :: n = 10
logical :: a(10)
integer :: b(10), c(10), i

do i = 1, n
    a(i) = b(i) == c(i)
end do
```
#### 3. 切片
```fortran
a(head: tail: step)
```
该方式将会引用数组索引从`head`到`tail`每间隔`step`步长的所有元素提取出来操作。

如将数组索引3-5的元素都赋值为0
```fortran
a(3:5) = 0
```
数组索引3以后的元素赋值为0
```fortran
a(3:) = 0
```
将数组中偶数索引设置为0
```fortran
a(2::2) = 0
```
将数组翻转
```fortran
a(1:n) = a(n:1:-1)
```
假设 `b(5,5)`, `a(5)`, 将a中所有元素赋值为b第二行所有元素
```fortran
a(:) = b(:, 2)
```
#### 4. Where
where 语句是一种特殊的数组操作语句，会根据数组的坐标值按照给定的规则进行操作。
`where` 支持并行运算，比`do`语句执行快。

如: 将a中所有大于3的元素赋给b中相应的位置
```fortran
where(a > 3)
    b = a
end where
```

该操作相当于
```fortran
do i = 1, n
    if (a(i) > 3) b(i) = a(i)
end do
```

或是将a中小于60的数赋值为60
```fortran
where (a < 60)
    a = 60
end where
```
相当于
```fortran
do i = 1, n
    if (a(i) < 60) a(i) = 60
end do
```
`where` 语句中指定的数组可以进行切片，如
```fortran
where(a(1:3) < 60)
    a = 60
end where
```

`where`语句也可以像`if`语句一样出现分支结构
比如将所有大于1的设置为1,小于-1的设置为-1,其他不变。
```fortran
where(a < -1)
    a = -1
else where(a > 1)
    a = 1
else where
    a = a
end where
```

`where`还可以进行嵌套, 也可以取名, 但是取名的`where`在结束时需要加上其名字，如
```fortran
where(a < 5)
    where(a /= 2)
        b = 3
    else where
        b = 1
    end where
end where
```

#### 5. FORALL
`forall` 语句可以看作隐式循环的拓展，除了可以实现隐式循环的赋值效果，也可以使用条件判断，语法模型如下
```fortran
forall (triplet1[, triplet2[, triplet3...]], mask)
```
triplet是用于赋值的数组坐标范围, mask为条件判断值，只有mask成立才会运行forall中的语句。
如:
```fortran
forall(i=2:10:2, j=1:5)
    a(i, j) = i + j
end forall
```
也可以通过mask条件，只处理`i == j`时
```fortran
forall(i=1:5, j=1:5, i == j)
    a(i, j) = i + 1
end forall
```

或是将a中大于10的赋值为0
```fortran
forall(i=1:5, j=1:5, a(i, j) > 10)
    a(i, j) = 0
end forall
```

`forall`也可以进行嵌套或与where语句连用，不再赘述。

总的来说, `forall` 和 `where` 语句可以缩减代码的编写量, 加快程序的运算速度，但是没有`do`语句灵活。

## 4. 数组存储方式
在计算机内存中, `fortran`二维数组是一列一列存储的, 这意味着内存中`a(1:1)`会与`a(2:1)`相邻, 而不与`a(1:2)`相临。

在多维数组中，是逐纬度存储的


## 5. 可变大小数组
在很多情况下，要等到程序执行之后才可以知道需要需要申请多大大小的数组，`fortran`提供了一类可变大小的数组。该类数组用`allocatable`修饰词修饰，并且使用`:`指示数组的纬度。
比如声明一个整数类型的一纬可变数组:
```fortran
integer, allocatable :: array(:)
```
> 如果要申请`n`纬可变数组, 则需要几个纬度就使用几个冒号。如三位数组: `integer, allocatable :: array(:, :)`

可变数组在使用之前必须通过`allocate`函数来声明其内存空间, 如下:
```fortran
allocate(array(10))
```
该函数还可以传入stat参数来检查是否成功申请到内存，如:
```fortran
integer :: err
integer, allocatable :: array(:)

allocate(array, stat=err)
if (err /= 0) print *, "array: Allocation request denied"
```
***
**allocated**
另外, fortran 还提供了 `allocated`函数来检查一个可变数组是否已经申请到内存。
如:
```fortran
if (allocated(array)) then
    print *, "array: Allocated"
else
    print *, "array: Not allocate."
end if
```
***
**deallocate**
fortran 提供了 `dellocate`函数来释放申请的内存空间，基本用法如下。
```fortran
if (allocated(array)) deallocate(array, stat=err)
if (err /= 0) print *, "array: Deallocation request denied"
```
必须是申请内存后的可变数组才可以被`deallocate`释放。

**使用`allocate`申请的内存空间在程序结束前不会被系统自动释放，如果需要`allocate`大量空间, 注意及时使用`deallocate`释放。**

下面的程序示例根据用户输入的学生数申请学生名称数组, 读入并且输出学生姓名。
```fortran
!> program 8-2
program demo_allocate
    implicit none
    !> The maximum size of one student's name
    integer, parameter :: name_max_size = 20

    !> Normal variales
    integer :: student_number, err, i
    character(len=20), allocatable :: student_names(:)

    write(*, "('Please enter the number of students', /, '>>> ', $)")
    read (*, *) student_number

    !> Allocate `student_names` array
    allocate(student_names(student_number), stat=err)
    if (err /= 0) print *, "student_names: Allocation request denied."

    !> Read all student names
    do i = 1, student_number
        write(*, "('Enter the ', I0,'th student''s name', /, '>>> ', $)") i
        read(*, *) student_names(i)
    end do

    !> Output all names
    write(*, *) "Each name of your student:"
    do i = 1, student_number
        write(*, "(I0,' th student''s name is: ', A)") i, student_names(i)
    end do

    !> Dellocate `student_names` array
    if (allocated(student_names)) deallocate(student_names, stat=err)
    if (err /= 0) print *, "student_names: Deallocation request denied."

end program
```

示例输入输出如下:
```
Please enter the number of students
>>> 5
Enter the 1th student's name
>>> A
Enter the 2th student's name
>>> B
Enter the 3th student's name
>>> C
Enter the 4th student's name
>>> D
Enter the 5th student's name
>>> E
 Each name of your student:
1 th student's name is: A
2 th student's name is: B
3 th student's name is: C
4 th student's name is: D
5 th student's name is: E
```
