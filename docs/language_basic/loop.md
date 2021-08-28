# 循环结构
## 1. do
do 循环需要一个整数类型的变量用作循环的控制变量，在下面的例子中，使用了变量`i`作为控制变量。
do 循环的语法如下
```fortran
integer :: i
do i = head, tail, step
end do
```
`head` 是循环开始时 `i `的初值
`tail` 是循环结束时 `i` 的条件
`step` 是循环步长, 每次 `i = i + step`
**例1** 输出 1～10所有整数
```fortran
!> program 6-1
program do_demo
    implicit none
    integer :: i
    do i = 1, 10
        write(*, *) i
    end do
end program
```
**例2** 输出 1～10所有奇数
```fortran
!> program 6-2
program do_step_demo
    implicit none
    integer :: i
    do i = 1, 10, 2
        write(*, *) i
    end do
end program
```

## 2. do while
语法如下
```fortran
do while (condition)
    ...
end do
```
该结构会执行内部的代码块直到 condition 不成立。
```fortran
!> program 6-3
program dowhile_demo
    implicit none
    integer :: i
    i = 1
    do while(i < 11)
        print *, i
        i = i + 1
    end do
end program
```

## 3. do concurrent
该循环只有在循环内部没有相互依赖时才可以使用, 也就是第一次运行和第二次运行之间没有相互联系。 `fortran`会将这类循环进行并行运算以提高速度。
```fortran
!> program 6-4
program concurrent_demo
    implicit none
    real, parameter :: pi = 3.14159265
    integer, parameter :: n = 10
    real :: result_sin(n)
    integer :: i

    do concurrent (i = 1:n)  ! Careful, the syntax is slightly different
      result_sin(i) = sin(i * pi/4.)
    end do

    print *, result_sin
end program
```

## 4. exit 和 cycle
`exit` : 退出当前的循环
`cycle`: 跳过当前次，进入下次循环

```fortran
!> program 6-5
program exit_demo
    implicit none
    integer :: i

    do i = 1, 100
      if (i > 10) then
        exit  ! Stop printing numbers
      end if
      print *, i
    end do
    ! Here i = 11
end program exit_test
```
**例** 打印1-10所有奇数
```fortran
!> program: 6-6
program cycle_demo
    implicit none
    integer :: i

    do i = 1, 10
      if (mod(i, 2) == 0) then
          cycle  ! Don't print even numbers
      end if
      print *, i
    end do
end program
```

## 5. tags
`fortran` 允许给循环标记上名字，并且可以在使用 `exit` 和 `cycle` 语句时 退出或跳过指定名字的循环。

**例** 打印加法表
下面的程序中，将外层循环命名为`outer_loop`, 内层循环命名为`innter_loop`
```fortran
!> program: 6-7
program tags_demo
    integer :: i, j

    outer_loop: do i = 1, 10
      inner_loop: do j = 1, 10
        if ((j + i) > 10) then  ! Print only pairs of i and j that add up to 10
          cycle outer_loop  ! Go to the next iteration of the outer loop
        end if
        print *, 'I=', i, ' J=', j, ' Sum=', j + i
      end do inner_loop
end do outer_loop
end program
```
