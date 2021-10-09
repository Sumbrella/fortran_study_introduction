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
如：
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

**生命周期**
一个变量被声明后, 当其所在的`subroutine, function, program`结束时, 其所占有的内存空间会被删除。
如:
```fortran
program count_demo
    implicit none

    integer :: i
    integer, parameter :: n = 5

    do i = 1, n
        call count_one()
    end do
end program

!! count and show how many times the subroutine be used.
subroutine count_one()
    implicit none
    integer :: count = 0
    count = count + 1
    write(*, *) "Count is : ", count
    return
end subroutine
```
会输出
```
Count is :            1
Count is :            1
Count is :            1
Count is :            1
Count is :            1
```
**SAVE**
为了让 `count` 保持不变, 可以用 **SAVE** 来延长变量的声明周期, 被save后的变量不会被销毁。
```fortran
program count_demo
    implicit none

    integer :: i
    integer, parameter :: n = 5

    do i = 1, n
        call count_one()
    end do
end program

!! count and show how many times the subroutine be used.
subroutine count_one()
    implicit none
    integer, save :: count = 0  !> give the feature of save
    count = count + 1
    write(*, *) "Count is : ", count
    return
end subroutine
```
输出
```
Count is :            1
Count is :            2
Count is :            3
Count is :            4
Count is :            5
```

**注意**
>在`gfortran`编译器中, 函数中所有的变量默认都为`save`类型。


### 3.2 实参与形参
在`function/subroutine`定义时, 给定的参数为`形式参数`。
而**调用** `function/subroutine`时, 实际给定的参数称为`实际参数`。
如:
```fortran
subroutine demo(a, b)
            ^^^^ ^^^
         这里的a, b为实际参数
    ...
end function demo

program main
    integer :: a, b
    ...
    call demo(a, b)
        ^^^ ^^^
    这里的a, b为形式参数
    ...
end program
```
### 3.3 参数传递
在上面的程序中`9-4`中, 可以看到将`program`中的`a`变量作为参数传递给函数`add`, 这个变量`a`在`program` 和 函数`add`是否指代的是同一个内存地址呢？
我们直接给出结论
**fortan 中, 所有的参数传递都是传址**
这句话的含义是，如果在函数中修改形参的值, 那么实参的值也会被跟着改变, 这是因为fortran形参与实参公用同一个内存地址。
如:
```fortran
!> program 9-5
program main
    integer :: a = 4
    write(*, *) "Program Main: before subroutine, the value of a is ", a
    call division_by_two(a)
    write(*, *) "Program Main: after subroutine, the value of a is ", a
end program

subroutine division_by_two(number)
    integer :: number
    number = number / 2
end subroutine
```
输出如下:
```
Program Main: before subroutine, the value of a is            4
Program Main: after subroutine, the value of a is            2
```

### 3.4 参数修饰词
由于 `fortran` 传递参数时是按址传递的, 因此在`function, subroutine`中,某些参数是不希望运行中被改变的, 比如`add(a, b)`函数中的变量`a, b`。
`fortran`提供了参数修饰词来让编辑器检查是否可以将某一参数改变。
#### 3.3.1 INTENT(IN)
被`intent(in)`修饰的参数在函数或子例程中如果被改变, 编译器会报错。
如:
```fortran
function intent_in_test(a)
    integer, intent(in) :: a

    a = 5
end function
```
会报错
```
4 |     a = 5
  |    1
Error: Dummy argument 'a' with INTENT(IN) in variable definition context (assignment) at (1)
```
**对于不需要被改变的参数, 用 `intent(in)` 修饰是良好的习惯。**

#### 3.3.2 INTENT(OUT)
与`intent(in)`类似, `intent(out)`, 用`intent(out)`指定的参数必须是可赋值的变量而不是表达式。
比如:
```fortran
subroutine intent_out_test(a)
    integer, intent(out) :: a

    write(*, *) a
end subroutine

program main
    implicit none
    call intent_in_test(10)

end program
```
将会报错, 这是因为给子例程传入的是一个表达式。
```
9 |     call intent_out_test(10)
  |                         1
Error: Non-variable expression in variable definition context (actual argument to INTENT = OUT/INOUT) at (1)
```

