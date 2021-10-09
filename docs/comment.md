# 注释编写规范
本文以`fortran`官方注释规范为指导, 便于`ford`等文档生成器自动生成文档为目的给出一个`fortran`注释编写的基本规范, 具体编写时可以根据个人习惯进行改进。
注释编写是非常重要的内容, 对于自己后续的使用、文档的编写以及其他人对该代码的阅读、修改、拓展等都有**无法替代**的意义。

## 1. 概述
`fortran` 注释由 `!` 开头后的整行, 而`!`后面的内容全部被编译器略去。
注释可以写在某一行语句的同行后面:
```fortran
i = 1  ! initialize the i
```
也可以写在其上面
```fortran
! initialize the i
i = 1
```
或是其下
```fortran
i = 1
! initialize the i
```
经验而言, 较为美观的方式是

> - 简短的辅助性语句写在语句同行
> - 沉长的描述性语句写在语句上行
> - 对模块、函数等的说明语句写在其定义语句下一行

当然可以根据具体情况进行调整, 但不论如何都需遵守:
> - 注释和代码之间不宜有多余的空行
> - 注释应及时换行, 影响阅读, 避免超过`fortran`同行字符限制
> - 注释的缩进与代码行所在的缩进保持一致

## 2. 注释描述符

实际上, 可以在`!`后增加一小些符号(注释描述符)来表示该行注释的大体内容, 比如我个人的习惯是:
- `! ` 普通性质注释。
- `!>` 对程序的运行过程起说明性描述性的注释。
- `!?` 对程序需要进一步改进、替换性的注释。
- `!!` 需要被写进文档的注释。
- `!*` 分隔符
- `!!` 一些重要或是提示性注释。

以`dijkstra`算法为例:
```fortran
!******************************************************
function dijkstra(graph, start) return(distance)
    !! find the cloestest path from start to
    !! all the point in the graph.
    !: The graph *must* have no minus weight.
    !! Author:  Sumbrella
    !! Version: Expermential
    !! Dependency: graph model
    !! Arguments:
    implicit
    type(Graph), intent(in)  :: graph
    !! the graph to be solved
    integer    , intent(in)  :: start    
    !! the start point
    integer    , allocatable :: distance(:)
    !! The shortest distance to each point of the graph

    integer                  :: u, v, w, n, d ! middle variables
    integer                  :: i, p          ! control variable
    integer    , parameter   :: INF = int(1e9)
    logical    , allocatable :: vis(:)  ! if one point is solved, the value of vis is true, nor false.

    n = graph%size   !> get the point number of the graph

    !> initialize
    allocate(vis(n))
    allocate(distance(n))
    distance = INF
    distance(start) = 0

    !> in each loop, dijkstra will get the most closest
    !> and not be visited yeat point to the start point
    !> then update distance of points which connected to
    !> this closest point.
    !? may be <queue> can improve this process.

    u = -1
    d = INF
    do while (.true.)
        !> find the cloestest and not visited point
        do i = 1, n
            if ( (u == -1 .or. (.not. vis(i))) .and. distance(i) < INF) then
                u = i
                d = distance(i)
            end if
        end do

        if (u == -1) exit  !> all points has been visited, exit

        !> upgrade all connected points
        p = graph%head(u)
        do while (p /= -1)
            w = graph%edges(p)%weight
            v = graph%edges(p)%to
            if (distance(v) > distance(u) + w) then
                distance(v) = distance(u) + w
            end if
            p = graph%next(p)
    end do
    return
end function
```
## 2. 文件注释
在`fortran`文件开头, 可以编写一段文件说明, 来大致说明该文件的内容、版本、作者、依赖库、使用方法等。

```fortran
!***************************************************
!! This file provide four kinds of sort algorithm.
!! Author: Sumbrella
!! Version: 1.0
!! Dependency: fortran95+
!! Example:
!! >
!!   use sort, only: quick_sort
!!   integer :: array(n)
!!   call quick_sort(array, array + n)
!! <
!***************************************************
```

## 3. 结构体注释
结构体在定义后, 在其下一行缩进写其总体描述。

在结构体内每一个成员的下一行写成员描述, 如:
```fortran
type :: Student
    !! a construct to save basic information of one student.
    character(10) :: name
    !! just student's name
    character(10) :: student_no
    !! key value, one student only math one student_no
    logical       :: sex
    !! .true. represent male, .false. represent female.
    ...
end type
```

## 4. 函数注释
函数定义后, 在其下一行对函数写总体性描述。
使用 `Example`, `Arguments`, `Version` 等来描述函数的各项信息。
如:
```fortran
function add(a, b)
    !! add two integer number together
    !! Version: 1.0
    !! Author : Sumbrella
    !! Example:
    !! >
    !!  write(*, *) add(1, 2)
    !! <
    !! Argments:
    integer, intent(in) :: a
    !! first number to be added
    integer, intent(in) :: b
    !! second numebr to be added
    integer             :: add

    add = a + b
    return
end function
```
或是更详细的版本
```fortran
subroutine check(condition, msg, code, warn)
    !! Checks the value of a logical condition
    !! version: experimental
    !!
    !!##### Behavior
    !!
    !! If `condition == .false.` and:
    !!
    !!   * No other arguments are provided, it stops the program with the default
    !!     message and exit code `1`;
    !!   * `msg` is provided, it prints the value of `msg`;
    !!   * `code` is provided, it stops the program with the given exit code;
    !!   * `warn` is provided and `.true.`, it doesn't stop the program and prints
    !!     the message.
    !!
    !!##### Examples
    !!
    !!* If `a /= 5`, stops the program with exit code `1`
    !!  and prints `Check failed.`
    !!``` fortran
    !!  call check(a == 5)
    !!```
    !!
    !!* As above, but prints `a == 5 failed`.
    !!``` fortran
    !!  call check(a == 5, msg='a == 5 failed.')
    !!```
    !!
    !!* As above, but doesn't stop the program.
    !!``` fortran
    !!  call check(a == 5, msg='a == 5 failed.', warn=.true.)
    !!```
    !!
    !!* As example #2, but stops the program with exit code `77`
    !!``` fortran
    !!  call check(a == 5, msg='a == 5 failed.', code=77)
    !!```
    !!
    !! Arguments:

    logical, intent(in) :: condition
    !! error condition
    character(*), intent(in), optional :: msg
    !! if error the message to be printed
    integer, intent(in), optional :: code
    !! the key vale of err
    logical, intent(in), optional :: warn
    !! the level of this err

    character(*), parameter :: msg_default = 'Check failed.'

    if (.not. condition) then
        if (optval(warn, .false.)) then
            write(stderr,*) optval(msg, msg_default)
        else
            call error_stop(optval(msg, msg_default), optval(code, 1))
        end if
    end if

end subroutine check
```

## 5. 接口注释
同样, 接口在其定义后的下一行描述接口的整体信息，
如:
```fortran
interface len_trim
    !! Returns the length of the character sequence without trailing spaces
    !! represented by the string.
    !!
    !! This method is elemental and returns a default integer scalar value.
    module procedure :: len_trim_string
end interface len_trim
```

## 6. 模块注释
同样, 某块在`module`语句的的下一行描述模块的整体信息。
不再赘述。
