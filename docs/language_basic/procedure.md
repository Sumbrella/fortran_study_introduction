# 过程
在写程序时常常会有一些代码块需要经常使用, 我们可以将其封装起来，封装好后的代码块可以统一调用，减少代码的书写量，提高程序的可读性、拓展性等。
## 1. 子例程 (subroutine)
### 1.1 语法
封装一个子例程按如下语法封装
```fortran
subroutine subroutine_name([argument1[, argument2, ..., argumentn]])
    ...
    return
end subroutine
```
使用时， 需要使用`call`语句
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


## 2. 函数 (function)
