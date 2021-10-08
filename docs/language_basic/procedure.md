# 过程
在写程序时常常会有一些代码块需要经常使用, 我们可以将其封装起来，封装好后的代码块可以统一调用，减少代码的书写量，提高程序的可读性、拓展性等。
## 1. 子例程 (subroutine)
### 1.1 语法
封装一个子例程按如下语法封装
```fortran
subroutine subroutine_name([argument1[, argument2, ..., argumentn]])
    argument_type1 :: argument1
    argument_type2 :: argument2
    ...
    argument_typen :: argumentn

    !> do something
    return
end subroutine
```

`argument1, ..., argumentn`为子例程的参数。
在子例程代码开始前，需要指定每一个参数的类型，以便编译器为函数申请内存空间。

子例程, 使用时， 需要使用`call`语句
```fortran
call subroutine_name([argument1[, argument2, ..., argumentn]]
```
子例程可以在源文件的任意位置定义, 但是不可以在`program`及`subroutine`, `function`内定义。
> 在单文件内编写子历程及函数时, 尽量将 program 代码放置到整个文件的最前面, subroutine 及 function 在 program 后面。这是为了方便用户阅读代码的主体逻辑。

子例程遇到 `return` 语句后会立刻退出, 但一个子例程并不一定需要编写 `return` 语句, 当子例程内的所有代码被运行完后，会自动退出。

下面的程序将输出`Hello World!`封装成子例程并且调用:
```fortran
!> program 9-1
program sayHello
    implicit none
    integer :: i

    do i = 1, 5
        call say()
    end do

end program

subroutine say()
    write(*, *) "Hello World!"
    return
end subroutine
```

### 1.2 带参数的子例程
一个代码块如果单纯只能运行一串特定的语句，很难被我们灵活的使用，比如说如果要输出一个给定的整数, 我们并不需要为每一个整数都编写子例程, 而是可以为子例程传参, 让子例程根据传入的参数运行。
```fortran
!> program 9-2
program subroutine_demo
    implicit none
    integer :: i
    write(*, *) "Enter an integer>>>"
    read(*, *) i

    call show_integer(i)
end program

subroutine show_integer(i)
    integer :: i
    write(*, *) "The number is", i
end subroutine show_integer
```
或是让两个整数的数值交换
```fortran
!>program 9-3
program swap_demo
    implicit none
    integer :: a, b

    a = 3
    b = 2

    write(*, *) "a = ", a, "b = ", b
    call swap(a, b)
    write(*, *) "a = ", a, "b = ", b

end program swap_demo


subroutine swap(a, b)
    implicit none
    integer :: a, b
    integer :: t
    t = a
    a = b
    b = t
end subroutine swap
```


## 2. 函数 (function)
函数与子例程一样, 也是一种封装代码的方式, 但是与子例程不同的是, 函数有**返回值**。即函数内的代码块运行结束后, 可以返回一个值作为该函数的`值`。


### 2.1 函数的定义

```fortran
function function_name([argument1[, argument2[, ...], argumentn])
    argument_type1 :: argument1
    argument_type2 :: argument2
    ...
    argument_typen :: argumentn
    return_type    :: function_name

    !> do something

end function
```
函数在定义时也需要像子例程一样给定每一个传入参数的数据类型。
特别的，函数还需要给出返回值的数据类型, 且**返回值的变量名称与函数的名称一致**。

下面的程序定义一个函数将两个整数相加:
```fortran
!> program 9-4
function add(a, b)
    !> Add two integer and return the result.
    integer :: a, b
    integer :: add    !> give the return type of this function.

    add = a + b
end function


program add_demo
    implicit none
    integer :: a, b
    write(*, *) "Input two integer splited by space>>>"
    read(*, *) a, b
    write(*, *) add(a, b)
end program add_demo
```

函数在使用时需要注意以下问题:
**1. 函数定义在主程序之后(不在模块内)**
如:
```fortran
program add_demo
    implicit none
    integer :: a, b
    write(*, *) "Input two integer splited by space>>>"
    read(*, *) a, b
    write(*, *) add(a, b)

end program add_demo

function add(a, b)
    integer :: a, b
    integer :: add    !> give the return type of this function.

    add = a + b
end function
```
执行该代码, 程序会报错
```
6 |     write(*, *) add(a, b)
  |               1
Error: Function 'add' at (1) has no IMPLICIT type
```
由于函数代码行在主程序之后, 程序在被编译时, 主程序还不知道函数`add`的返回值是什么类型，因此无法合理分配内存。
因此需要在主程序内对使用到的函数进行**声明**, 并用`external`修饰词表明该函数定义在主程序后。
因此, 只需要在程序第三、四行之间加上语句
`integer, external :: add`
程序即可运行。

**2. 函数定义时可以在定义时直接表明返回值类型**
如:
```fortran
integer function add(a, b)
    integer :: a, b
    add = a + b

end function
```


## 3. 参数 (argument)

### 3.1 作用域
在上面的程序`9-4`中, 可以看到有`program`和函数`add`内都有整数变量`a`和`b`, 为了防止`subroutine, function`在编写时用到的变量与`program`中的变量产生冲突, 每一个变量都有其**作用域**, 即变量名可以被使用的范围。
即:
1. 在 `program, function, subroutine` 中定义的变量名只能在其内部使用。

2. 不传递参数的情况下, 不同 `program, function, subroutine`中定义的变量之间互不影响, 可以使用相同的变量名。

对于第一点
如:
```fortran
program main
    implicit none
    integer :: a = 5 ! declated at main program

end program


subroutine example
    implicit none

    write(*, *) a  ! used at example subroutine
end subroutine
```

该程序会报错
```
11 |     write(*, *) a  ! used at example subroutine
   |                 1
Error: Symbol 'a' at (1) has no IMPLICIT type
```
这是因为在`progarm`中定义的变量作用域只在`program`中。

对于第二点
如
```fortran
program main
    implicit none
    integer :: a = 5
    write(*, *) "Porgram Main: before call subroutine, the value of a is:", a
    call example()
    write(*, *) "Porgram Main: after call subroutine, the value of a is:", a
end program

subroutine example
    implicit none
    integer :: a = 5
    a = a * 5 + 10
    write(*, *) "Subroutine Example: the value of a is:", a
end subroutine
```
### 3.2 形参与实参


### 3.3 参数修饰词
#### 3.3.1 INTENT(IN)

#### 3.3.2 INTENT(OUT)

### 3.4 特殊参数

## 4. 特殊函数递归
