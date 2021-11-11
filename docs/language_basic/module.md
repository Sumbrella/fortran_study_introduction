# 模块

很多情况下, 有一些编写的变量、常亮、派生类型、子例程、函数等是相互耦合的。可以将他们封装到一起形成模块，方便对这些程序的使用和管理。
创建模块就像是为程序代码创建文件夹，避免代码的臃肿。

## 11.1 模块定义
`fortran`中, 模块书写遵循如下语法:
```fortran
module module_name
    ...     ! variable, type and cosntant
contains
    ...     ! subroutine, function
end module [module_name]

```
比如定义一个常用常量库:
```fortran{class="line-numbers"}
module m_paramater
    implicit none
    real, parameter :: pi = acos(-1.)
    real, parameter :: ep = exp(1.)   
    integer :: prime_numbers_less_then_ten(4) = [2, 3, 5, 7]
end module
```


## 11.2 模块的使用
### 11.2.1 直接使用
`fortran` 中 `funciton/subroutine/program`都可以使用 `use` 语句来使用指定的模块, 如:

```fortran {class="line-numbers"}
program test
    use module_name
    ...
end program
```
> 注意: `use`语句需要出现在`implicit` 语句之前。

当模块被使用后, 模块中定义的所有代码块将引用进当前作用域。
比如:
```fortran {class="line-numbers"}
program main
    use m_paramater
end program
```


### 11.2.2 指定引用
为了避免变量名冲突, 引用模块时可以只引用部分内容或是给模块内变量更改名称, 需要使用到`only`语句。
```fortran
module m_paramater
    implicit none
    real, parameter :: pi = acos(-1.)
    real, parameter :: ep = exp(1.)   
    integer :: prime_numbers_less_then_ten(4) = [2, 3, 5, 7]
end module


program main
    use m_paramater, only: pi
    implicit none
    write(*, *) pi
end program
```

### 11.2.3 重命名
有的模块中定义的变量可能和程序需要使用的变量同名, 这时可以用`=>`将其改名。
```fortran
use m_paramater, only: constants_pi => pi
```
`=>`后面指向的是模块中的名字, 前面是重命名的名字。

## 11.3 模块成员管理
部分模块中的函数或是变量由于安全性问题, 不便于暴露给外部使用, 不希望或是不能被外部修改, 这时可以用`private`或是`public`关键字来指明模块中的内容是否暴露给外部, 默认情况下, 模块的所有成员都是`public`的, 也就是外部可以任意进行调用。
被`private`修饰的成员称为私有成员, `public`修饰的成员称为公共成员。

使用`private`关键字可以将模块中的成员隐藏, 如:
```fortran
module m_paramater
    implicit none
    real, parameter, private :: pi = acos(-1.)
    real, parameter :: ep = exp(1.)   
    integer :: prime_numbers_less_then_ten(4) = [2, 3, 5, 7]
end module


program main
    use m_paramater
    implicit none
    write(*, *) pi
end program
```
注意模块中中`pi`变量被赋予了`private`属性。
该程序会报错
```
12 |     write(*, *) pi
   |                  1
Error: Symbol 'pi' at (1) has no IMPLICIT type
```

也可以直接使用`private`关键字来改变模块成员默认是否暴露如:
```fortran
module m_name
    private
    integer :: a, b, c
    integer, public :: d
end module
```
此时模块中的所有变量默认都是`私有的`,
及`a, b, c`不会暴露给外部, `d`暴露给外部。
