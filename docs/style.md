# 代码风格
良好的代码编写风格主要依靠合适的空行、有层次的缩进和适当的语句内空格, 编写良好的代码风格**非常有助于**代码阅读、代码差错等。

## 1. 语句内空格
这一部分对代码阅读会有一定的影响, 尽量遵循。
### 1.1 运算符
双目运算符的前后都应有空格分隔, 否则在较长的等式将会难以阅读。

`GOOD!`
```fortran
a = 1
```
`BAD!`
```fortran
a=1
```
***
`GOOD!`
```fortran
a = (a + 1) * (3 - a) / (a - 1)
```
`BAD!`
```fortran
a=(a+1)*(3-a)/(a-1)
```
***
`GOOD!`
```fortran
if ( a + 1 == 2 .or. (b - 2 == 3 .and. c * 2 /= 4))
```
`BAD!`
```fortran
if (a+1==2 .or. (b-2==3 .and. c*2/=4))
```

### 1.2 逗号
逗号的后面空一格, 强调分隔。
`GOOD!`
```fortran
do i = 1, n
```
`BAD!`
```fortran
do i = 1,n
```
***
`GOOD!`
```fortran
function show5(a, b, c, d, e)
```
`BAD!`
```fortran
function show5(a,b,c,d,e)
```
***
`GOOD!`
```fortran
write(*, "(I0, X, A)") 5, "is a number."
```
`BAD!`
```fortran
write(*, "(I0,X,A)") 5,"is a number."
```

## 2. 缩进
这一部分对代码阅读及改错有**至关重要**的影响, 请**一定**要遵守。

总的而言
> **同一个层级的代码在同一个缩进层次内**。

如果不遵循上诉编写风格, 代码将会难以阅读, 尤其是在循环、选择语句嵌套时, 找不到自己是在哪一个循环体或是选择结构内。

### 2.1 代码块

内部包含的代码块应该比该代码的定义语句多缩进一个层级, 如:
```
program, function, subroutine, model, interface
```
等。

`GOOD!`
```fortran
program main
    write(*, *) "Hello World"
end program
```

`BAD!`
```fortran
program main
write(*, *) "Hello World"
end program
```

***
`GOOD!`
```fortran
module string
    integer, parameter :: MAX_STRING_LEN = 100

    type :: string_type
        ...
    end type

end program
```

`BAD!`
```fortran
module string
integer, parameter :: MAX_STRING_LEN = 100
type :: string_type
...
end type
end program
```
***

所有的分支、循环语句都需要遵守这个规则, 如:
```
if, do, do while
```
等。
其中的 `end if, end do, else`等语句与其开始的语句在同一个缩进层次,
其中的代码块多缩进一格。
这样的话, 从`end`忘上看, 找到第一个同一缩进层级的`do, do while, if`, 这两行之间的代码都在该选择语句或是循环语句内部。

`GOOD!`
```fortran
do i = 1, n
    if (mod(i, 2) == 0) then
        write(*, *) i, " mod 2 is 0."
    else
        write(*, *) i, " mod 2 is not 0."
    end if
end do
```

`BAD!`
```fortran
do i = 1, n
if (mod(i, 2) == 0) then
write(*, *) i, " mod 2 is 0."
else
write(*, *) i, " mod 2 is not 0."
end if
end do
```

### 2.2 参数列表
参数列表中, 修饰词的其实位置各行位置保持一致, `::`位置保持一致。

`GOOD!`
```fortran
function demo(a, b, one_student, sex)
    integer,         intent(in)  :: a
    real                         :: b
    character(len=2)             :: sex
    type(student),   intent(out) :: one_student
    ...
end function
```

`BAD!`
```fortran
function demo(a, b, one_student, sex)
    integer,intent(in)  :: a
    real :: b
    character(len=2) :: sex
    type(student), intent(out) :: one_student
    ...
end function
```

## 3. 合适的空行
空行遵循以下原则
1. 变量的定义语句和主体程序语句之间
2. 一个大的循环体的上下行
3. 不同的`funciton, subroutine, program`之间(一行即可, 两行更佳)
4. 程序上下部分逻辑有明显变化时

对于 1, 2
`GOOD!`
```fortran
program main
    integer :: i
    integer :: j
    integer :: array(2, 5)

    i = 10
    j = 5
    write(*, *) i + j

    do i = 1, 2
        do j = 1, 5
            array(i, j) = i + j
        end do
    end do

end program
```

`BAD!`
```fortran
program main
    integer :: i
    integer :: j
    integer :: array(2, 5)
    i = 10
    j = 5
    write(*, *) i + j
    do i = 1, 2
        do j = 1, 5
            array(i, j) = i + j
        end do
    end do
end program
```
***
对于 3
`GOOD!`
```fortran
subroutine sub1()
    ...
end subroutine


subroutine sub2()
    ...
end subroutine


function fun1()
    ...
end function
```

`BAD!`
```fortran
subroutine sub1()
    ...
end subroutine
subroutine sub2()
    ...
end subroutine
function fun1()
    ...
end function
```

最后, 代码风格不好的整体看起来像这样

```fortran
!> program 8-2
program demo_allocate
implicit none
!> The maximum size of one student's name
  integer, parameter :: name_max_size=20

!> Normal variales
integer :: student_number,err,i
character(len=20),allocatable :: student_names(:)

    write(*, "('Please enter the number of students', /,'>>> ',$)")
    read (*, *) student_number
    allocate(student_names(student_number),stat=err)
    if (err/=0) print *,"student_names: Allocation request denied."
do i = 1,student_number
write(*, "('Enter the ', I0,'th student''s name', /, '>>>', $)") i
read(*, *) student_names(i)
    end do
    write(*, *) "Each name of your student:"
    do i = 1, student_number
        write(*, "(I0,' th student''s name is: ', A)") i, student_names(i)
    end do
    if (allocated(student_names)) deallocate(student_names, stat=err)
    if (err /= 0) print *, "student_names: Deallocation request denied."
end program
```

正常写应该是这样
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