#### 3.3.3 INTENT(INOUT)
被该修饰词修饰的参数既不能被修改也不能是表达式。


### 3.4 特殊参数
#### 3.4.1 数组传参
- 当数组作为参数时, 如果将整个数组都传递给`function/subroutine`, 会占用大量的内存, 但是数组在内存中占用是一段连续的内存单元, 因此在传递数组时, 只需要**传递数组中某一个(一般是第一个)元素的地址就可以了**。
- 传递数组参数时, 由于数组是有大小的, 编译器需要知道数组的上下界以防止访问错误地址, 因此在申明数组参数时, 需要给出数组的大小
- 数组的大小也可以**使用`*`默认符号申请**, 通过该符号申请的数组会贪心的获取大小(传入的数组可以有多大就会申请多大)。


下面的程序一个用于打印数组元素的子例程：
```fortran
!> program 9-6
!! print an array for the first n elements.
subroutine print_array(array, n)
    implicit none
    integer, intent(in) :: array(*)  ! declaction of array
    integer, intent(in) :: n         ! the number to be printed
    integer             :: i         ! control variable of loop
    do i = 1, n
        write(*, "(I0, ' ', $)") array(i)
    end do
end subroutine

program main
    integer, parameter :: n = 10
    integer            :: i
    integer            :: array(n)

    array(1: 2) = [0, 1]
    do i = 3, n
        array(i) = array(i - 1) + array(i - 2)
    end do

    call print_array(array, n)
end program
```
程序输出如下:
```
0 1 1 2 3 5 8 13 21 34
```
**如果实参数组与形参数组的纬度或是大小不对应**, `fortarn` 程序也可以运行， 并且按照内存的顺序开数组。
如:
```fortran
program main
    integer, parameter :: n = 3
    integer            :: i, j
    integer            :: array(n, n)

    do i = 1, n
        do j = 1, n
            array(i, j) = i + j
        end do
    end do

    call print_array(array, 3)

end program
```
程序会输出
```
0 1 2
```
即为数组的第一列, 因为该array二维数组的前三个地址分别为`array(1, 1), array(2, 1), array(3, 1)`

#### 3.4.2 函数或子例程传参
实际上, 函数或是子例程也是内存中被存储的一段空间, 也可以被当作参数传递给函数。
如
```fortran
!> program 9-7
program main
    implicit none
    external :: sub1, sub2  !! use external to give definition of an subroutine.
    call call_subroutine(sub1)
    call call_subroutine(sub2)
end program

!! just use the subroutine.
subroutine call_subroutine(sub)
    implicit none
    external :: sub  !! use external give definition.
    call sub()
end subroutine

subroutine sub1()
    implicit none
    write(*, *) "Sub1: Be used!"
end subroutine

subroutine sub2()
    implicit none
    write(*, *) "Sub2: Be used!"
end subroutine

```

### 3.5 更加特殊的参数
#### 3.5.1 接口
对于满足下面条件的`subroutine/function`, 由于其参数或是返回值比较特殊, 需要在使用之前告诉编译器其返回值或各个参数的定义, 称为接口`interface`。
使用语法如下:
```fortran
interface
    function subroutine_name(args)
        arg_type, arg_declaction :: arg_name
        ...
    end function

    function function_name(args)
        arg_type, arg_decoration         :: arg_name
        return_type, return_decoration   :: function_name
        ...
    end function
end interface
```
1. 返回值为数组
2. 存在可选参数
3. 指定参数位置来传参
4. 输入指标参数
5. 返回值为指针



#### 3.5.2 可选参数
在部分需求下, `function/subroutine`的部分参数有时需要被传入, 有时不需要被传入, 这时就需要用到特殊的修饰词`optional`, 表明该参数是一个可选参数。另外, 可以用`present`函数来检查一个参数是否被传入。
如:
```fortran
subroutine useless(number)
    implicit none
    integer, optional :: number

    if (present(number)) then
        write(*, *) "The optional argument number is :", number
    else
        write(*, *) "The optional argument don't find."
    end if

end subroutine

program option_demo
    implicit none
    call useless(10)
    call useless()
end program
```

#### 3.5.3 指定参数位置传参


## 4. 特殊函数
### 4.1 递归函数
### 4.2 内部函数
