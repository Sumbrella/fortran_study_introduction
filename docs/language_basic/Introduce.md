# Fortran 引入
## 目录
## 1. Fortran 语言架构
首先来看一段`Fortran`代码，你不必知道代码中各部分的详细含义，只需要简单了解一下`Fortran`代码的语言结构。
```fortran
!> Program 1-1
program view_of_fortran
    use ios_fortran_env, only: int32, real32
    implicit none
    integer(int32) :: high
    real(real32)   :: weight, bmi

    write(*, *) "Please enter your high(cm) >>>"
    read(*, *) heigh

    write(*, *) "Please enter your weight(kg) >>>"
    read(*, *) weight

    bmi   = weight / (height / 100 * height / 100)
    write(*, *) "Your bmi is:", bmi

end program
```

1. `1`行为`注释(Comments)`, 注释是由 `!` 开头的语段, 计算机在编译fortran程序时会自动将每一行 由 `!`开头的语句略去。

2. `2`行及`最后一行`为程序 `入口声明` 及 `出口声明`, 该语句为 fortran 程序运行必不可少的语句。

3. `3`行引用了 `ios_fortran_env` 模块中的 `int32` 及 `real32`

3. `6-7`行为 变量声明语句, 在此声明程序运行时需要申请的内存空间及变量名称。

4. `9、12、16`行 为输入语句, 从指定的通道中读取数据， `10、13`行为输出语句，将数据输出指指定通道。

5. `15`行为赋值语句，该语句将右侧语句值赋予左侧变量。

`Fortran ` 程序常规的书写框架如下:
```fortran
program xxxx
    use xxx, only: xxx
    (implicit none)

    ! 变量声明
    xxx, xxx  :: xxx

    ! 主程序
    ...

end program (xxxx)
```

## 2. Fortran 书写格式
### 2.1 Fortran 字符集
Fortran 中能使用的字符包括:
1. 英文字符: a~z, A~Z
2. 数字字符: 0~9,
3. 22个特殊符号: :=+-*/(),.'"!%&;<>?$_(space)
> Note: fortran 程序对大小写不敏感，也就是说, 在fortran代码中
`Integer == INteGer == integer`

### 2.2 固定格式 (Fixed)
固定格式是为了方便老式穿孔卡片进行运作的程序书写格式，现在一般不推荐使用，
固定格式的书写有如下要求
1. `1` 字符如果为 C, c, * 则改行被当作注释
2. `1 ~ 5` 个字符只能是数字用于编号，否则是空格
3. `6`字符, 如果是 "0" 以外的任何字符，则改行会续接上一行
4. `7~72` 字符为编写区域
5. `73` 字符以后，被废弃，有些编译器在检查时会报错。
```fortran
C     !program 1-2: Fixed demo
      program hello
100       write(*, *) "hello, world!"
      end program
```
### 2.3 自由格式 (Free)
对每一行的具体字符没有要求，只有如下的几点注意
1. `!` 后为注释
2. 每行只能编写 `132` 个字
3. 一行代码如果最后是 `&`, 表示下一行代码与这一行续接。
