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
### 元素操作
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
