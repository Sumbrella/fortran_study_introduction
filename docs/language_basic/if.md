# 选择结构
## 1. If
### 1.1 if-end
输入一个学生成绩，如果及格则输出“及格”。
```fortran
!> program: 5-1
program one_if_demo
    implicit none
    integer :: score
    write(*, *) "输入成绩>>>"
    read(*, *) score

    if (score >= 60) then
        write(*, *) "及格"
    end if
end program
```
代码中可以看到, `if` 语句的基本语法结构为
```fortran
if (condition) then
    ...
end if
```
用括号括起来的为条件语句, 如果该条件语句的值为真，则会进入`IF`分支并运行内部代码。

### 1.2 if-else
输入一个学生成绩，如果及格则输出“及格”，否则输出不及格

```fortran
!> program: 5-2
program if_else_demo
    implicit none
    integer :: score
    write(*, *) "输入成绩>>>"
    read(*, *) score

    if (score >= 60) then
        write(*, *) "及格"
    else
        write(*, *) "不及"
    end if

end program
```

代码中可以看到, `if-else` 语句的基本语法结构为
```fortran
if (condition) then
    ...
else
    ...
end if
```

### 1.3 if-elseif-else
输入一个学生的成绩，如果分数超过100分或低于0分输出“超出范围”，60分以上输出“及格”，否则输出“不及格”。
```fortran
!> program: 5-3
program if_demo
    implicit none
    integer :: score
    write(*, *) "输入成绩>>>"
    read(*, *) score
    if (score > 100 .or. score < 0) then
        write(*, *) "超出范围"
    else if (score >= 60)
        write(*, *) "及格"
    else
        write(*, *) "不及"
    end if
end program
```
代码中可以看到, `if-else` 语句的基本语法结构为
```fortran
if (condition) then
    ...
else if (condition)
    ...
else
    ...
end if
```
程序会首先判定第一个if是否成立，如果成立则进入该if语句，如果不成立则会进下一个if
判断，如此反复。直到结束。

## 2. Select case 语句
基本表达式为:
```fortran
select case (expression)
case (condition1)
    ...
case (condition2)
    ...
case default
    ...
end select
```
例如，用`select case`语句实现上面的程序
```fortran
!> program: 5-4
program select_demo
    implicit none
    integer :: score
    write(*, *) "输入成绩>>>"
    read(*, *) score
    select case (score)
    case (101:)
        write(*, *) "超出范围"
    case (:-1)
        write(*, *) "超出范围"
    case (60: 100)
        write(*, *) "及格"
    case (0: 59)
        write(*, *) "不及格"
    end select
end program
```
说明:
1. `select case`与`end select`是`case`结构的入口和出口，必须成对出现。
2. `case`语句中的控制表达式类型可以是整型、逻辑型或字符型，但不可以用实型或 复型表达式。
3. `case`选择表达式必须与CASE控制表达式的类型一致。
4. `case`块可多可少，可以省略。
5. `case default`语句应不多于一条，并应放在所有CASE语句之后。
6. 当CASE控制表达式是整数时，可以有多种表示法。比如:
    - `case(1)`:当选择表达式的值为1时，执行相应的语句块。
    - `case(1，3，5)`:当选择表达式的值为1、3或者5时，执行相应的语句块。
    - `case(1:10)`: 当选择表达式的值为1~10时，执行相应的语句块

## 3. 练习

**EASY**
1. 从屏幕中读入两个整数 $a, b$, 按从小到大的顺序输出这两个数。
    >样例
    **Input**
    50 30
    **Output**
    30 50

**NORMAL**


**HARD**
