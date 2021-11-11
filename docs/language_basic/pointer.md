# 指针
## 12.1 指针的概念
指针是一个特殊的数据类型, 一般的数据类型, 如整数、实数等, 他们会在计算机的`一块内存`中储存`数据`。 而指针会在计算机的`一块内存`中储存`另一块内存的位置`。

比如, `integer` 变量 `a`, 在内存中的 *000* 位置中储存了一个整数`1`, 此时变量`a`使用的内存位置为*000*, 而该内存*000*中存储了一个整数`1`。

如果有一个指针`pa`指向变量`a`, 假设它在内存中的位置为*001*, 那么该内存存储的内容为 *000*.

| 变量 | 类型 | 内存位置 | 内容 |
| :-: | :-: | :-:| :-:|
| `a` | `integer`| *000* | `1` |
| `pa` | `pointer` | *001* | *000*|

当我们去访问`pa` 时候, 相当于得到了变量`a`在计算机内存中的位置。

## 12.2 指针的声明
虽然指针指向的是操作系统中的一块内存, 但是该内存的大小可能会随着变量的改变而改变, 如果指针指向一个整数`integer(kind=4)`, 那么该内存大小为`4bytes`, 如果指向`integer(kind=8)`, 那么该内存大小为`8bytes`。
因此, 指针在声明时也需要指定指针指向的变量的类型。
如:
```fortran
integer, pointer :: pa
```
定义了一个指向整数类型的指针。
而:
```fortran
real, pointer :: pb
```
指向了一个实数类型的指针。

## 12.3 指针的基本使用
### 12.3.1 指向某一变量
被指针指向的变量需要用`target`修饰词来修饰, 高速编译器该变量是可以别指向的。
指针指向变量时, 使用`=>`操作符。

如:
```fortran
!> program 12-1
program pointer_demo
    implicit none
    integer, target  :: a    ! use target
    integer, pointer :: pa

    a = 10
    pa=>a   
    write(*, *) pa
end program
```
程序会输出
```
       10
```

在修改指针内容时, 实际上修改的是指针所指向变量的内容, 如:

```fortran
!> program 12-2
program pointer_change_demo
    implicit none
    integer, target  :: a    ! use target
    integer, pointer :: pa

    a = 10
    pa=>a   

    write(*, *) "a=", a
    write(*, *) "pa=", pa

    pa = 5

    write(*, *) "a=", a
    write(*, *) "pa=", pa

end program
```

会输出
```
 a=          10
 pa=          10
 a=           5
 pa=           5
```
可以看到, 修改`pa`的值, `a`的值也被改变。

### 12.3.2 指针直接申请空间
我们知道, 指针指向的是一块内存空间, 有时, 我们不想把指针指向某一个特定的变量, 而是希望直接给指针分配内存空间来使用, 可以用`allocate`函数来分配。指针被分配内存后, 它可以被当作一个变量来使用, 与普通变量完全一致, 不过它申请的内存空间不会被自动释放, 需要使用`deallocate`来释放。

```fortran
!> program 12-3
program pointer_allocte_demo
    implicit none
    integer, pointer :: p

    allocate(p)
    p = 5
    write(*, *) 5
    deallocate(p)

end program
```
程序会输出:
```
       5
```

### 12.3.3 空指针
当指针没有指向某一个变量或没有被赋予空间时, 它所储存的内存地址是随机的, 未知的, 此时操作指针所指向的内存空间是**十分危险的**。
如:
```fortran
!> program 12-4
program null_pointer_demo
    implicit none
    integer, pointer :: p
    p = 5
end program
```
程序会报错
```
Program received signal SIGSEGV: Segmentation fault - invalid memory reference.
```
这是因为访问了未经申请的空间。
大部分编译器检查是否有未被申请的指针使用, 但也有一些编译器不进行检查。
`fortran` 提供了 `null` 函数来提供一个空的内存地址, 该内存地址是安全的。
因此, 在指针声明时, 将其指向`null`是较好的习惯。
```fortran
integer, pointer :: p => null()
```
或是使用`nullify`函数
```fortran
integer, pointer :: p
nullify(p)
```

另外, `fortran`提供了`associated`函数来判断指针是否已赋值。
```fortran
!> program 12-5
program associated_demo
    implicit none
    integer, target  :: a
    integer, pointer :: p => null()

    write(*, *) associated(p)
    p => a
    write(*, *) associated(p)
end program
```
程序输出:
```
F
T
```
## 12.4 指针数组
